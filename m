Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF24C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59A4920578
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WrT5vijK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728777AbgG3GKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728758AbgG3GKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:10:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A03C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 23:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7i/oU01pSKahB9sA7zWqIHiRiXPfiH+9euXkSu1Iu/0=; b=WrT5vijKlnpkXAeEmW3JOO43tA
        DJqM1qnIcD4kK7DTrKwlRy5iBsuHM7lDbiaSrWV6F1sR0Ejah06SgpIk9dTNiHAgwECdfVU0czByu
        Tlt5fliW0u+egxZOm/DCrmvGny4hgIPHQWufkgsq1LQqp7OFjGOPE+A2B3cO+gqXu2WZi9yEIkY84
        85iZhgUoXe5reLeUTNn9e6Otesbu7lNpkAA2QJypG1KlWhGH7/R+GeU4uZxHz3DZLFvQ069iS8gcp
        7JJzwkNA1YgPsDxwRxky+dEHBc3LsTonnnaU9npZ5GLD/HEJDABO1aiKLq3KEwrvcDHKicJs9CyAP
        q1lu0AVg==;
Received: from 138.57.168.109.cust.ip.kpnqwest.it ([109.168.57.138] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k11m8-0007WY-WF; Thu, 30 Jul 2020 06:10:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 8/8] modules: inherit TAINT_PROPRIETARY_MODULE
Date:   Thu, 30 Jul 2020 08:10:27 +0200
Message-Id: <20200730061027.29472-9-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200730061027.29472-1-hch@lst.de>
References: <20200730061027.29472-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a TAINT_PROPRIETARY_MODULE exports symbol, inherit the taint flag
for all modules importing these symbols, and don't allow loading
symbols from TAINT_PROPRIETARY_MODULE modules if the module previously
imported gplonly symbols.  Add a anti-circumvention devices so people
don't accidentally get themselves into trouble this way.

Comment from Greg:
 Ah, the proven-to-be-illegal "GPL Condom" defense :)

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/module.h |  1 +
 kernel/module.c        | 12 ++++++++++++
 2 files changed, 13 insertions(+)

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
index afb2bfdd5134b3..04f993863ae417 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -1456,6 +1456,18 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
 	if (!sym)
 		goto unlock;
 
+	if (license == GPL_ONLY)
+		mod->using_gplonly_symbols = true;
+
+	if (owner && test_bit(TAINT_PROPRIETARY_MODULE, &owner->taints)) {
+		if (mod->using_gplonly_symbols) {
+			sym = NULL;
+			goto getname;
+		}
+		add_taint_module(mod, TAINT_PROPRIETARY_MODULE,
+				 LOCKDEP_NOW_UNRELIABLE);
+	}
+
 	if (!check_version(info, name, mod, crc)) {
 		sym = ERR_PTR(-EINVAL);
 		goto getname;
-- 
2.27.0

