Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB08EC55196
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968072074F
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xr0FbjmV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgDYKGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:06:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55665 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726022AbgDYKG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:06:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587809187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tFHVWgZ3Q6lqkjVpUZxJz1LMZI6oDPg3glv0IYIJkNc=;
        b=Xr0FbjmVdbj3xfrcRhyXrV5S7Skwtvt0kWNiktVzxpGw/XqLPd+QmW8JZKK9CsSjBhC8BO
        ohXD6/NHJm5vQs9cb15spFVdrNGvCnbfKvViv54+jIhhVZUhnnOGrkJK5l6Nq/LboO7Os7
        3i8HeEg9sQ9wx6ic2Uxvc3XtYhD9Ikk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-joLo1Sq8M2ORiAAmYbZsNA-1; Sat, 25 Apr 2020 06:06:22 -0400
X-MC-Unique: joLo1Sq8M2ORiAAmYbZsNA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42ED445F;
        Sat, 25 Apr 2020 10:06:21 +0000 (UTC)
Received: from treble.redhat.com (ovpn-114-29.rdu2.redhat.com [10.10.114.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1981260BE1;
        Sat, 25 Apr 2020 10:06:20 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v2 11/11] x86/unwind/orc: Fix premature unwind stoppage due to IRET frames
Date:   Sat, 25 Apr 2020 05:06:14 -0500
Message-Id: <97a408167cc09f1cfa0de31a7b70dd88868d743f.1587808742.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1587808742.git.jpoimboe@redhat.com>
References: <cover.1587808742.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following execution path is possible:

  fsnotify()
    [ realign the stack and store previous SP in R10 ]
    <IRQ>
      [ only IRET regs saved ]
      common_interrupt()
        interrupt_entry()
	  <NMI>
	    [ full pt_regs saved ]
	    ...
	    [ unwind stack ]

When the unwinder goes through the NMI and the IRQ on the stack, and
then sees fsnotify(), it doesn't have access to the value of R10,
because it only has the five IRET registers.  So the unwind stops
prematurely.

However, because the interrupt_entry() code is careful not to clobber
R10 before saving the full regs, the unwinder should be able to read R10
from the previously saved full pt_regs associated with the NMI.

Handle this case properly.  When encountering an IRET regs frame
immediately after a full pt_regs frame, use the pt_regs as a backup
which can be used to get the C register values.

Also, note that a call frame resets the 'prev_regs' value, because a
function is free to clobber the registers.  For this fix to work, the
IRET and full regs frames must be adjacent, with no FUNC frames in
between.  So replace the FUNC hint in interrupt_entry() with an
IRET_REGS hint.

Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
---
 arch/x86/entry/entry_64.S     |  4 +--
 arch/x86/include/asm/unwind.h |  2 +-
 arch/x86/kernel/unwind_orc.c  | 51 +++++++++++++++++++++++++++--------
 3 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9fe0d5cad8e4..3063aa9090f9 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -511,7 +511,7 @@ SYM_CODE_END(spurious_entries_start)
  * +----------------------------------------------------+
  */
 SYM_CODE_START(interrupt_entry)
-	UNWIND_HINT_FUNC
+	UNWIND_HINT_IRET_REGS offset=3D16
 	ASM_CLAC
 	cld
=20
@@ -543,9 +543,9 @@ SYM_CODE_START(interrupt_entry)
 	pushq	5*8(%rdi)		/* regs->eflags */
 	pushq	4*8(%rdi)		/* regs->cs */
 	pushq	3*8(%rdi)		/* regs->ip */
+	UNWIND_HINT_IRET_REGS
 	pushq	2*8(%rdi)		/* regs->orig_ax */
 	pushq	8(%rdi)			/* return address */
-	UNWIND_HINT_FUNC
=20
 	movq	(%rdi), %rdi
 	jmp	2f
diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.=
h
index 499578f7e6d7..70fc159ebe69 100644
--- a/arch/x86/include/asm/unwind.h
+++ b/arch/x86/include/asm/unwind.h
@@ -19,7 +19,7 @@ struct unwind_state {
 #if defined(CONFIG_UNWINDER_ORC)
 	bool signal, full_regs;
 	unsigned long sp, bp, ip;
-	struct pt_regs *regs;
+	struct pt_regs *regs, *prev_regs;
 #elif defined(CONFIG_UNWINDER_FRAME_POINTER)
 	bool got_irq;
 	unsigned long *bp, *orig_sp, ip;
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 33b80a7f998f..0ebc11a8bb45 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -384,9 +384,38 @@ static bool deref_stack_iret_regs(struct unwind_stat=
e *state, unsigned long addr
 	return true;
 }
=20
+/*
+ * If state->regs is non-NULL, and points to a full pt_regs, just get th=
e reg
+ * value from state->regs.
+ *
+ * Otherwise, if state->regs just points to IRET regs, and the previous =
frame
+ * had full regs, it's safe to get the value from the previous regs.  Th=
is can
+ * happen when early/late IRQ entry code gets interrupted by an NMI.
+ */
+static bool get_reg(struct unwind_state *state, unsigned int reg_off,
+		    unsigned long *val)
+{
+	unsigned int reg =3D reg_off/8;
+
+	if (!state->regs)
+		return false;
+
+	if (state->full_regs) {
+		*val =3D ((unsigned long *)state->regs)[reg];
+		return true;
+	}
+
+	if (state->prev_regs) {
+		*val =3D ((unsigned long *)state->prev_regs)[reg];
+		return true;
+	}
+
+	return false;
+}
+
 bool unwind_next_frame(struct unwind_state *state)
 {
-	unsigned long ip_p, sp, orig_ip =3D state->ip, prev_sp =3D state->sp;
+	unsigned long ip_p, sp, tmp, orig_ip =3D state->ip, prev_sp =3D state->=
sp;
 	enum stack_type prev_type =3D state->stack_info.type;
 	struct orc_entry *orc;
 	bool indirect =3D false;
@@ -448,39 +477,35 @@ bool unwind_next_frame(struct unwind_state *state)
 		break;
=20
 	case ORC_REG_R10:
-		if (!state->regs || !state->full_regs) {
+		if (!get_reg(state, offsetof(struct pt_regs, r10), &sp)) {
 			orc_warn_current("missing R10 value at %pB\n",
 					 (void *)state->ip);
 			goto err;
 		}
-		sp =3D state->regs->r10;
 		break;
=20
 	case ORC_REG_R13:
-		if (!state->regs || !state->full_regs) {
+		if (!get_reg(state, offsetof(struct pt_regs, r13), &sp)) {
 			orc_warn_current("missing R13 value at %pB\n",
 					 (void *)state->ip);
 			goto err;
 		}
-		sp =3D state->regs->r13;
 		break;
=20
 	case ORC_REG_DI:
-		if (!state->regs || !state->full_regs) {
+		if (!get_reg(state, offsetof(struct pt_regs, di), &sp)) {
 			orc_warn_current("missing RDI value at %pB\n",
 					 (void *)state->ip);
 			goto err;
 		}
-		sp =3D state->regs->di;
 		break;
=20
 	case ORC_REG_DX:
-		if (!state->regs || !state->full_regs) {
+		if (!get_reg(state, offsetof(struct pt_regs, dx), &sp)) {
 			orc_warn_current("missing DX value at %pB\n",
 					 (void *)state->ip);
 			goto err;
 		}
-		sp =3D state->regs->dx;
 		break;
=20
 	default:
@@ -507,6 +532,7 @@ bool unwind_next_frame(struct unwind_state *state)
=20
 		state->sp =3D sp;
 		state->regs =3D NULL;
+		state->prev_regs =3D NULL;
 		state->signal =3D false;
 		break;
=20
@@ -518,6 +544,7 @@ bool unwind_next_frame(struct unwind_state *state)
 		}
=20
 		state->regs =3D (struct pt_regs *)sp;
+		state->prev_regs =3D NULL;
 		state->full_regs =3D true;
 		state->signal =3D true;
 		break;
@@ -529,6 +556,8 @@ bool unwind_next_frame(struct unwind_state *state)
 			goto err;
 		}
=20
+		if (state->full_regs)
+			state->prev_regs =3D state->regs;
 		state->regs =3D (void *)sp - IRET_FRAME_OFFSET;
 		state->full_regs =3D false;
 		state->signal =3D true;
@@ -543,8 +572,8 @@ bool unwind_next_frame(struct unwind_state *state)
 	/* Find BP: */
 	switch (orc->bp_reg) {
 	case ORC_REG_UNDEFINED:
-		if (state->regs && state->full_regs)
-			state->bp =3D state->regs->bp;
+		if (get_reg(state, offsetof(struct pt_regs, bp), &tmp))
+			state->bp =3D tmp;
 		break;
=20
 	case ORC_REG_PREV_SP:
--=20
2.21.1

