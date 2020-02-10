Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CF7C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D04020842
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="M/HlepiU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgBJQ7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:59:48 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43340 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJQ7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:59:48 -0500
Received: by mail-qk1-f196.google.com with SMTP id p7so2221477qkh.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 08:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SC2gi8N7AGUR5SCbIm9vLM8XLbhohA81u1OOTuOozjw=;
        b=M/HlepiUkc9ogysWeKLh1ViSduGffNCxi/E1RHlSaeLlWqHKTo3Str3JZ30E24tkUf
         FtXx+vlF+GtZB3lKiVqZSFvmJkegUgY9Hr6UUWWCGq6uYOuI/XjgoDXZhP/a3rhcCizs
         v4HbHF8aWA0zEIaW8gjsuG6Hd6Y8TSLSNSueE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SC2gi8N7AGUR5SCbIm9vLM8XLbhohA81u1OOTuOozjw=;
        b=UZWhyLTDRHTs5zDDwqut8SlszWUJi1+4YgHTZOAhrbw8JYqS/eUjpNd2xSrDRdNskg
         Ild4jx4qnAYNm7cHSb+PHzrcCgfkO2REdTB7AHynWCteAFpL02gUHBsDASn6ZQUqkxpD
         X5B3eFAjiwSg8/GUoK7qT0i+KmcJjGDJ9tJKPRQvEbM8Lzb/x7wrKC/6yEls1lmVSNaJ
         epfDoO/VB1JorSBIA2fG02FgOt/0Vxjqvav0oRwjvrPVouEx9SKOCdLwc3jid0oDjPCf
         w3NKYrbTIEZVLZaXJDcZPbL06UhX+T8wA/HF4G4pIdDreIQpVgesDl8YtjtquyRIlST/
         lorw==
X-Gm-Message-State: APjAAAVvQgL12kYNSRJOezjZsfCpe8770c3BBUrOWPg1TUujN5ZhRoBJ
        A+LDS2z3NRJVgE/FiwsjFyITJA==
X-Google-Smtp-Source: APXvYqxRojdgsio3dwYsQwmo5G3X6axwin5wOYBJ3Db0wH6BmOPa4lGZbiP6hcc39Cgqj8LBpHw2ug==
X-Received: by 2002:a37:bfc5:: with SMTP id p188mr2033267qkf.283.1581353985815;
        Mon, 10 Feb 2020 08:59:45 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id r1sm440712qtu.83.2020.02.10.08.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 08:59:45 -0800 (PST)
Date:   Mon, 10 Feb 2020 11:59:45 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
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
Subject: Re: [RFC 0/3] Revert SRCU from tracepoint infrastructure
Message-ID: <20200210165945.GA246160@google.com>
References: <20200207205656.61938-1-joel@joelfernandes.org>
 <1997032737.615438.1581179485507.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1997032737.615438.1581179485507.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,
Nice to hear from you. I replied below:

On Sat, Feb 08, 2020 at 11:31:25AM -0500, Mathieu Desnoyers wrote:
> ----- On Feb 7, 2020, at 3:56 PM, Joel Fernandes, Google joel@joelfernandes.org wrote:
> 
> > Hi,
> > These patches remove SRCU usage from tracepoints. The reason for proposing the
> > reverts is because the whole point of SRCU was to avoid having to call
> > rcu_irq_enter_irqson(). However this was added back in 865e63b04e9b2 ("tracing:
> > Add back in rcu_irq_enter/exit_irqson() for rcuidle tracepoints") because perf
> > was breaking..
> 
> I think the original patch re-enabling the rcu_irq_enter/exit_irqson() is a
> tracepoint band-aid over what should actually been fixed within perf instead.
> 
> Perf should not do rcu_read_lock/unlock()/synchronize_rcu(), but rather use
> tracepoint_synchronize_unregister() to match the read-side provided by
> tracepoints.

It feels like here you are kind of forcing tracepoint callbacks on what to
do. Why should we limit what tracepoint callbacks want to do? Further if the
callback indirectly calls some other kernel API that does use rcu_read_lock(), then it
is trouble again. I would rather make callbacks more robust, than having us
force down unwritten / undocumented rules onto them. BPF in their callbacks
also use rcu_read_lock from what I remember (but I'll have to double check).

> If perf can then just rely on the underlying synchronization provided by each
> instrumentation providers (tracepoint, kprobe, ...) and not explicitly add its own
> unneeded synchronization on top (e.g. rcu_read_lock/unlock), then it should simplify
> all this.

I kind of got lost here. The SRCU synchronization in current code is for
tracepoint_srcu which is for the tracepoint function table. Perf can't rely
on _that_ "underlying" synchronization. That is for a completely different
SRCU domain.

I think what you're proposing is:
1. Perf use its own SRCU domain and synchronize on that.
2. We remove rcu_irq_enter_irqson() for *rcuidle cases and just use SRCU in
all callbacks.

Is that right?

I think Peter said he does now want / like a separate SRCU domain within Perf
so that sounds like settled ;-)

Further what if a tracepoint callback calls into some code that does
preempt_disable() and exepects that to be an RCU read-side section? That will
get hosed too since RCU is not watching.

I would say RCU _has_ to watch callback code to be fair to them. Anything
else is a cop out IMO.

> > Since SRCU is not providing any benefit because of 865e63b04e9b2 anyway, let us
> > revert SRCU tracepoint code to maintain the sanity of potential
> > tracepoint callback registerers.
> 
> Introducing SRCU was done to simplify handling of rcuidle, thus removing some
> significant overhead that has been noticed due to use of rcu_irq_enter/exit_irqson().

But rcu_irq_enter() was added right back thus nulling that benefit.

> There is another longer-term goal in adding SRCU-synchronized tracepoints: adding
> the ability to create tracepoint probes which will be allowed to handle page
> faults properly. This is very relevant for the syscall tracepoints reading the
> system call parameters from user-space. Currently, we are stuck with sub par
> hacks such as filling the missing data with zeroes. Usually nobody notices because
> most syscall arguments are typically hot in the page cache, but it is still fragile.
> 
> I'd very much prefer see commits moving syscall tracepoints to use of SRCU
> (without preempt disable around the tracepoint calls) rather than a commit removing
> tracepoint SRCU use because of something that needs to be fixed within perf.

But such SRCU implementation / usage has to be done within the callback
itself (for syscalls in this case), that has nothing to do with removing SRCU
for tracepoint_srcu (the table). Perhaps for the syscall case, we can add a
new trace_ API specifically for SRCU that does the rcu_irq_enters_on() call
but does not do preempt_disable_notrace() before calling callbacks, thus
allowing the callback to handle page faults? And such new trace_ API can call
srcu_read_{,un}lock() on an SRCU domain specific to the tracepoint,
before/after the callback invocation.

thanks,

 - Joel


> Thanks,
> 
> Mathieu
> 
> 
> > 
> > Joel Fernandes (Google) (3):
> > Revert "tracepoint: Use __idx instead of idx in DO_TRACE macro to make
> > it unique"
> > Revert "tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle
> > tracepoints"
> > Revert "tracepoint: Make rcuidle tracepoint callers use SRCU"
> > 
> > include/linux/tracepoint.h | 40 ++++++--------------------------------
> > kernel/tracepoint.c        | 10 +---------
> > 2 files changed, 7 insertions(+), 43 deletions(-)
> > 
> > --
> > 2.25.0.341.g760bfbb309-goog
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
