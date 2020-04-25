Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29DFEC55196
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B32720857
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1k5wSrJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgDYKDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:03:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22767 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726035AbgDYKDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587809008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6lo1IW+Fx9gfrhLibtanrRKfPrv1DjFqbaGSJF5R+iY=;
        b=I1k5wSrJ504AsGK9ZFbtEf2MOqnk2NsxAWbejeeQlrvWoLS8trLybZfJdetMu2emg1qp8i
        rZggb580iB6LYskzz2+FF3ppjMp477V+LGxopmmNc2PKRRxhIIDZyUGTfE/tv3ULZ0tg/1
        r5ThMBX5B/TuYPpQFHK67JPhOYaeFvo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-JQU6IC3bOoKVgcJ5x_ZaZQ-1; Sat, 25 Apr 2020 06:03:24 -0400
X-MC-Unique: JQU6IC3bOoKVgcJ5x_ZaZQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7968B180F127;
        Sat, 25 Apr 2020 10:03:22 +0000 (UTC)
Received: from treble.redhat.com (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4160F60623;
        Sat, 25 Apr 2020 10:03:21 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 02/11] x86/entry/64: Fix unwind hints in register clearing code
Date:   Sat, 25 Apr 2020 05:03:01 -0500
Message-Id: <68fd3d0bc92ae2d62ff7879d15d3684217d51f08.1587808742.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1587808742.git.jpoimboe@redhat.com>
References: <cover.1587808742.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PUSH_AND_CLEAR_REGS macro zeroes each register immediately after
pushing it.  If an NMI or exception hits after a register is cleared,
but before the UNWIND_HINT_REGS annotation, the ORC unwinder will
wrongly think the previous value of the register was zero.  This can
confuse the unwinding process and cause it to exit early.

Because ORC is simpler than DWARF, there are a limited number of unwind
annotation states, so it's not possible to add an individual unwind hint
after each push/clear combination.  Instead, the register clearing
instructions need to be consolidated and moved to after the
UNWIND_HINT_REGS annotation.

Fixes: 3f01daecd545 ("x86/entry/64: Introduce the PUSH_AND_CLEAN_REGS mac=
ro")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
---
 arch/x86/entry/calling.h | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 0789e13ece90..1c7f13bb6728 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -98,13 +98,6 @@ For 32-bit we have the following conventions - kernel =
is built with
 #define SIZEOF_PTREGS	21*8
=20
 .macro PUSH_AND_CLEAR_REGS rdx=3D%rdx rax=3D%rax save_ret=3D0
-	/*
-	 * Push registers and sanitize registers of values that a
-	 * speculation attack might otherwise want to exploit. The
-	 * lower registers are likely clobbered well before they
-	 * could be put to use in a speculative execution gadget.
-	 * Interleave XOR with PUSH for better uop scheduling:
-	 */
 	.if \save_ret
 	pushq	%rsi		/* pt_regs->si */
 	movq	8(%rsp), %rsi	/* temporarily store the return address in %rsi */
@@ -114,34 +107,43 @@ For 32-bit we have the following conventions - kern=
el is built with
 	pushq   %rsi		/* pt_regs->si */
 	.endif
 	pushq	\rdx		/* pt_regs->dx */
-	xorl	%edx, %edx	/* nospec   dx */
 	pushq   %rcx		/* pt_regs->cx */
-	xorl	%ecx, %ecx	/* nospec   cx */
 	pushq   \rax		/* pt_regs->ax */
 	pushq   %r8		/* pt_regs->r8 */
-	xorl	%r8d, %r8d	/* nospec   r8 */
 	pushq   %r9		/* pt_regs->r9 */
-	xorl	%r9d, %r9d	/* nospec   r9 */
 	pushq   %r10		/* pt_regs->r10 */
-	xorl	%r10d, %r10d	/* nospec   r10 */
 	pushq   %r11		/* pt_regs->r11 */
-	xorl	%r11d, %r11d	/* nospec   r11*/
 	pushq	%rbx		/* pt_regs->rbx */
-	xorl    %ebx, %ebx	/* nospec   rbx*/
 	pushq	%rbp		/* pt_regs->rbp */
-	xorl    %ebp, %ebp	/* nospec   rbp*/
 	pushq	%r12		/* pt_regs->r12 */
-	xorl	%r12d, %r12d	/* nospec   r12*/
 	pushq	%r13		/* pt_regs->r13 */
-	xorl	%r13d, %r13d	/* nospec   r13*/
 	pushq	%r14		/* pt_regs->r14 */
-	xorl	%r14d, %r14d	/* nospec   r14*/
 	pushq	%r15		/* pt_regs->r15 */
-	xorl	%r15d, %r15d	/* nospec   r15*/
 	UNWIND_HINT_REGS
+
 	.if \save_ret
 	pushq	%rsi		/* return address on top of stack */
 	.endif
+
+	/*
+	 * Sanitize registers of values that a speculation attack might
+	 * otherwise want to exploit. The lower registers are likely clobbered
+	 * well before they could be put to use in a speculative execution
+	 * gadget.
+	 */
+	xorl	%edx,  %edx	/* nospec dx  */
+	xorl	%ecx,  %ecx	/* nospec cx  */
+	xorl	%r8d,  %r8d	/* nospec r8  */
+	xorl	%r9d,  %r9d	/* nospec r9  */
+	xorl	%r10d, %r10d	/* nospec r10 */
+	xorl	%r11d, %r11d	/* nospec r11 */
+	xorl	%ebx,  %ebx	/* nospec rbx */
+	xorl	%ebp,  %ebp	/* nospec rbp */
+	xorl	%r12d, %r12d	/* nospec r12 */
+	xorl	%r13d, %r13d	/* nospec r13 */
+	xorl	%r14d, %r14d	/* nospec r14 */
+	xorl	%r15d, %r15d	/* nospec r15 */
+
 .endm
=20
 .macro POP_REGS pop_rdi=3D1 skip_r11rcx=3D0
--=20
2.21.1

