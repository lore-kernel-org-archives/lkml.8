Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9518C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5C11206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 18:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403978AbgDCSZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:25:03 -0400
Received: from serv1.kernkonzept.com ([159.69.200.6]:55927 "EHLO
        mx.kernkonzept.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgDCSZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 14:25:03 -0400
X-Greylist: delayed 2421 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Apr 2020 14:25:02 EDT
Received: from muedsl-82-207-238-232.citykom.de ([82.207.238.232] helo=x1c.dd1.int.kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
        id 1jKQN3-0001aj-DO; Fri, 03 Apr 2020 19:44:45 +0200
From:   Benjamin Lamowski <benjamin.lamowski@kernkonzept.com>
To:     xiaoyao.li@intel.com
Cc:     philipp.eppelt@kernkonzept.com, bp@alien8.de, fenghua.yu@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, luto@kernel.org,
        mingo@redhat.com, nivedita@alum.mit.edu, pbonzini@redhat.com,
        peterz@infradead.org, sean.j.christopherson@intel.com,
        tglx@linutronix.de, tony.luck@intel.com, x86@kernel.org,
        Benjamin Lamowski <benjamin.lamowski@kernkonzept.com>
Subject: [PATCH 1/1] x86/split_lock: check split lock feature on initialization
Date:   Fri,  3 Apr 2020 19:44:03 +0200
Message-Id: <20200403174403.306363-2-benjamin.lamowski@kernkonzept.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200403174403.306363-1-benjamin.lamowski@kernkonzept.com>
References: <20200325030924.132881-1-xiaoyao.li@intel.com>
 <20200403174403.306363-1-benjamin.lamowski@kernkonzept.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the setup code probes for the availability of the TEST_CTRL MSR,
the current initialization code unconditionally probes it even on
systems where this architectural MSR is not available.

This commit changes the code to check for the availability of the split
lock detect feature before initializing it.

Fixes: dbaba47085b0c ("x86/split_lock: Rework the initialization flow of split lock detection")
Signed-off-by: Benjamin Lamowski <benjamin.lamowski@kernkonzept.com>
---
 arch/x86/kernel/cpu/intel.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 9a26e972cdea..70d338ff4807 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -586,7 +586,7 @@ static void init_intel_misc_features(struct cpuinfo_x86 *c)
 	wrmsrl(MSR_MISC_FEATURES_ENABLES, msr);
 }
 
-static void split_lock_init(void);
+static void split_lock_init(struct cpuinfo_x86 *c);
 
 static void init_intel(struct cpuinfo_x86 *c)
 {
@@ -703,7 +703,7 @@ static void init_intel(struct cpuinfo_x86 *c)
 	if (tsx_ctrl_state == TSX_CTRL_DISABLE)
 		tsx_disable();
 
-	split_lock_init();
+	split_lock_init(c);
 }
 
 #ifdef CONFIG_X86_32
@@ -1061,9 +1061,10 @@ static void sld_update_msr(bool on)
 	wrmsrl(MSR_TEST_CTRL, test_ctrl_val);
 }
 
-static void split_lock_init(void)
+static void split_lock_init(struct cpuinfo_x86 *c)
 {
-	split_lock_verify_msr(sld_state != sld_off);
+	if (cpu_has(c, X86_FEATURE_SPLIT_LOCK_DETECT))
+		split_lock_verify_msr(sld_state != sld_off);
 }
 
 bool handle_user_split_lock(struct pt_regs *regs, long error_code)
-- 
2.25.1

