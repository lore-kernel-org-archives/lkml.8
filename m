Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED65AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C965320707
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2Y3gF3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgFOK2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728369AbgFOK2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 06:28:19 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01326C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 03:28:00 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id b13so5483106uav.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 03:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rU9JUkj2VKBxOM/smu29U/AAlMTJdm//1yIZ5VQj9EA=;
        b=F2Y3gF3uRYirDOAb5XX55RRvXWHeHzIeuhSD+GjOYTHODp3C4K9//0udlcm4sa2Uzj
         nomsh1D+3VZBczj8gcHfQ0rkA9m1bQnOlN83aoFGLmOlo9SJHCQCOE/PQBfU5Fg4E9e3
         hH3yqx9L7qcseMnwiMHp2uqmzaYTr/il44xyntpqvS9s66dsB6DRtpbfSyfG6LwHaWlq
         X/NaRksGyLOSEoZjSen9/eXHn6xn6Z55GSR/u1fOGHs8hXz2N4pM9DyoP5MdxMSm+J91
         BbajoHlcXh6fYkjRb8XHrNRYZsc2H0LHxa/heDa6wojUim/qRAhsdnqXhKg6i0OtjhTM
         zoIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rU9JUkj2VKBxOM/smu29U/AAlMTJdm//1yIZ5VQj9EA=;
        b=Fi1ge8pnJodQTYvmoX1G3bJZTRbtvE8enidd2unKoqpp7zCbuH8Bkj1XGldLg/Rxw3
         +tONdHWALw3rCAR8aLX7AS8goA/q6J3eW0VLsCLE3hciHTbxBsBqb6oEpgc2X2GZm1xo
         xHAt3YnRP6Dd60NDxv1JgknHi3tC89W92HsIBL4tL/y3jUBzfGQgeZ6JzCMG+ktFmCwy
         ciA6KOfcNj77C16gA3wUb/V9cMfrrlbmWC7mi4X8xeNCCpOJ9OWSphTpSNbf+Y7SpTr1
         /Yz2UVninfa+chmYyJEoZCYnubUNSlgWZyRaWuGpw/vIOT80qTK2YmLE5tfIRhEfUmE3
         Ynlw==
X-Gm-Message-State: AOAM531R/LyyL0J6OtcH2lUwYj90/GLF7mIxuGfI6kyF7Cju34fmrthu
        R4E6ZHTvhj815+8gipXxg4Z75/ToZ3scMRkK26fYpA==
X-Google-Smtp-Source: ABdhPJwqruSZ2YdClo42lU1i0GNev9Ttn+TX/3lFS69tG19RZd2QloosVZ8WiPcvWCvHPan+PJ4ijIRijoHbG1CVJbs=
X-Received: by 2002:ab0:6086:: with SMTP id i6mr17903493ual.129.1592216879850;
 Mon, 15 Jun 2020 03:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200528190610.179984-1-saravanak@google.com> <20200528190610.179984-3-saravanak@google.com>
 <20200529130012.GJ4610@sirena.org.uk> <CAGETcx9Y8VoPCjrVFdDwU=+m3_0OTZQgj9b5eSHSTgSqeCZrUQ@mail.gmail.com>
 <20200601172323.GE45647@sirena.org.uk> <CAGETcx-T=NstJDV2S8gKmqpOv1r2-fTRs1pwOtSQ6rJumhVGBg@mail.gmail.com>
 <20200609105115.GA4583@sirena.org.uk>
In-Reply-To: <20200609105115.GA4583@sirena.org.uk>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 15 Jun 2020 12:27:23 +0200
Message-ID: <CAPDyKFohcYjSvBjjB01mg7bOFCJA8XukgRPsZJm48X44sFzeYA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] regulator: Add support for sync_state() callbacks
To:     Mark Brown <broonie@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jun 2020 at 12:51, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jun 08, 2020 at 08:16:44PM -0700, Saravana Kannan wrote:
> > On Mon, Jun 1, 2020 at 10:23 AM Mark Brown <broonie@kernel.org> wrote:
>
> > > This is I think the first time anyone has suggested that this is likely
> > > to be an issue - the previous concerns have all been about screens
> > > glitching.
>
> > Looks like we got at least one concrete example now in [1].
>
> That's the Exynos VDD_INT/CPU issue.  I'm not clear that this is
> entirely covered TBH, AIUI it needs a coupler all the time so it's not
> just a case of waiting for the consumers.
>
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.
>
> > But it doesn't really ignore consumer requests though. In response to
> > all your comments above, I haven't done a good job of explaining the
> > issues and the solution. I'll try to redo that part again when I send
> > v3 and hopefully I can do better.
>
> Yes, I think a lot of this is about clarity of explanation.
>
> > > My concern is that introducing extra delays is likely to make things
> > > more fragile and complex.  As far as I can see this is just making
> > > things even worse by adding spurious dependencies and delaying things
> > > further.
>
> > I wouldn't call it delaying any requests. This is just an additional
> > constraint like any other consumer. This definitely makes things more
> > stable in cases where all the devices probe and even in cases where
> > some of those devices might never probe (example I gave in [2]).
>
> Since your current implementation restricts things until essentially the
> entire system is running this is going to affect consumers that don't
> share their regulator.  Part of the reason I am so against that idea is
> that when it is very important that a driver be able to change the
> voltage and have that actually take effect usually the hardware will be
> built such that that regulator isn't shared so shareability issues don't
> apply, we have regulator_get_exclusive() for such situations though
> it's wound up not as widely used as it could be for a bunch of reasons.
> Things like MMC where we have to conform to a hardware spec that
> includes lowering as well as raising voltages will have issues with
> this.
>

eMMC is not only about voltage levels, but also about enable/disable
of the regulator(s).

More precisely, one needs to follow the steps specified in the eMMC
spec, when disabling the regulator(s).

In other words, the mmc host driver needs to be probed (consumer of
the regulator), before the regulator(s) can be disabled.

Kind regards
Uffe
