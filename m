Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF633C5518C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC52C2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jf0hGa5H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgDVPfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgDVPfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:35:37 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0079CC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:35:37 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id o198so1379631ybg.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gw49UCUA+MxUdui86xvGBcU7HcJbNmoaqXmsGDzgO8U=;
        b=jf0hGa5H/bCibFz7jYTFGwo1UW4+5XJtNa1wdeSptZvVKa3rpjfcwesdeEXSijnoeW
         Y0ZuKuklLiXCP7t8mjS+vvQreJDNkLe5EB3OVNNZTnq5oZtdVdYGj3cv3W1luqsiZ+tt
         X+JhQPUX16VhskBE9SZ+XWNTlIs5bWPR7q+jHXU/RSCLxslrdTOctHfWwMB7UkNNxutx
         jxa8XRZslxxT/CETSL5jwohYmqo6PlUm6zXWlu0kq16u2aRqrbcpftutjg9FJh93xCgu
         oj838X9BYGBTJ2qyTLyz5tx6d4TpEVfNx1gTPZd3UqLHvgq7Nkyfmoj+rk8V+Bo2Ko0e
         oyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gw49UCUA+MxUdui86xvGBcU7HcJbNmoaqXmsGDzgO8U=;
        b=NPGwHYsqdPHKo9M75IHCirj3ZVciyfh/j9zqPaJwwZTsmiUFUR5+Ve/cy5JuPtvyYL
         VAL2h57bBZyPDYTgyAu55JVsA8sXJ2AGytNyhtwd0INyGipHwbwf67oVlD/fcBbc/rsg
         oA+sjJdniX4ai7tDq6WGhTGMLl3Iwzj+i8FpGft3AcoRMeRD4KJYY5GGHywiZ2dSikAO
         7E3yvT5WY9uGOKjLFT4LLhodXqmsvltauCO5OjcF8sfWQgkfUbpRJ8nbm+YFQAaHluGi
         rNekRuZtcWSAH9qEkPDkbU6FO/bf81TDPQEpbQqqacBNH+DxP+kY9s9HAc475cPy4nP1
         u/eg==
X-Gm-Message-State: AGi0PuZ4cwTNj5w5abddlza5LKtRvg6aIvMHWO5xo1q501bFnGGClxOe
        gu43YZjJCD6dGDSniUX613SAeC/UqeDynyo1Ci4V2w==
X-Google-Smtp-Source: APiQypKqgluEm/jU7Nq3EBw7D/D6t10+ZX9Wk59axe2rwGWMYazAHuHeHL8UICRKyhEi09ITNucozNU5SElLqkcfkkA=
X-Received: by 2002:a25:77d8:: with SMTP id s207mr36205777ybc.47.1587569736033;
 Wed, 22 Apr 2020 08:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200421004329.43109-1-irogers@google.com> <20200422082016.GE962614@krava>
 <20200422135949.GD20647@kernel.org>
In-Reply-To: <20200422135949.GD20647@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 22 Apr 2020 08:35:24 -0700
Message-ID: <CAP-5=fVBZTxTzjb8bW-x5rEPaOM7srxsNOdDaEB3nbERxMud0A@mail.gmail.com>
Subject: Re: [PATCH] perf script: avoid null dereference on symbol
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 6:59 AM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Apr 22, 2020 at 10:20:16AM +0200, Jiri Olsa escreveu:
> > On Mon, Apr 20, 2020 at 05:43:29PM -0700, Ian Rogers wrote:
> > > al->sym may be null given current if conditions and may cause a segv.
> > >
> > > Fixes: cd2bedb7863e9 (perf script: Allow --symbol to accept hexadecimal addresses)
> >
> > seems it's wrong commit number, I see it under d2bedb7863e9
>
> Thanks, added your Acked-by, I noticed the wrong commit number, fixed it
> up to the same you point above.

Thanks for fixing the commit number, I'll try to figure out why I'm
calculating these incorrectly.

Ian

> - Arnaldo
>
> >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/util/event.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> > > index dc0e11214ae1..f581550a3015 100644
> > > --- a/tools/perf/util/event.c
> > > +++ b/tools/perf/util/event.c
> > > @@ -626,7 +626,7 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
> > >                     ret = strlist__has_entry(symbol_conf.sym_list,
> > >                                             al->sym->name);
> > >             }
> > > -           if (!(ret && al->sym)) {
> > > +           if (!ret && al->sym) {
> >
> > Acked-by: Jiri Olsa <jolsa@redhat.com>
> >
> > thanks,
> > jirka
> >
> > >                     snprintf(al_addr_str, sz, "0x%"PRIx64,
> > >                             al->map->unmap_ip(al->map, al->sym->start));
> > >                     ret = strlist__has_entry(symbol_conf.sym_list,
> > > --
> > > 2.26.1.301.g55bc3eb7cb9-goog
> > >
> >
>
> --
>
> - Arnaldo
