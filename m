Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7E8C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 06:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6CC20768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 06:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgCRGd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 02:33:57 -0400
Received: from mga17.intel.com ([192.55.52.151]:59647 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgCRGd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 02:33:57 -0400
IronPort-SDR: 22YJcNclYrVFdmQUFuXYKOhZYEv1rCOjCvukpkODvJ/m6LumKPTWWxBTuHWRyAhaH4G+WPU96H
 K2rqdh99Z2Tg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 23:33:56 -0700
IronPort-SDR: D/3ToO4N56EOzqqQi6Ztwn214LULD8LKfUysvs3aQ/pE5axxi5YEUgYwjRjNwPp1byH9CFKdLT
 tYiQwxgSGi8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,566,1574150400"; 
   d="scan'208";a="268248630"
Received: from unknown (HELO lxy-clx-4s.sh.intel.com) ([10.239.43.66])
  by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2020 23:33:52 -0700
From:   Xiaoyao Li <xiaoyao.li@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     xiaoyao.li@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpufeatures: make bits in cpu_caps_cleared[] and cpu_cpus_set[] exclusive
Date:   Wed, 18 Mar 2020 14:16:24 +0800
Message-Id: <20200318061624.150313-1-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In apply_forced_caps(), cpu_caps_set[] overrides cpu_caps_cleared[], so
that setup_clear_cpu_cap() cannot clear one cap if setup_force_cpu_cap()
sets the cap before it.

Explicitly clear the bit in cpu_caps_cleared[] when set it in
cpu_caps_set[], and vice versa, can fix this.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 arch/x86/include/asm/cpufeature.h | 1 +
 arch/x86/kernel/cpu/cpuid-deps.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index 59bf91c57aa8..f6d976b05d2c 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -144,6 +144,7 @@ extern void clear_cpu_cap(struct cpuinfo_x86 *c, unsigned int bit);
 #define setup_force_cpu_cap(bit) do { \
 	set_cpu_cap(&boot_cpu_data, bit);	\
 	set_bit(bit, (unsigned long *)cpu_caps_set);	\
+	clear_bit(bit, (unsigned long *)cpu_caps_cleared);	\
 } while (0)
 
 #define setup_force_cpu_bug(bit) setup_force_cpu_cap(bit)
diff --git a/arch/x86/kernel/cpu/cpuid-deps.c b/arch/x86/kernel/cpu/cpuid-deps.c
index 3cbe24ca80ab..e16c36094e6c 100644
--- a/arch/x86/kernel/cpu/cpuid-deps.c
+++ b/arch/x86/kernel/cpu/cpuid-deps.c
@@ -82,6 +82,7 @@ static inline void clear_feature(struct cpuinfo_x86 *c, unsigned int feature)
 	if (!c) {
 		clear_cpu_cap(&boot_cpu_data, feature);
 		set_bit(feature, (unsigned long *)cpu_caps_cleared);
+		clear_bit(feature, (unsigned long *)cpu_caps_set);
 	} else {
 		clear_bit(feature, (unsigned long *)c->x86_capability);
 	}
-- 
2.20.1

