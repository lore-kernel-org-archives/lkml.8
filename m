Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A140C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2067721741
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 13:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599485961;
	bh=F+vehrrDrAfIV9i6ID63zh7sEgGFkW6eFJYW5E8YQHQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tVhhjP2y/wYRbARAknjmlrkjAiTNegkReq9siQxzRp5drLBOa6MYRcew1jm/LI/B9
	 ysmQ5VlETxhCybFAlqBsUyoF7JAyZ5/GjpRN1q8ACXQJB05jpSgS0xodXTvwh8RZkg
	 2oQP5qZdqzbyjwOAx5R+aVvtmEEkKNHNortKwJAg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgIGNiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 09:38:25 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36143 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729401AbgIGNXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:23:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id z1so15843751wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 06:22:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jw3ZabYmqpCSQDTYowWmd33rXHnppYFQbMxFutigDOU=;
        b=kxsPUFaELtJLHPWAoYt1fnYie4NDdmSyfj2XTuHHRtmyelUxLgrfy+MYiiVluR1YnF
         ch8+T1egldCGhUF5iq5hw7LlxVJwXufICiA5JmXfsW7kL+QDwJdy4S3rq1FNuXDOFdsl
         0AZuHXvgTwMsURx8WvZ1enLbMM+F7hgKaJtRUkl9bc/E3qfBOVGLmzjgzfVC0cncj6Io
         VpHkSdXx75Qlh/HTOmroZnT+Ld+q/K4CERVU7tENr7utne38Tcs2LfevyX9fscFe8YV3
         u41utouiZv6IpasPplIRQkg1B6QxghVwbUNpNgA87PnXO8yVTbOPxpRGRtfUUpPl/lYr
         3Akg==
X-Gm-Message-State: AOAM532pvbK8twtCucbiwnXV2bnLFNkbm1a1yWzA9NtflKBNrwzKjLOY
        qkr7sypIj4O6B2DA0zjY++ejhTNjjd0H+Lmyazs=
X-Google-Smtp-Source: ABdhPJy+SlaAJQL068e7tf1CGc3id41YdCtykVF6ENJPsogzaYmryxf4shlGtuSlnL+c2XDjfu8nrWoFf6HdOXbZVKs=
X-Received: by 2002:adf:82d5:: with SMTP id 79mr17700246wrc.60.1599484956845;
 Mon, 07 Sep 2020 06:22:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200907034502.753230-1-namhyung@kernel.org> <20200907034502.753230-2-namhyung@kernel.org>
 <20200907112925.GJ1199773@krava> <20200907113201.GK1199773@krava>
In-Reply-To: <20200907113201.GK1199773@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 7 Sep 2020 22:22:25 +0900
Message-ID: <CAM9d7cisp7QQJF8RT7fPW4rQ4tTrZtK8PM61fKGFKGE-xHqevw@mail.gmail.com>
Subject: Re: [PATCH 1/9] perf evlist: Fix cpu/thread map leak
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <andi@firstfloor.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Mon, Sep 7, 2020 at 8:32 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Sep 07, 2020 at 01:29:29PM +0200, Jiri Olsa wrote:
> > On Mon, Sep 07, 2020 at 12:44:54PM +0900, Namhyung Kim wrote:
> > > Asan reported leak of cpu and thread maps as they have one more
> > > refcount than released.  I found that after setting evlist maps it
> > > should release it's refcount.
> > >
> > > It seems to be broken from the beginning so I chose the original
> > > commit as the culprit.  But not sure how it's applied to stable trees
> > > since there are many changes in the code after that.
> > >
> > > Fixes: 7e2ed097538c5 ("perf evlist: Store pointer to the cpu and thread maps")
> > > Fixes: 4112eb1899c0e ("perf evlist: Default to syswide target when no thread/cpu maps set")
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/evlist.c | 11 ++++++++---
> > >  1 file changed, 8 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> > > index e3fa3bf7498a..c0768c61eb43 100644
> > > --- a/tools/perf/util/evlist.c
> > > +++ b/tools/perf/util/evlist.c
> > > @@ -946,6 +946,10 @@ int perf_evlist__create_maps(struct evlist *evlist, struct target *target)
> > >
> > >     perf_evlist__set_maps(&evlist->core, cpus, threads);
> > >
> > > +   /* as evlist now has references, put count here */
> > > +   perf_cpu_map__put(cpus);
> > > +   perf_thread_map__put(threads);
> >
> > nice catch, I checked perf_evlist__create_syswide_maps is doing this
>
> because you fixed that :))) missed the rest of the patch.. sry

No worries and thanks for the review! :)

Namhyung
