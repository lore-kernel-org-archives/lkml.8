Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C457C4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BA0120732
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgBZBRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:17:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:34983 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbgBZBRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:17:38 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 17:17:38 -0800
X-IronPort-AV: E=Sophos;i="5.70,486,1574150400"; 
   d="scan'208";a="384648699"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Feb 2020 17:17:37 -0800
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/mce: Fix logic and comments around MSR_PPIN_CTL
Date:   Tue, 25 Feb 2020 17:17:37 -0800
Message-Id: <20200226011737.9958-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two implemented bits in the PPIN_CTL MSR:

Bit0: LockOut (R/WO)
      Set 1 to prevent further writes to MSR_PPIN_CTL.

Bit 1: Enable_PPIN (R/W)
       If 1, enables MSR_PPIN to be accessible using RDMSR.
       If 0, an attempt to read MSR_PPIN will cause #GP.

So there are four defined values:
	0: PPIN is disabled, PPIN_CTL may be updated
	1: PPIN is disabled. PPIN_CTL is locked against updates
	2: PPIN is enabled. PPIN_CTL may be updated
	3: PPIN is enabled. PPIN_CTL is locked against updates

Code would only enable the X86_FEATURE_INTEL_PPIN feature for case "2".
When it should have done so for both case "2" and case "3".

Fix the final test to just check for the enable bit.
Also fix some of the other comments in this function.

Cc: <stable@vger.kernel.org>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/intel.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 5627b1091b85..f996ffb887bc 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -493,17 +493,18 @@ static void intel_ppin_init(struct cpuinfo_x86 *c)
 			return;
 
 		if ((val & 3UL) == 1UL) {
-			/* PPIN available but disabled: */
+			/* PPIN locked in disabled mode */
 			return;
 		}
 
-		/* If PPIN is disabled, but not locked, try to enable: */
-		if (!(val & 3UL)) {
+		/* If PPIN is disabled, try to enable */
+		if (!(val & 2UL)) {
 			wrmsrl_safe(MSR_PPIN_CTL,  val | 2UL);
 			rdmsrl_safe(MSR_PPIN_CTL, &val);
 		}
 
-		if ((val & 3UL) == 2UL)
+		/* Is the enable bit set? */
+		if (val & 2UL)
 			set_cpu_cap(c, X86_FEATURE_INTEL_PPIN);
 	}
 }
-- 
2.21.1

