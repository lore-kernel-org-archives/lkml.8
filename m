Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF180C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0AC12082E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 04:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589172833;
	bh=Uf/dQt3pOb42ZMkyeOF+KZniQCmaCDN+4LcrOHEj2qc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wpruWu+J7wfgdBsECk9mbEICFzaF1wVPSLYi5BCLwm/k0fPWIcaMfFd6XJoDyS2Oj
	 bFejk1Wm8S0duuZwDJ37te6uFqdX+m9UyUX0DOdAd7Jg55P1C+xHHTN4LO7kTa8oW6
	 UfLx6roVzcaQ+zlB/dr+bMJwkRhUivtpAMrqpsKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgEKExx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 00:53:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728989AbgEKExu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 00:53:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE9442184D;
        Mon, 11 May 2020 04:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589172829;
        bh=Uf/dQt3pOb42ZMkyeOF+KZniQCmaCDN+4LcrOHEj2qc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bjqDFAomX2xBIvyoY7/YfoUgsg8v2Towsjn+NYNS9GZ1Df8x8h8UdLLVfy6Rw2Ep7
         ynGlmrSuaGJaa4py+Gtcgmhkb/vY0vzUGkYNW+iP6+dJkbh/Jn2DVtLSaNEZfDBXei
         qdKGWNHviFQB0cb3hOD7/S2l8xbck2ZJApfASBV8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>
Subject: [PATCH v12 17/18] x86/elf: Enumerate kernel FSGSBASE capability in AT_HWCAP2
Date:   Mon, 11 May 2020 00:53:10 -0400
Message-Id: <20200511045311.4785-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511045311.4785-1-sashal@kernel.org>
References: <20200511045311.4785-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

The kernel needs to explicitly enable FSGSBASE. So, the application needs
to know if it can safely use these instructions. Just looking at the CPUID
bit is not enough because it may be running in a kernel that does not
enable the instructions.

One way for the application would be to just try and catch the SIGILL.
But that is difficult to do in libraries which may not want to overwrite
the signal handlers of the main application.

Enumerate the enabled FSGSBASE capability in bit 1 of AT_HWCAP2 in the ELF
aux vector. AT_HWCAP2 is already used by PPC for similar purposes.

The application can access it open coded or by using the getauxval()
function in newer versions of glibc.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
---
 arch/x86/include/uapi/asm/hwcap2.h | 3 +++
 arch/x86/kernel/cpu/common.c       | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/hwcap2.h b/arch/x86/include/uapi/asm/hwcap2.h
index 8b2effe6efb82..5fdfcb47000f9 100644
--- a/arch/x86/include/uapi/asm/hwcap2.h
+++ b/arch/x86/include/uapi/asm/hwcap2.h
@@ -5,4 +5,7 @@
 /* MONITOR/MWAIT enabled in Ring 3 */
 #define HWCAP2_RING3MWAIT		(1 << 0)
 
+/* Kernel allows FSGSBASE instructions available in Ring 3 */
+#define HWCAP2_FSGSBASE			BIT(1)
+
 #endif
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 0d480cbadc7dc..b5a086ea34258 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1495,8 +1495,10 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 	setup_umip(c);
 
 	/* Enable FSGSBASE instructions if available. */
-	if (cpu_has(c, X86_FEATURE_FSGSBASE))
+	if (cpu_has(c, X86_FEATURE_FSGSBASE)) {
 		cr4_set_bits(X86_CR4_FSGSBASE);
+		elf_hwcap2 |= HWCAP2_FSGSBASE;
+	}
 
 	/*
 	 * The vendor-specific functions might have changed features.
-- 
2.20.1

