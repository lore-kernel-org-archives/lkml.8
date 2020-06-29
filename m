Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC30C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C4420656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728999AbgF2Swl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:52:41 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:49426 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726889AbgF2Swc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:32 -0400
X-Greylist: delayed 903 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jun 2020 14:52:31 EDT
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 29 Jun
 2020 19:21:36 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.56.13) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Mon, 29 Jun
 2020 19:21:33 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <tony.luck@intel.com>,
        <pawan.kumar.gupta@linux.intel.com>, <jpoimboe@redhat.com>,
        <peterz@infradead.org>, <thellstrom@vmware.com>,
        <mgross@linux.intel.com>, <kim.phillips@amd.com>,
        <linux-kernel@vger.kernel.org>
CC:     <DavidWang@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>,
        <CobeChen@zhaoxin.com>
Subject: [PATCH] x86/cpufeatures: Add new Zhaoxin CPU features
Date:   Mon, 29 Jun 2020 19:21:29 +0800
Message-ID: <1593429689-25131-1-git-send-email-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.56.13]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new Zhaoxin CPU features for enumeration in /proc/cpuinfo:
SM2, SM2_EN, SM3, SM4, SM3_EN, SM4_EN, PARALLAX, PARALLAX_EN,
TM3, TM3_EN, RNG2, RNG2_EN, PHE2, PHE2_EN, RSA, RSA_EN.

CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 0]  SM2
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 1]  SM2_EN
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 4]  SM3 SM4
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 5]  SM3_EN SM4_EN
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 16] PARALLAX
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 17] PARALLAX_EN
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 20] TM3
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 21] TM3_EN
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 22] RNG2
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 23] RNG2_EN
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 25] PHE2
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 26] PHE2_EN
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 27] RSA
CPUID.(EAX=0xc0000001,ECX=0):EDX[bit 28] RSA_EN

SM2, SM3, SM4 are Chinese Cipher Security algorithm.
PARALLAX is a feature that automatically adjusts processors's voltage
as a function of temperature.
TM3 is Zhaoxin CPU Thermal Monitor v3.
RNG2 is Zhaoxin Random Number Generation v2.
PHE2 is Zhaoxin Padlock Hash Engine v2.
RSA is Zhaoxin hardware support for RSA algorithm.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/include/asm/cpufeatures.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index c693ebf..a6c2d2b 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -145,9 +145,13 @@
 #define X86_FEATURE_RDRAND		( 4*32+30) /* RDRAND instruction */
 #define X86_FEATURE_HYPERVISOR		( 4*32+31) /* Running on a hypervisor */
 
-/* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5 */
+/* VIA/Cyrix/Centaur/Zhaoxin-defined CPU features, CPUID level 0xC0000001, word 5 */
+#define X86_FEATURE_SM2			( 5*32+ 0) /* Chinese cipher security hardware support of SM2 */
+#define X86_FEATURE_SM2_EN		( 5*32+ 1) /* SM2 enabled */
 #define X86_FEATURE_XSTORE		( 5*32+ 2) /* "rng" RNG present (xstore) */
 #define X86_FEATURE_XSTORE_EN		( 5*32+ 3) /* "rng_en" RNG enabled */
+#define X86_FEATURE_CCS			( 5*32+ 4) /* "sm3 sm4" Chinese Cipher Security hardware support*/
+#define X86_FEATURE_CCS_EN		( 5*32+ 5) /* "sm3_en sm4_en" sm3 sm4 enabled */
 #define X86_FEATURE_XCRYPT		( 5*32+ 6) /* "ace" on-CPU crypto (xcrypt) */
 #define X86_FEATURE_XCRYPT_EN		( 5*32+ 7) /* "ace_en" on-CPU crypto enabled */
 #define X86_FEATURE_ACE2		( 5*32+ 8) /* Advanced Cryptography Engine v2 */
@@ -156,6 +160,16 @@
 #define X86_FEATURE_PHE_EN		( 5*32+11) /* PHE enabled */
 #define X86_FEATURE_PMM			( 5*32+12) /* PadLock Montgomery Multiplier */
 #define X86_FEATURE_PMM_EN		( 5*32+13) /* PMM enabled */
+#define X86_FEATURE_PARALLAX		( 5*32+16) /* Parallax auto adjust processor voltage */
+#define X86_FEATURE_PARALLAX_EN		( 5*32+17) /* Parallax auto adjust processor voltage enabled */
+#define X86_FEATURE_TM3			( 5*32+20) /* Thermal Monitor v3 support */
+#define X86_FEATURE_TM3_EN		( 5*32+21) /* TM3 enabled */
+#define X86_FEATURE_RNG2		( 5*32+22) /* RNG v2 present */
+#define X86_FEATURE_RNG2_EN		( 5*32+23) /* RNG v2 enabled */
+#define X86_FEATURE_PHE2		( 5*32+25) /* PHE v2 present */
+#define X86_FEATURE_PHE2_EN		( 5*32+26) /* PHE v2 enabled */
+#define X86_FEATURE_RSA			( 5*32+27) /* RSA hardware support */
+#define X86_FEATURE_RSA_EN		( 5*32+28) /* RSA enabled */
 
 /* More extended AMD flags: CPUID level 0x80000001, ECX, word 6 */
 #define X86_FEATURE_LAHF_LM		( 6*32+ 0) /* LAHF/SAHF in long mode */
-- 
2.7.4

