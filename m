Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7F0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06445206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJO7VrBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgFAQNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAQND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:13:03 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393ECC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 09:13:03 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id r18so2942808ybl.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 09:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NjSVQRGYCwzYwvExi7f09WRPtiPSz55cN9wX5qFOjkI=;
        b=GJO7VrBzG8A442/c8ZdnXbXkZ6WqgXMzWt6bz9tK21tfKwo7otNS/MWd5cU+Sbw5SM
         aBJ1JR+Bll1FVrAfEOm3pkPOkPbnhFuS2BG8dnxsGWWJIBS6eEMtrnLalw9ofm/oEeVZ
         ri3tHQUayKFezyeNgruPm7ujL0zj4llFWtETDS7T1dXAxK/ttvfRYCiYBavhwv0lTGeE
         c9DKOBHxaihxhS+laWkH9JlOti2eLyoDBsjTkv7OgdBu1F+C9+Hvc8011un3fuTYoedV
         pJmQO03i8QN4xR2lPXVHaZLxO1+b16upP5Uycas7X8lQgWHoXjZBqt9WIG9mIsPERicR
         /jvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NjSVQRGYCwzYwvExi7f09WRPtiPSz55cN9wX5qFOjkI=;
        b=jX/BAKU/pET1YX+1QhIf8amHbjXnNsR5X+xV26v/LdNKSJxE9NHDYC5R+i/+UKn8ZE
         s6UqdootxhP4orVvQcp+iVu7Kf7KS4xhAuoRZ4QIo3BjZ0gngETXPAy0ik4c+nnPwutn
         KTDpu7/jGRVnCQmc0jbVY+acTEvD/N7k7mQnl6MRzIJazjUKj2MrEIPNiiDFyByNhBOB
         oMWWiPo/YhkVFJGsGREDY7g3cgnlU+j/WRc9o/ZhRHND87pzu8LfNovdLzdt6uajK88p
         EddX9ziQaFhXfZxeubgEkTFNr51DdDGnfTqDfe9ssRiKfmNoxAnf8tBndhxd6jTAJMuL
         vF6A==
X-Gm-Message-State: AOAM530SoYZsBHZIRgc3A5PWqxr9/UagkIwezrmHuOY+ZPgSKZSV7aHt
        Iqjb/Oy4R32mz30ohDc81gU/Pk7uSOtRul/LdZUuoi4D
X-Google-Smtp-Source: ABdhPJys4vgV2gdq6VDG4647ibXdEGVXHZ2J9lxoBVIGRSrk/Hg7Oc+J6qJCHNH0JC3ZZPYI181yYgDJgO+AMdD2s20=
X-Received: by 2002:a25:790e:: with SMTP id u14mr33884194ybc.324.1591027982206;
 Mon, 01 Jun 2020 09:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200524224219.234847-1-jolsa@kernel.org> <20200524224219.234847-14-jolsa@kernel.org>
 <CAP-5=fVmCZZhHfHU8EFcKDvs8555cuTfyH3VpW_k-oX42S1svg@mail.gmail.com> <20200601130905.GA1031432@krava>
In-Reply-To: <20200601130905.GA1031432@krava>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 1 Jun 2020 09:12:51 -0700
Message-ID: <CAP-5=fVRNskkDyw3fr-DTUfFeLv0b+O6uEONQY=xB65X2iRc7g@mail.gmail.com>
Subject: Re: [PATCH 13/14] perf tests: Add parse metric test for ipc metric
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 6:09 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Jun 01, 2020 at 12:55:44AM -0700, Ian Rogers wrote:
> > On Sun, May 24, 2020 at 3:43 PM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Adding new test that process metrics code and checks
> > > the expected results. Starting with easy ipc metric.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> >
> > Acked-by: Ian Rogers <irogers@google.com>
> >
> > I wonder if there's a better organization with testing in
> > pmu-events.c, expr.c and now parse-metric.c.
>
> hum, so
>  - expr.c is testing core interface,
>  - parse-metric is testing specific metric processing from
>    parsing to final ratio
>  - pmu-events.c is testing pmu events aliases and parsing of
>    all the metrics
>
> pmu-events.c is testing both pmu events and metrics,
> but I think it fits in the way it's done together

Agreed, it makes following this a little bit of a challenge. When I
did the parsing in pmu-events I'd originally done it in expr.c for
example. Perhaps if there were a parse-metric in tools/perf/util then
things would align better as well. Just thinking out loud :-)

Thanks,
Ian

> jirka
>
