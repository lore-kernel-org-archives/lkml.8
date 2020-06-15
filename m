Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B4C0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5DC20644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pGbdVD61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730699AbgFOOxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730529AbgFOOxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:53:45 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90ACEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:53:44 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r9so14958335wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TO/UlS5nQwaskSKkWnxhtbr58cxMAZAbeQDdoacE6pI=;
        b=pGbdVD61bJ5VXk7tPHS9VeyRR1c449xy+yOAiFLWktnxVI5RGEPjXKHzyoAQ/HB7Xv
         g/jTZqHr8NXLeCjbGKe7oW7GrT8VdnM20DSsCwZ0R5/gMhf5zpOWfx74tRx1aCqYAEyT
         MUezcBhiKZRgvqGVf6acB/crB0YnbfkBZrFbZL+IH2LiJKXCPkOmDTqMP3iuDGAUGYCB
         I2BBhxF8G6hQ31pMB4dwjOp73L+bMb/fkN4QOU9cYT7po6BQF6rOCoCxxLM/Hge69Szf
         RqNpg0f80hMy8P/P7NDKZFxLi4kV6HghZOkM5Nx6oKs9p34w8bDqlJLE5Ejf1GWKq/bW
         huzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TO/UlS5nQwaskSKkWnxhtbr58cxMAZAbeQDdoacE6pI=;
        b=ffCEfZR/JGzKfZUzO30Vj6LC/QnvpRTMnPmaAelQohSD0Sr19Noi31hzBYZLQcqHYY
         ArvBYkspGSI6w6jjqtSTs0PLTidtl9Cpi2B/3NYFjsh5BJc1owe+98KjSsmm3ctz9Diz
         M653dJWlKn/fXJYRI2JX/RNvhq5BA26Qtze5MMlYVzo8uHT5t7fWesU7U0cuFRcYW6DW
         RjJYDGCudHSqPMYcWrRgpDBFgeeXnVkF0HE+ykK6ahvzEGX8yLGo6x+WQJc9UWvxjAV5
         1rzrWDWt7w05PwQmmwcYaDntDD1bP/iVy3gUXPbrEo8oIPWM4w7q8t6VyRYylyiqO/sl
         WeUw==
X-Gm-Message-State: AOAM531arr0W2ThR3gpnPvsnqhcyvK/09IcoGDbyCecdZGIV3prNv9Jl
        WwynQ7ZyPp4mpSOY8BjVkTungw==
X-Google-Smtp-Source: ABdhPJyObri4Sx4uNpy8MHQeWbXJ3AvJJL/BWpDdAHYNWah9fhogVmCUj27GgYrTiDSWdeTsa65shQ==
X-Received: by 2002:a7b:c76a:: with SMTP id x10mr13701463wmk.16.1592232823049;
        Mon, 15 Jun 2020 07:53:43 -0700 (PDT)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id s8sm25864689wrg.50.2020.06.15.07.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 07:53:42 -0700 (PDT)
Date:   Mon, 15 Jun 2020 16:53:36 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20200615145336.GA220132@google.com>
References: <CACT4Y+Zwm47qs8yco0nNoD_hFzHccoGyPznLHkBjAeg9REZ3gA@mail.gmail.com>
 <CANpmjNPNa2f=kAF6c199oYVJ0iSyirQRGxeOBLxa9PmakSXRbA@mail.gmail.com>
 <CACT4Y+Z+FFHFGSgEJGkd+zCBgUOck_odOf9_=5YQLNJQVMGNdw@mail.gmail.com>
 <20200608110108.GB2497@hirez.programming.kicks-ass.net>
 <20200611215538.GE4496@worktop.programming.kicks-ass.net>
 <CACT4Y+aKVKEp1yoBYSH0ebJxeqKj8TPR9MVtHC1Mh=jgX0ZvLw@mail.gmail.com>
 <20200612114900.GA187027@google.com>
 <CACT4Y+bBtCbEk2tg60gn5bgfBjARQFBgtqkQg8VnLLg5JwyL5g@mail.gmail.com>
 <CANpmjNM+Tcn40MsfFKvKxNTtev-TXDsosN+z9ATL8hVJdK1yug@mail.gmail.com>
 <20200615142949.GT2531@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615142949.GT2531@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020, Peter Zijlstra wrote:

