Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C855C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3984B207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbgANKRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:17:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42327 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731618AbgANKRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:17:00 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irJFn-0007hI-UY; Tue, 14 Jan 2020 11:16:56 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6B3941C192C;
        Tue, 14 Jan 2020 11:16:54 +0100 (CET)
Date:   Tue, 14 Jan 2020 10:16:54 -0000
From:   "tip-bot2 for Sean Christopherson" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/zhaoxin: Use common IA32_FEAT_CTL MSR initialization
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191221044513.21680-8-sean.j.christopherson@intel.com>
References: <20191221044513.21680-8-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Message-ID: <157899701425.1022.11243594971447018373.tip-bot2@tip-bot2>
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

Commit-ID:     7d37953ba81121c8725f99356f7ee9762d4c3ed9
Gitweb:        https://git.kernel.org/tip/7d37953ba81121c8725f99356f7ee9762d4c3ed9
Author:        Sean Christopherson <sean.j.christopherson@intel.com>
AuthorDate:    Fri, 20 Dec 2019 20:45:01 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Jan 2020 17:50:40 +01:00

x86/zhaoxin: Use common IA32_FEAT_CTL MSR initialization

Use the recently added IA32_FEAT_CTL MSR initialization sequence to
opportunistically enable VMX support when running on a Zhaoxin CPU.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20191221044513.21680-8-sean.j.christopherson@intel.com
---
 arch/x86/Kconfig.cpu          | 2 +-
 arch/x86/kernel/cpu/zhaoxin.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index cba5b64..526425f 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -389,7 +389,7 @@ config X86_DEBUGCTLMSR
 
 config IA32_FEAT_CTL
 	def_bool y
-	depends on CPU_SUP_INTEL || CPU_SUP_CENTAUR
+	depends on CPU_SUP_INTEL || CPU_SUP_CENTAUR || CPU_SUP_ZHAOXIN
 
 menuconfig PROCESSOR_SELECT
 	bool "Supported processor vendors" if EXPERT
diff --git a/arch/x86/kernel/cpu/zhaoxin.c b/arch/x86/kernel/cpu/zhaoxin.c
index 8e6f2f4..630a145 100644
--- a/arch/x86/kernel/cpu/zhaoxin.c
+++ b/arch/x86/kernel/cpu/zhaoxin.c
@@ -141,6 +141,8 @@ static void init_zhaoxin(struct cpuinfo_x86 *c)
 	set_cpu_cap(c, X86_FEATURE_LFENCE_RDTSC);
 #endif
 
+	init_ia32_feat_ctl(c);
+
 	if (cpu_has(c, X86_FEATURE_VMX))
 		zhaoxin_detect_vmx_virtcap(c);
 }
