Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97090C38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D5C72075A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 23:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgEFXuo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 19:50:44 -0400
Received: from mga11.intel.com ([192.55.52.93]:22516 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgEFXue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 19:50:34 -0400
IronPort-SDR: jof/3rPbb9FPWE/FstfGpnNpuwzobHtLALOg7vafv7QI7Z8pxXuhCclVww84s2Ode2qtmzgsBw
 jDhidq+dZx9A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 16:50:31 -0700
IronPort-SDR: 9sNPWl6NHJRwt/Qx2aLUX8d+XLEBJrueDqYI9OOBKgEeH5SRLqpbLmf1UkHa85o4etq+9abTUJ
 mRgHZlshZ+5A==
X-IronPort-AV: E=Sophos;i="5.73,361,1583222400"; 
   d="scan'208";a="435084104"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 16:50:30 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, ravi.v.shankar@intel.com,
        mingo@redhat.com, babu.moger@amd.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH V3 4/4] x86/resctrl: Use appropriate API for strings terminated by newline
Date:   Wed,  6 May 2020 16:49:55 -0700
Message-Id: <a99e4de3dc3f0e60281de1274ccb064071200fd9.1588808538.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1588808537.git.reinette.chatre@intel.com>
References: <cover.1588808537.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user input to files in the resctrl filesystem are expected to be
terminated with a newline. Testing the user input includes a test for
the presence of a newline and then replacing the newline with NUL
byte followed by comparison using strcmp().

sysfs_streq() exists to test if strings are equal, treating both NUL and
newline-then-NUL as equivalent string terminations. Even more,
sysfs_match_string() exists to match a given string in an array using
sysfs_streq().

Replace existing strcmp() comparisons of strings that are terminated
with a newline with more appropriate sysfs_streq() via the
sysfs_match_string() API that can perform the match across the different
mode strings that are already maintained in an array.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 32 ++++++++++++++------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index c60a3b307f7d..e70694892c02 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1408,12 +1408,11 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 {
 	struct rdtgroup *rdtgrp;
 	enum rdtgrp_mode mode;
-	int ret = 0;
+	int user_m;
+	int ret;
 
-	/* Valid input requires a trailing newline */
-	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+	if (nbytes == 0)
 		return -EINVAL;
-	buf[nbytes - 1] = '\0';
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (!rdtgrp) {
@@ -1425,11 +1424,17 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 
 	mode = rdtgrp->mode;
 
-	if ((!strcmp(buf, "shareable") && mode == RDT_MODE_SHAREABLE) ||
-	    (!strcmp(buf, "exclusive") && mode == RDT_MODE_EXCLUSIVE) ||
-	    (!strcmp(buf, "pseudo-locksetup") &&
-	     mode == RDT_MODE_PSEUDO_LOCKSETUP) ||
-	    (!strcmp(buf, "pseudo-locked") && mode == RDT_MODE_PSEUDO_LOCKED))
+	ret = sysfs_match_string(rdt_mode_str, buf);
+	if (ret < 0) {
+		rdt_last_cmd_puts("Unknown or unsupported mode\n");
+		goto out;
+	}
+
+	user_m = ret;
+	ret = 0;
+
+	/* Do nothing and return success if user asks for current mode */
+	if (user_m == mode)
 		goto out;
 
 	if (mode == RDT_MODE_PSEUDO_LOCKED) {
@@ -1438,14 +1443,14 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 		goto out;
 	}
 
-	if (!strcmp(buf, "shareable")) {
+	if (user_m == RDT_MODE_SHAREABLE) {
 		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 			ret = rdtgroup_locksetup_exit(rdtgrp);
 			if (ret)
 				goto out;
 		}
 		rdtgrp->mode = RDT_MODE_SHAREABLE;
-	} else if (!strcmp(buf, "exclusive")) {
+	} else if (user_m == RDT_MODE_EXCLUSIVE) {
 		if (!rdtgroup_mode_test_exclusive(rdtgrp)) {
 			ret = -EINVAL;
 			goto out;
@@ -1456,14 +1461,11 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 				goto out;
 		}
 		rdtgrp->mode = RDT_MODE_EXCLUSIVE;
-	} else if (!strcmp(buf, "pseudo-locksetup")) {
+	} else if (user_m == RDT_MODE_PSEUDO_LOCKSETUP) {
 		ret = rdtgroup_locksetup_enter(rdtgrp);
 		if (ret)
 			goto out;
 		rdtgrp->mode = RDT_MODE_PSEUDO_LOCKSETUP;
-	} else {
-		rdt_last_cmd_puts("Unknown or unsupported mode\n");
-		ret = -EINVAL;
 	}
 
 out:
-- 
2.21.0