> On Mon, Jun 15, 2020 at 09:53:06AM +0200, Marco Elver wrote:
> > 
> > Disabling KCOV for smp_processor_id now moves the crash elsewhere. In
> > the case of KASAN into its 'memcpy' wrapper, called after
> > __this_cpu_read in fixup_bad_iret. This is making me suspicious,
> > because it shouldn't be called from the noinstr functions.
> 
> With your .config, objtool complains about exactly that though:
> 
> vmlinux.o: warning: objtool: fixup_bad_iret()+0x8e: call to memcpy() leaves .noinstr.text section
> 
> The utterly gruesome thing below 'cures' that.

Is __memcpy() generally available? I think that bypasses KASAN and
whatever else.

> > For KCSAN the crash still happens in check_preemption_disabled, in the
> > inlined native_save_fl function (apparently on its 'pushf'). If I turn
> > fixup_bad_iret's __this_cpu_read into a raw_cpu_read (to bypass
> > check_preemption_disabled), no more crash with KCSAN.
> 
> vmlinux.o: warning: objtool: debug_smp_processor_id()+0x0: call to __sanitizer_cov_trace_pc() leaves .noinstr.text section
> vmlinux.o: warning: objtool: check_preemption_disabled()+0x1f: call to __sanitizer_cov_trace_pc() leaves .noinstr.text section
> vmlinux.o: warning: objtool: __this_cpu_preempt_check()+0x4: call to __sanitizer_cov_trace_pc() leaves .noinstr.text section
> 
> That could be either of those I suppose, did you have the NOP patches
> on? Let me try... those seem to placate objtool at least.
> 
> I do see a fair amount of __kasan_check*() crud though:
> 
> vmlinux.o: warning: objtool: rcu_nmi_exit()+0x44: call to __kasan_check_read() leaves .noinstr.text section
> vmlinux.o: warning: objtool: rcu_dynticks_eqs_enter()+0x1c: call to __kasan_check_write() leaves .noinstr.text section
> vmlinux.o: warning: objtool: rcu_nmi_enter()+0x46: call to __kasan_check_read() leaves .noinstr.text section
> vmlinux.o: warning: objtool: rcu_dynticks_eqs_exit()+0x21: call to __kasan_check_write() leaves .noinstr.text section
> vmlinux.o: warning: objtool: __rcu_is_watching()+0x1c: call to __kasan_check_read() leaves .noinstr.text section
> vmlinux.o: warning: objtool: debug_locks_off()+0x1b: call to __kasan_check_write() leaves .noinstr.text section
> 
> That wasn't supported to happen with the __no_sanitize patches on (which
> I didn't forget). Aah, I think we've lost a bunch of patches.. /me goes
> rummage.
> 
> This:
> 
>   https://lkml.kernel.org/r/20200603114051.896465666@infradead.org
> 
> that cures the rcu part of that.
> 
> Let me go look at your KCSAN thing now...

I tried to find the stack that is used by the crashing code -- which led
me to entry_stack? So I tried this:

--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -370,7 +370,7 @@ struct x86_hw_tss {
 #define IO_BITMAP_OFFSET_INVALID	(__KERNEL_TSS_LIMIT + 1)
 
 struct entry_stack {
-	unsigned long		words[64];
+	unsigned long		words[128];
 };
 
 struct entry_stack_page {

No more crash. But that's probably not what we want. Just a datapoint.

> ---
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index af75109485c26..031a21fb5a741 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -675,6 +675,14 @@ struct bad_iret_stack {
>  	struct pt_regs regs;
>  };
>  
> +void __always_inline __badcpy(void *dst, void *src, int nr)
> +{
> +	unsigned long *d = dst, *s = src;
> +	nr /= sizeof(unsigned long);
> +	while (nr--)
> +		*(d++) = *(s++);
> +}
> +

If we can use __memcpy() here, that would probably solve that.

Thanks,
-- Marco
