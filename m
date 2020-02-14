Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5ACC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9318D2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgBNW2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:28:19 -0500
Received: from mga05.intel.com ([192.55.52.43]:5120 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727958AbgBNW1Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:27:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 14:27:23 -0800
X-IronPort-AV: E=Sophos;i="5.70,442,1574150400"; 
   d="scan'208";a="227756445"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2020 14:27:22 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] x86/mce: Add mce=print_all option
Date:   Fri, 14 Feb 2020 14:27:19 -0800
Message-Id: <20200214222720.13168-7-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200214222720.13168-1-tony.luck@intel.com>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200214222720.13168-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes, when logs are getting lost, it's nice to just
have everything dumped to the serial console.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c     | 7 ++++++-
 arch/x86/kernel/cpu/mce/internal.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 066d3903ef97..22925fd5e189 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -590,7 +590,7 @@ static int mce_default_notifier(struct notifier_block *nb, unsigned long val,
 	if (!m)
 		return NOTIFY_DONE;
 
-	if (!m->kflags)
+	if (mca_cfg.print_all || !m->kflags)
 		__print_mce(m);
 
 	return NOTIFY_DONE;
@@ -1950,6 +1950,7 @@ void mce_disable_bank(int bank)
  * mce=no_cmci Disables CMCI
  * mce=no_lmce Disables LMCE
  * mce=dont_log_ce Clears corrected events silently, no log created for CEs.
+ * mce=print_all Print all machine check logs to console
  * mce=ignore_ce Disables polling and CMCI, corrected events are not cleared.
  * mce=TOLERANCELEVEL[,monarchtimeout] (number, see above)
  *	monarchtimeout is how long to wait for other CPUs on machine
@@ -1978,6 +1979,8 @@ static int __init mcheck_enable(char *str)
 		cfg->lmce_disabled = 1;
 	else if (!strcmp(str, "dont_log_ce"))
 		cfg->dont_log_ce = true;
+	else if (!strcmp(str, "print_all"))
+		cfg->print_all = true;
 	else if (!strcmp(str, "ignore_ce"))
 		cfg->ignore_ce = true;
 	else if (!strcmp(str, "bootlog") || !strcmp(str, "nobootlog"))
@@ -2244,6 +2247,7 @@ static ssize_t store_int_with_restart(struct device *s,
 static DEVICE_INT_ATTR(tolerant, 0644, mca_cfg.tolerant);
 static DEVICE_INT_ATTR(monarch_timeout, 0644, mca_cfg.monarch_timeout);
 static DEVICE_BOOL_ATTR(dont_log_ce, 0644, mca_cfg.dont_log_ce);
+static DEVICE_BOOL_ATTR(print_all, 0644, mca_cfg.print_all);
 
 static struct dev_ext_attribute dev_attr_check_interval = {
 	__ATTR(check_interval, 0644, device_show_int, store_int_with_restart),
@@ -2268,6 +2272,7 @@ static struct device_attribute *mce_device_attrs[] = {
 #endif
 	&dev_attr_monarch_timeout.attr,
 	&dev_attr_dont_log_ce.attr,
+	&dev_attr_print_all.attr,
 	&dev_attr_ignore_ce.attr,
 	&dev_attr_cmci_disabled.attr,
 	NULL
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index b785c0d0b590..bf09b8aa8184 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -114,6 +114,7 @@ struct mca_config {
 	bool dont_log_ce;
 	bool cmci_disabled;
 	bool ignore_ce;
+	bool print_all;
 
 	__u64 lmce_disabled		: 1,
 	      disabled			: 1,
-- 
2.21.1

