Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBDEC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF1F20724
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:33:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCLLdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:33:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42949 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgCLLdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 07:33:21 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jCM5U-0001MW-HU; Thu, 12 Mar 2020 12:33:16 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EBA5E1C222D;
        Thu, 12 Mar 2020 12:33:15 +0100 (CET)
Date:   Thu, 12 Mar 2020 11:33:15 -0000
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/amd: Call init_amd_zn() om Family 19h processors too
Cc:     Kim Phillips <kim.phillips@amd.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200311191451.13221-1-kim.phillips@amd.com>
References: <20200311191451.13221-1-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <158401279562.28353.13562420867204506851.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     753039ef8b2f1078e5bff8cd42f80578bf6385b0
Gitweb:        https://git.kernel.org/tip/753039ef8b2f1078e5bff8cd42f80578bf6385b0
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Wed, 11 Mar 2020 14:14:51 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 12 Mar 2020 12:13:44 +01:00

x86/cpu/amd: Call init_amd_zn() om Family 19h processors too

Family 19h CPUs are Zen-based and still share most architectural
features with Family 17h CPUs, and therefore still need to call
init_amd_zn() e.g., to set the RECLAIM_DISTANCE override.

init_amd_zn() also sets X86_FEATURE_ZEN, which today is only used
in amd_set_core_ssb_state(), which isn't called on some late
model Family 17h CPUs, nor on any Family 19h CPUs:
X86_FEATURE_AMD_SSBD replaces X86_FEATURE_LS_CFG_SSBD on those
later model CPUs, where the SSBD mitigation is done via the
SPEC_CTRL MSR instead of the LS_CFG MSR.

Family 19h CPUs also don't have the erratum where the CPB feature
bit isn't set, but that code can stay unchanged and run safely
on Family 19h.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200311191451.13221-1-kim.phillips@amd.com
---
 arch/x86/include/asm/cpufeatures.h | 2 +-
 arch/x86/kernel/cpu/amd.c          | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f3327cb..f980efc 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -217,7 +217,7 @@
 #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
-#define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
+#define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 or above (Zen) */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
 #define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL configured */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index ac83a0f..dc6894a 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -925,7 +925,8 @@ static void init_amd(struct cpuinfo_x86 *c)
 	case 0x12: init_amd_ln(c); break;
 	case 0x15: init_amd_bd(c); break;
 	case 0x16: init_amd_jg(c); break;
-	case 0x17: init_amd_zn(c); break;
+	case 0x17: fallthrough;
+	case 0x19: init_amd_zn(c); break;
 	}
 
 	/*
