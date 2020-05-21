Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C026C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E77D920671
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQCnSMEQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbgEUQLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 12:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbgEUQLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:11:07 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463F6C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:11:07 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id r128so3084711ybc.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+gc76dvAmcnKyafrzIlIXk+cdWsPwaRbHG7m3tGh9Qc=;
        b=mQCnSMEQGZ6tabeU1j68y7o6DGhmRJOY0Kn6mMfHvBIUAWq2O/ODgrivjbSM0aX8db
         daxjooLBGVHOTfaY+n4/A/E6kHQJ0IjceexQRI0mH/rzdstUMjHvV2v/MXoOeAKEDs7T
         LeLmAYybUL6z77zumQPOWHGFq1XQI4Fu5zDfM2OC3mCZ1QKwpw50b00ZP4gL+e3nDj1W
         dDVH+lgDApbAY1eEVNqw+B7RXkv89SBH34rPo4oYv+CEzKw3Z6et9yuy2VKyP1AFAx0F
         FCy6TqqqM3phM9gDvlPQlnbAk46Snr1wMkAqwaImFhoDHzXU8oSLQBBwzN80CrwFYFzL
         xJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+gc76dvAmcnKyafrzIlIXk+cdWsPwaRbHG7m3tGh9Qc=;
        b=sTmQYIX3pFKopsVQYb3p8BnnJy4oh8SD7qbg5k2hZvVsly/XWzgmPcy6P0Ko1hepM6
         7Akunvo4YrLOdstfQzC4MRZsB+MKX5DADkYcP/zJEaw4ZIMZbUBZCGdg10N+SsdEe9Gz
         0vYRlrYfKewb1qpnktIS7TaajYPwXLChiCWbgB/GjMPQMO/8aEcAKfpk/FvMP203sZMH
         taV4t5lJOSuyRz6uKpn/4fedUJ0zBGhTdooH4bW/rgc9xi+Q4EPdfQCLnJADz8HHOFu8
         NEIL6zGYeeaJbP6ZCn8sbLXdD0HI6c0HKQfAN+G1FkMUbiIPqKbyTvCOR1uW1ucggf7J
         IXYg==
X-Gm-Message-State: AOAM532mQPqPhBufBOp5tJH1cpK/M3GCrAkLswo2LAqc5Uc7jza3c1la
        5LTOhiFC67JGtIjP02ObjbK4n1dVROI7yLPPZU0V/g==
X-Google-Smtp-Source: ABdhPJz7NOo5MfhpZzS4whBV+pg+WOr/GFx5Rc+Hob9mF79VGeHZavlboXvTIHHwqbLizUM0gSkymOrENrGwwdBDeV0=
X-Received: by 2002:a25:d450:: with SMTP id m77mr16088061ybf.177.1590077466196;
 Thu, 21 May 2020 09:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200521133218.30150-1-liwei391@huawei.com> <20200521133218.30150-2-liwei391@huawei.com>
 <20200521155400.GA14034@kernel.org>
In-Reply-To: <20200521155400.GA14034@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 21 May 2020 09:10:55 -0700
Message-ID: <CAP-5=fWe-74NG1YBS2g2okgNMvScPD6qFh-n8jr_YbzdTug44Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] perf metrictroup: Fix memory leak of metric_events
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Wei Li <liwei391@huawei.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Li Bin <huawei.libin@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Hongbo Yao <yaohongbo@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 8:54 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, May 21, 2020 at 09:32:15PM +0800, Wei Li escreveu:
> > From: Hongbo Yao <yaohongbo@huawei.com>
> >
> > Fix memory leak of metric_events in function metricgroup__setup_events()
>
> The leak is there but this code has changed a lot recently, please take
> a look at my perf/core branch and keep Ian Rogers in the loop,
>
> - Arnaldo

Thanks, I'd posted the same change here:
https://lore.kernel.org/lkml/20200508053629.210324-10-irogers@google.com/
but it looks like it was mislaid. Arnaldo, I can re-post that patch or
Acked-by this patch. I'm easy either way.

Thanks,
Ian

> > Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
> > ---
> >  tools/perf/util/metricgroup.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> > index 926449a7cdbf..69bf0f4d646e 100644
> > --- a/tools/perf/util/metricgroup.c
> > +++ b/tools/perf/util/metricgroup.c
> > @@ -184,6 +184,7 @@ static int metricgroup__setup_events(struct list_head *groups,
> >               if (!evsel) {
> >                       pr_debug("Cannot resolve %s: %s\n",
> >                                       eg->metric_name, eg->metric_expr);
> > +                     free(metric_events);
> >                       continue;
> >               }
> >               for (i = 0; i < eg->idnum; i++)
> > @@ -191,11 +192,13 @@ static int metricgroup__setup_events(struct list_head *groups,
> >               me = metricgroup__lookup(metric_events_list, evsel, true);
> >               if (!me) {
> >                       ret = -ENOMEM;
> > +                     free(metric_events);
> >                       break;
> >               }
> >               expr = malloc(sizeof(struct metric_expr));
> >               if (!expr) {
> >                       ret = -ENOMEM;
> > +                     free(metric_events);
> >                       break;
> >               }
> >               expr->metric_expr = eg->metric_expr;
> > --
> > 2.17.1
> >
>
> --
>
> - Arnaldo
