Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C498C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3014C2076E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 16:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Yfe6inOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgDGQea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 12:34:30 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54068 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbgDGQe1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:34:27 -0400
Received: from zn.tnic (p200300EC2F0B2700A94266E658FF3DDD.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2700:a942:66e6:58ff:3ddd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D0DC01EC0CE4;
        Tue,  7 Apr 2020 18:34:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586277266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2nrp0t21u9Sz6mRb2KOw0mqOxOF2y5zAGm7PPtydsew=;
        b=Yfe6inOC1M4Lc6nkMsvUY146N1ssCfU63QEkrRag6avq85Sy4My5Y+kdsR+/igGcWAMSFx
        PZ+jxbsbdpRd5fqEWCakQKpb2BoYu9+aiQomCOkvi9x0RfP2ckuxO4RmV4jCFANSJ1h0kb
        F3W569zIGAW7O+SnmviKalOgkP6GE7A=
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/9] x86/mce: Add mce=print_all option
Date:   Tue,  7 Apr 2020 18:34:12 +0200
Message-Id: <20200407163414.18058-8-bp@alien8.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200407163414.18058-1-bp@alien8.de>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200407163414.18058-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

Sometimes, when logs are getting lost, it's nice to just
have everything dumped to the serial console.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200214222720.13168-7-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/core.c     | 7 ++++++-
 arch/x86/kernel/cpu/mce/internal.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index fc879b6669d5..4efe6c128887 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -591,7 +591,7 @@ static int mce_default_notifier(struct notifier_block *nb, unsigned long val,
 	if (!m)
 		return NOTIFY_DONE;
 
-	if (!m->kflags)
+	if (mca_cfg.print_all || !m->kflags)
 		__print_mce(m);
 
 	return NOTIFY_DONE;
@@ -1962,6 +1962,7 @@ void mce_disable_bank(int bank)
  * mce=no_cmci Disables CMCI
  * mce=no_lmce Disables LMCE
  * mce=dont_log_ce Clears corrected events silently, no log created for CEs.
+ * mce=print_all Print all machine check logs to console
  * mce=ignore_ce Disables polling and CMCI, corrected events are not cleared.
  * mce=TOLERANCELEVEL[,monarchtimeout] (number, see above)
  *	monarchtimeout is how long to wait for other CPUs on machine
@@ -1990,6 +1991,8 @@ static int __init mcheck_enable(char *str)
 		cfg->lmce_disabled = 1;
 	else if (!strcmp(str, "dont_log_ce"))
 		cfg->dont_log_ce = true;
+	else if (!strcmp(str, "print_all"))
+		cfg->print_all = true;
 	else if (!strcmp(str, "ignore_ce"))
 		cfg->ignore_ce = true;
 	else if (!strcmp(str, "bootlog") || !strcmp(str, "nobootlog"))
@@ -2256,6 +2259,7 @@ static ssize_t store_int_with_restart(struct device *s,
 static DEVICE_INT_ATTR(tolerant, 0644, mca_cfg.tolerant);
 static DEVICE_INT_ATTR(monarch_timeout, 0644, mca_cfg.monarch_timeout);
 static DEVICE_BOOL_ATTR(dont_log_ce, 0644, mca_cfg.dont_log_ce);
+static DEVICE_BOOL_ATTR(print_all, 0644, mca_cfg.print_all);
 
 static struct dev_ext_attribute dev_attr_check_interval = {
 	__ATTR(check_interval, 0644, device_show_int, store_int_with_restart),
@@ -2280,6 +2284,7 @@ static struct device_attribute *mce_device_attrs[] = {
 #endif
 	&dev_attr_monarch_timeout.attr,
 	&dev_attr_dont_log_ce.attr,
+	&dev_attr_print_all.attr,
 	&dev_attr_ignore_ce.attr,
 	&dev_attr_cmci_disabled.attr,
 	NULL
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index 74a01829c4f4..55f5c7b755f2 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -119,6 +119,7 @@ struct mca_config {
 	bool dont_log_ce;
 	bool cmci_disabled;
 	bool ignore_ce;
+	bool print_all;
 
 	__u64 lmce_disabled		: 1,
 	      disabled			: 1,
-- 
2.21.0

