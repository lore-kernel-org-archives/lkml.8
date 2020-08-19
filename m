Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA9FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE66620882
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kylehuey.com header.i=@kylehuey.com header.b="LdQLhHlk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgHST2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHST2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:28:34 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439DEC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:28:33 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id g19so27627129ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kCTXaY0TGg8ry6Z0HaRXL1z4YQjPrVbTii0ZmMV3oc8=;
        b=LdQLhHlkA0nDA8wIzpR8U+G5ou21fd2ZpXnFxAdqmeTyPLZTZs5REGRGhvLs7R3kQv
         TzSsUy0xLUMwHl60hP/JCplenBwyKz83ETZGDx7lh15lmvBXgailtsYExGRei0q7BD7u
         fk+GbmAjSBwDKReCd5lvMtb/V67gYYtrw+vv2dZXFDx3tXDjzKazIYnHuowv6asy7e0u
         OQ1LddiqaDgACCkBt1sXH4Cu+lI2F9fk+9zCa126xRAykMG3ljmgpKkIFpSqJagZVqKb
         0Cs0cu0++2A05nZUSqwRSycTXhqrKfeIV2v0I4yTnuJWdegdOY7bLHKl7NYrguUhoJQg
         pswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kCTXaY0TGg8ry6Z0HaRXL1z4YQjPrVbTii0ZmMV3oc8=;
        b=QJGLgFfe9mE5gxuIGlbqwvjzuvP4ptyT4tgevw3SSB1Ids1daOTyHeSGGmSbisJG0W
         WXHWkXBJDeneXD1VGPp5l7YQ2Z5v+PxryqtuDt3bzRL78ij7Oj1+EGCna2JkmzNjWKIe
         BZ5xH+o2Q/0o7fQH6469p0Ns9q4htXVFxS3ZGjiJp4Kl+233unrDlr+EpllTx8NiW9P5
         z96g8vRcLQMIXo/ij6/bRlGJ6ybNU6rR4wLp/NhmvURyImKUmXwBrsKpHJKa4XWyEfFH
         MbmUJSRYK1LuApfTe0fH4ervkazRdG1mGuNSXXA4YYbnaQbz29bUxvHUanIdsRcu0Au7
         D2hg==
X-Gm-Message-State: AOAM531OL05rIPCuU3y35IIQg3JJtwvOJUb4Q5bun048NKUhJaA2M6aS
        0Oy7gsgabxc7rgGaJMXmZPpRV5tR1I6gAe7myKK2PQ==
X-Google-Smtp-Source: ABdhPJzGk3ge5QyByjAtb+4h6YKxI+7KR81PJLwmltEfLhfv4aXC2PLcjm2JVuVGJryu4bWDFej5d5GTOjC3KoKpqU0=
X-Received: by 2002:a17:906:7698:: with SMTP id o24mr27678280ejm.182.1597865311802;
 Wed, 19 Aug 2020 12:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAP045Ao5-+vvTzCOaCkfwztsd2Q0_8kh85UxuXW0bbcfVbF40w@mail.gmail.com>
 <20200819184149.GH2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200819184149.GH2674@hirez.programming.kicks-ass.net>
