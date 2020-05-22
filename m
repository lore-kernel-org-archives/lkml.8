Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1E37C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AA3E2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIC3yeif"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgEVNzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 09:55:35 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43501 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729406AbgEVNzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 09:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590155733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
         references:references; bh=lMN9ugxkQrx+Q8hqDn7Ib+EILsxzS3qmd9hYAY2w5Wk=;
        b=JIC3yeifu0+y5FvradmDKSoYpKwbIF5IF3r/Y8jVSIxqjzwtorxO0odvgUcv9bXoxTbQss
        qv13Uva16riy0Sf710siOmx5YxWB9ib08cYbztGKeUIk214OPaRfXOp7M6uhipBgdv7OIp
        30EVxDOwhd2DyeNOSyLDuq6YUgnloc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-WGJ9S7FLNCuHkULD-J4xVQ-1; Fri, 22 May 2020 09:55:32 -0400
X-MC-Unique: WGJ9S7FLNCuHkULD-J4xVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C74280B72D
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:55:31 +0000 (UTC)
Received: from treble (ovpn-112-59.rdu2.redhat.com [10.10.112.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 20C3210013D9
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 13:55:31 +0000 (UTC)
Date:   Fri, 22 May 2020 08:54:39 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Dave Jones <dsj@fb.com>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>
Subject: [PATCH] x86/unwind/orc: Fix unwind_get_return_address_ptr() for
 inactive tasks
Message-ID: <20200522135435.vbxs7umku5pyrdbk@treble>
References: <000000000000c866c705a61a95d4@google.com>
 <9a337dfa-175f-e13b-1977-0f63d589f37c@I-love.SAKURA.ne.jp>
 <CACT4Y+bAg0jJSVSu-AwP2k5QMk3kgnwRn4xXb3C5Mx-CyMRwdA@mail.gmail.com>
 <99be7df0-c0af-3985-aa7b-674990e319b2@i-love.sakura.ne.jp>
 <54652cf1-ca04-c3ec-a2fe-d0f47484fb5f@i-love.sakura.ne.jp>
 <20200522043037.fny37n7kjbfyrxo4@treble>
 <alpine.LSU.2.21.2005220940070.18061@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2005220940070.18061@pobox.suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Normally, show_trace_log_lvl() scans the stack, looking for text
addresses to print.  In parallel, it unwinds the stack with
unwind_next_frame().  If the stack address matches the pointer returned
by unwind_get_return_address_ptr() for the current frame, the text
address is printed normally without a question mark.  Otherwise it's
considered a breadcrumb (potentially from a previous call path) and it's
printed with a question mark to indicate that the address is unreliable
and typically can be ignored.

Since the following commit:

  f1d9a2abff66 ("x86/unwind/orc: Don't skip the first frame for inactive tasks")

... for inactive tasks, show_trace_log_lvl() prints *only* unreliable
addresses (prepended with '?').

That happens because, for the first frame of an inactive task,
unwind_get_return_address_ptr() returns the wrong return address
pointer: one word *below* the task stack pointer.  show_trace_log_lvl()
starts scanning at the stack pointer itself, so it never finds the first
'reliable' address, causing only guesses to being printed.

The first frame of an inactive task isn't a normal stack frame.  It's
actually just an instance of 'struct inactive_task_frame' which is left
behind by __switch_to_asm().  Now that this inactive frame is actually
exposed to callers, fix unwind_get_return_address_ptr() to interpret it
properly.

Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Fixes: f1d9a2abff66 ("x86/unwind/orc: Don't skip the first frame for inactive tasks")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/unwind_orc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index fa79e4227d3d..7f969b2d240f 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -320,12 +320,19 @@ EXPORT_SYMBOL_GPL(unwind_get_return_address);
 
 unsigned long *unwind_get_return_address_ptr(struct unwind_state *state)
 {
+	struct task_struct *task = state->task;
+
 	if (unwind_done(state))
 		return NULL;
 
 	if (state->regs)
 		return &state->regs->ip;
 
+	if (task != current && state->sp == task->thread.sp) {
+		struct inactive_task_frame *frame = (void *)task->thread.sp;
+		return &frame->ret_addr;
+	}
+
 	if (state->sp)
 		return (unsigned long *)state->sp - 1;
 
-- 
2.21.1

