Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44E4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B875420772
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDJHqykY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgHQFXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 01:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgHQFXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 01:23:44 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54486C061388
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 22:23:44 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p37so7573186pgl.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 22:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rvHREJoleP0JUZs3Dvt83vX65WijQycSG2RFi03WGKs=;
        b=QDJHqykYOPiXjK9hVif8fRYqxZCtxZqRXzuVfseze4T4GKQ+5BidtRUWsKFJFiC2+5
         OktCe6fkxBGeHYPJCRAm54qiktc572cEIo2LEh9bIrZbRm1kkroyEbHQOHWQHOHg49CM
         MuUSuLo5wwycxrP8HSPmJ2dFHtpHORNggrZZtalHXEHZRk4HQnXuVOKjTeKCl5u3uQ8J
         aIvCo/Fv0wRvofFqIPJ21pcgYtvZeqY6DBi4lvctvwb1MlxXj9PRIzHtUwWiSvlbO3J4
         mOY9rvaKGaVfihNSsFXgA+Alu3g3VTQd3FQ2m9hvgJBajuM1ry3GnykQxqLr8/E7uOUP
         kYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rvHREJoleP0JUZs3Dvt83vX65WijQycSG2RFi03WGKs=;
        b=rgitBSgGOcvaxY0Q3zN+vNjSM4+7mjs77GpRD3kFYKi5Xl+2jys/EOAGBsgNrscwEg
         gLsSOGg3X1tx424+T+AvXlWzO0pgl6B0y1WuVO/Jnda74wIna+CLPG8heTYaCVxxMo6R
         BsKR/loc5MBkNlI0G8yKM5oqWJibpd+pn2Vw9/z8tSkVHltN0wKkxCIwLub1EWcDIbuW
         snjZj5KYnVMiCdpe1aIXmJyHSAa6Zky0xrn3Km62txjAmlh2VRX7ZrAw9DR3/zEWdYcc
         fmd0vhio8CN2IA91J5ldM+/oty12waEsNEyFcWd27V0ljyUl0pGFri1xdFA7m1/DT7XZ
         3n/w==
X-Gm-Message-State: AOAM533o3JHNb1ZnLMUe+ThRV/o9NblU8zcilt5Bb19p5TBWVTfVTBrN
        zaNO75UdL57SXSQRHpFWmxU=
X-Google-Smtp-Source: ABdhPJxZSepobHQ9GAwcE1Tb82oTAsdlrtp659qhIYWGrs5giqtKaaDHxKJrDhawAJJZNs/yyvdCOg==
X-Received: by 2002:a63:ea41:: with SMTP id l1mr6258912pgk.419.1597641823903;
        Sun, 16 Aug 2020 22:23:43 -0700 (PDT)
Received: from localhost ([121.0.29.56])
        by smtp.gmail.com with ESMTPSA id d93sm15904744pjk.44.2020.08.16.22.23.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Aug 2020 22:23:43 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/3] x86/entry: avoid calling into sync_regs() when entering from userspace
Date:   Mon, 17 Aug 2020 14:23:53 +0800
Message-Id: <20200817062355.2884-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20200817062355.2884-1-jiangshanlai@gmail.com>
References: <CALCETrWx66qLc-NiwKS_Zu=BP8JDTzfeUO7A2vDd01kXNmiNiA@mail.gmail.com>
 <20200817062355.2884-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

7f2590a110b8("x86/entry/64: Use a per-CPU trampoline stack for IDT entries")
made a change that when any exception happens on userspace, the
entry code will save the pt_regs on the sp0 stack, and then copy it
to the thread stack via sync_regs() and switch to thread stack
afterward.

And recent x86/entry work makes interrupt also use idtentry
and makes all the interrupt code save the pt_regs on the sp0 stack
and then copy it to the thread stack like exception.

This is hot path (page fault, ipi), such overhead should be avoided.
This patch borrows the way how original interrupt_entry handles it.
It switches to the thread stack directly right away when comes
from userspace.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 43 +++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 70dea9337816..1a7715430da3 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -928,19 +928,42 @@ SYM_CODE_END(paranoid_exit)
 SYM_CODE_START_LOCAL(error_entry)
 	UNWIND_HINT_FUNC
 	cld
-	PUSH_AND_CLEAR_REGS save_ret=1
-	ENCODE_FRAME_POINTER 8
-	testb	$3, CS+8(%rsp)
+	testb	$3, CS-ORIG_RAX+8(%rsp)
 	jz	.Lerror_kernelspace
 
-	/*
-	 * We entered from user mode or we're pretending to have entered
-	 * from user mode due to an IRET fault.
-	 */
 	SWAPGS
 	FENCE_SWAPGS_USER_ENTRY
-	/* We have user CR3.  Change to kernel CR3. */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rax
+	/*
+	 * Switch to the thread stack. The IRET frame and orig_ax are
+	 * on the stack, as well as the return address. RDI..R12 are
+	 * not (yet) on the stack and space has not (yet) been
+	 * allocated for them.
+	 */
+	pushq	%rdx
+
+	/* Need to switch before accessing the thread stack. */
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdx
+	movq	%rsp, %rdx
+	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
+
+	 /*
+	  * We have RDX, return address, and orig_ax on the stack on
+	  * top of the IRET frame. That means offset=24
+	  */
+	UNWIND_HINT_IRET_REGS base=%rdx offset=24
+
+	pushq	7*8(%rdx)		/* regs->ss */
+	pushq	6*8(%rdx)		/* regs->rsp */
+	pushq	5*8(%rdx)		/* regs->eflags */
+	pushq	4*8(%rdx)		/* regs->cs */
+	pushq	3*8(%rdx)		/* regs->ip */
+	pushq	2*8(%rdx)		/* regs->orig_ax */
+	pushq	8(%rdx)			/* return address */
+	UNWIND_HINT_FUNC
+
+	PUSH_AND_CLEAR_REGS rdx=(%rdx), save_ret=1
+	ENCODE_FRAME_POINTER 8
+	ret
 
 .Lerror_entry_from_usermode_after_swapgs:
 	/* Put us onto the real thread stack. */
@@ -964,6 +987,8 @@ SYM_CODE_START_LOCAL(error_entry)
 	 * for these here too.
 	 */
 .Lerror_kernelspace:
+	PUSH_AND_CLEAR_REGS save_ret=1
+	ENCODE_FRAME_POINTER 8
 	leaq	native_irq_return_iret(%rip), %rcx
 	cmpq	%rcx, RIP+8(%rsp)
 	je	.Lerror_bad_iret
-- 
2.19.1.6.gb485710b

