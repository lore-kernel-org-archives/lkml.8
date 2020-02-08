Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD884C35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 16:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F4602082E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 16:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="MO2id8+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgBHQb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 11:31:27 -0500
Received: from mail.efficios.com ([167.114.26.124]:42720 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgBHQb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 11:31:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2D28B255388;
        Sat,  8 Feb 2020 11:31:26 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Wl36KL9wZiOO; Sat,  8 Feb 2020 11:31:25 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B5BDD254FDD;
        Sat,  8 Feb 2020 11:31:25 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B5BDD254FDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1581179485;
        bh=XPkQv+3Atolp5liJyyh90gyuF6beyNjA6q77Y6SWSmU=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=MO2id8+8XOGBfJzJ4oE0m0bXSXOn+DFbMP5gGZZHF9mhMNuBcHuXFKKHXhZBqgg0q
         U+QAeKLSQZB2jBkCaVGElFnXcx+spcKV05mZy8lGUeiY2V3W5r40mv4adis5ZnCwv9
         UrLE/2sT36W4xiNVEuO7UWB+fRiMSbQiMis0bIHBmQ9Ka9peDgJT4IxG0F71et1ZF+
         1wXUPL3Xwg35MSPdHqJY+oDUP8KNRagyFPedpgD6U4Li50UvidgfZn94v0md+ILlYL
         L3W8LooDBfu+6aUZhAb7yFV2Dxi3U8WgWAHAwepVJBiBBUTpIZ83cD3mdTNfss5lup
         6ZvA8E5bwP04w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JaPeqxBAaBD1; Sat,  8 Feb 2020 11:31:25 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 9DD92254EE3;
        Sat,  8 Feb 2020 11:31:25 -0500 (EST)
Date:   Sat, 8 Feb 2020 11:31:25 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     "Joel Fernandes, Google" <joel@joelfernandes.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Fontana <rfontana@redhat.com>,
        rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        paulmck <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Message-ID: <1997032737.615438.1581179485507.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200207205656.61938-1-joel@joelfernandes.org>
References: <20200207205656.61938-1-joel@joelfernandes.org>
Subject: Re: [RFC 0/3] Revert SRCU from tracepoint infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3895 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Topic: Revert SRCU from tracepoint infrastructure
Thread-Index: PMD/ty+mHKm7zkEqxhTVkMEkATXx4A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Feb 7, 2020, at 3:56 PM, Joel Fernandes, Google joel@joelfernandes.org wrote:

> Hi,
> These patches remove SRCU usage from tracepoints. The reason for proposing the
> reverts is because the whole point of SRCU was to avoid having to call
> rcu_irq_enter_irqson(). However this was added back in 865e63b04e9b2 ("tracing:
> Add back in rcu_irq_enter/exit_irqson() for rcuidle tracepoints") because perf
> was breaking..

I think the original patch re-enabling the rcu_irq_enter/exit_irqson() is a
tracepoint band-aid over what should actually been fixed within perf instead.

Perf should not do rcu_read_lock/unlock()/synchronize_rcu(), but rather use
tracepoint_synchronize_unregister() to match the read-side provided by
tracepoints.

If perf can then just rely on the underlying synchronization provided by each
instrumentation providers (tracepoint, kprobe, ...) and not explicitly add its own
unneeded synchronization on top (e.g. rcu_read_lock/unlock), then it should simplify
all this.

> 
> Further it occurs to me that, by using SRCU for tracepoints, we forgot that RCU
> is not really watching the tracepoint callbacks. This means that anyone doing
> preempt_disable() in their tracepoint callback, and expecting RCU to listen to
> them is in for a big surprise. When RCU is not watching, it does not care about
> preempt-disable sections on CPUs as you can see in the forced-quiescent state
> loop.

As Paul noted, SRCU is the exception to the "RCU watching".

> 
> Since SRCU is not providing any benefit because of 865e63b04e9b2 anyway, let us
> revert SRCU tracepoint code to maintain the sanity of potential
> tracepoint callback registerers.

Introducing SRCU was done to simplify handling of rcuidle, thus removing some
significant overhead that has been noticed due to use of rcu_irq_enter/exit_irqson().

There is another longer-term goal in adding SRCU-synchronized tracepoints: adding
the ability to create tracepoint probes which will be allowed to handle page
faults properly. This is very relevant for the syscall tracepoints reading the
system call parameters from user-space. Currently, we are stuck with sub par
hacks such as filling the missing data with zeroes. Usually nobody notices because
most syscall arguments are typically hot in the page cache, but it is still fragile.

I'd very much prefer see commits moving syscall tracepoints to use of SRCU
(without preempt disable around the tracepoint calls) rather than a commit removing
tracepoint SRCU use because of something that needs to be fixed within perf.

Thanks,

Mathieu


> 
> Joel Fernandes (Google) (3):
> Revert "tracepoint: Use __idx instead of idx in DO_TRACE macro to make
> it unique"
> Revert "tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle
> tracepoints"
> Revert "tracepoint: Make rcuidle tracepoint callers use SRCU"
> 
> include/linux/tracepoint.h | 40 ++++++--------------------------------
> kernel/tracepoint.c        | 10 +---------
> 2 files changed, 7 insertions(+), 43 deletions(-)
> 
> --
> 2.25.0.341.g760bfbb309-goog

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
