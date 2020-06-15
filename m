Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17BF8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E494920739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RCpCMYm2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730248AbgFOOa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgFOOa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:30:26 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C981C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iVtDey7osCTiXRlBck0DMsdzE3CHMm8eourPYCpuPzc=; b=RCpCMYm2KeErVoebP4brd4PoGi
        8yHqF1nw5116S5QlkbTgcv1ndddUSk/wdK2PhHx8a71YiqLpVTyet3gUwfa11lix7lqVjcZex+NPC
        IRuT3MmjG+QSK+64UJ/3IkBoiR+aSdvnJdD4ThmJNchHTAEqLjVBI9uwzTe3LMwwrEa0+gNI8dOoS
        cWinMea+XtydP4bIfhwgzGUCRwMWTdlwtU9PdZQGrb7HD034NhQf7KAKZt7rqWZ45zBz5IuvDHAmH
        XDjVO1Wtan9nx5b+XfZz185gMi+QPJPNPbijylin4cMCKy1vYTY65V85ALDVuS7iXQ9Qdh93LeWxa
        Kfq91ipg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkq7W-0006Eh-6c; Mon, 15 Jun 2020 14:29:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1BBA33028C8;
        Mon, 15 Jun 2020 16:29:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 09DC3203B8172; Mon, 15 Jun 2020 16:29:50 +0200 (CEST)
Date:   Mon, 15 Jun 2020 16:29:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH -tip v3 1/2] kcov: Make runtime functions
 noinstr-compatible
Message-ID: <20200615142949.GT2531@hirez.programming.kicks-ass.net>
References: <CAAeHK+zErjaB64bTRqjH3qHyo9QstDSHWiMxqvmNYwfPDWSuXQ@mail.gmail.com>
 <CACT4Y+Zwm47qs8yco0nNoD_hFzHccoGyPznLHkBjAeg9REZ3gA@mail.gmail.com>
 <CANpmjNPNa2f=kAF6c199oYVJ0iSyirQRGxeOBLxa9PmakSXRbA@mail.gmail.com>
 <CACT4Y+Z+FFHFGSgEJGkd+zCBgUOck_odOf9_=5YQLNJQVMGNdw@mail.gmail.com>
 <20200608110108.GB2497@hirez.programming.kicks-ass.net>
 <20200611215538.GE4496@worktop.programming.kicks-ass.net>
 <CACT4Y+aKVKEp1yoBYSH0ebJxeqKj8TPR9MVtHC1Mh=jgX0ZvLw@mail.gmail.com>
 <20200612114900.GA187027@google.com>
 <CACT4Y+bBtCbEk2tg60gn5bgfBjARQFBgtqkQg8VnLLg5JwyL5g@mail.gmail.com>
 <CANpmjNM+Tcn40MsfFKvKxNTtev-TXDsosN+z9ATL8hVJdK1yug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM+Tcn40MsfFKvKxNTtev-TXDsosN+z9ATL8hVJdK1yug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 09:53:06AM +0200, Marco Elver wrote:
> 
> Disabling KCOV for smp_processor_id now moves the crash elsewhere. In
> the case of KASAN into its 'memcpy' wrapper, called after
> __this_cpu_read in fixup_bad_iret. This is making me suspicious,
> because it shouldn't be called from the noinstr functions.

With your .config, objtool complains about exactly that though:

vmlinux.o: warning: objtool: fixup_bad_iret()+0x8e: call to memcpy() leaves .noinstr.text section

The utterly gruesome thing below 'cures' that.

> For KCSAN the crash still happens in check_preemption_disabled, in the
> inlined native_save_fl function (apparently on its 'pushf'). If I turn
> fixup_bad_iret's __this_cpu_read into a raw_cpu_read (to bypass
> check_preemption_disabled), no more crash with KCSAN.

vmlinux.o: warning: objtool: debug_smp_processor_id()+0x0: call to __sanitizer_cov_trace_pc() leaves .noinstr.text section
vmlinux.o: warning: objtool: check_preemption_disabled()+0x1f: call to __sanitizer_cov_trace_pc() leaves .noinstr.text section
vmlinux.o: warning: objtool: __this_cpu_preempt_check()+0x4: call to __sanitizer_cov_trace_pc() leaves .noinstr.text section

That could be either of those I suppose, did you have the NOP patches
on? Let me try... those seem to placate objtool at least.

I do see a fair amount of __kasan_check*() crud though:

vmlinux.o: warning: objtool: rcu_nmi_exit()+0x44: call to __kasan_check_read() leaves .noinstr.text section
vmlinux.o: warning: objtool: rcu_dynticks_eqs_enter()+0x1c: call to __kasan_check_write() leaves .noinstr.text section
vmlinux.o: warning: objtool: rcu_nmi_enter()+0x46: call to __kasan_check_read() leaves .noinstr.text section
vmlinux.o: warning: objtool: rcu_dynticks_eqs_exit()+0x21: call to __kasan_check_write() leaves .noinstr.text section
vmlinux.o: warning: objtool: __rcu_is_watching()+0x1c: call to __kasan_check_read() leaves .noinstr.text section
vmlinux.o: warning: objtool: debug_locks_off()+0x1b: call to __kasan_check_write() leaves .noinstr.text section

That wasn't supported to happen with the __no_sanitize patches on (which
I didn't forget). Aah, I think we've lost a bunch of patches.. /me goes
rummage.

This:

  https://lkml.kernel.org/r/20200603114051.896465666@infradead.org

that cures the rcu part of that.

Let me go look at your KCSAN thing now...

---
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index af75109485c26..031a21fb5a741 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -675,6 +675,14 @@ struct bad_iret_stack {
 	struct pt_regs regs;
 };
 
+void __always_inline __badcpy(void *dst, void *src, int nr)
+{
+	unsigned long *d = dst, *s = src;
+	nr /= sizeof(unsigned long);
+	while (nr--)
+		*(d++) = *(s++);
+}
+
 asmlinkage __visible noinstr
 struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
 {
@@ -690,13 +698,13 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
 		(struct bad_iret_stack *)__this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
 
 	/* Copy the IRET target to the temporary storage. */
-	memcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
+	__badcpy(&tmp.regs.ip, (void *)s->regs.sp, 5*8);
 
 	/* Copy the remainder of the stack from the current stack. */
-	memcpy(&tmp, s, offsetof(struct bad_iret_stack, regs.ip));
+	__badcpy(&tmp, s, offsetof(struct bad_iret_stack, regs.ip));
 
 	/* Update the entry stack */
-	memcpy(new_stack, &tmp, sizeof(tmp));
+	__badcpy(new_stack, &tmp, sizeof(tmp));
 
 	BUG_ON(!user_mode(&new_stack->regs));
 	return new_stack;
