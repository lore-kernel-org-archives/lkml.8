Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C755C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 03:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE12E206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 03:41:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5FGegCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgENDld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 23:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgENDld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 23:41:33 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D103CC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 20:41:32 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id s37so806073ybe.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 20:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wgGBPApfMen/3AKC9GulhxtmJ5nu3WUilZQROpGUHVI=;
        b=g5FGegCBPa+B9wy5kadW3vK8vhhdO+DosxKNSA+6+nu1h1bIBvrS3FWYUQW+9cokgw
         D05Xy5v7qn7fW4oyK9FQbNIdC7X8hc6fiEyaFt62jUv+ZtHILVK4RFM7S5TMNSGpyO0H
         NBIDpGnC5PB+nC5lFIk40gRAv/Jv14lyhob3kwuk17ebvUnKG5wGus9SES/6dQ24IOcY
         +KXHbardCdeu4pQ5KZwlm8tCT9UIkFEt0cOGR+EYX6RLipoUU7GInaydrxdKQ3I8qEVB
         sLQPwaVzOLZ1uvp/svlFMp10SZDr4hE+C2K/sp4kXcrgtsiqCfPe8uW00s1izENr/ehW
         0fDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wgGBPApfMen/3AKC9GulhxtmJ5nu3WUilZQROpGUHVI=;
        b=dAQH7NhynVCMgMBnA4KyXZubCXwHBZFLCTIfRHOZ2paxzLowj6Y0B5VK7H7J7Jy+Z3
         6v6n+ktO4Mi88VRM45a0D3Y8UCI5d7Wy0hSv3OOe8PgYIZ9LPrN/Oh9dwRvVTTW/bmjC
         Ak9MkkjzmCuvLAz35Tt/DbZK9X4XYtsD6nrFYmUOFMoINy1IaWU0S4GAj9dCU5hjiMQn
         vNV0501xGokjXojbc1QqtvSY03YqK8rC/3vjiUwWrUzgKm7+l+fX3O9ffRg5TuUgxv21
         3lWGvLPkhJ9Eftnxq8w5cF4aiTnm6LNrcr4nFUtzJLd0BclIUWzYztZWAaKFYWOe97z8
         ar0Q==
X-Gm-Message-State: AOAM533AXQvZuAjbeiiP+B26HarHmb9rnaZOQ7zcJXuji2IRHz4w4t7A
        3KuWaF73P4IGEWFF3GX6kgjY25t0NIl8kolj/kadMA==
X-Google-Smtp-Source: ABdhPJwHuCOizgYSE1KlOAH0U5KF6lEYkx65E9cxAH1IdSmN9uOBaS/bSYaMzKdgwzhTNENmJu9ByFHLl/kVK1MlLSU=
X-Received: by 2002:a25:3182:: with SMTP id x124mr2502468ybx.324.1589427691446;
 Wed, 13 May 2020 20:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200511205307.3107775-1-jolsa@kernel.org> <20200511205307.3107775-4-jolsa@kernel.org>
 <CAP-5=fU5bbWWyWXDMoMvsMY4BbUsRUqgrOtGUrdiYjSsJZ+t-A@mail.gmail.com> <20200513113345.GI3158213@krava>
In-Reply-To: <20200513113345.GI3158213@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 13 May 2020 20:41:20 -0700
Message-ID: <CAP-5=fW6nA0jL5H+=LrdbEx5c0C_9WrgcZgC0GLaNU4mFP5cyg@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf stat: Add --metrics-file option
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 4:33 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, May 13, 2020 at 12:04:55AM -0700, Ian Rogers wrote:
>
> SNIP
>
> > > +METRICS FILE
> > > +------------
> > > +The file with metrics has following syntax:
> > > +
> > > +  NAME = EXPRESSION ;
> > > +  NAME = EXPRESSION ;
> > > +  ...
> > > +
> > > +where NAME is unique identifier of the metric, which is later used in
> > > +perf stat as -M option argument (see below).
> > > +
> > > +The EXPRESSION is the metric's formula with following grammar:
> > > +
> > > +  EXPR: EVENT
> > > +  EXPR: EXPR if EXPR else EXPR
> >
> > Not introduced by this patch, but this patch is exposing it as an API.
>
> yea, I was thinking about this and I think we will put a disclaimer in
> here that this is not an API and the interface can change.. it's really
> mostly intended to help out with running a custom metric which is not
> compiled in ... I don't want to be commited to support old API
>
> > This notion of if-else is really weird. For one thing there are no
> > comparison operators. The unit test doesn't really help:
> >         ret |= test(&ctx, "1+1 if 3*4 else 0", 2);
> > What kind of comparison is "3*4"? If 0.0 causes the else clause then will -0.0?
> > A typical expression I see written in C is to give a ratio such:
> >   value = denom == 0 ? 0 : nom / denom;
> > I've worked around encoding this by extending expr.y locally.
>
> AFAICS it's used only with #SMT_on in the condition, aybe we could limit
> the condition only for #SMT_on term?
>
>
> >
> > > +  EXPR: NUMBER
> > > +  EXPR: EXPR | EXPR
> > > +  EXPR: EXPR & EXPR
> > > +  EXPR: EXPR ^ EXPR
> >
> > Again, it's odd that these cast the double to a long and then assign
> > the result back to a double.
>
> is this even used anywhere? perhaps it was added just to be complete

I don't believe they are used and checked with the pmu parsing test
that removing them doesn't cause any x86 expressions to break. I'd
prefer it if we could remove the unused operators and avoid
advertising here.

Thanks,
Ian

> SNIP
>
> > > +       2.002460174                 0.86                23.37                 0.86
> > > +       3.003969795                 1.03                23.93                 1.03
> > > +  ...
> >
> > A feature request would be to allow metrics in terms of other metrics,
> > not just events :-) For example, it is common to sum all cache
> > hit/miss events. It is laborious to copy that expression for hit rate,
> > miss rate, etc.
> >
> > Perhaps the expression parsing code should be folded into the event
> > parsing code.
>
> nice idea, but let's finish straighten up what we have first ;-)
>
> I'll try to go through all the fixes/tests you posted and let's
> get it in first
>
> thanks,
> jirka
>
