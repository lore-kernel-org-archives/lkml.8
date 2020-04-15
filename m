Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D32C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B37C20784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896024AbgDOJwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895896AbgDOJt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:49:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BEBC03C1A7;
        Wed, 15 Apr 2020 02:49:55 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jOefz-0005rZ-QZ; Wed, 15 Apr 2020 11:49:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 674831C0450;
        Wed, 15 Apr 2020 11:49:47 +0200 (CEST)
Date:   Wed, 15 Apr 2020 09:49:47 -0000
From:   "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Add mce=print_all option
Cc:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200214222720.13168-7-tony.luck@intel.com>
References: <20200214222720.13168-7-tony.luck@intel.com>
MIME-Version: 1.0
Message-ID: <158694418705.28353.5090927003309338068.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     43505646941bee217b91d064756975aa1ab6ee3b
Gitweb:        https://git.kernel.org/tip/43505646941bee217b91d064756975aa1ab6ee3b
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Fri, 14 Feb 2020 14:27:19 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Apr 2020 16:00:30 +02:00

x86/mce: Add mce=print_all option

Sometimes, when logs are getting lost, it's nice to just
have everything dumped to the serial console.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20200214222720.13168-7-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/core.c     | 7 ++++++-
 arch/x86/kernel/cpu/mce/internal.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index fc879b6..4efe6c1 100644
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
index 74a0182..55f5c7b 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -119,6 +119,7 @@ struct mca_config {
 	bool dont_log_ce;
 	bool cmci_disabled;
 	bool ignore_ce;
+	bool print_all;
 
 	__u64 lmce_disabled		: 1,
 	      disabled			: 1,
