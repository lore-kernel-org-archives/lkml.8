Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412A3C54FD2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 03:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCCE20724
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 03:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbgCYD1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 23:27:10 -0400
Received: from mga01.intel.com ([192.55.52.88]:39340 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727253AbgCYD1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 23:27:08 -0400
IronPort-SDR: vKhRNizHQhaRl993yZvAV8tGIzLtohcBjIyivbl1Sl8MGj/vPOjw5c+v4PwNKkA8OazxZ5suVh
 fzqJnlOMKFpg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 20:27:08 -0700
IronPort-SDR: 7I16jIMiWtO8LKycInGLDqLZkstmd2V+72W8N55D6DVRkqRoRYUaMUgMG+8SVfw7uWKIg1uYbF
 Ci9EJ083pPww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,302,1580803200"; 
   d="scan'208";a="240290011"
Received: from lxy-clx-4s.sh.intel.com ([10.239.43.39])
  by fmsmga008.fm.intel.com with ESMTP; 24 Mar 2020 20:27:05 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, luto@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v7 2/2] x86/split_lock: Avoid runtime reads of the TEST_CTRL MSR
Date:   Wed, 25 Mar 2020 11:09:24 +0800
Message-Id: <20200325030924.132881-3-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325030924.132881-1-xiaoyao.li@intel.com>
References: <20200325030924.132881-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a context switch from a task that is detecting split locks
to one that is not (or vice versa) we need to update the TEST_CTRL
MSR. Currently this is done with the common sequence:
	read the MSR
	flip the bit
	write the MSR
in order to avoid changing the value of any reserved bits in the MSR.

Cache unused and reserved bits of TEST_CTRL MSR with SPLIT_LOCK_DETECT
bit cleared during initialization, so we can avoid an expensive RDMSR
instruction during context switch.

Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Originally-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 arch/x86/kernel/cpu/intel.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index deb5c42c2089..1f414578899c 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -45,6 +45,7 @@ enum split_lock_detect_state {
  * split lock detect, unless there is a command line override.
  */
 static enum split_lock_detect_state sld_state __ro_after_init = sld_off;
+static u64 msr_test_ctrl_cache __ro_after_init;
 
 /*
  * Processors which have self-snooping capability can handle conflicting
@@ -1037,6 +1038,8 @@ static void __init split_lock_setup(void)
 		break;
 	}
 
+	rdmsrl(MSR_TEST_CTRL, msr_test_ctrl_cache);
+
 	if (!split_lock_verify_msr(true)) {
 		pr_info("MSR access failed: Disabled\n");
 		return;
@@ -1053,14 +1056,10 @@ static void __init split_lock_setup(void)
  */
 static void sld_update_msr(bool on)
 {
-	u64 test_ctrl_val;
-
-	rdmsrl(MSR_TEST_CTRL, test_ctrl_val);
+	u64 test_ctrl_val = msr_test_ctrl_cache;
 
 	if (on)
 		test_ctrl_val |= MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
-	else
-		test_ctrl_val &= ~MSR_TEST_CTRL_SPLIT_LOCK_DETECT;
 
 	wrmsrl(MSR_TEST_CTRL, test_ctrl_val);
 }
-- 
2.20.1

