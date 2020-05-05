Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5A1C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C16112073B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbgEEQEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:04:42 -0400
Received: from foss.arm.com ([217.140.110.172]:44342 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729398AbgEEQEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:04:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB43031B;
        Tue,  5 May 2020 09:04:41 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 513D23F71F;
        Tue,  5 May 2020 09:04:39 -0700 (PDT)
Date:   Tue, 5 May 2020 17:04:22 +0100
From:   Mark Rutland <mark.rutland@arm.com>
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
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch V4 part 1 07/36] locking/atomics: Flip fallbacks and
 instrumentation
Message-ID: <20200505160421.GA27127@lakrids.cambridge.arm.com>
References: <20200505131602.633487962@linutronix.de>
 <20200505134058.769149955@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505134058.769149955@linutronix.de>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 03:16:09PM +0200, Thomas Gleixner wrote:
> Currently instrumentation of atomic primitives is done at the
> architecture level, while composites or fallbacks are provided at the
> generic level.
> 
> The result is that there are no uninstrumented variants of the
> fallbacks. Since there is now need of such (see the next patch),
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

FWIW, the scripting changes all look fine to me, so:

Acked-by: Mark Rutland <mark.rutland@arm.com>

I'm hoping that I can convert the remaining arches over to arch_atomic
atop of this, at which point we can remove the duplication, and have the
usual arch_<foo>/raw_<foo>/<foo> split.

Thanks,
Mark.
