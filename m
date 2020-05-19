Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58339C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D3C52072C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgESV3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:29:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:37811 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727065AbgESV3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:29:07 -0400
IronPort-SDR: calwNAkkl1Nx2MfYgUNjJM15C079b9ha3mjn+n7bP+hJARgsHYfRyfc8864HmgRpELfH93RFe7
 iZOPWm+jBTDg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 14:28:57 -0700
IronPort-SDR: MdmYWyVT48oXiYzdxlaF5nJbDbPdAi5G3Wu1qGFKS5La5TIMrXZEKhFQScVTb4dkQDCpumxwF+
 89BVI/XwLtCQ==
X-IronPort-AV: E=Sophos;i="5.73,411,1583222400"; 
   d="scan'208";a="264449079"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 14:28:56 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     kuo-lang.tseng@intel.com, ravi.v.shankar@intel.com,
        mingo@redhat.com, babu.moger@amd.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH V6 4/4] x86/resctrl: Use appropriate API for strings terminated by newline
Date:   Tue, 19 May 2020 14:28:31 -0700
Message-Id: <79faf008e6460a2bc8a3cc02313f7900552b1475.1589922949.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589922949.git.reinette.chatre@intel.com>
References: <cover.1589922949.git.reinette.chatre@intel.com>
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
Changes since V5:
- Remove the early check of the sysfs_match_string() return code. (Andy)

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 28 ++++++++++----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 088a1536bccc..07e0f150c56e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1414,13 +1414,11 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 				   char *buf, size_t nbytes, loff_t off)
 {
 	struct rdtgroup *rdtgrp;
-	enum rdtgrp_mode mode;
 	int ret = 0;
+	int user_m;
 
-	/* Valid input requires a trailing newline */
-	if (nbytes == 0 || buf[nbytes - 1] != '\n')
+	if (nbytes == 0)
 		return -EINVAL;
-	buf[nbytes - 1] = '\0';
 
 	rdtgrp = rdtgroup_kn_lock_live(of->kn);
 	if (!rdtgrp) {
@@ -1430,29 +1428,25 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
 
 	rdt_last_cmd_clear();
 
-	mode = rdtgrp->mode;
+	user_m = sysfs_match_string(rdt_mode_str, buf);
 
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
@@ -1462,16 +1456,16 @@ static ssize_t rdtgroup_mode_write(struct kernfs_open_file *of,
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
 	} else {
 		rdt_last_cmd_puts("Unknown or unsupported mode\n");
 		ret = -EINVAL;
+		goto out;
 	}
+	rdtgrp->mode = user_m;
 
 out:
 	rdtgroup_kn_unlock(of->kn);
-- 
2.21.0

