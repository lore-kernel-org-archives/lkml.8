Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00618C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 05:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B19492075B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 05:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="je1otCBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgANFSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 00:18:04 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44833 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgANFSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 00:18:04 -0500
Received: by mail-lj1-f194.google.com with SMTP id u71so12746749lje.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 21:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YF7sH12nM8SqMP6NliChTSRyyRsEg8Bqgkiw1eGtd14=;
        b=je1otCBT2BCUAoVS3qhGpG/ju3P/zmJbBw1f252ea28TDW17YlgfZ61cZYKX3Pzz3H
         fxVHjfL39f0PHeOAkRzst2Sj8enNPNjt2bb+qnpSSeHgmrExwaHMcl7xa8StrUuAcxsv
         MI0wmR0qw4XTJG2ys7QOXGCIr3XtCEKvT8EorRHU9x/b+RpI2oP2SWeUEdRgj765m6XX
         Xrqe5sj0CC16vlpF7Oe2a8Boz9DpYojvGiAIoiXxBtXfGdKXuxZB4OzDLV6mBs8gyWn8
         Sx56rJeR6+Evf8cahsZ3usZJSXrJxMkEU/tbVSmLtraQxKnU6IZAGEmp1mx7TaXdRzBP
         WNmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YF7sH12nM8SqMP6NliChTSRyyRsEg8Bqgkiw1eGtd14=;
        b=pxGETn0Ii6p0ibbWhqxtrIVEK/KE4BdFZteK8XHU5KVxzAuj6prYqvMRy1skbiNXh2
         Mmv4W3lkbZf3bvdTig6D5v9uYlkYQP4ZVcjXeIRVKFwbGsJxa+CxYkCuWG0Kl1IaiCp6
         qjfp03NAcxNyFffR8VNrY0srt9OTWRPjOMAOp15Uk9EgcVDGIcpuUG9GFOOyE2uIS8Fw
         xqTbxXDGy7uH9BRKEp79WJd7hADSIoDHieXZqJxP13RoSTHTEHC7IN8ubPWj6UFAMYnF
         HsjnQb0+GLF/tYi6afcfKP7M59+jjozSq44B8sx8FdAHditTLxGcak1Y/vSOf1JFJhMp
         Uo/w==
X-Gm-Message-State: APjAAAU4UtcXyXHsna/cKH3/98ZDCXfcLJpTFrkZZ4nkeI/PcyxquNAN
        vP8hO+8U0i86yy/AZQRvnO1OcRr6HEED5ySjT+4=
X-Google-Smtp-Source: APXvYqxGnXFfKM8bZxDsVrrgxPOxJXcjjHAQjRHWoiBhj0CyMlapopM3NSydrSRmLFfuhU6WubSlm5WQ72irbNywibw=
X-Received: by 2002:a2e:990e:: with SMTP id v14mr12219066lji.23.1578979081450;
 Mon, 13 Jan 2020 21:18:01 -0800 (PST)
MIME-Version: 1.0
References: <c0460c78-b1a6-b5f7-7119-d97e5998f308@linux.intel.com>
 <c93309dc-b920-f5fa-f997-e8b2faf47b88@linux.intel.com> <20200108160713.GI2844@hirez.programming.kicks-ass.net>
 <cc239899-5c52-2fd0-286d-4bff18877937@linux.intel.com> <20200110140234.GO2844@hirez.programming.kicks-ass.net>
 <20200111005213.6dfd98fb36ace098004bde0e@kernel.org> <20200110164531.GA2598@kernel.org>
 <20200111084735.0ff01c758bfbfd0ae2e1f24e@kernel.org> <2B79131A-3F76-47F5-AAB4-08BCA820473F@fb.com>
 <5e191833.1c69fb81.8bc25.a88c@mx.google.com> <158a4033-f8d6-8af7-77b0-20e62ec913b0@linux.intel.com>
 <20200114122506.3cf442dc189a649d4736f86e@kernel.org>
