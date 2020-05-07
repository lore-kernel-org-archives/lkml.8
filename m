Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F24AC35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 179E320708
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEGXlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 19:41:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:48834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgEGXlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 19:41:31 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFA0B206B9;
        Thu,  7 May 2020 23:41:28 +0000 (UTC)
Date:   Thu, 7 May 2020 19:41:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [patch V4 part 1 07/36] locking/atomics: Flip fallbacks and
 instrumentation
Message-ID: <20200507194127.262bc543@gandalf.local.home>
In-Reply-To: <20200505134058.769149955@linutronix.de>
References: <20200505131602.633487962@linutronix.de>
        <20200505134058.769149955@linutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 May 2020 15:16:09 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> Currently instrumentation of atomic primitives is done at the
> architecture level, while composites or fallbacks are provided at the
> generic level.
> 
> The result is that there are no uninstrumented variants of the
> fallbacks. Since there is now need of such (see the next patch),

Just a comment on the change log. Can we avoid saying "see the next patch"?
A few years from now, if we stumble on changes in this commit and need to
see that next patch, if something happened to lore, it may be difficult to
find what that next patch was. But saying that patch's subject, would be
just a simple search in the git history.

That said, looking at "the next patch" which is "x86/doublefault: Remove
memmove() call", does that patch really have a need for such?

-- Steve



> invert this ordering.
> 
> Doing this means moving the instrumentation into the generic code as
> well as having (for now) two variants of the fallbacks.
> 
> Notes:
> 
>  - the various *cond_read* primitives are not proper fallbacks
>    and got moved into linux/atomic.c. No arch_ variants are
>    generated because the base primitives smp_cond_load*()
>    are instrumented.
> 
>  - once all architectures are moved over to arch_atomic_ we can remove
>    one of the fallback variants and reclaim some 2300 lines.
> 
>  - atomic_{read,set}*() are no longer double-instrumented
> 
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
>
