Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27295C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0657207F9
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 08:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="j64aX7dj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgFIID4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 04:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgFIIDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 04:03:54 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1F4C03E97C
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 01:03:54 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id z2so19421981ilq.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 01:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j1zGYv5vIgLOimP3OkCOR1BJL86Aah0WsXhX6Tk0Sdg=;
        b=j64aX7djANteYpMcDhvc55pN0tloE0TEjFQh/23kTMOaSBk6RmhppYEFXMkoGdg4sw
         5BIUnaXkHt9/5YDTA7pX98HXD8igreLE9KJ91WJkbu+A326LN0sucvCR1CVcfVpxgUtn
         ozNn7T1mY2F525QmEg2vBq9VaIvNzOcd0OsB6VuDysK+dVg40MaLbWxMacg9Tw6KFLAW
         mDXsIHq+pSdeeUUdTk788NoXburAZQWJwhw1U4LBo5aUwtYeSffoQY9SaBGqNfCnUebs
         mnu0NGGIoDW4S7rHUTj0lX4SzoPjIPBIRCNNbsthL8jLJMGnH3V1UmQs1kIxAPTcVBom
         qdqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j1zGYv5vIgLOimP3OkCOR1BJL86Aah0WsXhX6Tk0Sdg=;
        b=BzC+DfnRnouCEeyTjytPNj7jSUu78eZRHG4M4I1ezkQxqDQbKK+VXqVbi/scKz2eoF
         sBdKzATRdbICQ3K+ucZw1j3W+F5MDMH/W7RWEQiooU/gMy+DMzCVUV8Ki589/QVMMHHC
         5yxR2l2/2PehbpR+xsbGADyvKtu5ckTAonoO61VeFXdaymmdIxQkM++0XO2Yiq4gf6Np
         XEJ7pdD3ZTwnxxPyMYAMg5n5iJFWsLMe39H4nWvEtDJhpAgVkZF8ZCaOhR5pqCliNVlW
         XMQOkETBmWwAyQlQwX2FleF5z1OnyssFYfiiy7lDSixg4Ue88FymQSuEOrJWCtAguLV5
         3UKg==
X-Gm-Message-State: AOAM531aflk+AwUfMWAyR/Au4pGW/XWH2ozBYxn9F+LXEwYX5m8Uf5Gb
        7TDxR0muqTc7hK9vM3XuRBhIHfC8r/Qbrk1Gn8qTlQ==
X-Google-Smtp-Source: ABdhPJxCIRFqxlaeMcEOtPwe/tKI+0LrF+62rvn8x4i3MMq7i7bSsnyaDQVz1wSDBOWugHPjhH3QtP8L9elO1yeZsss=
X-Received: by 2002:a92:aa07:: with SMTP id j7mr26117162ili.40.1591689833582;
 Tue, 09 Jun 2020 01:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200516064507.19058-1-warthog618@gmail.com> <CAMpxmJUbC4qmUGM0Z-6hXsYPRSpEpNM7iXgc7XbMcf_epi0Lig@mail.gmail.com>
 <20200604160006.GA5730@sol> <CAMRc=MfS1sCTU3vs5Gq_6+Ubt_89HX34mqabtpGbAASo+SfzSw@mail.gmail.com>
 <20200606015647.GA8099@sol>
In-Reply-To: <20200606015647.GA8099@sol>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 9 Jun 2020 10:03:42 +0200
Message-ID: <CAMRc=Mdz__0TD8Qa33KRK9PE6jLvxa_O_dDjA54MHBLOeMxWfg@mail.gmail.com>
Subject: Re: [RFC PATCH] gpio: uapi: v2 proposal
To:     Kent Gibson <warthog618@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sob., 6 cze 2020 o 03:56 Kent Gibson <warthog618@gmail.com> napisa=C5=82(a)=
:
>

[snip!]

> >
> > I'd say yes - consolidation and reuse of data structures is always
> > good and normally they are going to be wrapped in some kind of
> > low-level user-space library anyway.
> >
>
> Ok, and I've changed the values field name to bitmap, along with the chan=
ge
> to a bitmap type, so the stuttering is gone.
>
> And, as the change to bitmap substantially reduced the size of
> gpioline_config, I now embed that in the gpioline_info instead of
> duplicating all the other fields.  The values field will be zeroed
> when returned within info.
>

Could you post an example, I'm not sure I follow.

> > > And I've renamed "default_values" to just "values" in my latest draft
> > > which doesn't help with the stuttering.
> > >
> >
> > Why though? Aren't these always default values for output?
> >
>
> To me "default" implies a fallback value, and that de-emphasises the
> fact that the lines will be immediately set to those values as they
> are switched to outputs.
> These are the values the outputs will take - the "default" doesn't add
> anything.
>

Fair enough, values it is.

[snip!]

> > >
> > > I'm also kicking around the idea of adding sequence numbers to events=
,
> > > one per line and one per handle, so userspace can more easily detect
> > > mis-ordering or buffer overflows.  Does that make any sense?
> > >
> >
> > Hmm, now that you mention it - and in the light of the recent post by
> > Ryan Lovelett about polling precision - I think it makes sense to have
> > this. Especially since it's very easy to add.
> >
>
> OK.  I was only thinking about the edge events, but you might want it
> for your line info events on the chip fd as well?
>

I don't see the need for it now, but you never know. Let's leave it
out for now and if we ever need it - we now have the appropriate
padding.

> > > And would it be useful for userspace to be able to influence the size=
 of
> > > the event buffer (currently fixed at 16 events per line)?
> > >
> >
> > Good question. I would prefer to not overdo it though. The event
> > request would need to contain the desired kfifo size and we'd only
> > allow to set it on request, right?
> >
>
> Yeah, it would only be relevant if edge detection was set and, as per
> edge detection itself, would only be settable via the request, not
> via set_config.  It would only be a suggestion, as the kfifo size gets
> rounded up to a power of 2 anyway.  It would be capped - I'm open to
> suggestions for a suitable max value.  And the 0 value would mean use
> the default - currently 16 per line.
>

This sounds good. How about 512 for max value for now and we can
always increase it if needed. I don't think we should explicitly cap
it though - let the user specify any value and just silently limit it
to 512 in the kernel.

> If you want the equivalent for the info watch then I'm not sure where to
> hook it in.  It should be at the chip scope, and there isn't any
> suitable ioctl to hook it into so it would need a new one - maybe a
> set_config for the chip?  But the buffer size would only be settable up
> until you add a watch.
>

I don't think we need this. Status changes are naturally much less
frequent and the potential for buffer overflow is miniscule here.

Bart
