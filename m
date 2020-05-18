Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD938C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF55820715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 23:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgERXrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 19:47:23 -0400
Received: from mga02.intel.com ([134.134.136.20]:65333 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbgERXrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 19:47:18 -0400
IronPort-SDR: a+0TBaaoglEYnYmqeMxm9Jb6YycpMTDeBn+QW8qMM67GfcwiYDawOb2rKSD41w4y1klPYOxzDw
 YJbRTwAk+QXw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 16:47:12 -0700
IronPort-SDR: 1c5lss4U7G9EI9oBxLXuQZxRq6qrLODLeOzUOYw74fwFvC5AFjjrAnTvIHITJmliDAa4UYRMy8
 7Pypk+RPMjFg==
X-IronPort-AV: E=Sophos;i="5.73,408,1583222400"; 
   d="scan'208";a="288757573"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 16:47:11 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, ravi.v.shankar@intel.com,
        mingo@redhat.com, babu.moger@amd.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH V5 4/4] x86/resctrl: Use appropriate API for strings terminated by newline
Date:   Mon, 18 May 2020 16:46:49 -0700
Message-Id: <a953992d99a1930703cba1362a3005d517c4cb33.1589844108.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589844108.git.reinette.chatre@intel.com>
References: <cover.1589844108.git.reinette.chatre@intel.com>
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
Changes since V4:
- Remove "mode" local variable from rdtgroup_mode_write(). This variable
  was previously used to create shorter lines with the original strcmp()
  code that was removed in patch 4/4.
- Andy pointed out that the repeated assignment to rdtgrp->mode could be
  replaced by a single assignment after all the checks. This was initially
  rejected because it would let the "RDT_MODE_PSEUDO_LOCKED" assignment
  slip through. Even so, Andy's feedback revealed that the new changes
  unintentionally let a user's attempt at setting the mode to pseudo-locked
  be silently ignored where it previously reported an error. Restore original
  user space behavior by returning success when user attempts to change any
  mode when it is already the current mode (including pseudo-locked) and
  returning failure when user attempts to set the mode to pseudo-locked.
  After this change it is possible to follow Andy's original suggestion
  of using a single assignment. (Andy)

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 40 ++++++++++++++------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 088a1536bccc..31f1bacaa288 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1414,13 +1414,11 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 				   char *buf, size_t nbytes, loff_t off)
 {
 	struct rdtgroup *rdtgrp;
-	enum rdtgrp_mode mode;
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
@@ -1430,29 +1428,33 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 
 	rdt_last_cmd_clear();
 
-	mode = rdtgrp->mode;
+	ret = sysfs_match_string(rdt_mode_str, buf);
+	if (ret < 0) {
+		rdt_last_cmd_puts("Unknown or unsupported mode\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	user_m = ret;
+	ret = 0;
 
-	if ((!strcmp(buf, "shareable") && mode == RDT_MODE_SHAREABLE) ||
-	    (!strcmp(buf, "exclusive") && mode == RDT_MODE_EXCLUSIVE) ||
-	    (!strcmp(buf, "pseudo-locksetup") &&
-	     mode == RDT_MODE_PSEUDO_LOCKSETUP) ||
-	    (!strcmp(buf, "pseudo-locked") && mode == RDT_MODE_PSEUDO_LOCKED))
+	/* Do nothing and return success if user asks for current mode */
+	if (user_m == rdtgrp->mode)
 		goto out;
 
-	if (mode == RDT_MODE_PSEUDO_LOCKED) {
+	if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
 		rdt_last_cmd_puts("Cannot change pseudo-locked group\n");
 		ret = -EINVAL;
 		goto out;
 	}
 
-	if (!strcmp(buf, "shareable")) {
+	if (user_m == RDT_MODE_SHAREABLE) {
 		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP) {
 			ret = rdtgroup_locksetup_exit(rdtgrp);
 			if (ret)
 				goto out;
 		}
-		rdtgrp->mode = RDT_MODE_SHAREABLE;
-	} else if (!strcmp(buf, "exclusive")) {
+	} else if (user_m == RDT_MODE_EXCLUSIVE) {
 		if (!rdtgroup_mode_test_exclusive(rdtgrp)) {
 			ret = -EINVAL;
 			goto out;
@@ -1462,16 +1464,16 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 			if (ret)
 				goto out;
 		}
-		rdtgrp->mode = RDT_MODE_EXCLUSIVE;
-	} else if (!strcmp(buf, "pseudo-locksetup")) {
+	} else if (user_m == RDT_MODE_PSEUDO_LOCKSETUP) {
 		ret = rdtgroup_locksetup_enter(rdtgrp);
 		if (ret)
 			goto out;
-		rdtgrp->mode = RDT_MODE_PSEUDO_LOCKSETUP;
-	} else {
+	} else if (user_m == RDT_MODE_PSEUDO_LOCKED) {
 		rdt_last_cmd_puts("Unknown or unsupported mode\n");
 		ret = -EINVAL;
+		goto out;
 	}
+	rdtgrp->mode = user_m;
 
 out:
 	rdtgroup_kn_unlock(of->kn);
-- 
2.21.0

