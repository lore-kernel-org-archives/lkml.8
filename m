Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71A7C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4CB0222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 19:32:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kWwtVbX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbgBNTcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 14:32:25 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35044 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729075AbgBNTcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 14:32:24 -0500
Received: by mail-yb1-f193.google.com with SMTP id p123so5314969ybp.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 11:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ceZdUC7bCwrEmtz1S3C9+688fy8+lwKr9au/LM7bdbk=;
        b=kWwtVbX3cDe/sVX6RJhzOgLIC5O/ZigNed1/HiPAq0YeXGo8rFglKn098d1rnog8od
         +RIj0EsXS5xVRUI7K3w0IyIYxrUbTftZEbFwRRj2sMkwrWNdQ/f2MgmAGGqKE5wvK6qa
         4VYZwMTsxQtLNcyu2CUar5H13nQp5502ai/8krLyTh2gvEgVH4pv1f6w7utUT2bNDzQ+
         vSiMgpg/FRA4bHDlQKyN5XNL99m8GCoc1Bl28P/TgKOZQEvGWW6xw7HCX7gFIiQZl4aF
         4mFMf3FRHBvJGmzFlJt7wlEJEY54gAiPXuyDe2VKIHo70jZCQuYZ8R+z0VcuFG/N3Hix
         TGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ceZdUC7bCwrEmtz1S3C9+688fy8+lwKr9au/LM7bdbk=;
        b=Pp3d9iMCV7ekopFeJwXD5mxkmcVuRLFGiswkiPE29gbBlghmIuQwSMj9LOY40Jii1T
         PueRzjzGazTyup9PKUokbI5bAeBRX3KCU4TloSNjfWv9PDxDRmO07YpAhjVCfXoVSXYQ
         tb1gEqGE8T2n2Btl+Br8+6lLJnhJIJw0xlrhCMFpQsxSn3ikJZA3sibnMla43JSz8aPF
         MK07mLeZVEDmJ0HmBDzNi5tBLp5QnBB/PJdmOU85mvIUmzMvfpbln1ceUAaG7plCh2j/
         M1AA88P1sufzaaxvqxrrL/qBgG53Nnp+TvTn9qHxE1K+dm6kdnsRYjXoF+iikeT4tMRE
         q3AA==
X-Gm-Message-State: APjAAAUfmStF0X097QhsxQ35rxv6NfY1QDf3vSubAh52mH4AYP0zOmay
        phFSf1BkB4nE9cT9dJY178s21ldmPXusBilvkIkaCy/7YIoECA==
X-Google-Smtp-Source: APXvYqzCdu2C6++diEU4bQbUPO2BP44Ccs6eGqp935T89ugWbb3sIRvDUvf864NCdR0s1N9Ei8NXJvxKAA0C9r+ytvc=
X-Received: by 2002:a25:48c6:: with SMTP id v189mr4442380yba.41.1581708742788;
 Fri, 14 Feb 2020 11:32:22 -0800 (PST)
MIME-Version: 1.0
References: <20191206231539.227585-1-irogers@google.com> <20200214075133.181299-1-irogers@google.com>
In-Reply-To: <20200214075133.181299-1-irogers@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 14 Feb 2020 11:32:11 -0800
Message-ID: <CAP-5=fWzXKNO=OFdDqAqNiZ2+kmgOTQkt78Hhe6Y9s83YYVKYw@mail.gmail.com>
Subject: Re: [PATCH v6 0/6] Optimize cgroup context switch
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Marco Elver <elver@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On a thread related to these patches Peter had previously asked for
what the performance numbers looked like. I've tested on Westmere and
Cascade Lake platforms. The benchmark is a set of processes in
different cgroups reading/writing to a file descriptor, where the read
context switches. To ensure the context switch all the processes are
pinned to a particular CPU, the benchmark is tested to ensure the
expected context-switches matches those performed. The benchmark
increases the number of perf events and cgroups, it also looks at the
effect of just monitoring 1 cgroup in an increasing set of cgroups.

Before the patches on Westmere if we do system wide profiling of 10
events and then increase the cgroups to 208 and monitor just one, the
context switch times go from 4.6us to 15.3us. If we monitor each
cgroup then the context switch times are 172.5us. With the patches,
the time for monitoring 1 cgroup goes from 4.6us to 14.9us, but when
monitoring all cgroups the context switch times are 14.1us. The small
speed up when monitoring 1 cgroup out of  a set is that in most
context switches the O(n) search for an event in a cgroup is now
O(log(n)). When all cgroups are monitored the number of events in the
kernel is the product of the number of events and cgroups, giving a
larger value for 'n' and a more dramatic speed up - 172.5us becomes
14.9us.

In summary what we see for performance is that before the patches we
see context switch times being affected by the number of cgroups
monitored, after the patches there is still a context switch cost in
monitoring events, but it is similar whether 1 or all cgroups are
being monitored. This fits with the intuition of what the patches are
trying to do by avoiding searches of events that are for cgroups the
current task isn't within.The results are consistent but less dramatic
for smaller numbers of events and cgroups. We've not identified a slow
down from the patches, but there is a degree of noise in the timing
data. Broadly, with turbo disabled on the test machines the patches
make context switch performance the same or faster. For a more
representative number of events and cgroups, say 6 and 32, we see
context switch time improve from 29.4us to 13.2us when all cgroups are
monitored.

Thanks,
Ian


On Thu, Feb 13, 2020 at 11:51 PM Ian Rogers <irogers@google.com> wrote:
>
> Avoid iterating over all per-CPU events during cgroup changing context
> switches by organizing events by cgroup.
>
> To make an efficient set of iterators, introduce a min max heap
> utility with test.
>
> The v6 patch reduces the patch set by 4 patches, it updates the cgroup
> id and fixes part of the min_heap rename from v5.
>
> The v5 patch set renames min_max_heap to min_heap as suggested by
> Peter Zijlstra, it also addresses comments around preferring
> __always_inline over inline.
>
> The v4 patch set addresses review comments on the v3 patch set by
> Peter Zijlstra.
>
> These patches include a caching algorithm to improve the search for
> the first event in a group by Kan Liang <kan.liang@linux.intel.com> as
> well as rebasing hit "optimize event_filter_match during sched_in"
> from https://lkml.org/lkml/2019/8/7/771.
>
> The v2 patch set was modified by Peter Zijlstra in his perf/cgroup
> branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
>
> These patches follow Peter's reorganization and his fixes to the
> perf_cpu_context min_heap storage code.
>
> Ian Rogers (5):
>   lib: introduce generic min-heap
>   perf: Use min_heap in visit_groups_merge
>   perf: Add per perf_cpu_context min_heap storage
>   perf/cgroup: Grow per perf_cpu_context heap storage
>   perf/cgroup: Order events in RB tree by cgroup id
>
> Peter Zijlstra (1):
>   perf/cgroup: Reorder perf_cgroup_connect()
>
>  include/linux/min_heap.h   | 135 ++++++++++++++++++++
>  include/linux/perf_event.h |   7 ++
>  kernel/events/core.c       | 251 +++++++++++++++++++++++++++++++------
>  lib/Kconfig.debug          |  10 ++
>  lib/Makefile               |   1 +
>  lib/test_min_heap.c        | 194 ++++++++++++++++++++++++++++
>  6 files changed, 563 insertions(+), 35 deletions(-)
>  create mode 100644 include/linux/min_heap.h
>  create mode 100644 lib/test_min_heap.c
>
> --
> 2.25.0.265.gbab2e86ba0-goog
>
