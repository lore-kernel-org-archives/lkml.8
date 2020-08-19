Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20DEC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C0E62067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 17:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Il4mUn2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgHSRCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 13:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgHSRCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 13:02:06 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5069AC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 10:02:05 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id g13so11184699ioo.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 10:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5R0bKLD4IQJAxbXV/MHy5oB2ZKOef13BK1brjzJ63Q=;
        b=Il4mUn2KElTQdKcXtaNWURCYaRHxLSwjgiUP5m1oe7/nNMPk3by8+5BUYv52G22R9c
         g7BTGrNNW6WBMf2aIXKP7uTyJRrgbLDQ0lIW4dFwtp8SoIAY0vpZkh/TlqIe4o73ye0a
         0yWWxkBtp0WUT6dGO855eUjmVjnJRQXI6MjENle0kyb0I1c9uWSatRY1Zd8J1J3CAr5z
         dsnJgvWWdcRSbry8lnt4BaRfwbuWX046gwBGDd0HHZlUBjr7fXlZgCSGjgAeJLNbyS0p
         hVFvhgK+gTr3jXAMqfr5n+Sxezdk4w7HEVfDJYClNLuM0ZZLsFXRSgtzWNIy6wXApI6X
         A9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5R0bKLD4IQJAxbXV/MHy5oB2ZKOef13BK1brjzJ63Q=;
        b=dZkinArVfJvg6KGUaPJhfZl7V4zEUBerxDAaMi+gTiioXxXsTlZya1HweqKaeVP/rV
         bOplle05o9jULuQIRcLyQUqloVybAK+wv5cee/egw9f8OEshqxCeaYl794vqJjMo8Ji3
         FuZSCIk2tTcIEFdxkE0nzwrw4mPP/d3XioqHQH/o6zF0V2H4hGLF/sKaOxBD4u8/DX4i
         uplU/r6UmWAg06Gvmmryg69SKEjjLLCy/EUPvNkaFyFVXo+8Lx8iXS1PuKB7xqWfgLaw
         NCmPmcZwacNnwlh4eV86CG7tVZs/YYvwLL3y9muXmwxIaQDrracY0qISit/uhDulYjki
         UxOw==
X-Gm-Message-State: AOAM531kJrOlTe8iiRMEf2P8Mxz7YYVnioLtDOJx1YR9o5GYn8T5vS3n
        eYmJGo/EU9z/0Z2fwNdltEBZieW5qjbPLaFDN2kPRA==
X-Google-Smtp-Source: ABdhPJz6U3qxfQY7FyyjwoYDmcSIZxEIGX20jsPbcikmWABU8VgSxQUtwLuL76KK7Ncz4aahl8skE/4PZ2aPsssIy2c=
X-Received: by 2002:a05:6638:d95:: with SMTP id l21mr23962229jaj.98.1597856524486;
 Wed, 19 Aug 2020 10:02:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200817193140.3659956-1-mathieu.poirier@linaro.org> <ede047ea-ad6a-1f7e-d597-b47bc87271c3@huawei.com>
In-Reply-To: <ede047ea-ad6a-1f7e-d597-b47bc87271c3@huawei.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 19 Aug 2020 11:01:38 -0600
Message-ID: <CANLsYkw2aBJmrHV+8_bDUtgD-Jfvndqz2kOfNNcBBMM+vztkug@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add entries for CoreSight and Arm SPE
To:     John Garry <john.garry@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>,
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

On Tue, 18 Aug 2020 at 11:56, John Garry <john.garry@huawei.com> wrote:
>
> On 17/08/2020 20:31, Mathieu Poirier wrote:
> > Add entries for perf tools elements related to the support of
> > Arm CoreSight and Arm SPE.
>
> Thanks for doing this...
>
> >
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >   MAINTAINERS | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 4e2698cc7e23..f9bb76baeec9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13427,8 +13427,18 @@ F:   tools/perf/
> >   PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS
> >   R:  John Garry <john.garry@huawei.com>
> >   R:  Will Deacon <will@kernel.org>
> > +R:   Mathieu Poirier <mathieu.poirier@linaro.org>
> > +R:   Leo Yan <leo.yan@linaro.org>
> >   L:  linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >   S:  Supported
> > +F:   tools/build/feature/test-libopencsd.c
> > +F:   tools/perf/arch/arm/util/auxtrace.c
> > +F:   tools/perf/arch/arm/util/cs-etm.*
> > +F:   tools/perf/arch/arm/util/pmu.c
> > +F:   tools/perf/arch/arm64/util/arm-spe.c
> > +F:   tools/perf/util/arm-spe.h
> > +F:   tools/perf/util/cs-etm-decoder/*
> > +F:   tools/perf/util/cs-etm.*
>
> But from the previous discussion, I thought that we wanted an entry to
> cover all tools/perf/arch/arm64/ and other related folders. Or was it
> just put all special interest parts (like SPE support) under one entry
> and leave the other arm/arm64 parts to be caught by "PERFORMANCE EVENTS
> SUBSYSTEM" entry?

I do not have the time to maintain anything outside of coresight -
listing individual files as I did removes any ambiguity on that front.
I'm happy to add tools/perf/arch/arm and tools/perf/arch/arm64/ if you
agree to maintain them.  In that case you will have to be more
specific about the "other related folders" you are referring to above.

Thanks,
Mathieu

>
> Cheers,
> John
>
> >   F:  tools/perf/pmu-events/arch/arm64/
> >
> >   PERSONALITY HANDLING
> >
>
