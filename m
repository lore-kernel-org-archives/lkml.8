Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E5ECC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F27A02078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QpSfvOra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgHST0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbgHST0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:26:39 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A343CC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:26:38 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id 77so21662891ilc.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5BGtZ5BwqTPokae+tJqoDxjKYZ/7jxyi3A6FMN4E2E=;
        b=QpSfvOraCUWInnVwbf3MKR/NLu0NRKWHSeAg3qqfODo4RvhX/fwn9+lgH6IQ3tYNz4
         m3w4S3CJPicgeglnKYKmB8I4U3vEqYPhxemXhR9MY1tIJLteXyBSePGHhjjzttuYzkHZ
         WyUewGmFKBM1qE0mDlYoOTbfc1QabnpTKb30+dbqheGBEG/mrm/KvBNC7aYU/lRiSWk6
         vlSxRv+hhUTAk7PuYl9KmNiKC7Huv3mnOcJEhUJHFnUPujmS1BUMSR+7PEJzWsz/XQyY
         C9E4X9e1+nnpvqbAvK/tnZzg+Un1js7MP5axCs6lMUgkQhppoZh8k5OZw/2goHV888Sd
         NVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5BGtZ5BwqTPokae+tJqoDxjKYZ/7jxyi3A6FMN4E2E=;
        b=ZBUE/hJh/PCOU15Xvl4GMe98KkBpm4/c5M3rlddJzcP5XAu4M6vSR4tIGjsCnuq016
         FcXsjS31oJ34UPtdx+6sjX0v6nMCKjinVPolGZtnYhmwqL51+sLWXDpoXKth7FhVIn3o
         coTg7JsGy04wmgazngca6yQupoiAL5sOqKUQ8Hwkrvwhp1uWBvM7ZWlZJE11y+pJUblt
         /3JkqNImHva74+8QGG7sire/APsg/zlnYeez/sbI+kCSCkLI13rn3Oqui9mCs2uVmInK
         /LE/E1EZSTwrLfreUdPOCuuoxK0bYBuUNGB/mFlgkSbxAqY75quanXysk5zMMF6Mz8JK
         WmFQ==
X-Gm-Message-State: AOAM533cM7Hr/MisYW4tDVDpdKoBu8EOVFI9O5ILgtUHM2UxWSQ8i0w6
        kjUmp21Q0UU8+uUm7eJikDo1WbjPY3qUeTKoZOJMmA==
X-Google-Smtp-Source: ABdhPJyhMn6q6v7MlLQpkx4Nfd3hJdOKCYH6ftQHmVsP5ZCCgztT91KpYuNinLcOgLhFQaKni7bw9wlukfnbcwbd5Sk=
X-Received: by 2002:a92:a008:: with SMTP id e8mr2004066ili.140.1597865197748;
 Wed, 19 Aug 2020 12:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200817193140.3659956-1-mathieu.poirier@linaro.org>
 <ede047ea-ad6a-1f7e-d597-b47bc87271c3@huawei.com> <CANLsYkw2aBJmrHV+8_bDUtgD-Jfvndqz2kOfNNcBBMM+vztkug@mail.gmail.com>
 <20200819173050.GA18091@willie-the-truck>
In-Reply-To: <20200819173050.GA18091@willie-the-truck>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 19 Aug 2020 13:26:26 -0600
Message-ID: <CANLsYkzn2yuhVzZD0p-C156qi28ukHQDa83F8pezESsptG4d1Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add entries for CoreSight and Arm SPE
To:     Will Deacon <will@kernel.org>
Cc:     John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020 at 11:30, Will Deacon <will@kernel.org> wrote:
>
> On Wed, Aug 19, 2020 at 11:01:38AM -0600, Mathieu Poirier wrote:
> > On Tue, 18 Aug 2020 at 11:56, John Garry <john.garry@huawei.com> wrote:
> > > On 17/08/2020 20:31, Mathieu Poirier wrote:
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 4e2698cc7e23..f9bb76baeec9 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -13427,8 +13427,18 @@ F:   tools/perf/
> > > >   PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
> > > >   R:  John Garry <john.garry@huawei.com>
> > > >   R:  Will Deacon <will@kernel.org>
> > > > +R:   Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > +R:   Leo Yan <leo.yan@linaro.org>
> > > >   L:  linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> > > >   S:  Supported
> > > > +F:   tools/build/feature/test-libopencsd.c
> > > > +F:   tools/perf/arch/arm/util/auxtrace.c
> > > > +F:   tools/perf/arch/arm/util/cs-etm.*
> > > > +F:   tools/perf/arch/arm/util/pmu.c
> > > > +F:   tools/perf/arch/arm64/util/arm-spe.c
> > > > +F:   tools/perf/util/arm-spe.h
> > > > +F:   tools/perf/util/cs-etm-decoder/*
> > > > +F:   tools/perf/util/cs-etm.*
> > >
> > > But from the previous discussion, I thought that we wanted an entry to
> > > cover all tools/perf/arch/arm64/ and other related folders. Or was it
> > > just put all special interest parts (like SPE support) under one entry
> > > and leave the other arm/arm64 parts to be caught by "PERFORMANCE EVENTS
> > > SUBSYSTEM" entry?
> >
> > I do not have the time to maintain anything outside of coresight -
> > listing individual files as I did removes any ambiguity on that front.
> > I'm happy to add tools/perf/arch/arm and tools/perf/arch/arm64/ if you
> > agree to maintain them.  In that case you will have to be more
> > specific about the "other related folders" you are referring to above.
>
> None of us have time for this, hence why I think putting us all in one entry
> with all of the files listed there makes the most sense; then people do
> whatever they can and try to help each other out based on how much time they
> have. I think that's much better than fine-grained maintainership where a
> given file has a single point of failure.

Thanks for the clarification - just wanted to make sure I don't sign
you guys up for something you didn't agree to.

>
> So I think it should include:
>
>   tools/perf/arch/arm64/
>   tools/pmu-events/arch/arm64/
>
> along with the SPE and Coresight files.
>
> Arnaldo would still handle the patches, so this is really about giving us a
> chance to review incoming patches without having to fish them out from the
> lists.
>
> Will