From:   Kyle Huey <me@kylehuey.com>
Date:   Wed, 19 Aug 2020 12:28:16 -0700
Message-ID: <CAP045ApfQnsHsimmhLsSeL2OSB98-Q3f=nM4em5rqr_paz4=5Q@mail.gmail.com>
Subject: Re: [REGRESSION 5.8] x86/entry: DR0 break-on-write not working
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 11:42 AM <peterz@infradead.org> wrote:
>
> On Wed, Aug 19, 2020 at 10:53:58AM -0700, Kyle Huey wrote:
> > rr, a userspace record and replay debugger[0], has a test suite that
> > attempts to exercise strange corners of the Linux API. One such
> > test[1] began failing after 2bbc68f8373c0631ebf137f376fbea00e8086be7.
> > I have not tried to understand what has changed in the kernel here but
> > since the commit message says "No functional change" I assume
> > something has gone wrong.
> >
> > The test expects to get a SIGTRAP when watchvar is written to in the
> > forked child, but instead the program just exits normally and we get a
> > status value corresponding to that (exit code 77 = wait status
> > 0x4d00). This test program should be usable outside of rr's test suite
> > if you replace the test_assert/atomic_puts functions with
> > assert/printf and replace the util.h include with appropriate standard
> > includes.
> >
> > This regression is present in 5.8.
>
> $ uname -a
> Linux ivb-ep 5.9.0-rc1-dirty #343 SMP PREEMPT Wed Aug 19 15:04:35 CEST 2020 x86_64 GNU/Linux
>
> $ ./ptrace_debug_regs
> FAILED: errno=0 (Success)
> ptrace_debug_regs: ptrace_debug_regs.c:104: main: Assertion `"FAILED: !" && check_cond(status == ((5 << 8) | 0x7f))' failed.
> Aborted
>
> I'm guess that is not the expected outcome, is that the same failure you
> saw?

Yes. Is status also 0x4d00 for you?

The program is expected to complete with no assertions firing.

- Kyle

> ---
> /* -*- Mode: C; tab-width: 8; c-basic-offset: 2; indent-tabs-mode: nil; -*- */
>
> #include <stdio.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/ptrace.h>
> #include <stdarg.h>
> #include <assert.h>
> #include <sys/wait.h>
> #include <errno.h>
> #include <string.h>
> #include <stddef.h>
> #include <sys/user.h>
>
> /**
>  * Print the printf-like arguments to stdout as atomic-ly as we can
>  * manage.  Async-signal-safe.  Does not flush stdio buffers (doing so
>  * isn't signal safe).
>  */
> __attribute__((format(printf, 1, 2))) inline static int atomic_printf(
>     const char* fmt, ...) {
>   va_list args;
>   char buf[1024];
>   int len;
>
>   va_start(args, fmt);
>   len = vsnprintf(buf, sizeof(buf) - 1, fmt, args);
>   va_end(args);
>   return write(STDOUT_FILENO, buf, len);
> }
>
> /**
>  * Write |str| on its own line to stdout as atomic-ly as we can
>  * manage.  Async-signal-safe.  Does not flush stdio buffers (doing so
>  * isn't signal safe).
>  */
> inline static int atomic_puts(const char* str) {
>   return atomic_printf("%s\n", str);
> }
>
> inline static int check_cond(int cond) {
>   if (!cond) {
>     atomic_printf("FAILED: errno=%d (%s)\n", errno, strerror(errno));
>   }
>   return cond;
> }
>
> #define test_assert(cond) assert("FAILED: !" && check_cond(cond))
>
> #define NEW_VALUE 0xabcdef
>
> static void breakpoint(void) {}
>
> static char watch_var;
>
> int main(void) {
>   pid_t child;
>   int status;
>   int pipe_fds[2];
>
>   test_assert(0 == pipe(pipe_fds));
>
>   if (0 == (child = fork())) {
>     char ch;
>     read(pipe_fds[0], &ch, 1);
>     breakpoint();
>     watch_var = 1;
>     return 77;
>   }
>
>   test_assert(0 == ptrace(PTRACE_ATTACH, child, NULL, NULL));
>   test_assert(child == waitpid(child, &status, 0));
>   test_assert(status == ((SIGSTOP << 8) | 0x7f));
>   test_assert(1 == write(pipe_fds[1], "x", 1));
>
>   test_assert(0 == ptrace(PTRACE_POKEUSER, child,
>                           (void*)offsetof(struct user, u_debugreg[0]),
>                           (void*)breakpoint));
>   /* Enable DR0 break-on-exec */
>   test_assert(0 == ptrace(PTRACE_POKEUSER, child,
>                           (void*)offsetof(struct user, u_debugreg[7]),
>                           (void*)0x1));
>
>   test_assert(0 == ptrace(PTRACE_CONT, child, NULL, NULL));
>   test_assert(child == waitpid(child, &status, 0));
>   test_assert(status == ((SIGTRAP << 8) | 0x7f));
>   test_assert(0x1 == ptrace(PTRACE_PEEKUSER, child,
>                             (void*)offsetof(struct user, u_debugreg[6])));
>
>   test_assert(0 == ptrace(PTRACE_POKEUSER, child,
>                           (void*)offsetof(struct user, u_debugreg[0]),
>                           &watch_var));
>   /* Enable DR0 break-on-write */
>   test_assert(0 == ptrace(PTRACE_POKEUSER, child,
>                           (void*)offsetof(struct user, u_debugreg[7]),
>                           (void*)0x10001));
>
>   test_assert(0 == ptrace(PTRACE_CONT, child, NULL, NULL));
>   test_assert(child == waitpid(child, &status, 0));
>   test_assert(status == ((SIGTRAP << 8) | 0x7f));
>   test_assert(0x1 == ptrace(PTRACE_PEEKUSER, child,
>                             (void*)offsetof(struct user, u_debugreg[6])));
>
>   test_assert(0 == ptrace(PTRACE_DETACH, child, NULL, NULL));
>
>   test_assert(child == waitpid(child, &status, 0));
>   test_assert(WIFEXITED(status));
>   test_assert(WEXITSTATUS(status) == 77);
>
>   atomic_puts("EXIT-SUCCESS");
>   return 0;
> }
