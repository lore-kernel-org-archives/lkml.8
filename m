Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869BFC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 574222173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 05:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="phq+qYMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgEHFn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 01:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgEHFnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 01:43:55 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F4BC05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 22:43:55 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id c2so330196ybi.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 22:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BiVT8x4Fc5dyq46n+Hw+xDF4oIkQkHtFR1b/SJCs0I4=;
        b=phq+qYMe/tmA1caYZbha2uS86UrX+JoR3gK3zeZIeQazLEaSE9RApfQAi/p7y5hJ57
         V5XX0C8acA7Mq1AoSeRo860sfn3QU/+8eYAXZjttoaOuscvEiEwVLqEzYEo3IiKh7zTZ
         4BrKn8RPhEDBbuXhM3Cr0V5Xdm4nnf6/DEb3su888Yt1ZpxPNs6PXDVOwQCzJ3qqYOfJ
         4EMGNgyAUD9WadFwdw9wdcslT5yR0AlGXEPPJQIgXYFpbObM6A+WAcHyS8O0IWZTliJ6
         80tXa6KrLND9zVldwxZuqUsW3zrLDzsbT3P+sbdP5mtvr7xn3zsso/kjiNDQfycEYyRW
         VCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BiVT8x4Fc5dyq46n+Hw+xDF4oIkQkHtFR1b/SJCs0I4=;
        b=jgc6+fH21dBIH4EIblYcQOrx24VQABJSWCMYpOuqeDeFvFTRAP++IgEuAjB70Oz+7Z
         Py9FxeLIG5fQ4yDaGpEhgO2A6ME0VMfuCu+BgjnMGGSoIk5Rk14YNmRuwTG9NES4f5XY
         2P5DJre5IYsOkA+JbKrggjUhPHMHptVEDYTaaSKsa9nENQJv9xqLTAGcQ/5BvAqJM/eH
         h2gZBN+/XmybhUcnZfJw0TXcEIbMi1rk8YYZAkXlF4HT5nt53uRATENgFhD+emiirFq8
         +oZw5jF7N+1aj7C3cu0pexyaGjIQxIcAk4zSZpl3V6wo8r0sYqwz1s+Dcm+nIODu+h9L
         b5Ww==
X-Gm-Message-State: AGi0PubrfcI3r+v0HABAhfyZbTF5q5/3j0BPtE5+f+xFerNJxSWlBQLb
        Gy/f5Z/quweTuNvHi/JN4BZk8a2qi1/AcRGosG889w==
X-Google-Smtp-Source: APiQypIpdGKyF4W8GsRGUUk4zGtCDqmFqLpXC0AQwLENnNPtdqCovYxcVCyWnJiASZ0d++HoZhpR7c5m9PF3dfTzUzE=
X-Received: by 2002:a25:7cc1:: with SMTP id x184mr2015977ybc.403.1588916634370;
 Thu, 07 May 2020 22:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200507081436.49071-1-irogers@google.com> <20200507174835.GB3538@tassilo.jf.intel.com>
 <CAP-5=fUdoGJs+yViq3BOcJa7YyF53AD9RGQm8aRW72nMH0sKDA@mail.gmail.com> <20200507214652.GC3538@tassilo.jf.intel.com>
In-Reply-To: <20200507214652.GC3538@tassilo.jf.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 7 May 2020 22:43:43 -0700
Message-ID: <CAP-5=fV2eNAt0LLHYXeLMR6GZi_oGZyzz8psErNkbahLQs-VLQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] Share events between metrics
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 2:47 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> > > - without this change events within a metric may get scheduled
> > >   together, after they may appear as part of a larger group and be
> > >   multiplexed at different times, lowering accuracy - however, less
> > >   multiplexing may compensate for this.
> >
> > I agree the heuristic in this patch set is naive and would welcome to
> > improve it from your toplev experience. I think this change is
> > progress on TopDownL1 - would you agree?
>
> TopdownL1 in non SMT mode should always fit. Inside a group
> deduping always makes sense.
>
> The problem is SMT mode where it doesn't fit. toplev tries
> to group each node and each level together.

Thanks Andi, I've provided some examples of TopDownL3_SMT in the cover
letter of the v3 patch set:
https://lore.kernel.org/lkml/20200508053629.210324-1-irogers@google.com/
I tested sandybridge and cascadelake and the results look similar to
the non-SMT version. Let me know if there's a different variant to
test.

> >
> > I'm wondering if what is needed are flags to control behavior. For
> > example, avoiding the use of groups altogether. For TopDownL1 I see.
>
> Yes the current situation isn't great.
>
> For Topdown your patch clearly is an improvement, I'm not sure
> it's for everything though.
>
> Probably the advanced heuristics are only useful for a few
> formulas, most are very simple. So maybe it's ok. I guess
> would need some testing over the existing formulas.

Agreed, do you have a pointer on a metric group where things would
obviously be worse? I started off with a cache miss and hit rate
metric and similar to topdown this approach is a benefit.

In v3 I've added a --metric-no-merge option to retain existing
grouping behavior, I've also added a --metric-no-group that avoids
groups for all metrics. This may be useful if the NMI watchdog can't
be disabled.

Thanks for the input!
Ian

> -Andi
