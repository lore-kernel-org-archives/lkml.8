Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B82C2BBC7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 937612074B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388668AbgDMU62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:58:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:8591 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733299AbgDMU6Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 16:58:24 -0400
IronPort-SDR: lfLas3BSUw/VSZ5VktiZEjQcFDAAiUvBKLjlWRs8KFEQRg0VKDLCmzgYu1G/EBE1fXbjeCEQsm
 G7cWtzv39bfg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 13:58:22 -0700
IronPort-SDR: tb7Za98YRpkT32NZhHWbbskeu9k1XsyohvCyQVkxlFJnn/WvMB1Wq6xNeC9C/0aRE9p2VsaoJ2
 WIsHuxhUE3kg==
X-IronPort-AV: E=Sophos;i="5.72,380,1580803200"; 
   d="scan'208";a="453301669"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 13:58:21 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, ravi.v.shankar@intel.com,
        mingo@redhat.com, babu.moger@amd.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH V2 4/4] x86/resctrl: Use appropriate API for strings terminated by newline
Date:   Mon, 13 Apr 2020 13:58:03 -0700
Message-Id: <d1e508e76d09e6de90a961aeefbc04021ab0f0ea.1586801373.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1586801373.git.reinette.chatre@intel.com>
References: <cover.1586801373.git.reinette.chatre@intel.com>
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
Changes since V1:
- Remove unnecessary checks on user input (Andy Shevchenko)
- Change code style surrounding usage of sysfs_match_string() (Andy Shevchenko)

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 32 ++++++++++++++------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d4e9b8a204d6..a8cbec226633 100644
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

