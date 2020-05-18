Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455F7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27FF920835
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824009;
	bh=jH7gTIliVxxfxhV+AmfMIuFNThbagTKS2LMc0asBq8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1CXvtvEa4DBI9bPYRovpzqa70/MlU2/dIdTbHgb7Eo3MVYLt9c1+QM+WsmlrRGTTK
	 a4sBsEcCrWTnl+WCI7PatIvhh0RL/X5Xbpi0BEZThvsHGlJNv/lRg2Xfg7RNLjED5i
	 1AibIZiQ2+J6rwu4OHjaAQjMZMeqDjLCXvPmKCpY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbgERRqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:46:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:46382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730110AbgERRqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:46:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B64D20671;
        Mon, 18 May 2020 17:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823996;
        bh=jH7gTIliVxxfxhV+AmfMIuFNThbagTKS2LMc0asBq8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aN1V0YWCFBUO38FDO++vfqYppTF1FBwHJCFb+Ufmzmdxh9MT7b6qyNTuqKxmJMH3+
         9wH1scydWQFyAhaGAACc5KItE65KUiueqAD081szdIWY47AkA9hnfzKKE9+zZpAjNG
         HZiEaMzQpsEc2+FKmR/fI+AFfaXK8Ytrfi1AdGyo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Joe Mario <jmario@redhat.com>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 4.14 029/114] x86/entry/64: Fix unwind hints in kernel exit path
Date:   Mon, 18 May 2020 19:36:01 +0200
Message-Id: <20200518173509.026210081@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173503.033975649@linuxfoundation.org>
References: <20200518173503.033975649@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Poimboeuf <jpoimboe@redhat.com>

commit 1fb143634a38095b641a3a21220774799772dc4c upstream.

In swapgs_restore_regs_and_return_to_usermode, after the stack is
switched to the trampoline stack, the existing UNWIND_HINT_REGS hint is
no longer valid, which can result in the following ORC unwinder warning:

  WARNING: can't dereference registers at 000000003aeb0cdd for ip swapgs_restore_regs_and_return_to_usermode+0x93/0xa0

For full correctness, we could try to add complicated unwind hints so
the unwinder could continue to find the registers, but when when it's
this close to kernel exit, unwind hints aren't really needed anymore and
it's fine to just use an empty hint which tells the unwinder to stop.

For consistency, also move the UNWIND_HINT_EMPTY in
entry_SYSCALL_64_after_hwframe to a similar location.

Fixes: 3e3b9293d392 ("x86/entry/64: Return to userspace from the trampoline stack")
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Reported-by: Dave Jones <dsj@fb.com>
Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reported-by: Joe Mario <jmario@redhat.com>
Reported-by: Jann Horn <jannh@google.com>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/60ea8f562987ed2d9ace2977502fe481c0d7c9a0.1587808742.git.jpoimboe@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/entry_64.S |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -302,7 +302,6 @@ GLOBAL(entry_SYSCALL_64_after_hwframe)
 	 */
 syscall_return_via_sysret:
 	/* rcx and r11 are already restored (see code above) */
-	UNWIND_HINT_EMPTY
 	POP_REGS pop_rdi=0 skip_r11rcx=1
 
 	/*
@@ -311,6 +310,7 @@ syscall_return_via_sysret:
 	 */
 	movq	%rsp, %rdi
 	movq	PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %rsp
+	UNWIND_HINT_EMPTY
 
 	pushq	RSP-RDI(%rdi)	/* RSP */
 	pushq	(%rdi)		/* RDI */
@@ -606,6 +606,7 @@ GLOBAL(swapgs_restore_regs_and_return_to
 	 */
 	movq	%rsp, %rdi
 	movq	PER_CPU_VAR(cpu_tss_rw + TSS_sp0), %rsp
+	UNWIND_HINT_EMPTY
 
 	/* Copy the IRET frame to the trampoline stack. */
 	pushq	6*8(%rdi)	/* SS */


