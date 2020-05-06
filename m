Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC2CC38A2A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9FA12076D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 22:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aGCSAnRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbgEFWwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 18:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730252AbgEFWwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 18:52:31 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9420C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 15:52:31 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id o8so742616ybc.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 15:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=41sdg7Fqp0L398L6Jcqw7Uls0o1vtYT6lkwEqB/show=;
        b=aGCSAnRS4ufZWa/Hdtn/oXVbdCAKXqMfRSovLmO4cTwAs5WGQ8G4K1Z5+bRDZrBStt
         Z4qsWWWYcy9ro3d38qVZSmsAdSRqyVR699x1XRwL3ODJR/aJifJuKYrQ/BWpFP9oDa2m
         icPtnh5okmjsKkslbzj30uAQV0GxFbJpTUERIcO86EBZeuFWPuJM5GHf7KMMeu9wptqe
         1883/TqkOspDZKDqYSLKMcQxTEUKgi4uMcrSIs6k9LPI1RFpWA3tXnxZMQYK/EtqumFF
         cBZBMNYSzl87gJRJN6fwCZDJOLbqx/QTWXm58pIaID7MZ7d+xm9kQWUhBeh6B702rux5
         2DRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=41sdg7Fqp0L398L6Jcqw7Uls0o1vtYT6lkwEqB/show=;
        b=aFM3JJbMdA/l9gNtJmmNzgGWRX3pmEGHCHrK9G/GVIXx2eIHKuaZ5Bqwy0ST87XHZd
         BfRiZdvyPymtmbg4fTkXzWW3rba+Mx51DQkj/NbedgiMufixWKyz8ZPWi/oHMfKtkY/c
         BvhohI93/aeGEpQYiE6dpUriYz265D+HkgId+zL28g0Ui3PqrxPkdGhhtRuTU3LGt6Em
         votvwj16VoeG3/oAHHAgsKMoPxyKKy/bDMwgkquZpp63iL/Ov64NenEfggrGJFM2tZMi
         DS5gz6f+ID3vnR+KZXh9IVayZ0Il/1O6nSaw/RifgP1NqTPxQLWBs4TBVKYJZQVDfPHc
         NgGQ==
X-Gm-Message-State: AGi0PubIUHoWjAnELPpIY0UuEGtxLeYOayu2WFlgNA+Zch+MAbnfJbPu
        82/NusxrKoOh+twiq9Sz+UsoDWS54PZWK8QiBoWEQQ==
X-Google-Smtp-Source: APiQypInNJQQLjZ8f+y1CbKBWXGiHGzJMFKsWtO22R4vKOoix4Z833p1QHbzPpyzlMm8cgkbKDtwY4H5oHleTblRWkY=
X-Received: by 2002:a25:4443:: with SMTP id r64mr16715090yba.41.1588805550497;
 Wed, 06 May 2020 15:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200422220430.254014-1-irogers@google.com> <20200422220430.254014-6-irogers@google.com>
 <20200423112915.GH1136647@krava> <CAP-5=fU7=FvpRr+PMsc_xebiETBgbNcv7U2jX3pJT87X7LAdtQ@mail.gmail.com>
In-Reply-To: <CAP-5=fU7=FvpRr+PMsc_xebiETBgbNcv7U2jX3pJT87X7LAdtQ@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 6 May 2020 15:52:19 -0700
Message-ID: <CAP-5=fXkQnXZKXKyJfpP6PM409J=DxhU4SvxiA5VcP6e7REdOg@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] perf expr: increase max other
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haiyan Song <haiyanx.song@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 7:23 AM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Apr 23, 2020 at 4:29 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Wed, Apr 22, 2020 at 03:04:24PM -0700, Ian Rogers wrote:
> > > Large metrics such as Branch_Misprediction_Cost_SMT on x86 broadwell
> > > need more space.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/expr.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> > > index 0938ad166ece..4938bfc608b7 100644
> > > --- a/tools/perf/util/expr.h
> > > +++ b/tools/perf/util/expr.h
> > > @@ -2,7 +2,7 @@
> > >  #ifndef PARSE_CTX_H
> > >  #define PARSE_CTX_H 1
> > >
> > > -#define EXPR_MAX_OTHER 20
> > > +#define EXPR_MAX_OTHER 64
> > >  #define MAX_PARSE_ID EXPR_MAX_OTHER
> > >
> > >  struct expr_parse_id {
> > > --
> > > 2.26.2.303.gf8c07b1a785-goog
> > >
> >
> > ok, and we should probably start to think about what Andi suggested
> > in here: https://lore.kernel.org/lkml/20200224210308.GQ160988@tassilo.jf.intel.com/
>
> Agreed, a hash table would make sense. This was the smallest value
> that would let the test on x86 pass.

Fwiw, I have done this based on tools/lib/bpf/hashmap.h in CLs
following on from this patch set. I'm holding off sending so I can
rebase on acme's perf/next when the CLs acked by Jirka land:
https://lore.kernel.org/lkml/20200503221650.GA1916255@krava/
The libbpf dependency for a hashmap is counter intuitive, so maybe
there's something better to do there.

Thanks,
Ian

> Thanks,
> Ian
>
> > jirka
> >
