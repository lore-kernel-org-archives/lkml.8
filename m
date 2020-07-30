Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42246C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F16C20838
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DR65LCOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbgG3Rqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 13:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgG3Rqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 13:46:43 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471ABC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 10:46:43 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id t15so20162757iob.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 10:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KAQxMtrcNtT/qn4VP9i1rWA9WddbB6VGPbgpkMkGrA0=;
        b=DR65LCOUMQR20BJpxQ9xrmHCoWWhUQ8CIys3obDf+4dsubLWlGYWkVgHK80ueyn9Ht
         tisBUvDtBMEqouGdnSOotr7ZVXkUYZ5ELYgzRS37so41EvGVV3W5AVVEzbJGu1pqK3xC
         PALm8nzf7olRFrjBT2UgQleA2wTWMeB/k8HjG9FdODa6BiJTz5MhY6xw1uaqaM+L5XAw
         sq03qRHMP13q76GoVjPiktV7yUZQ6jBmQVrboaQHDeV5Ie7RAlWXxHYc1fSWC6ZSCmAc
         v0h8HIGh2upttDFZyv5JL6pMFZuLdl4OkPzftWSje+AOrhg17VWaYN+Ouz6gJDFLG8pl
         h0qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KAQxMtrcNtT/qn4VP9i1rWA9WddbB6VGPbgpkMkGrA0=;
        b=TKORmu3YTOOZrVTOYgaU4D2JDZImq27CarU0MotwybUwIL2LgzQYZBYPvP/lcXStZL
         GmkdoOKq7Kc7HAns956dEuxZZos2WJJW2qkf2aqhEOEsY738lQgPMvQkSlDky/TXQ6bS
         1Li/ZC2/OaJLJz3z2UvSvSNujtEXYXLO/xiuBgx5pJR2PchKFC4igagKSQTO/19HHwHZ
         weeyccVVZOCSNkXnqV5M2XuW1TSFytdxiHoo092ohkxsWe9TocU/FAgFP++R86Ryf4wk
         G40R1AoEYPdhn4EMDCYXYoKIM6EzUzntWxdmSdA4T9Tfh4REk8YHyOwEbonK42IPq6EI
         JUCA==
X-Gm-Message-State: AOAM531VAUSsj95sVbCU72OeRET2qMmZwh+p0156WE0Ie0Ik3IEsnF5f
        hvRo7tFRrK0SWgxYxLetdQCklkAtG6vGbeiZOZE=
X-Google-Smtp-Source: ABdhPJyhYSIPo/giDMeelwhangK4RmO8N4BnVkCP2Rskejgr5cQANOAipXRcjsyTeYIcHCvQYRbde9p2WR4m/oKgVd8=
X-Received: by 2002:a6b:dd12:: with SMTP id f18mr22464031ioc.109.1596131202475;
 Thu, 30 Jul 2020 10:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200713144331eucas1p25911c4ffa9315f632d8f6dd833588981@eucas1p2.samsung.com>
 <20200713144324.23654-1-a.hajda@samsung.com> <e55a23bf-59bb-43c6-f7d7-467c282b8648@samsung.com>
 <20200730070832.GA4045592@kroah.com> <CAKdAkRTKjHg2y8yTFgxr4yY98M8D2noutDBfB1mh7wwLLQrYbw@mail.gmail.com>
 <20200730164845.GE5055@sirena.org.uk>
In-Reply-To: <20200730164845.GE5055@sirena.org.uk>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu, 30 Jul 2020 10:46:31 -0700
Message-ID: <CAKdAkRS+QooavPaKMcsaUQdRJGky_6JYq1EiUbyT_gcU3ZYeJw@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] driver core: add probe error check helper
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 9:49 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Thu, Jul 30, 2020 at 09:18:30AM -0700, Dmitry Torokhov wrote:
>
> > I believe it still has not been answered why this can't be pushed into
> > resource providers (clock, regulators, gpio, interrupts, etc),
> > especially for devm APIs where we know exactly what device we are
> > requesting a resource for, so that individual drivers do not need to
> > change anything.
>
> The error messages are frequently in the caller rather than the
> frameworks, it's often helpful for the comprehensibility of the error
> messages especially in cases where things may be legitimately absent.

Not for deferral. All you need to know in this case is:

"device A is attempting to request resource B which is not ready yet"

There is nothing to handle on the caller part except to float the error up.

>
> >                  We can mark the device as being probed so that probe
> > deferral is only handled when we actually execute probe() (and for the
> > bonus points scream loudly if someone tries to return -EPROBE_DEFER
> > outside of probe path).
>
> Is this a big issue?

We do not know ;) Probably not. It will just get reported as an
ordinary failure and the driver will handle it somehow. Still it would
be nice to know if we attempt to raise deferrals in code paths where
they do not make sense.

Thanks.

-- 
Dmitry
