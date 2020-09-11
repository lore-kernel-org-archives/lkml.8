Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF28C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B0E621D6C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5D5Y5nQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgIKQB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:01:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58336 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726308AbgIKQBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:01:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599840063;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OT2QPFFKcLToAECZ3O+2lLWiSx0fYvw4RHtgCq0Giu0=;
        b=C5D5Y5nQSiV0oTdC8gvUQNlZsXHHqAQtfymqzppftyEZg26pW+PUsQBzd5d1MasvVfFdL9
        TTD45IlrL1/HCQ+/tLxrsgP8YQxc4peRcKIbvkzzWGLAevfvOjkLShn0sbb1g1yRkmih3I
        LM2qIUVnScIfcdgYmRMPHZtazWKIo0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-ZmSp7LduMm-z3RNV-dFK4g-1; Fri, 11 Sep 2020 12:00:57 -0400
X-MC-Unique: ZmSp7LduMm-z3RNV-dFK4g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B9AC57086;
        Fri, 11 Sep 2020 16:00:56 +0000 (UTC)
Received: from treble (ovpn-115-26.rdu2.redhat.com [10.10.115.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9301C1002D57;
        Fri, 11 Sep 2020 16:00:55 +0000 (UTC)
Date:   Fri, 11 Sep 2020 11:00:53 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: WARNING: Kernel stack regs has bad 'bp' value
Message-ID: <20200911160053.w66xit3imcqsn33g@treble>
References: <c0ba7077-7977-0155-d7be-d4133ebaee5c@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0ba7077-7977-0155-d7be-d4133ebaee5c@deltatee.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 01:42:21PM -0600, Logan Gunthorpe wrote:
> Hi,
> 
> A couple of times now, I've hit a very rare kernel warning (see below)
> while doing IO to an NVMe drive. I do not have a reliable way to
> reproduce this bug but it seems to have started very roughly around v5.8.
> 
> I've found someone else (Naresh Kamboju) has reported a very similar
> issue here[1] though there were no responses and I can't find the email
> anywhere else but through that link. Naresh mentions a method to
> reproduce the bug which I have not tried.
> 
> After some research on similar occurrences of this warning[2], it seems
> to be caused by assembly code making use of the %rbp register and an
> interrupt calling unwind_stack_frame() at just the wrong time (this
> happens more frequently with KASAN enabled, which is the case on my
> setup). When this happens, the offending function is seen in the stack dump.
> 
> One such function, which is common in all the stack dumps, is
> asm_call_on_stack(). This was introduced in v5.8 and pushes and replaces
> %rbp.
> 
> 931b94145981 ("x86/entry: Provide helpers for executing on the irqstack")
> 
> I'm not sure if this is the cause of the bug but it seems worth looking
> at. A comment in the code suggests that %rbp is saved for the ORC
> unwinder, but perhaps this doesn't play nicely with the Frame Pointer
> unwinder which is printing this warning.

Hi Logan,

Thanks for the bug report.  (Sorry I missed the first one, Naresh.)

The problem is that ret_from_fork() is no longer in .entry.text, so the
following check in the FP unwinder doesn't work when ret_from_fork()
gets interrupted.

	/*
	 * Don't warn if the unwinder got lost due to an interrupt in entry
	 * code or in the C handler before the first frame pointer got set up:
	 */
	if (state->got_irq && in_entry_code(state->ip))
		goto the_end;

If you have the ability to recreate, can you try the following patch?

A combination of a lot of forks and a lot of interrupts should trigger
it.  I'll try to recreate as well.

diff --git a/arch/x86/include/asm/frame.h b/arch/x86/include/asm/frame.h
index 296b346184b2..fb42659f6e98 100644
--- a/arch/x86/include/asm/frame.h
+++ b/arch/x86/include/asm/frame.h
@@ -60,12 +60,26 @@
 #define FRAME_END "pop %" _ASM_BP "\n"
 
 #ifdef CONFIG_X86_64
+
 #define ENCODE_FRAME_POINTER			\
 	"lea 1(%rsp), %rbp\n\t"
+
+static inline unsigned long encode_frame_pointer(struct pt_regs *regs)
+{
+	return (unsigned long)regs + 1;
+}
+
 #else /* !CONFIG_X86_64 */
+
 #define ENCODE_FRAME_POINTER			\
 	"movl %esp, %ebp\n\t"			\
 	"andl $0x7fffffff, %ebp\n\t"
+
+static inline unsigned long encode_frame_pointer(struct pt_regs *regs)
+{
+	return (unsigned long)regs & 0x7fffffff;
+}
+
 #endif /* CONFIG_X86_64 */
 
 #endif /* __ASSEMBLY__ */
@@ -83,6 +97,11 @@
 
 #define ENCODE_FRAME_POINTER
 
+static inline unsigned long encode_frame_pointer(struct pt_regs *regs)
+{
+	return 0;
+}
+
 #endif
 
 #define FRAME_BEGIN
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 13ce616cc7af..ba4593a913fa 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -42,6 +42,7 @@
 #include <asm/spec-ctrl.h>
 #include <asm/io_bitmap.h>
 #include <asm/proto.h>
+#include <asm/frame.h>
 
 #include "process.h"
 
@@ -133,7 +134,7 @@ int copy_thread(unsigned long clone_flags, unsigned long sp, unsigned long arg,
 	fork_frame = container_of(childregs, struct fork_frame, regs);
 	frame = &fork_frame->frame;
 
-	frame->bp = 0;
+	frame->bp = encode_frame_pointer(childregs);
 	frame->ret_addr = (unsigned long) ret_from_fork;
 	p->thread.sp = (unsigned long) fork_frame;
 	p->thread.io_bitmap = NULL;

