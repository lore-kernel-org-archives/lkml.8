Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9E4C2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46A6C2071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759462;
	bh=fMRsRQ+65f7C+MmvTPcopeURpod73xJ3PavLOx/8fiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CmwcnXcqKRryprEkjN9uAGJa9N5n+8jQBel50Q+owcVXf3vW4fccfgnq9y3EtMFrn
	 S6hJSAPQfSWQ59eEoXlQ4qlYpmh58v6S5cZg1JTXX2p8AamUaBX63mflgLM0fwe1V2
	 WAc3vtMP10RSkma+SONWlF+BptupUqrRflNMCaws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389713AbgDAQoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:44:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389157AbgDAQoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:44:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2E0B206E9;
        Wed,  1 Apr 2020 16:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759457;
        bh=fMRsRQ+65f7C+MmvTPcopeURpod73xJ3PavLOx/8fiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FdZBFBN2FPqimWYi6CuuuCDcoaZLo6Weor0VSjVtd4UlhRNVcFP03/sVcjkKs5dN6
         fnjcsJa9/pkeCQ0FBzio91fPET3TYuxTIFAO3vv1HOCN5OBUv0Vv+75JDPHgNFL5NY
         lfk9WiTocPbi9Zy4v1H8GnnTa0xKFoY+VzEK/aMg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 086/148] arm64: compat: map SPSR_ELx<->PSR for signals
Date:   Wed,  1 Apr 2020 18:17:58 +0200
Message-Id: <20200401161601.333675944@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Rutland <mark.rutland@arm.com>

commit 25dc2c80cfa33153057aa94984855acd57adf92a upstream.

The SPSR_ELx format for exceptions taken from AArch32 differs from the
AArch32 PSR format. Thus, we must translate between the two when setting
up a compat sigframe, or restoring context from a compat sigframe.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Fixes: 7206dc93a58fb764 ("arm64: Expose Arm v8.4 features")
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Suzuki Poulose <suzuki.poulose@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/kernel/signal32.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -321,6 +321,7 @@ static int compat_restore_sigframe(struc
 	int err;
 	sigset_t set;
 	struct compat_aux_sigframe __user *aux;
+	unsigned long psr;
 
 	err = get_sigset_t(&set, &sf->uc.uc_sigmask);
 	if (err == 0) {
@@ -344,7 +345,9 @@ static int compat_restore_sigframe(struc
 	__get_user_error(regs->compat_sp, &sf->uc.uc_mcontext.arm_sp, err);
 	__get_user_error(regs->compat_lr, &sf->uc.uc_mcontext.arm_lr, err);
 	__get_user_error(regs->pc, &sf->uc.uc_mcontext.arm_pc, err);
-	__get_user_error(regs->pstate, &sf->uc.uc_mcontext.arm_cpsr, err);
+	__get_user_error(psr, &sf->uc.uc_mcontext.arm_cpsr, err);
+
+	regs->pstate = compat_psr_to_pstate(psr);
 
 	/*
 	 * Avoid compat_sys_sigreturn() restarting.
@@ -500,6 +503,7 @@ static int compat_setup_sigframe(struct
 				 struct pt_regs *regs, sigset_t *set)
 {
 	struct compat_aux_sigframe __user *aux;
+	unsigned long psr = pstate_to_compat_psr(regs->pstate);
 	int err = 0;
 
 	__put_user_error(regs->regs[0], &sf->uc.uc_mcontext.arm_r0, err);
@@ -518,7 +522,7 @@ static int compat_setup_sigframe(struct
 	__put_user_error(regs->compat_sp, &sf->uc.uc_mcontext.arm_sp, err);
 	__put_user_error(regs->compat_lr, &sf->uc.uc_mcontext.arm_lr, err);
 	__put_user_error(regs->pc, &sf->uc.uc_mcontext.arm_pc, err);
-	__put_user_error(regs->pstate, &sf->uc.uc_mcontext.arm_cpsr, err);
+	__put_user_error(psr, &sf->uc.uc_mcontext.arm_cpsr, err);
 
 	__put_user_error((compat_ulong_t)0, &sf->uc.uc_mcontext.trap_no, err);
 	/* set the compat FSR WnR */


