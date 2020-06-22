Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AEDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9BA0206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgFVPWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729049AbgFVPWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:22:14 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE424C061795;
        Mon, 22 Jun 2020 08:22:13 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jnOGn-0003qn-MF; Mon, 22 Jun 2020 17:22:01 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 25C361C0051;
        Mon, 22 Jun 2020 17:22:01 +0200 (CEST)
Date:   Mon, 22 Jun 2020 15:22:00 -0000
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/msr: Move the F15h MSRs where they belong
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Borislav Petkov <bp@suse.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200621163323.14e8533f@canb.auug.org.au>
References: <20200621163323.14e8533f@canb.auug.org.au>
MIME-Version: 1.0
Message-ID: <159283932089.16989.16947739862636103746.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     99e40204e014e06644072c39001a269d9689e0d1
Gitweb:        https://git.kernel.org/tip/99e40204e014e06644072c39001a269d9689e0d1
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Sun, 21 Jun 2020 12:41:53 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 22 Jun 2020 17:15:53 +02:00

x86/msr: Move the F15h MSRs where they belong

1068ed4547ad ("x86/msr: Lift AMD family 0x15 power-specific MSRs")

moved the three F15h power MSRs to the architectural list but that was
wrong as they belong in the family 0x15 list. That also caused:

  In file included from trace/beauty/tracepoints/x86_msr.c:10:
  perf/trace/beauty/generated/x86_arch_MSRs_array.c:292:45: error: initialized field overwritten [-Werror=override-init]
    292 |  [0xc0010280 - x86_AMD_V_KVM_MSRs_offset] = "F15H_PTSC",
        |                                             ^~~~~~~~~~~
  perf/trace/beauty/generated/x86_arch_MSRs_array.c:292:45: note: (near initialization for 'x86_AMD_V_KVM_MSRs[640]')

due to MSR_F15H_PTSC ending up being defined twice. Move them where they
belong and drop the duplicate.

Also, drop the respective tools/ changes of the msr-index.h copy the
above commit added because perf tool developers prefer to go through
those changes themselves in order to figure out whether changes to the
kernel headers would need additional handling in perf.

Fixes: 1068ed4547ad ("x86/msr: Lift AMD family 0x15 power-specific MSRs")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Link: https://lkml.kernel.org/r/20200621163323.14e8533f@canb.auug.org.au
---
 arch/x86/include/asm/msr-index.h       | 5 ++---
 tools/arch/x86/include/asm/msr-index.h | 5 +----
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index eb95372..63ed8fe 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -422,11 +422,8 @@
 #define MSR_AMD_PERF_CTL		0xc0010062
 #define MSR_AMD_PERF_STATUS		0xc0010063
 #define MSR_AMD_PSTATE_DEF_BASE		0xc0010064
-#define MSR_F15H_CU_PWR_ACCUMULATOR     0xc001007a
-#define MSR_F15H_CU_MAX_PWR_ACCUMULATOR 0xc001007b
 #define MSR_AMD64_OSVW_ID_LENGTH	0xc0010140
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
-#define MSR_F15H_PTSC			0xc0010280
 #define MSR_AMD_PPIN_CTL		0xc00102f0
 #define MSR_AMD_PPIN			0xc00102f1
 #define MSR_AMD64_CPUID_FN_1		0xc0011004
@@ -469,6 +466,8 @@
 #define MSR_F16H_DR0_ADDR_MASK		0xc0011027
 
 /* Fam 15h MSRs */
+#define MSR_F15H_CU_PWR_ACCUMULATOR     0xc001007a
+#define MSR_F15H_CU_MAX_PWR_ACCUMULATOR 0xc001007b
 #define MSR_F15H_PERF_CTL		0xc0010200
 #define MSR_F15H_PERF_CTL0		MSR_F15H_PERF_CTL
 #define MSR_F15H_PERF_CTL1		(MSR_F15H_PERF_CTL + 2)
diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index 7dfd45b..ef452b8 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -414,18 +414,15 @@
 #define MSR_AMD64_PATCH_LEVEL		0x0000008b
 #define MSR_AMD64_TSC_RATIO		0xc0000104
 #define MSR_AMD64_NB_CFG		0xc001001f
+#define MSR_AMD64_CPUID_FN_1		0xc0011004
 #define MSR_AMD64_PATCH_LOADER		0xc0010020
 #define MSR_AMD_PERF_CTL		0xc0010062
 #define MSR_AMD_PERF_STATUS		0xc0010063
 #define MSR_AMD_PSTATE_DEF_BASE		0xc0010064
-#define MSR_F15H_CU_PWR_ACCUMULATOR     0xc001007a
-#define MSR_F15H_CU_MAX_PWR_ACCUMULATOR 0xc001007b
 #define MSR_AMD64_OSVW_ID_LENGTH	0xc0010140
 #define MSR_AMD64_OSVW_STATUS		0xc0010141
-#define MSR_F15H_PTSC			0xc0010280
 #define MSR_AMD_PPIN_CTL		0xc00102f0
 #define MSR_AMD_PPIN			0xc00102f1
-#define MSR_AMD64_CPUID_FN_1		0xc0011004
 #define MSR_AMD64_LS_CFG		0xc0011020
 #define MSR_AMD64_DC_CFG		0xc0011022
 #define MSR_AMD64_BU_CFG2		0xc001102a
