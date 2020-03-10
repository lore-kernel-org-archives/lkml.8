Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665AFC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362BF2467F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 08:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583827800;
	bh=q58/jumb4vpiXoPIfOU8+VxkKfKKNM+I+NPxgALyx7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FCo28jug/Fkv4NUXZMK31vSOkiD25R6Wq37K25VWYctdLdL04/Y9Rd7A18xcSeI6e
	 pzZIwskdIa+OPgp9RBD1LyBFxUKt9Yq7qYJ47fku9qcOzWPPa8hwkGXWRzRvcp6jfM
	 1ZNGHrNFUpCKsO7tw84A8ognSqNEpNFUCFnlLbEY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgCJIJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 04:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgCJIJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 04:09:58 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FF4D2253D;
        Tue, 10 Mar 2020 08:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583827797;
        bh=q58/jumb4vpiXoPIfOU8+VxkKfKKNM+I+NPxgALyx7k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=o0SQ3GY3Nu/Nk5t+QZmbCNgmxih/L61BfkWIhcmZAv5rQL66LdNDdj/5YH/HVdQBX
         7YDij2d6Vo1vnzGd2JUmVJ0z0TSEkR0GKp1+1xBaagJF/2HBZvnbXxWgjIx1m1P/HO
         nnr5InhJ5H8u1HzOAY/zaiKpUhdQFiUz1h+y1py4=
Date:   Tue, 10 Mar 2020 17:09:51 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>
Subject: Re: Instrumentation and RCU
Message-Id: <20200310170951.87c29e9c1cfbddd93ccd92b3@kernel.org>
In-Reply-To: <87fteh73sp.fsf@nanos.tec.linutronix.de>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de>
        <20200309141546.5b574908@gandalf.local.home>
        <87fteh73sp.fsf@nanos.tec.linutronix.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 09 Mar 2020 19:59:18 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> >> #2) Breakpoint utilization
> >> 
> >>     As recent findings have shown, breakpoint utilization needs to be
> >>     extremly careful about not creating infinite breakpoint recursions.
> >> 
> >>     I think that's pretty much obvious, but falls into the overall
> >>     question of how to protect callchains.
> >
> > This is rather unique, and I agree that its best to at least get to a point
> > where we limit the tracing within breakpoint code. I'm fine with making
> > rcu_nmi_exit() nokprobe too.
> 
> Yes, the break point stuff is unique, but it has nicely demonstrated how
> much of the code is affected by it.

I see. I had followed the callchain several times, and always found new function.
So I agree with the off-limit section idea. That is a kind of entry code section
but more generic one. It is natural to split such sensitive code in different
place.

BTW, what about kdb stuffs? (+Cc Jason)

> >> #4 Protecting call chains
> >> 
> >>    Our current approach of annotating functions with notrace/noprobe is
> >>    pretty much broken.
> >> 
> >>    Functions which are marked NOPROBE or notrace call out into functions
> >>    which are not marked and while this might be ok, there are enough
> >>    places where it is not. But we have no way to verify that.

Agreed. That's the reason why I haven't add kprobe-fuzzer yet.
It is easy to make a fuzzer for kprobes by ftrace (note that we need
to enable CONFIG_KPROBE_EVENTS_ON_NOTRACE=y to check notrace functions),
but there is no way to kick the target code. In the result, most of the
kprobed functions are just not hit. I'm not sure such test code is
reasonable or not.

> > Note, if notrace is an issue it shows up pretty quickly, as just enabling
> > function tracing will enable all non notrace locations, and if something
> > shouldn't be traced, it will crash immediately.
> 
> Steven, you're not really serious about this, right? This is tinkering
> at best.
> 
> We have code pathes which are not necessarily covered in regular
> testing, depend on config options etc.
> 
> Have you ever looked at code coverage maps? There are quite some spots
> which we don't reach in testing.
> 
> So how do you explain the user that the blind spot he hit in the weird
> situation on his server which he wanted to analyze crashed his machine?
> 
> Having 'off limit' sections allows us to do proper tool based analysis
> with full coverage. That's really the only sensible approach.
> 
> > I have a RCU option for ftrace ops to set, if it requires RCU to be
> > watching, and in that case, it wont call the callback if RCU is not
> > watching.
> 
> That's nice but does not solve the problem.
> 
> >>    That's just a recipe for disaster. We really cannot request from
> >>    sysadmins who want to use instrumentation to stare at the code first
> >>    whether they can place/enable an instrumentation point somewhere.
> >>    That'd be just a bad joke.
> >> 
> >>    I really think we need to have proper text sections which are off
> >>    limit for any form of instrumentation and have tooling to analyze the
> >>    calls into other sections. These calls need to be annotated as safe
> >>    and intentional.
> >> 
> >> Thoughts?
> >
> > This can expand quite a bit. At least when I did something similar with
> > NMIs, as there was a time I wanted to flag all places that could be called
> > from NMI, and found that there's a lot of code that can be.
> >
> > I can imagine the same for marking nokprobes as well. And I really don't
> > want to make all notrace stop tracing the entire function and all that it
> > can call, as that will go back to removing all callers from NMIs as
> > do_nmi() itself is notrace.
> 
> The point is that you have something like this:
> 
> section "text.offlimit"
> 
> nmi()
> {
>         do_fragile_stuff_on_enter();
> 
>         offlimit_safecall(do_some_instrumentable_stuff());
> 
>         do_fragile_stuff_on_exit();
> }
> 
> section "text"
> 
> do_some_instrumentable_stuff()
> {
> }
> 
> So if someone adds another call
> 
> section "text.offlimit"
> 
> nmi()
> {
>         do_fragile_stuff_on_enter();
> 
>         offlimit_safecall(do_some_instrumentable_stuff());
> 
>         do_some_other_instrumentable_stuff();
> 
>         do_fragile_stuff_on_exit();
> }
> 
> which is also in section "text" then the analysis tool will find the
> missing offlimit_safecall() - or what ever method we chose to annotate
> that stuff. Surely not an annotation on the called function itself
> because that might be safe to call in one context but not in another.

Hmm, what the offlimit_safecall() does? and what happen if the 
do_fragile_stuff_on_enter() invokes a library code? I think we also need
to tweak kbuild to duplicate some library code to the off-limit text area.

> These annotations are halfways easy to monitor for abuse and they should
> be prominent enough in the code that at least for the people dealing
> with that kind of code they act as a warning flag.

This off-limit text will be good for entries, but I think we still not
able to remove all NOKPROBE_SYMBOLS with this.

For example __die() is marked a NOKPROBE because if we hit a recursive
int3, it calls BUG() to dump stacks etc for debug. So that function
must NOT probed. (I think we also should mark all backtrace functions
in this case, but not yet) Would we move those backtrace related
functions (including printk, and console drivers?) into the offlimit
text too?

Hmm, if there is a bust_kprobes(), that can be easy to fix this issue.


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
