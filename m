Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4E9C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C368E217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MTLQB+BV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636699AbgDPQDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636701AbgDPQDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:03:06 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ED8C061A41
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:03:06 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id n188so2329391ybc.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 09:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8S1/Zns0w2R+tWbAqZwRs1WaDE0dC4Kc/yx5VLZAeGs=;
        b=MTLQB+BVCxzC+oMRlPaO9Ob8QIjC0GTapJqaf3HNMHPLHkwGDnClFH/GSsUrHpeKe2
         e6C8dkjphgKV8Im1RfV3qc28op+ocJJGSDzAZraTBdbWqqDkdOE51SDiZvt7xVnr3Wmy
         9CbU0uTh7PisUHo/cP2HPDvDrKJ21aGOzdk1sW7Yu+1z0aAfV1gETke3KJBtCwPhA2zG
         d/UzRrBU/eUE6E8o407hIgu4Kms1R7Sj8W314EXfaLtPcGnUBY64eakUdAxfqm7nwTTo
         GpvfeHdrnGdpIMmKOv1HzBp1CtwcIXUb/joe8gxkGDS0wzs4C0o6evcdcJBlrY5mvyeI
         5ZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8S1/Zns0w2R+tWbAqZwRs1WaDE0dC4Kc/yx5VLZAeGs=;
        b=i2UHu8HPlC7ZPtka/g79fsmA6m+ed9OKD6sQXPVfsPnOF5OWADFopNMNpX1pgHV+KM
         FAQ5la8ME7ec+MfM/+0K6qZvs955MCo1Pkkcrvsnd9zJSTbg3uIyoGvl9Wij1I+lGFHY
         mtZHt3GHiSlUT/BjAQZrTLfr+knJoP6no9mSEVpq9LFarQwxKG+8oKHon910pRna/Dc8
         Pq1w8gyetagv6cXEKgUThYqNOnLjY/UTfAHGz0jt0qReUcqhqZFUCYNBQ+DYSM+7NVW5
         2/u13sU3I3qDM8BCWYjaMCYVGcCdEwiuigY0MA/7N+n/5QUHbv4kgi6/qTmRpxVa2e/2
         /kbA==
X-Gm-Message-State: AGi0PuZfjNIcaW+L29OL0vR5+JfQAQdeYm4cQCxCIhTj/GNG1JzOU/Iw
        +8qfs0nCBR1M/E4Ot8IpFd+KEcI8Aazvvp2YXuG4JQ==
X-Google-Smtp-Source: APiQypIhOc/b1doEKpGTc2ZxzB7I5cOsPCJcdcWW+Yz3YaPcVeVv30HCHQwVY1yq+kEq5mdjTQ3p0+llYJJaMyXa3Dc=
X-Received: by 2002:a25:77d8:: with SMTP id s207mr17566908ybc.47.1587052985348;
 Thu, 16 Apr 2020 09:03:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200416063551.47637-1-irogers@google.com> <20200416063551.47637-5-irogers@google.com>
 <20200416095501.GC369437@krava>
In-Reply-To: <20200416095501.GC369437@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 16 Apr 2020 09:02:54 -0700
Message-ID: <CAP-5=fVOb1nV2gdGGWLQvTApoMR=qzaSQHSwxsAKAXQ=wqQV+g@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] perf tools: add support for libpfm4
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Igor Lubashev <ilubashe@akamai.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jiwei Sun <jiwei.sun@windriver.com>,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 2:55 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Apr 15, 2020 at 11:35:51PM -0700, Ian Rogers wrote:
> > From: Stephane Eranian <eranian@google.com>
> >
> > This patch links perf with the libpfm4 library if it is available
> > and NO_LIBPFM4 isn't passed to the build. The libpfm4 library
> > contains hardware event tables for all processors supported by
> > perf_events. It is a helper library that helps convert from a
> > symbolic event name to the event encoding required by the
> > underlying kernel interface. This library is open-source and
> > available from: http://perfmon2.sf.net.
> >
> > With this patch, it is possible to specify full hardware events
> > by name. Hardware filters are also supported. Events must be
> > specified via the --pfm-events and not -e option. Both options
> > are active at the same time and it is possible to mix and match:
> >
> > $ perf stat --pfm-events inst_retired:any_p:c=1:i -e cycles ....
> >
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> > Reviewed-by: Ian Rogers <irogers@google.com>
>
>         # perf list
>         ...
>         perf_raw pfm-events
>           r0000
>             [perf_events raw event syntax: r[0-9a-fA-F]+]
>
>         skl pfm-events
>           UNHALTED_CORE_CYCLES
>             [Count core clock cycles whenever the clock signal on the specific core is running (not halted)]
>           UNHALTED_REFERENCE_CYCLES
>
> please add ':' behind the '* pfm-events' label

Thanks! Not sure I follow here. skl here is the pmu. pfm-events is
here just to make it clearer these are --pfm-events. The event is
selected with '--pfm-events UNHALTED_CORE_CYCLES'. Will putting
skl:pfm-events here make it look like that is part of the event
encoding?

Thanks,
Ian

> jirka
>
