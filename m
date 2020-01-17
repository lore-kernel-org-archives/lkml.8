Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518F0C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3100C2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgAQSTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:19:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57225 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgAQSTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:19:14 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isWD8-00068N-NQ; Fri, 17 Jan 2020 19:19:10 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5504C1C19F0;
        Fri, 17 Jan 2020 19:19:10 +0100 (CET)
Date:   Fri, 17 Jan 2020 18:19:10 -0000
From:   "tip-bot2 for Tony W Wang-oc" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pti] x86/speculation/spectre_v2: Exclude Zhaoxin CPUs from
 SPECTRE_V2
Cc:     "Tony W Wang-oc" <TonyWWang-oc@zhaoxin.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1579227872-26972-2-git-send-email-TonyWWang-oc@zhaoxin.com>
References: <1579227872-26972-2-git-send-email-TonyWWang-oc@zhaoxin.com>
MIME-Version: 1.0
Message-ID: <157928515016.396.58449726740359497.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/pti branch of tip:

Commit-ID:     1e41a766c98b481400ab8c5a7aa8ea63a1bb03de
Gitweb:        https://git.kernel.org/tip/1e41a766c98b481400ab8c5a7aa8ea63a1bb03de
Author:        Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
AuthorDate:    Fri, 17 Jan 2020 10:24:31 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jan 2020 19:13:47 +01:00

x86/speculation/spectre_v2: Exclude Zhaoxin CPUs from SPECTRE_V2

New Zhaoxin family 7 CPUs are not affected by SPECTRE_V2. So define a
separate cpu_vuln_whitelist bit NO_SPECTRE_V2 and add these CPUs to the cpu
vulnerability whitelist.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/1579227872-26972-2-git-send-email-TonyWWang-oc@zhaoxin.com

---
 arch/x86/kernel/cpu/common.c |  9 ++++++++-
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
