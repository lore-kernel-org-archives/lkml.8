Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E40C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF752078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ioqTZ1gW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHSSmi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbgHSSmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:42:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46569C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B29FoEhgmnRdMUe2XUeYcC87nlcEZTTxdQ1pYpiIYXc=; b=ioqTZ1gWxjszNRk3mHLVrPtu0Q
        v70912J1b30aGRHW6W6fI+R0tQmYy1omfZLPp1l543GOAIwARpCYRW/z9BAth+4I2R+MU6YyPA555
        1018n8TTvy+yUKT/VP9L6NPFlvhEZ1WCObL0u6Odv3SCmnOHp3Mo1eonp5QPha5hwc7tft5MCdCbT
        UUYd2Cn6s3iZVnLDsbv14OubA/jqUUMwYp4A/yRWao+b9c6OdKmzm4o0sghhB/WaU4PmRXX3ktQyz
        Owq7+5/Tp+jpo2M4T8rWvKws5tAHSkDUEjuAF9cgcvUUazDqUbgcD+3aXfPIniGUkF1ojf7w4dqFz
        aFqm8evg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8T21-0005z2-Ey; Wed, 19 Aug 2020 18:41:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 33437301179;
        Wed, 19 Aug 2020 20:41:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 012A12BFF9E50; Wed, 19 Aug 2020 20:41:49 +0200 (CEST)
Date:   Wed, 19 Aug 2020 20:41:49 +0200
From:   peterz@infradead.org
To:     Kyle Huey <me@kylehuey.com>
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
Subject: Re: [REGRESSION 5.8] x86/entry: DR0 break-on-write not working
Message-ID: <20200819184149.GH2674@hirez.programming.kicks-ass.net>
References: <CAP045Ao5-+vvTzCOaCkfwztsd2Q0_8kh85UxuXW0bbcfVbF40w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP045Ao5-+vvTzCOaCkfwztsd2Q0_8kh85UxuXW0bbcfVbF40w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 10:53:58AM -0700, Kyle Huey wrote:
> rr, a userspace record and replay debugger[0], has a test suite that
> attempts to exercise strange corners of the Linux API. One such
> test[1] began failing after 2bbc68f8373c0631ebf137f376fbea00e8086be7.
> I have not tried to understand what has changed in the kernel here but
> since the commit message says "No functional change" I assume
> something has gone wrong.
> 
> The test expects to get a SIGTRAP when watchvar is written to in the
> forked child, but instead the program just exits normally and we get a
> status value corresponding to that (exit code 77 = wait status
> 0x4d00). This test program should be usable outside of rr's test suite
> if you replace the test_assert/atomic_puts functions with
> assert/printf and replace the util.h include with appropriate standard
> includes.
> 
> This regression is present in 5.8.

$ uname -a
Linux ivb-ep 5.9.0-rc1-dirty #343 SMP PREEMPT Wed Aug 19 15:04:35 CEST 2020 x86_64 GNU/Linux

$ ./ptrace_debug_regs
FAILED: errno=0 (Success)
ptrace_debug_regs: ptrace_debug_regs.c:104: main: Assertion `"FAILED: !" && check_cond(status == ((5 << 8) | 0x7f))' failed.
Aborted

I'm guess that is not the expected outcome, is that the same failure you
saw?

---
/* -*- Mode: C; tab-width: 8; c-basic-offset: 2; indent-tabs-mode: nil; -*- */

#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/ptrace.h>
#include <stdarg.h>
#include <assert.h>
#include <sys/wait.h>
#include <errno.h>
#include <string.h>
#include <stddef.h>
#include <sys/user.h>

/**
 * Print the printf-like arguments to stdout as atomic-ly as we can
 * manage.  Async-signal-safe.  Does not flush stdio buffers (doing so
 * isn't signal safe).
 */
__attribute__((format(printf, 1, 2))) inline static int atomic_printf(
    const char* fmt, ...) {
  va_list args;
  char buf[1024];
  int len;

  va_start(args, fmt);
  len = vsnprintf(buf, sizeof(buf) - 1, fmt, args);
  va_end(args);
  return write(STDOUT_FILENO, buf, len);
}

/**
 * Write |str| on its own line to stdout as atomic-ly as we can
 * manage.  Async-signal-safe.  Does not flush stdio buffers (doing so
 * isn't signal safe).
 */
inline static int atomic_puts(const char* str) {
  return atomic_printf("%s\n", str);
}

inline static int check_cond(int cond) {
  if (!cond) {
    atomic_printf("FAILED: errno=%d (%s)\n", errno, strerror(errno));
  }
  return cond;
}

#define test_assert(cond) assert("FAILED: !" && check_cond(cond))

#define NEW_VALUE 0xabcdef

static void breakpoint(void) {}

static char watch_var;

int main(void) {
  pid_t child;
  int status;
  int pipe_fds[2];

  test_assert(0 == pipe(pipe_fds));

  if (0 == (child = fork())) {
    char ch;
    read(pipe_fds[0], &ch, 1);
    breakpoint();
    watch_var = 1;
    return 77;
  }

  test_assert(0 == ptrace(PTRACE_ATTACH, child, NULL, NULL));
  test_assert(child == waitpid(child, &status, 0));
  test_assert(status == ((SIGSTOP << 8) | 0x7f));
  test_assert(1 == write(pipe_fds[1], "x", 1));

  test_assert(0 == ptrace(PTRACE_POKEUSER, child,
                          (void*)offsetof(struct user, u_debugreg[0]),
                          (void*)breakpoint));
  /* Enable DR0 break-on-exec */
  test_assert(0 == ptrace(PTRACE_POKEUSER, child,
                          (void*)offsetof(struct user, u_debugreg[7]),
                          (void*)0x1));

  test_assert(0 == ptrace(PTRACE_CONT, child, NULL, NULL));
  test_assert(child == waitpid(child, &status, 0));
  test_assert(status == ((SIGTRAP << 8) | 0x7f));
  test_assert(0x1 == ptrace(PTRACE_PEEKUSER, child,
                            (void*)offsetof(struct user, u_debugreg[6])));

  test_assert(0 == ptrace(PTRACE_POKEUSER, child,
                          (void*)offsetof(struct user, u_debugreg[0]),
                          &watch_var));
  /* Enable DR0 break-on-write */
  test_assert(0 == ptrace(PTRACE_POKEUSER, child,
                          (void*)offsetof(struct user, u_debugreg[7]),
                          (void*)0x10001));

  test_assert(0 == ptrace(PTRACE_CONT, child, NULL, NULL));
  test_assert(child == waitpid(child, &status, 0));
  test_assert(status == ((SIGTRAP << 8) | 0x7f));
  test_assert(0x1 == ptrace(PTRACE_PEEKUSER, child,
                            (void*)offsetof(struct user, u_debugreg[6])));

  test_assert(0 == ptrace(PTRACE_DETACH, child, NULL, NULL));

  test_assert(child == waitpid(child, &status, 0));
  test_assert(WIFEXITED(status));
  test_assert(WEXITSTATUS(status) == 77);

  atomic_puts("EXIT-SUCCESS");
  return 0;
}
