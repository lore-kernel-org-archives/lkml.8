Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E27FC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A65D206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xsEoUGLy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h3xAjGS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgIAOSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgIALt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:49:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AECE5C061258;
        Tue,  1 Sep 2020 04:48:02 -0700 (PDT)
Date:   Tue, 01 Sep 2020 11:47:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598960878;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QxQGD3orW6Tw8fMSFhy6+mq1binzzE0l0OZ3Nu2XiJo=;
        b=xsEoUGLyeMdxgqI/TyKy7fbqX+aaD6cy6odKKwipVHLzLskKaS0a1Sxz7Z/NtXfJJ+FlWd
        kaGMu10yUPe1cIn3oR+e3zN1u1AdszjeNnIO8zuUgzhbgerXynXoJVGT0khkCgYHjvZ8eU
        hl9fxHnADG5KycRjf9aKSwx8L2aKbX5kTt5gbEKPfyEGqYAF9z2iuo2DkVsNpGlw1rVKYZ
        DtEWNbZk6WvtDsl95V6xuQ/gBLNn5e+WCGhgYLSwjvVex3vnhAIOnaXWSsjyI2DFQJ2E9r
        VsAntu78Q+SBZxxNVk5pddXR6R/qgb6np0Fw7JQSWn84zhBBVSTVTKFIPE2hkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598960878;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QxQGD3orW6Tw8fMSFhy6+mq1binzzE0l0OZ3Nu2XiJo=;
        b=h3xAjGS8VUsYkn/hNG24eHmB9dd5+Jgu8A0vVZxHwg9Aghtgoj/bXGINEL9mA5BBPGlqzB
        kq1z1qO6KORwr8DQ==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/build] arm64/kernel: Remove needless Call Frame
 Information annotations
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821194310.3089815-10-keescook@chromium.org>
References: <20200821194310.3089815-10-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <159896087826.20229.6704483539643786154.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/build branch of tip:

Commit-ID:     34b4a5c54c429d12bcc783a27650752237c49a36
Gitweb:        https://git.kernel.org/tip/34b4a5c54c429d12bcc783a27650752237c49a36
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Fri, 21 Aug 2020 12:42:50 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Sep 2020 09:50:36 +02:00

arm64/kernel: Remove needless Call Frame Information annotations

Remove last instance of an .eh_frame section by removing the needless Call
Frame Information annotations which were likely leftovers from 32-bit ARM.

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lore.kernel.org/r/20200821194310.3089815-10-keescook@chromium.org
---
 arch/arm64/kernel/smccc-call.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/smccc-call.S b/arch/arm64/kernel/smccc-call.S
index 1f93809..d624479 100644
--- a/arch/arm64/kernel/smccc-call.S
+++ b/arch/arm64/kernel/smccc-call.S
@@ -9,7 +9,6 @@
 #include <asm/assembler.h>
 
 	.macro SMCCC instr
-	.cfi_startproc
 	\instr	#0
 	ldr	x4, [sp]
 	stp	x0, x1, [x4, #ARM_SMCCC_RES_X0_OFFS]
@@ -21,7 +20,6 @@
 	b.ne	1f
 	str	x6, [x4, ARM_SMCCC_QUIRK_STATE_OFFS]
 1:	ret
-	.cfi_endproc
 	.endm
 
 /*
