Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7536EC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4754F2082E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kt8490Cs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgDTQBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgDTQBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:01:09 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807CCC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:01:09 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id l25so3630852vso.6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WuNts4roSnVT38mDLnWv8jRqAzTZYkIvGI570vYzqIk=;
        b=Kt8490CslR4OqE/aETy1fwAP5QHSzjGDLnG8yf9sqUiS1eq8aFIGFaUhvsKdhoYRmZ
         5QWpLoH1voY42TCIL3LtQCSdsqnQLA3PR1p5h3lNhGJ7DQEpwijurr9d552wwqYSvJix
         G3CgpMcIeNjE6rDWsTrKf/hbdnLbSPD96lVi6d5TswAFhs70Ou51+LK4yyZ4VfQoxThI
         vVevwRR5Zj4yFPZ5jX+JNlyRkTjEAaiSfmsfkbMcOZwS4//swio/OYmhG5XtnH8yzTsl
         r6LGXbXFMXoHsZyEPvAWQurXMqK/2tHNXhFSa80rc5+Iigb+vkepCFzXjyvwclbNqXbk
         ApeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WuNts4roSnVT38mDLnWv8jRqAzTZYkIvGI570vYzqIk=;
        b=dOoquCL1LtW9dyRe3JEb40uUIsyVBParXJ/ykng10R9LoMF5O1B2WHlSXzMqyj8ulg
         inqJlUn1hcVKb9Y+8zqpZwxOOdpDxVX2q1WH/ldYTO1UUSBBtuWG4DlcEHRMRYhZUJ05
         IIdZ68NMlaJxXFA7bIvQXTCTC6AmzF8m3RcYWDCK7jLvMRrYSDUjKWbEPlgfatCw84ly
         DEtnQeQwMgbUQyCJjqDWMYMXIPFt/nMTRuAPU4CYN7+PsKZiAaLDOZSTch1FGhKcHi0N
         BeopXcyG3SGVtTmBRgYyYmfE9IgGkXHFA07jjAqR7+7L5SI1iZTzJrYHZNtx8Fz5CHA6
         Dpkg==
X-Gm-Message-State: AGi0PuYjsJtirCQlUVPOGXRqYbc5SNy9b9XvQ3ATY5NrCnDNdRvmiP9G
        AP9ZtmZVItkb5DFT73jpAOY44xFyXt7Wp7xnnzDItg==
X-Google-Smtp-Source: APiQypI5oaa7q9V3LmP4iLVpQ4JzGxnSs2yJwZdBfxUsrbjPC5spOcVIFYLzBUDARenM70dIMC9RJWWNt6hanXq3mo0=
X-Received: by 2002:a67:fad7:: with SMTP id g23mr11921778vsq.240.1587398467678;
 Mon, 20 Apr 2020 09:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200106202919.2943-1-kan.liang@linux.intel.com> <20200110131749.GD2827@hirez.programming.kicks-ass.net>
In-Reply-To: <20200110131749.GD2827@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 20 Apr 2020 09:00:56 -0700
Message-ID: <CABPqkBTSwoCOt_pOQvX4qSTy6D5DKYvZVXJd66Vf=2mGVsOpvQ@mail.gmail.com>
Subject: Re: [PATCH V5 RESEND 00/14] TopDown metrics support for Icelake
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 10, 2020 at 5:17 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jan 06, 2020 at 12:29:05PM -0800, kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> >
> > Icelake has support for measuring the level 1 TopDown metrics
> > directly in hardware. This is implemented by an additional METRICS
> > register, and a new Fixed Counter 3 that measures pipeline SLOTS.
> >
> > New in Icelake
> > - Do not require generic counters. This allows to collect TopDown always
> >   in addition to other events.
> > - Measuring TopDown per thread/process instead of only per core
> >
> > For the Ice Lake implementation of performance metrics, the values in
> > PERF_METRICS MSR are derived from fixed counter 3. Software should start
> > both registers, PERF_METRICS and fixed counter 3, from zero.
> > Additionally, software is recommended to periodically clear both
> > registers in order to maintain accurate measurements. The latter is
> > required for certain scenarios that involve sampling metrics at high
> > rates. Software should always write fixed counter 3 before write to
> > PERF_METRICS.
>
> Do we really have to support this trainwreck? This is such ill designed
> hardware, I'm loath to support it, it might encourage more such
> 'creative' things and we really don't need that.
>
Yes, we do because it provides important information per hyper-thread.

I understand that the hardware is convoluted to support because it
introduces a new concept: a single counter computing multiple high
level metrics. It is difficult to abstract cleanly especially when you
add on top that it is connected with a new fixed counter (SLOTS).

The challenges I see:
   - single MSR containing multiple non monotonically incrementing fields
   - point of reference. Need to know when fields were zeroed to
understand on what part of the execution the topdown percentages are
computed.
   - must combine with fixed counter 3 (SLOTS) to operate correctly

I see two ways of supporting this new concept.

1/ Abstract as individual events

In Kan's approach, the nature of the PERF_METRICS MSR is hidden.
He exposes the individual metrics as pseudo-events: topdown-retiring,
topdown-bad-spec, slots, ...
These events are based on the fields of the PERF_METRICS (except slots).

Given that each field is a percentage, he chose to scale them by SLOTS
to expose them as monotonically incrementing events. This makes it
easier on the perf tool.

To ensure the pseudo-events make sense, it is necessary to put them
into a single event group.
That also helps the kernel with a single WRMSR/RDMSR for all 4 metrics.

Given that the point of reference is important, any read of the group
resets the fields.

With this approach, the perf tool has no changes required, except
recomputing the topdown percentages from the scale counts.

2/ Abstract the multi-metric MSR

This is another approach, whereby we could export a new abstraction of
a structured counter. The kernel could publish the structure of the
counter
like it does today for the structure of the config register
(/sys/devices/cpu/format). The tool would parse the format and extract
the fields from the
64-bit value of the MSR. The width and unit would be part of the
format, just like what is done for some pseudo events already.
To program this MSR, you'd have to add a single pseudo event, e.g.,
TOPDOWN_L1. The grouping would be implicit.
The point of reference approach would be the same as the first
approach: any read would reset the counts.
The kernel would still have to handle the SLOTS counter.
This approach requires fewer changes to the kernel but more in the tool.

If you have another approach in mind, please share it.
The PERF_METRICS hardware is very useful, we cannot really afford not
having it supported.
I am happy to help.
