Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0946CC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB53424655
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCJLnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:43:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33437 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgCJLnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:43:42 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jBdIF-0005q3-On; Tue, 10 Mar 2020 12:43:27 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 4AAF51040A5; Tue, 10 Mar 2020 12:43:27 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
In-Reply-To: <20200310170951.87c29e9c1cfbddd93ccd92b3@kernel.org>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de> <20200309141546.5b574908@gandalf.local.home> <87fteh73sp.fsf@nanos.tec.linutronix.de> <20200310170951.87c29e9c1cfbddd93ccd92b3@kernel.org>
Date:   Tue, 10 Mar 2020 12:43:27 +0100
Message-ID: <87pndk5tb4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami,

Masami Hiramatsu <mhiramat@kernel.org> writes:
> On Mon, 09 Mar 2020 19:59:18 +0100
> Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> >> #2) Breakpoint utilization
>> >> 
>> >>     As recent findings have shown, breakpoint utilization needs to be
>> >>     extremly careful about not creating infinite breakpoint recursions.
>> >> 
>> >>     I think that's pretty much obvious, but falls into the overall
>> >>     question of how to protect callchains.
>> >
>> > This is rather unique, and I agree that its best to at least get to a point
>> > where we limit the tracing within breakpoint code. I'm fine with making
>> > rcu_nmi_exit() nokprobe too.
>> 
>> Yes, the break point stuff is unique, but it has nicely demonstrated how
>> much of the code is affected by it.
>
> I see. I had followed the callchain several times, and always found new function.
> So I agree with the off-limit section idea. That is a kind of entry code section
> but more generic one. It is natural to split such sensitive code in different
> place.
>
> BTW, what about kdb stuffs? (+Cc Jason)

That's yet another area of wreckage which nobody every looked at.

>> >> #4 Protecting call chains
>> >> 
>> >>    Our current approach of annotating functions with notrace/noprobe is
>> >>    pretty much broken.
>> >> 
>> >>    Functions which are marked NOPROBE or notrace call out into functions
>> >>    which are not marked and while this might be ok, there are enough
>> >>    places where it is not. But we have no way to verify that.
>
> Agreed. That's the reason why I haven't add kprobe-fuzzer yet.
> It is easy to make a fuzzer for kprobes by ftrace (note that we need
> to enable CONFIG_KPROBE_EVENTS_ON_NOTRACE=y to check notrace functions),
> but there is no way to kick the target code. In the result, most of the
> kprobed functions are just not hit. I'm not sure such test code is
> reasonable or not.

Well, test code is always reasonable, but you have to be aware that code
coverage is a really hard to solve problem with a code base as complex
as the kernel.

>> which is also in section "text" then the analysis tool will find the
>> missing offlimit_safecall() - or what ever method we chose to annotate
>> that stuff. Surely not an annotation on the called function itself
>> because that might be safe to call in one context but not in another.
>
> Hmm, what the offlimit_safecall() does? and what happen if the 
> do_fragile_stuff_on_enter() invokes a library code? I think we also need
> to tweak kbuild to duplicate some library code to the off-limit text
> area.

That's why we want the sections and the annotation. If something calls
out of a noinstr section into a regular text section and the call is not
annotated at the call site, then objtool can complain and tell you. What
Peter and I came up with looks like this:

noinstr foo()
	do_protected(); <- Safe because in the noinstr section

	instr_begin();	<- Marks the begin of a safe region, ignored
        		   by objtool

        do_stuff();     <- All good   

        instr_end();    <- End of the safe region. objtool starts
			   looking again

        do_other_stuff();  <- Unsafe because do_other_stuff() is
        		      not protected
and:

noinstr do_protected()
        bar();		<- objtool will complain here

See?

>> These annotations are halfways easy to monitor for abuse and they should
>> be prominent enough in the code that at least for the people dealing
>> with that kind of code they act as a warning flag.
>
> This off-limit text will be good for entries, but I think we still not
> able to remove all NOKPROBE_SYMBOLS with this.
>
> For example __die() is marked a NOKPROBE because if we hit a recursive
> int3, it calls BUG() to dump stacks etc for debug. So that function
> must NOT probed. (I think we also should mark all backtrace functions
> in this case, but not yet) Would we move those backtrace related
> functions (including printk, and console drivers?) into the offlimit
> text too?

That's something we need to figure out and decide on. Some of this stuff
sureley wants to be in the noinstr section. Other things might end up
still being explicitely annotated, but that should be the exception not
the rule.

> Hmm, if there is a bust_kprobes(), that can be easy to fix this issue.

That might help, but is obviously racy as hell.

Thanks,

        tglx
