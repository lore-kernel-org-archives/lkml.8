Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1D8C4332B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:26:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B9B120772
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:26:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYiQuSUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgCRV0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:26:31 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:33024 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCRV0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 17:26:30 -0400
Received: by mail-ua1-f66.google.com with SMTP id i7so9768526uap.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 14:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=57T18qefr2GsLeN4acf/6cYvMdZYQCvObbNEQaOVlbg=;
        b=oYiQuSUqT5TwsTt1msNPAO5dvLoUM9VGgKJ9v8gaUO7bAy5CzqBVVvLeZEo21Vt6ig
         YXa4limQgf1VdF+sCe7kpVjH2Or0zZhrUMcz6BgWspwyFxCbxpIJLW6WAa7DjWCWKVZu
         YBzUhvxJum3jXBLubkeyG85KpECKKraUozPDOC1geLOxzByIErp4FnDHTL2+SNiwnEVB
         Ya1AruaGYbbijH95Sx3a8flcyUgpMRKi+EmXiuROh/nrEoqXMlJsHxYBV9YD4X/uczSM
         TWUZwmEwrI7KIB1oS9DlqUcrFg6+auImPf8Ml6FAX650W7Lq3IhHEbBgvajDXiQxnb/E
         kGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=57T18qefr2GsLeN4acf/6cYvMdZYQCvObbNEQaOVlbg=;
        b=GgoPVFr0GZJ/b6dwHLKhQSUtHRWijvFccCsnhiXn0ve38zjzEsiIR9c/UjWSY2/OxX
         hQj8Te9+DcBFyt7hLukE4EPvB/NTIOH6s81+xrDZnctVAS283/POP//jW74ioDCjpqfU
         VMCootymaWL2mBNpqhd8nVuq4gSGEUQzvJ/PBqISmksp/z7fsKx4nNG4MfZ5ZLmp373p
         rJ2UeNy1skUFONYbqp3EGRev+a+nT6C4ixmAdC+D6SsIqdGREyzIDVXQ7vZiTEJhSVb+
         eBRfwd176q+iaa5a4AqB9YnmsmdM5rTuiSrLU4VXn+yneWcQzGTp0ttE7CkmaGu3pJr7
         H2bg==
X-Gm-Message-State: ANhLgQ2SqiiohtWzftRk9DsfUpk9yp9IjGS9d5IfYjtq3wS1likZoS1T
        8UuNW7pR9EFnarx5XWWEmgch2M4txi6imt2R4RrkSA==
X-Google-Smtp-Source: ADFU+vtsQ9m/KpArtjCMo9sdI0mP0gJC/qqeV1ttZgOUKnTXfud7eC+vvJFfV6ZavDLKNiY+kmhwU2zuy4AboN1IecI=
X-Received: by 2002:a9f:358b:: with SMTP id t11mr4536550uad.134.1584566788001;
 Wed, 18 Mar 2020 14:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200313231024.17601-1-kim.phillips@amd.com> <CABPqkBS8TUMTEz_motpd+8xK599tLXAonUHwp-CWMyU2RhcbQg@mail.gmail.com>
 <2581de5a-969b-93c7-0565-2eef51717900@amd.com> <20200318204257.GL20730@hirez.programming.kicks-ass.net>
In-Reply-To: <20200318204257.GL20730@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 18 Mar 2020 14:26:16 -0700
Message-ID: <CABPqkBQn7VRWQu-JU9BfE8y3g_uqhKEtN6GYuVuKs6QTGPHzgw@mail.gmail.com>
Subject: Re: [PATCH 1/3 v2] perf/amd/uncore: Prepare L3 thread mask code for
 Family 19h support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kim Phillips <kim.phillips@amd.com>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 1:43 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Mar 18, 2020 at 09:46:41AM -0500, Kim Phillips wrote:
>
> > > But this does not work with the cpumask programmed for the amd_l3 PMU. This mask
> > > shows, as it should, one CPU/CCX. So that means that when I do:
> > >
> > > $ perf stat -a amd_l3/event=llc_event/
> > >
> > > This only collects on the CPUs listed in the cpumask: 0,4,8,12 ....
> > > That means that L3 events generated by the other CPUs on the CCX are
> > > not monitored.
> > > I can easily see the problem by pinning a memory bound program to
> > > CPU64, for instance.
> >
> > Right, the higher level code calls the driver with a single cpu==0
> > call if the perf tool is invoked with a simple -a style system-wide.

No, it does not.

With -a, when -C is not passed, the perf tool picks up the cpumask for
the PMU from sysfs:
$ cat /proc/sys/devices/amd_l3/cpumask

You can easily verify this by running: strace -etrace=perf_event_open
perf stat -a -e amd_l3/event=0x00/.
This is the default common mode.

The problem is that here to get any meaningful result, you need to force a -C.
The CPU in the cpumask is just the CPU to which to attach the event in
order to access the correct uncore PMU.
Here, you have one CPU per CCX which is expected and perfectly fine.

The thread_mask is a hardware filter on the uncore L3 PMU. If you set
by default the thread_mask to 0xff, then
you obtain a full system view with a simple -a, or per socket with
--per-socket. So we need to find a way to
make this common case work properly first. Expecting the users to know
that for some amd_l3 events you need
to force -C 0-255 is not practical. I also think that forcing the
cpumask to 0-255 is not right solution. This is not how
this is done for any other uncore PMU I know of and some do have the
thread filter, such as the Skylake CHA.



> > If the tool is invoked with supplemental switches to -a, like -C 0-255,
> > and -A, the driver gets called multiple times with all the unique cpu
> > values.  The latter is the expected invocation style when measuring
> > a benchmark pinned on a subset of cpus, i.e., when evaluating
> > the driver, and is the more deterministic behaviour for the driver
> > to have, given it cannot tell the difference otherwise.
>
> That seems to suggest it is all horribly broken.
