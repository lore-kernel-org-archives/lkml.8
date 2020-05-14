Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5479C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 23:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9577720727
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 23:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="orITDQkI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbgENXDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 19:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728915AbgENXDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 19:03:01 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08419C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 16:03:01 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id i16so130065ybq.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 16:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O3giVcb0q9LiDqtRCOl7tUI8tTD6PNV0NlsSPJaM/o8=;
        b=orITDQkIHJz7agF18bRRT4E3e/2q11s5ptgnEhfqFThw8QO0lSas8iZeBxNR6DcNLY
         4KJtOTSPbFuuJoCyGY+C4j/w9qS4T10e7WM4ZwVVYGNxtQQlUDkumxEOTkmmJPtUlcTO
         BvbqjsqqujRjn55ldkRKlfKhZMVdco/U3CUOl8iJdh70apev73J6jnMYP0hmN2xZsD+3
         99anueQoVXUZ5WfpLhsYic3hPlPdk33V3rH1/mQg/NCPE4C5zULkeLJO43mDW2r6SsjC
         XKnClmdxt5mTh8SsvsmbifFnJhYzUZg8xgYIWMOVFVF3EVTnYUFk5DoCAaGvXtJ4YUpW
         2A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O3giVcb0q9LiDqtRCOl7tUI8tTD6PNV0NlsSPJaM/o8=;
        b=aBRDM6CfRXApuj6c7wDAT0+gv7HooSBeEWi/iHmHVsWxHeyDhOOrPlVy/JVVPnXn2N
         f1krABW7Enamuh8w2z33HbWBZNQAall2/Hx+0JO/1qfdlDxO98VelrpaOpA7d1cKUHEC
         BPJLbffxYZcNSchKjdHAT6Zur3Dg+6Ikg1Dm9w8IwkLPCM0Aw4pxOdgKeSh+F49DJcbK
         2g63veaRCgv9kL9wbpvE+cWZpibLswHqS3Q7FFWtR6yPDGiitjsqscsEXEx2MzNuKQjs
         uO84juREMzdHfd5wY6zOJ3zEplNESeyTi1gu7OJ77UdtpLjX3W2gIolhE+gkT6KqlBHQ
         FdeQ==
X-Gm-Message-State: AOAM530DHAaGxe5LHQu6+etwKQw4l3GOK9h/a71psuuQJGTanh3tIZyj
        pyJzOJJZSFJ5qvYggWs76dmpWVuMomU/jVDy93oDpw==
X-Google-Smtp-Source: ABdhPJz8rCWbTAdxMRGS+MTPdcYDEFMFFSGPx580u6+EgNONRsA8f4cpvMWI3FAq5LGVXHQKphchtKJfYRAxmU9bfO8=
X-Received: by 2002:a25:3182:: with SMTP id x124mr1053657ybx.324.1589497380051;
 Thu, 14 May 2020 16:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200513062236.854-1-irogers@google.com> <20200513062236.854-2-irogers@google.com>
 <ac88604a-56c2-b632-57c2-3bee316dcea7@huawei.com> <CAP-5=fVkD+0wCMcBBHWM8djsnn2KsshOyK_XcjNDTsiVo04vwQ@mail.gmail.com>
 <5264e16c-fb1a-4bbc-96b5-1d867e38902e@huawei.com>
In-Reply-To: <5264e16c-fb1a-4bbc-96b5-1d867e38902e@huawei.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 14 May 2020 16:02:49 -0700
Message-ID: <CAP-5=fWt58UVTTj_qvirMhMOaUbur+HzxrTi5u1qvCA1ft9BEw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Improve pmu event metric testing
To:     John Garry <john.garry@huawei.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 2:00 AM John Garry <john.garry@huawei.com> wrote:
>
> On 13/05/2020 17:10, Ian Rogers wrote:
> >> Out of interest, if we could move the validation of metrics to jevents,
> >> how much functionality would we still have here?
> > If we add checking to jevents then the MetricExpr would be known to be
> > valid, however, the events (aka ids) within the expression could be
> > invalid.
>
> So I think that has some value. I mean, just to detect syntax errors,
> like those remedied in "perf metrics: fix parse errors in power8 metrics".
>
> > I'm not sure we could realistically check the events at
> > jevents (build) time as there is no guarantee that the machine we run
> > on is the same as the one we compile on.
>
> But we could at least check that there are event aliases for that CPU,
> right? (by examining the JSONs for that cpu). If the event alias does
> not actually match on the target CPU, then that can't be helped.

Agreed, I think there will be some cases where something more can be
done. Jiri has proposed fake pmus as well:
https://www.spinics.net/lists/linux-perf-users/msg11760.html
I don't know how much sense it makes trying to get this in jevents, as
long as 'perf test' is run.

Thanks,
Ian

> Cheers,
> John
>
