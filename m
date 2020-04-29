Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8140C83001
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 01:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7D220737
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 01:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgD2BuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 21:50:21 -0400
Received: from mx140-tc.baidu.com ([61.135.168.140]:33259 "EHLO
        tc-sys-mailedm02.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726158AbgD2BuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 21:50:21 -0400
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm02.tc.baidu.com (Postfix) with ESMTP id 142A811C0063;
        Wed, 29 Apr 2020 09:50:07 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, peterz@infradead.org, ggherdovich@suse.cz,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com
Subject: [PATCH] x86: move turbo_disabled() out of intel_set_max_freq_ratio
Date:   Wed, 29 Apr 2020 09:50:07 +0800
Message-Id: <1588125007-8799-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

move the turbo_disabled before intel_set_max_freq_ratio,
when turbo is disabled, the max frequency ratio is a const
value, it is unnecessary to read MSR_TURBO_RATIO* msr to
compute

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/kernel/smpboot.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fe3ab9632f3b..8979c459df2f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1987,7 +1987,7 @@ static bool intel_set_max_freq_ratio(void)
 out:
 	arch_turbo_freq_ratio = div_u64(turbo_freq * SCHED_CAPACITY_SCALE,
 					base_freq);
-	arch_set_max_freq_ratio(turbo_disabled());
+	arch_set_max_freq_ratio(false);
 	return true;
 }
 
@@ -2009,6 +2009,9 @@ static void init_freq_invariance(void)
 	if (smp_processor_id() != 0 || !boot_cpu_has(X86_FEATURE_APERFMPERF))
 		return;
 
+	if (turbo_disabled())
+		return;
+
 	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
 		ret = intel_set_max_freq_ratio();
 
-- 
2.16.2

