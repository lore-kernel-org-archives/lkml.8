Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D43C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BFB62078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 21:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gVPk5wRJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgHSVgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 17:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHSVgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 17:36:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78ED3C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 14:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UaMTQzQR/2iD7LYG3TBB/MsacjZTmGqhqlIGfP/7qyQ=; b=gVPk5wRJ1OVpBU+UO4Nn99K2Py
        wKgQ8yNJ7e9p1Qs9SjO7zHIcoclTqoW4XqIwgbqx9e4oIGwtRUYeV71ZnUiER4vVB+PKimW0Oqxof
        x3nra9YZl7BkRxUku+kMz+cv3X2DzPkYPmEQ7wQDfQsThDkkpTNnyLrt/5qTKV8xsYcg0cX0BRykf
        hMoCE30BHD+mXBDJknaesJnDE+QhXTuTjoezkszkrpXVbItMlboKC0HGBKhA4e5HDiS6d+c+lZcMT
        8o1Dia4T2to7XWZTKbWu29UCyZ4p85u2eka9AuqlO9k2TOZf3yyNV+m9w/NDnOoEu837bmg1jEJB5
        hB1Ablfw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k8Vk9-0001Za-Ei; Wed, 19 Aug 2020 21:35:38 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8EAD980C9E; Wed, 19 Aug 2020 23:35:34 +0200 (CEST)
Date:   Wed, 19 Aug 2020 23:35:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kyle Huey <me@kylehuey.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andy Lutomirski <luto@kernel.org>,
        Robert O'Callahan <rocallahan@gmail.com>,
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
Message-ID: <20200819213534.GQ3982@worktop.programming.kicks-ass.net>
References: <CAP045Ao5-+vvTzCOaCkfwztsd2Q0_8kh85UxuXW0bbcfVbF40w@mail.gmail.com>
 <20200819184149.GH2674@hirez.programming.kicks-ass.net>
 <CAP045ApfQnsHsimmhLsSeL2OSB98-Q3f=nM4em5rqr_paz4=5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP045ApfQnsHsimmhLsSeL2OSB98-Q3f=nM4em5rqr_paz4=5Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 12:28:16PM -0700, Kyle Huey wrote:

> > I'm guess that is not the expected outcome, is that the same failure you
> > saw?
> 
> Yes. Is status also 0x4d00 for you?

Indeed.

> The program is expected to complete with no assertions firing.

When I comment out the break-on-exec test, the break-on-write test
succeeds.

When I add a few printk()'s to our #DB handler (6) the program will
magically work again.

I'm not much for ptrace(), but are we sure the test program is well
behaved?

The below also always works..

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
  test_assert(0 == ptrace(PTRACE_POKEUSER, child,
                          (void*)offsetof(struct user, u_debugreg[1]),
                          &watch_var));
  test_assert(0 == ptrace(PTRACE_POKEUSER, child,
                          (void*)offsetof(struct user, u_debugreg[7]),
                          (void*)0x100005));

  test_assert(0 == ptrace(PTRACE_CONT, child, NULL, NULL));
  test_assert(child == waitpid(child, &status, 0));
  test_assert(status == ((SIGTRAP << 8) | 0x7f));
  test_assert(0x1 == ptrace(PTRACE_PEEKUSER, child,
                            (void*)offsetof(struct user, u_debugreg[6])));

  test_assert(0 == ptrace(PTRACE_CONT, child, NULL, NULL));
  test_assert(child == waitpid(child, &status, 0));
  test_assert(status == ((SIGTRAP << 8) | 0x7f));
  test_assert(0x2 == ptrace(PTRACE_PEEKUSER, child,
                            (void*)offsetof(struct user, u_debugreg[6])));

  test_assert(0 == ptrace(PTRACE_DETACH, child, NULL, NULL));

  test_assert(child == waitpid(child, &status, 0));
  test_assert(WIFEXITED(status));
  test_assert(WEXITSTATUS(status) == 77);

  atomic_puts("EXIT-SUCCESS");
  return 0;
}