In-Reply-To: <20200114122506.3cf442dc189a649d4736f86e@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 13 Jan 2020 21:17:49 -0800
Message-ID: <CAADnVQLCtrvvagbbkZG4PyAKb2PWzUouxG3=nxvm8QdpgEWtGQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] perf/core: open access for CAP_SYS_PERFMON
 privileged process
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Song Liu <songliubraving@fb.com>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 7:25 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Sat, 11 Jan 2020 12:57:18 +0300
> Alexey Budankov <alexey.budankov@linux.intel.com> wrote:
>
> >
> > On 11.01.2020 3:35, arnaldo.melo@gmail.com wrote:
>
> > > Message-ID: <A7F0BF73-9189-44BA-9264-C88F2F51CBF3@kernel.org>
> > >
> > > On January 10, 2020 9:23:27 PM GMT-03:00, Song Liu <songliubraving@fb.com> wrote:
> > >>
> > >>
> > >>> On Jan 10, 2020, at 3:47 PM, Masami Hiramatsu <mhiramat@kernel.org>
> > >> wrote:
> > >>>
> > >>> On Fri, 10 Jan 2020 13:45:31 -0300
> > >>> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > >>>
> > >>>> Em Sat, Jan 11, 2020 at 12:52:13AM +0900, Masami Hiramatsu escreveu:
> > >>>>> On Fri, 10 Jan 2020 15:02:34 +0100 Peter Zijlstra
> > >> <peterz@infradead.org> wrote:
> > >>>>>> Again, this only allows attaching to previously created kprobes,
> > >> it does
> > >>>>>> not allow creating kprobes, right?
> > >>>>
> > >>>>>> That is; I don't think CAP_SYS_PERFMON should be allowed to create
> > >>>>>> kprobes.
> > >>>>
> > >>>>>> As might be clear; I don't actually know what the user-ABI is for
> > >>>>>> creating kprobes.
> > >>>>
> > >>>>> There are 2 ABIs nowadays, ftrace and ebpf. perf-probe uses ftrace
> > >> interface to
> > >>>>> define new kprobe events, and those events are treated as
> > >> completely same as
> > >>>>> tracepoint events. On the other hand, ebpf tries to define new
> > >> probe event
> > >>>>> via perf_event interface. Above one is that interface. IOW, it
> > >> creates new kprobe.
> > >>>>
> > >>>> Masami, any plans to make 'perf probe' use the perf_event_open()
> > >>>> interface for creating kprobes/uprobes?
> > >>>
> > >>> Would you mean perf probe to switch to perf_event_open()?
> > >>> No, perf probe is for setting up the ftrace probe events. I think we
> > >> can add an
> > >>> option to use perf_event_open(). But current kprobe creation from
> > >> perf_event_open()
> > >>> is separated from ftrace by design.
> > >>
> > >> I guess we can extend event parser to understand kprobe directly.
> > >> Instead of
> > >>
> > >>    perf probe kernel_func
> > >>    perf stat/record -e probe:kernel_func ...
> > >>
> > >> We can just do
> > >>
> > >>    perf stat/record -e kprobe:kernel_func ...
> > >
> > >
> > > You took the words from my mouth, exactly, that is a perfect use case, an alternative to the 'perf probe' one of making a disabled event that then gets activated via record/stat/trace, in many cases it's better, removes the explicit probe setup case.
> >
> > Arnaldo, Masami, Song,
> >
> > What do you think about making this also open to CAP_SYS_PERFMON privileged processes?
> > Could you please also review and comment on patch 5/9 for bpf_trace.c?
>
> As we talked at RFC series of CAP_SYS_TRACING last year, I just expected
> to open it for enabling/disabling kprobes, not for creation.
>
> If we can accept user who has no admin priviledge but the CAP_SYS_PERFMON,
> to shoot their foot by their own risk, I'm OK to allow it. (Even though,
> it should check the max number of probes to be created by something like
> ulimit)
> I think nowadays we have fixed all such kernel crash problems on x86,
> but not sure for other archs, especially on the devices I can not reach.
> I need more help to stabilize it.

I don't see how enable/disable is any safer than creation.
If there are kernel bugs in kprobes the kernel will crash anyway.
I think such partial CAP_SYS_PERFMON would be very confusing to the users.
CAP_* is about delegation of root privileges to non-root.
Delegating some of it is ok, but disallowing creation makes it useless
for bpf tracing, so we would need to add another CAP later.
Hence I suggest to do it right away instead of breaking
sys_perf_even_open() access into two CAPs.
