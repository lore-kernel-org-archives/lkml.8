Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6DDC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 03:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0A6214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 03:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578972316;
	bh=QkHyKAGTddSsShkAKK/9wz9s/LBEIbe4rXene2Ocgcw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lW8UQ/A8punaR6rQfAGZm6+xjxX5jfRrYxFNv9qS9jAzT5Xmn77fHIjLzWXJplYQv
	 4YUHhhS5d/6STMM8BKhe7M09t0DKctnItrJPnGEdFJS5p4INlMSAHObai6esr98wC+
	 l8xZCu2JIaxFB+a+byol3I79TfTZtuhqwa3dZyH0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgANDZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 22:25:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:53920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbgANDZP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 22:25:15 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E500420CC7;
        Tue, 14 Jan 2020 03:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578972314;
        bh=QkHyKAGTddSsShkAKK/9wz9s/LBEIbe4rXene2Ocgcw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P/oeRpMLF2bpU9nSUQIoi6OYhsI/JtCANb5Pqun4pmvjYHBs7iMrEF+jFM0p99K5J
         9Vi0fL0G6yVxBBlCqCZKTylkfO4ZfpLayfsRohavJxscGdKhB7RSASxW8zY1uijujf
         6uDPYCefy+oYQMT3d2EYhKpa1jdmy1aUOBRfXGok=
Date:   Tue, 14 Jan 2020 12:25:06 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     arnaldo.melo@gmail.com, Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        "jani.nikula@linux.intel.com" <jani.nikula@linux.intel.com>,
        "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "james.bottomley@hansenpartnership.com" 
        <james.bottomley@hansenpartnership.com>,
        Serge Hallyn <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Robert Richter <rric@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/9] perf/core: open access for CAP_SYS_PERFMON
 privileged process
Message-Id: <20200114122506.3cf442dc189a649d4736f86e@kernel.org>
In-Reply-To: <158a4033-f8d6-8af7-77b0-20e62ec913b0@linux.intel.com>
References: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
        <c93309dc-b920-f5fa-f997-e8b2faf47b88@linux.intel.com>
        <20200108160713.GI2844@hirez.programming.kicks-ass.net>
        <cc239899-5c52-2fd0-286d-4bff18877937@linux.intel.com>
        <20200110140234.GO2844@hirez.programming.kicks-ass.net>
        <20200111005213.6dfd98fb36ace098004bde0e@kernel.org>
        <20200110164531.GA2598@kernel.org>
        <20200111084735.0ff01c758bfbfd0ae2e1f24e@kernel.org>
        <2B79131A-3F76-47F5-AAB4-08BCA820473F@fb.com>
        <5e191833.1c69fb81.8bc25.a88c@mx.google.com>
        <158a4033-f8d6-8af7-77b0-20e62ec913b0@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Jan 2020 12:57:18 +0300
Alexey Budankov <alexey.budankov@linux.intel.com> wrote:

> 
> On 11.01.2020 3:35, arnaldo.melo@gmail.com wrote:

> > Message-ID: <A7F0BF73-9189-44BA-9264-C88F2F51CBF3@kernel.org>
> > 
> > On January 10, 2020 9:23:27 PM GMT-03:00, Song Liu <songliubraving@fb.com> wrote:
> >>
> >>
> >>> On Jan 10, 2020, at 3:47 PM, Masami Hiramatsu <mhiramat@kernel.org>
> >> wrote:
> >>>
> >>> On Fri, 10 Jan 2020 13:45:31 -0300
> >>> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >>>
> >>>> Em Sat, Jan 11, 2020 at 12:52:13AM +0900, Masami Hiramatsu escreveu:
> >>>>> On Fri, 10 Jan 2020 15:02:34 +0100 Peter Zijlstra
> >> <peterz@infradead.org> wrote:
> >>>>>> Again, this only allows attaching to previously created kprobes,
> >> it does
> >>>>>> not allow creating kprobes, right?
> >>>>
> >>>>>> That is; I don't think CAP_SYS_PERFMON should be allowed to create
> >>>>>> kprobes.
> >>>>
> >>>>>> As might be clear; I don't actually know what the user-ABI is for
> >>>>>> creating kprobes.
> >>>>
> >>>>> There are 2 ABIs nowadays, ftrace and ebpf. perf-probe uses ftrace
> >> interface to
> >>>>> define new kprobe events, and those events are treated as
> >> completely same as
> >>>>> tracepoint events. On the other hand, ebpf tries to define new
> >> probe event
> >>>>> via perf_event interface. Above one is that interface. IOW, it
> >> creates new kprobe.
> >>>>
> >>>> Masami, any plans to make 'perf probe' use the perf_event_open()
> >>>> interface for creating kprobes/uprobes?
> >>>
> >>> Would you mean perf probe to switch to perf_event_open()?
> >>> No, perf probe is for setting up the ftrace probe events. I think we
> >> can add an
> >>> option to use perf_event_open(). But current kprobe creation from
> >> perf_event_open()
> >>> is separated from ftrace by design.
> >>
> >> I guess we can extend event parser to understand kprobe directly.
> >> Instead of
> >>
> >> 	perf probe kernel_func
> >> 	perf stat/record -e probe:kernel_func ...
> >>
> >> We can just do 
> >>
> >> 	perf stat/record -e kprobe:kernel_func ...
> > 
> > 
> > You took the words from my mouth, exactly, that is a perfect use case, an alternative to the 'perf probe' one of making a disabled event that then gets activated via record/stat/trace, in many cases it's better, removes the explicit probe setup case.
> 
> Arnaldo, Masami, Song,
> 
> What do you think about making this also open to CAP_SYS_PERFMON privileged processes?
> Could you please also review and comment on patch 5/9 for bpf_trace.c?

As we talked at RFC series of CAP_SYS_TRACING last year, I just expected
to open it for enabling/disabling kprobes, not for creation.

If we can accept user who has no admin priviledge but the CAP_SYS_PERFMON,
to shoot their foot by their own risk, I'm OK to allow it. (Even though,
it should check the max number of probes to be created by something like
ulimit)
I think nowadays we have fixed all such kernel crash problems on x86,
but not sure for other archs, especially on the devices I can not reach.
I need more help to stabilize it.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
