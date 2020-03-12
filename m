Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99929C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6093420738
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2axZD6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgCLRbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:31:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51363 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726520AbgCLRa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584034257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zNgKjY4uG3pY18Bga7cSRfqY/wy2g8l/muxrIlSofrA=;
        b=i2axZD6CKWbql+cEIjpceOifGip7iG81qFImwhmQycOHVPPWbVuzy+oGLw1XnZ/sa6pz5f
        cW09FgapNhweQDscjuRPUpr1AOBSd9r2atPjZOHySC5TV+OQ2AYc/ugljt3O2AIxihZfRd
        v9C9/XjzyQYtaN8oz11y8i/jZighGps=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-owoaIwB5OGa2RdxUndfHQQ-1; Thu, 12 Mar 2020 13:30:53 -0400
X-MC-Unique: owoaIwB5OGa2RdxUndfHQQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A30709300C;
        Thu, 12 Mar 2020 17:30:51 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-137.rdu2.redhat.com [10.10.122.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3983360C80;
        Thu, 12 Mar 2020 17:30:50 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 01/14] x86/dumpstack: Add SHOW_REGS_IRET mode
Date:   Thu, 12 Mar 2020 12:30:20 -0500
Message-Id: <2b2c601047136a4dbe42ed58715071e5323b5dae.1584033751.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1584033751.git.jpoimboe@redhat.com>
References: <cover.1584033751.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that __show_regs() has the concept of "modes" to indicate which
registers should be displayed, replace show_iret_regs() with a new
SHOW_REGS_IRET mode.  This is only a cleanup and doesn't change any
behavior.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/kdebug.h |  1 +
 arch/x86/kernel/dumpstack.c   | 27 ++++++++++-----------------
 arch/x86/kernel/process_64.c  |  7 ++++++-
 3 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/kdebug.h b/arch/x86/include/asm/kdebug.=
h
index 247ab14c6309..6112227368e7 100644
--- a/arch/x86/include/asm/kdebug.h
+++ b/arch/x86/include/asm/kdebug.h
@@ -23,6 +23,7 @@ enum die_val {
 };
=20
 enum show_regs_mode {
+	SHOW_REGS_IRET,
 	SHOW_REGS_SHORT,
 	/*
 	 * For when userspace crashed, but we don't think it's our fault, and
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index ae64ec7f752f..8a9ff25779ec 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -126,15 +126,8 @@ void show_ip(struct pt_regs *regs, const char *loglv=
l)
 	show_opcodes(regs, loglvl);
 }
=20
-void show_iret_regs(struct pt_regs *regs)
-{
-	show_ip(regs, KERN_DEFAULT);
-	printk(KERN_DEFAULT "RSP: %04x:%016lx EFLAGS: %08lx", (int)regs->ss,
-		regs->sp, regs->flags);
-}
-
 static void show_regs_if_on_stack(struct stack_info *info, struct pt_reg=
s *regs,
-				  bool partial)
+				  bool iret_only)
 {
 	/*
 	 * These on_stack() checks aren't strictly necessary: the unwind code
@@ -145,17 +138,17 @@ static void show_regs_if_on_stack(struct stack_info=
 *info, struct pt_regs *regs,
 	 * next stack, this function will be called again with the same regs so
 	 * they can be printed in the right context.
 	 */
-	if (!partial && on_stack(info, regs, sizeof(*regs))) {
+	if (!iret_only && on_stack(info, regs, sizeof(*regs))) {
 		__show_regs(regs, SHOW_REGS_SHORT);
=20
-	} else if (partial && on_stack(info, (void *)regs + IRET_FRAME_OFFSET,
-				       IRET_FRAME_SIZE)) {
+	} else if (iret_only && on_stack(info, (void *)regs + IRET_FRAME_OFFSET=
,
+					 IRET_FRAME_SIZE)) {
 		/*
 		 * When an interrupt or exception occurs in entry code, the
 		 * full pt_regs might not have been saved yet.  In that case
 		 * just print the iret frame.
 		 */
-		show_iret_regs(regs);
+		__show_regs(regs, SHOW_REGS_IRET);
 	}
 }
=20
@@ -166,13 +159,13 @@ void show_trace_log_lvl(struct task_struct *task, s=
truct pt_regs *regs,
 	struct stack_info stack_info =3D {0};
 	unsigned long visit_mask =3D 0;
 	int graph_idx =3D 0;
-	bool partial =3D false;
+	bool iret_only =3D false;
=20
 	printk("%sCall Trace:\n", log_lvl);
=20
 	unwind_start(&state, task, regs, stack);
 	stack =3D stack ? : get_stack_pointer(task, regs);
-	regs =3D unwind_get_entry_regs(&state, &partial);
+	regs =3D unwind_get_entry_regs(&state, &iret_only);
=20
 	/*
 	 * Iterate through the stacks, starting with the current stack pointer.
@@ -210,7 +203,7 @@ void show_trace_log_lvl(struct task_struct *task, str=
uct pt_regs *regs,
 			printk("%s <%s>\n", log_lvl, stack_name);
=20
 		if (regs)
-			show_regs_if_on_stack(&stack_info, regs, partial);
+			show_regs_if_on_stack(&stack_info, regs, iret_only);
=20
 		/*
 		 * Scan the stack, printing any text addresses we find.  At the
@@ -269,9 +262,9 @@ void show_trace_log_lvl(struct task_struct *task, str=
uct pt_regs *regs,
 			unwind_next_frame(&state);
=20
 			/* if the frame has entry regs, print them */
-			regs =3D unwind_get_entry_regs(&state, &partial);
+			regs =3D unwind_get_entry_regs(&state, &iret_only);
 			if (regs)
-				show_regs_if_on_stack(&stack_info, regs, partial);
+				show_regs_if_on_stack(&stack_info, regs, iret_only);
 		}
=20
 		if (stack_name)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index ffd497804dbc..d1986a63d403 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -71,7 +71,12 @@ void __show_regs(struct pt_regs *regs, enum show_regs_=
mode mode)
 	unsigned int fsindex, gsindex;
 	unsigned int ds, es;
=20
-	show_iret_regs(regs);
+	show_ip(regs, KERN_DEFAULT);
+	printk(KERN_DEFAULT "RSP: %04x:%016lx EFLAGS: %08lx", (int)regs->ss,
+		regs->sp, regs->flags);
+
+	if (mode =3D=3D SHOW_REGS_IRET)
+		return;
=20
 	if (regs->orig_ax !=3D -1)
 		pr_cont(" ORIG_RAX: %016lx\n", regs->orig_ax);
--=20
2.21.1

