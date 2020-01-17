Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB53C33CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 02:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F21C2064C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 02:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388502AbgAQCYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 21:24:11 -0500
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:61840 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726726AbgAQCYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 21:24:10 -0500
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 17 Jan
 2020 10:24:06 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.64.11) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Fri, 17 Jan
 2020 10:24:04 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <luto@kernel.org>,
        <pawan.kumar.gupta@linux.intel.com>, <peterz@infradead.org>,
        <fenghua.yu@intel.com>, <vineela.tummalapalli@intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     <DavidWang@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>
Subject: [PATCH v1 1/2] x86/speculation/spectre_v2: Exclude Zhaoxin CPUs from SPECTRE_V2
Date:   Fri, 17 Jan 2020 10:24:31 +0800
Message-ID: <1579227872-26972-2-git-send-email-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1579227872-26972-1-git-send-email-TonyWWang-oc@zhaoxin.com>
References: <1579227872-26972-1-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.64.11]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New Zhaoxin family 7 CPUs are not affected by SPECTRE_V2. So create
a separate cpu_vuln_whitelist flag bit NO_SPECTRE_V2 and add these
CPUs to the cpu vulnerability whitelist.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/common.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2e4d902..6048bd3 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1023,6 +1023,7 @@ static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
 #define MSBDS_ONLY		BIT(5)
 #define NO_SWAPGS		BIT(6)
 #define NO_ITLB_MULTIHIT	BIT(7)
+#define NO_SPECTRE_V2		BIT(8)
 
 #define VULNWL(_vendor, _family, _model, _whitelist)	\
 	{ X86_VENDOR_##_vendor, _family, _model, X86_FEATURE_ANY, _whitelist }
@@ -1084,6 +1085,10 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 	/* FAMILY_ANY must be last, otherwise 0x0f - 0x12 matches won't work */
 	VULNWL_AMD(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT),
 	VULNWL_HYGON(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT),
+
+	/* Zhaoxin Family 7 */
+	VULNWL(CENTAUR,	7, X86_MODEL_ANY,	NO_SPECTRE_V2),
+	VULNWL(ZHAOXIN,	7, X86_MODEL_ANY,	NO_SPECTRE_V2),
 	{}
 };
 
@@ -1116,7 +1121,9 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 		return;
 
 	setup_force_cpu_bug(X86_BUG_SPECTRE_V1);
-	setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
+
+	if (!cpu_matches(NO_SPECTRE_V2))
+		setup_force_cpu_bug(X86_BUG_SPECTRE_V2);
 
 	if (!cpu_matches(NO_SSB) && !(ia32_cap & ARCH_CAP_SSB_NO) &&
 	   !cpu_has(c, X86_FEATURE_AMD_SSB_NO))
-- 
2.7.4

