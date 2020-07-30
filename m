Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C2AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B5E32082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbgG3QaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:30:00 -0400
Received: from verein.lst.de ([213.95.11.211]:56532 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgG3QaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:30:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 70B0468BEB; Thu, 30 Jul 2020 18:29:57 +0200 (CEST)
Date:   Thu, 30 Jul 2020 18:29:57 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/8] modules: inherit TAINT_PROPRIETARY_MODULE
Message-ID: <20200730162957.GA22469@lst.de>
References: <20200730061027.29472-1-hch@lst.de> <20200730061027.29472-9-hch@lst.de> <20200730141232.GA31539@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730141232.GA31539@linux-8ccs>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 04:12:32PM +0200, Jessica Yu wrote:
>> +	if (owner && test_bit(TAINT_PROPRIETARY_MODULE, &owner->taints)) {
>> +		if (mod->using_gplonly_symbols) {
>> +			sym = NULL;
>> +			goto getname;
>> +		}
>> +		add_taint_module(mod, TAINT_PROPRIETARY_MODULE,
>> +				 LOCKDEP_NOW_UNRELIABLE);
>> +	}
>
> Sorry that I didn't think of this yesterday, but I'm wondering if we
> should print a warning before add_taint_module(). Maybe something
> along the lines of, "%s: module uses symbols from proprietary module
> %s, inheriting taint.", with %s being mod->name, owner->name. We can
> check mod->taints for TAINT_PROPRIETARY_MODULE and print the warning once.
>
> Additionally, maybe it's a good idea to print an error before goto
> getname (e.g., "%s: module using GPL-only symbols uses symbols from
> proprietary module %s."), so one would know why the module load
> failed, right now this manifests itself as an unknown symbol error.
>
> Otherwise, this patchset looks good to me and I agree with it in
> principle. Thanks Christoph!

What about this version?  It also factors the code out into a new
helper, and replaces the add_taint_module with a simple set_bit,
as the system-wide tain must have been set before by definition:

---
From 25e928b6b691911717d30b3449e56fca3e13dba9 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 28 Jul 2020 23:33:33 +0200
Subject: modules: inherit TAINT_PROPRIETARY_MODULE

If a TAINT_PROPRIETARY_MODULE exports symbol, inherit the taint flag
for all modules importing these symbols, and don't allow loading
symbols from TAINT_PROPRIETARY_MODULE modules if the module previously
imported gplonly symbols.  Add a anti-circumvention devices so people
don't accidentally get themselves into trouble this way.

Comment from Greg:
  "Ah, the proven-to-be-illegal "GPL Condom" defense :)"

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/module.h |  1 +
 kernel/module.c        | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index 30b0f5fcdb3c37..e30ed5fa33a738 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -389,6 +389,7 @@ struct module {
 	unsigned int num_gpl_syms;
 	const struct kernel_symbol *gpl_syms;
 	const s32 *gpl_crcs;
+	bool using_gplonly_symbols;
 
 #ifdef CONFIG_UNUSED_SYMBOLS
 	/* unused exported symbols. */
diff --git a/kernel/module.c b/kernel/module.c
index afb2bfdd5134b3..81d5facce28c14 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1431,6 +1431,24 @@ static int verify_namespace_is_imported(const struct load_info *info,
 	return 0;
 }
 
+static bool inherit_taint(struct module *mod, struct module *owner)
+{
+	if (!owner || !test_bit(TAINT_PROPRIETARY_MODULE, &owner->taints))
+		return true;
+
+	if (mod->using_gplonly_symbols) {
+		pr_info("%s: module using GPL-only symbols uses symbols from proprietary module %s.\n",
+			mod->name, owner->name);
+		return false;
+	}
+
+	if (!test_bit(TAINT_PROPRIETARY_MODULE, &mod->taints)) {
+		pr_info("%s: module uses symbols from proprietary module %s, inheriting taint.\n",
+			mod->name, owner->name);
+		set_bit(TAINT_PROPRIETARY_MODULE, &mod->taints);
+	}
+	return true;
+}
 
 /* Resolve a symbol for this module.  I.e. if we find one, record usage. */
 static const struct kernel_symbol *resolve_symbol(struct module *mod,
@@ -1456,6 +1474,14 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
 	if (!sym)
 		goto unlock;
 
+	if (license == GPL_ONLY)
+		mod->using_gplonly_symbols = true;
+
+	if (!inherit_taint(mod, owner)) {
+		sym = NULL;
+		goto getname;
+	}
+
 	if (!check_version(info, name, mod, crc)) {
 		sym = ERR_PTR(-EINVAL);
 		goto getname;
-- 
2.27.0

