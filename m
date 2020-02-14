Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172E0C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8E9924685
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581694000;
	bh=xrUbGDO2zFhOgr6Jpr2DTebcvshnihlSekd/HRR6A9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mZGKsJVyMz7gLmCCeSiX5CqFfIKBLgPhTazVV+V0+UlL3ODsmQvUo6+a/tYo72pkK
	 /woOv+E4EFI0PAGMovEyatlmg4KYCxsTNSEpkHCV3v1f9Nt9T5eY14ZTx7+WFkoQIR
	 bhUJ2bD9du07ehByVIiJJhGpWWzdzeGJtksykENk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387562AbgBNP0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:26:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:38406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387536AbgBNP0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:26:36 -0500
Received: from lenoir.home (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8F1D22314;
        Fri, 14 Feb 2020 15:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581693996;
        bh=xrUbGDO2zFhOgr6Jpr2DTebcvshnihlSekd/HRR6A9I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nCv09DOZAtNbNbsKvYBlzQFkW7QR2bzRHxSdcTeaHHrB6+2MJGOQowII+au9nGxIM
         mo7N4l52E8W0PlzZfX35LFu5C5ru+kYQOr2KdEubEPxY54I0pTaQVw30RHzxF8sZ3G
         ji8VtylpUyTyn63x8v81/eJt7g2pAbVMNPG2gln4=
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>
Subject: [PATCH 4/5] arm: Remove TIF_NOHZ
Date:   Fri, 14 Feb 2020 16:26:14 +0100
Message-Id: <20200214152615.25447-5-frederic@kernel.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214152615.25447-1-frederic@kernel.org>
References: <20200214152615.25447-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm entry code calls context tracking from fast path. TIF_NOHZ is unused
and can be safely removed.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Russell King <linux@armlinux.org.uk>
---
 arch/arm/Kconfig                   | 1 -
 arch/arm/include/asm/thread_info.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 38b764cae559..97864aabc2a6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -72,7 +72,6 @@ config ARM
 	select HAVE_ARM_SMCCC if CPU_V7
 	select HAVE_EBPF_JIT if !CPU_ENDIAN_BE32
 	select HAVE_CONTEXT_TRACKING
-	select HAVE_TIF_NOHZ
 	select HAVE_COPY_THREAD_TLS
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK if !XIP_KERNEL
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 0d0d5178e2c3..3609a6980c34 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -141,7 +141,6 @@ extern int vfp_restore_user_hwstate(struct user_vfp *,
 #define TIF_SYSCALL_TRACEPOINT	6	/* syscall tracepoint instrumentation */
 #define TIF_SECCOMP		7	/* seccomp syscall filtering active */
 
-#define TIF_NOHZ		12	/* in adaptive nohz mode */
 #define TIF_USING_IWMMXT	17
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_RESTORE_SIGMASK	20
-- 
2.25.0

