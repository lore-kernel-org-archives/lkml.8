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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2782CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0498C20772
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 05:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXJimjsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgHQFXy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 01:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgHQFXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 01:23:51 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240FAC061388
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 22:23:51 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d188so7666332pfd.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 22:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lX4MGl52Lwj2RqDLktcES8oPE5Th7oKu9QQhvN2v7jY=;
        b=mXJimjsCVLFGwN07Ny7dByJ3vouBK6S3ibvsZmxXm4JnTzYEIvPzYpQd9r7/SyxwAV
         OMEAtyH77MVQACvVj/bQNjHOFRLnxSuEoWonEHiJzsEr7GSJiym6cCWK95oES2cos1v+
         OX3wMVoalujQtUwV1aaQOTvDhJ6XR/98SNXU/QLW7Tvg3Jzpy/mDE8aosfOkBy84wE2l
         WXWcamaqFYduXq3Te6w2i4oxG2FuRCdz14TMyQWlr9LUW37GwNj7/c9I8yISYv4H925J
         M9OBG+jG1eODVqPkp/qTTPo4pA+hMrHtKaHTaqvO3kDe/ymk3d9C7PGBl40dNHVikrWe
         RO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lX4MGl52Lwj2RqDLktcES8oPE5Th7oKu9QQhvN2v7jY=;
        b=K+kGmicyZYC7lA/mx0nczbti9GF5hIxxz3az92wHedAIFbzuN3/gl1wCxisjyekZNT
         f0kPp4HoC9PDY/NHrXAq/fwLbOM9tZrU+E150n+ndeJFmeypWp65gBzm4mZ+mFeRKFta
         FblZ5A8MjiF2J4HHPLNqw9h6tjwrCx2i5DDERQ/1AbWl8qRL/+hz4Q59forQLLHvqcPZ
         AZ+A0pqKdF1B9PX5BZbNEo2gVnUlEv2fUPJAfebThH+77GjMhJgvMx8vFqClWOjRsSJ3
         K+QZqNLNWEowLKgJ0swrBe5fb4syuh/fFosC1BYqiW+64z/2G6cb0swzRFr1WZvDwimW
         S+AA==
X-Gm-Message-State: AOAM533LSeBuy98q81RVkFkZMP/z4z7EYh6jDBvDIZA4IdQ0j2VR4Vzw
        lptDTrGotXpAwotEbvQJpjGchCJE0Jne35Jg
X-Google-Smtp-Source: ABdhPJyDEbtVQsPGOWj+0ZwgV07yUPF2CH+IRuT0AA1Pr4lU4/stExycIprGHRU+b35/tfTbT2xPfg==
X-Received: by 2002:a62:7d0b:: with SMTP id y11mr1326662pfc.262.1597641830144;
        Sun, 16 Aug 2020 22:23:50 -0700 (PDT)
Received: from localhost ([121.0.29.56])
        by smtp.gmail.com with ESMTPSA id y4sm17676282pff.44.2020.08.16.22.23.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Aug 2020 22:23:49 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/3] x86/entry: directly switch to kernel stack when .Lerror_bad_iret
Date:   Mon, 17 Aug 2020 14:23:54 +0800
Message-Id: <20200817062355.2884-3-jiangshanlai@gmail.com>
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

Directly copy pt_regs to kernel stack when .Lerror_bad_iret.
Directly switch to kernel stack when .Lerror_bad_iret.

We can see that entry_64.S do the following things back to back
when .Lerror_bad_iret:
  call fixup_bad_iret(), switch to sp0 stack with pt_regs copied
  call sync_regs(), switch to kernel stack with pt_regs copied

So we can do the all things together in fixup_bad_iret().

After this patch, fixup_bad_iret() is restored to the behavior before
7f2590a110b8("x86/entry/64: Use a per-CPU trampoline stack for IDT entries")

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 13 ++-----------
 arch/x86/kernel/traps.c   |  9 ++++-----
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 1a7715430da3..911cfa0da637 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -965,16 +965,6 @@ SYM_CODE_START_LOCAL(error_entry)
 	ENCODE_FRAME_POINTER 8
 	ret
 
-.Lerror_entry_from_usermode_after_swapgs:
-	/* Put us onto the real thread stack. */
-	popq	%r12				/* save return addr in %12 */
-	movq	%rsp, %rdi			/* arg0 = pt_regs pointer */
-	call	sync_regs
-	movq	%rax, %rsp			/* switch stack */
-	ENCODE_FRAME_POINTER
-	pushq	%r12
-	ret
-
 .Lerror_entry_done_lfence:
 	FENCE_SWAPGS_KERNEL_ENTRY
 .Lerror_entry_done:
@@ -1028,7 +1018,8 @@ SYM_CODE_START_LOCAL(error_entry)
 	mov	%rsp, %rdi
 	call	fixup_bad_iret
 	mov	%rax, %rsp
-	jmp	.Lerror_entry_from_usermode_after_swapgs
+	ENCODE_FRAME_POINTER 8
+	ret
 SYM_CODE_END(error_entry)
 
 SYM_CODE_START_LOCAL(error_return)
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 1f66d2d1e998..852de6f1bf88 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -684,13 +684,12 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
 	/*
 	 * This is called from entry_64.S early in handling a fault
 	 * caused by a bad iret to user mode.  To handle the fault
-	 * correctly, we want to move our stack frame to where it would
-	 * be had we entered directly on the entry stack (rather than
-	 * just below the IRET frame) and we want to pretend that the
-	 * exception came from the IRET target.
+	 * correctly, we want to move our stack frame to kernel stack
+	 * (rather than just below the IRET frame) and we want to
+	 * pretend that the exception came from the IRET target.
 	 */
 	struct bad_iret_stack tmp, *new_stack =
-		(struct bad_iret_stack *)__this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
+		(struct bad_iret_stack *)__this_cpu_read(cpu_current_top_of_stack) - 1;
 
 	/* Copy the IRET target to the temporary storage. */
 	__memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
-- 
2.19.1.6.gb485710b

