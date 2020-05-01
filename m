Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615DCC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 04:47:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 392C6208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 04:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbpP6/JC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgEAEro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 00:47:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52175 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726452AbgEAErn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 00:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588308462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NT93Ylw+ngaHdbY/ecfijM8YRJCeyUONnkx665ymxd0=;
        b=QbpP6/JCLyIeysUpdYGoMYSF02bJL9S/eUFGGqDYUhSbByv2WdBaxzFqevwxriM50HfON0
        XnBLflz5wAlJziaRdl+87s9HiNp4PMevYQo/11+ZT95sg33Qud7uHLkmrc8/g6jFk5QCJv
        jKLrb3MpDUUMnVqAxRGEO7tQnuUZOGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-448-sgIUT4CbPQSNkgSrIqtJBg-1; Fri, 01 May 2020 00:47:39 -0400
X-MC-Unique: sgIUT4CbPQSNkgSrIqtJBg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6714845F;
        Fri,  1 May 2020 04:47:37 +0000 (UTC)
Received: from treble (ovpn-113-19.rdu2.redhat.com [10.10.113.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44AA09323;
        Fri,  1 May 2020 04:47:35 +0000 (UTC)
Date:   Thu, 30 Apr 2020 23:47:33 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC][PATCH] x86/ftrace: Have ftrace trampolines turn read-only
 at the end of system boot up
Message-ID: <20200501044733.eqf6hc6erucsd43x@treble>
References: <20200430202147.4dc6e2de@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200430202147.4dc6e2de@oasis.local.home>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 08:21:47PM -0400, Steven Rostedt wrote:
> The cause is the "ftrace=function" would register the function tracer
> and create a trampoline, and it will set it as executable and
> read-only. Then the "trace_options=func_stack_trace" would then update
> the same trampoline to include the stack tracer version of the function
> tracer. But since the trampoline already exists, it updates it with
> text_poke_bp(). The problem is that text_poke_bp() called while
> system_state == SYSTEM_BOOTING, it will simply do a memcpy() and not
> the page mapping, as it would think that the text is still read-write.
> But in this case it is not, and we take a fault and crash.
> 
> Instead, lets keep the ftrace trampolines read-write during boot up,
> and then when the kernel executable text is set to read-only, the
> ftrace trampolines get set to read-only as well.

Would it be easier to just call a new __text_poke_bp() which skips the
SYSTEM_BOOTING check, since you know the trampoline will always be
read-only?

Like:

diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index 67315fa3956a..710106256916 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -45,6 +45,7 @@ extern void *text_poke(void *addr, const void *opcode, size_t len);
 extern void text_poke_sync(void);
 extern void *text_poke_kgdb(void *addr, const void *opcode, size_t len);
 extern int poke_int3_handler(struct pt_regs *regs);
+extern void __text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
 extern void text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate);
 
 extern void text_poke_queue(void *addr, const void *opcode, size_t len, const void *emulate);
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 7867dfb3963e..9cc983cc9291 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1265,6 +1265,14 @@ void __ref text_poke_queue(void *addr, const void *opcode, size_t len, const voi
 	text_poke_loc_init(tp, addr, opcode, len, emulate);
 }
 
+void __ref __text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
+{
+	struct text_poke_loc tp;
+
+	text_poke_loc_init(&tp, addr, opcode, len, emulate);
+	text_poke_bp_batch(&tp, 1);
+}
+
 /**
  * text_poke_bp() -- update instructions on live kernel on SMP
  * @addr:	address to patch
@@ -1278,13 +1286,10 @@ void __ref text_poke_queue(void *addr, const void *opcode, size_t len, const voi
  */
 void __ref text_poke_bp(void *addr, const void *opcode, size_t len, const void *emulate)
 {
-	struct text_poke_loc tp;
-
 	if (unlikely(system_state == SYSTEM_BOOTING)) {
 		text_poke_early(addr, opcode, len);
 		return;
 	}
 
-	text_poke_loc_init(&tp, addr, opcode, len, emulate);
-	text_poke_bp_batch(&tp, 1);
+	__text_poke_bp(addr, opcode, len, emulate);
 }
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 867c126ddabe..c36f51f01f6e 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -469,7 +469,7 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 	mutex_lock(&text_mutex);
 	/* Do a safe modify in case the trampoline is executing */
 	new = ftrace_call_replace(ip, (unsigned long)func);
-	text_poke_bp((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
+	__text_poke_bp((void *)ip, new, MCOUNT_INSN_SIZE, NULL);
 	mutex_unlock(&text_mutex);
 }
 

