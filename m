Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF72BC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACA7C20672
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSMp1E7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgG1WHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729654AbgG1WHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:07:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A365C0619D4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:07:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x5so940212wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 15:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yNjtG/Ppk+gQT7Qol4h75D+wSaMe69jZnCwP/w16s9g=;
        b=YSMp1E7RF4zNZ07R1alwQIvbeDMjPIZWwOYZNtvhdv9dCGDoCauAecZz0txiTF8MYA
         Cmn0+Ib/Uv9RNGi5cqtJdsBS1l3bCnRjtV0TOhao9EoWJ9dajr9/xpWTZgbqAEgW0AVB
         QTdMT5EAF5AspHw6YefR+Bg+h6lgvYfd2XyGI0FooYUnnzH8fZddF9SW7EHZXtM40aRh
         YnHAfisOXakQWfO+khJT4FsZ69YO6V3UVQ2TcHm9X0O6omRlrdwzc0S5O59dHosM3iu8
         rg89PH87STYM/U3wQrKBrLupiJoLm/HuTNxN8GYeZ+RA/cSm51WOy4qQ/QTgiRwbBVYT
         U6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNjtG/Ppk+gQT7Qol4h75D+wSaMe69jZnCwP/w16s9g=;
        b=JV8XEIRXhPSTxTlz7XYTXwOQTCnjlVLXZXh7Kbxu7EJChID1/PH77YoAiMybcD5Sk+
         Cjnzbex0KOGj0lQX87DY3pQNuzbNZwcqBTVojPXOT8OgIXNP9PimRrSnZMdad0fVRKKO
         8i0mR1mXhbfbVS1r3bckdL4urA04n9nY3p8HceRkK7v2U5tJF6bMYiUII/nlVgjnzjwv
         p+Yp0CZ+kRh7XYedSYBT+7pHzThTMwacIAABpD6MXdTMRgkPJNH6ux6CImrf7E5Pqo6W
         9HXWc0D9tw4zxtJT/uHiHlrg/t2YlEJ+O99fPGYaiTzydV+fVlGU+CSBJzL7x6u0JZMF
         aC9A==
X-Gm-Message-State: AOAM533fmVtaM6S/Bj967elfRjtfzZsMkxcB67v+78flLt08/wUHXoNv
        UknVIduO5gKjvvCcLNR2FtvIk00v4g2ePp/zCjUM3g==
X-Google-Smtp-Source: ABdhPJx8ktpw7PKb8X9C7utuR4EGxd5Zemvet/KyKeb+2tSmKYlWKuFXwDYE1wjg1fBRGU9xyTq7VmjUuwJedxftAag=
X-Received: by 2002:a1c:e908:: with SMTP id q8mr6125255wmc.59.1595974038580;
 Tue, 28 Jul 2020 15:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.10.Ibe84fae61cd914c116e6d59ffeb644f1cbecd601@changeid>
 <159596523705.1360974.7169089810545711557@swboyd.mtv.corp.google.com>
 <CAHcu+VbYrbWStNNaidDygY=d4f6F5tXUxWtsuH0x3oVeELGWVA@mail.gmail.com> <159597194837.1360974.9212489704079396891@swboyd.mtv.corp.google.com>
In-Reply-To: <159597194837.1360974.9212489704079396891@swboyd.mtv.corp.google.com>
From:   Daniel Campello <campello@google.com>
Date:   Tue, 28 Jul 2020 16:06:42 -0600
Message-ID: <CAHcu+VZ032uZ==-Lqix=x61pdurNXjOiKvrKTaKJqUyUgn8OGQ@mail.gmail.com>
Subject: Re: [PATCH 10/15] iio: sx9310: Simplify error return handling
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 3:32 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Daniel Campello (2020-07-28 14:23:29)
> > On Tue, Jul 28, 2020 at 1:40 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Daniel Campello (2020-07-28 08:12:53)
> > > > @@ -368,13 +368,13 @@ static int sx9310_wait_for_sample(struct sx9310_data *data)
> > > >  static int sx9310_read_proximity(struct sx9310_data *data,
> > > >                                  const struct iio_chan_spec *chan, int *val)
> > > >  {
> > > > -       int ret = 0;
> > > > +       int ret;
> > > >         __be16 rawval;
> > > >
> > > >         mutex_lock(&data->mutex);
> > > >
> > > >         ret = sx9310_get_read_channel(data, chan->channel);
> > > > -       if (ret < 0)
> > > > +       if (ret)
> > > >                 goto out;
> > > >
> > > >         if (data->client->irq) {
> > > > @@ -394,11 +394,11 @@ static int sx9310_read_proximity(struct sx9310_data *data,
> > > >
> > > >         mutex_lock(&data->mutex);
> > > >
> > > > -       if (ret < 0)
> > > > +       if (ret)
> > > >                 goto out_disable_irq;
> > >
> > > Why is this condition checked after grabbing the mutex? Shouldn't it be
> > > checked before grabbing the mutex? Or is that supposed to be a
> > > mutex_unlock()?
> > We acquire the lock before jumping to out_disable_irq which is before
> > a mutex_unlock()
>
> Does this function need to hold the mutex lock around get/put_read_channel?
Yes, both get/put_read_channel and get/put_event_channel use
sx9310_update_chan_en which is updating data->chan_{read,event}
bitmaps.
> It drops the lock while waiting and then regrabs it which seems to
> imply that another reader could come in and try to get the channel again
> during the wait. So put another way, it may be simpler to shorten the
> lock area and then bail out of this function to a place where the lock
> isn't held already on the return path.
