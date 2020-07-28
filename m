Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E674EC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 21:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1DC52065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 21:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YK8aGH7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgG1Vcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 17:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgG1Vca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 17:32:30 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F15C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 14:32:30 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id r4so83289pls.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=nog6I1ImyNyq0+O1gfRhInkU2I7Jgi2bEICANP1hoBw=;
        b=YK8aGH7hGj9Nh6bAPQGpVfyPuUN02hUZ+fVn6ryvf2tirGFUVzuzD4fUiRq8a4QYS+
         grQHh7nvHbbXR/0d9nx9zOzqiWJKYbBXC6HV8bcyIELt2xk9opR02IU5ztm7C2XDaS7G
         mixfOgJxHyYaYryaQrM1zPmxoMl6q4/pB86Gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=nog6I1ImyNyq0+O1gfRhInkU2I7Jgi2bEICANP1hoBw=;
        b=Pxi1BJHkBfmg/EP4ncpVMobX/9leuJy2ajbD3keWZThy9U88K8iDOdi9QU5mFT9p6L
         ZZTehaPphy+avmm2lmO+Q7f8/7inU2O5O9EXW+UjmfCUh2SZVHNqae8embDc6d2Gk69Z
         f3mLso/yBepT5PoyYiQmW7YgNge3Ad+j2puSzklbqEtw8dmh0BrRkvpD4HwxFH8PfQ52
         85R9cpJ3DUBxqvwfA2pOXPHemgBkMRWnTOp0dzWJHAnNLdxAhMWiP1DQFzP1M8pzczP7
         QAp8cW3vHAQbsSEOTLKH+qqNtxd8RtKm6/VATR5cY7oE8t3ocEJG2TJpRCiq4RPaWx1r
         YewQ==
X-Gm-Message-State: AOAM530SfgTuG+K9WnUQevO7gykYy1PchRPVXzDFXZ/n5L74gRQnNTnO
        NCcncjEXGPByEU2sQeYXvFqwiA==
X-Google-Smtp-Source: ABdhPJxfaoR6u1bnMbcNU4Ms4jruAX1+/p/Idf0FpyzChRlmxP09b+wzBqi2CIeuf6OuBlcixrnPJA==
X-Received: by 2002:a17:902:8685:: with SMTP id g5mr11281085plo.201.1595971950196;
        Tue, 28 Jul 2020 14:32:30 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id f8sm18693pfk.107.2020.07.28.14.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 14:32:29 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHcu+VbYrbWStNNaidDygY=d4f6F5tXUxWtsuH0x3oVeELGWVA@mail.gmail.com>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid> <20200728151258.1222876-1-campello@chromium.org> <20200728091057.10.Ibe84fae61cd914c116e6d59ffeb644f1cbecd601@changeid> <159596523705.1360974.7169089810545711557@swboyd.mtv.corp.google.com> <CAHcu+VbYrbWStNNaidDygY=d4f6F5tXUxWtsuH0x3oVeELGWVA@mail.gmail.com>
Subject: Re: [PATCH 10/15] iio: sx9310: Simplify error return handling
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>
To:     Daniel Campello <campello@chromium.org>
Date:   Tue, 28 Jul 2020 14:32:28 -0700
Message-ID: <159597194837.1360974.9212489704079396891@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Campello (2020-07-28 14:23:29)
> On Tue, Jul 28, 2020 at 1:40 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Daniel Campello (2020-07-28 08:12:53)
> > > @@ -368,13 +368,13 @@ static int sx9310_wait_for_sample(struct sx9310=
_data *data)
> > >  static int sx9310_read_proximity(struct sx9310_data *data,
> > >                                  const struct iio_chan_spec *chan, in=
t *val)
> > >  {
> > > -       int ret =3D 0;
> > > +       int ret;
> > >         __be16 rawval;
> > >
> > >         mutex_lock(&data->mutex);
> > >
> > >         ret =3D sx9310_get_read_channel(data, chan->channel);
> > > -       if (ret < 0)
> > > +       if (ret)
> > >                 goto out;
> > >
> > >         if (data->client->irq) {
> > > @@ -394,11 +394,11 @@ static int sx9310_read_proximity(struct sx9310_=
data *data,
> > >
> > >         mutex_lock(&data->mutex);
> > >
> > > -       if (ret < 0)
> > > +       if (ret)
> > >                 goto out_disable_irq;
> >
> > Why is this condition checked after grabbing the mutex? Shouldn't it be
> > checked before grabbing the mutex? Or is that supposed to be a
> > mutex_unlock()?
> We acquire the lock before jumping to out_disable_irq which is before
> a mutex_unlock()

Does this function need to hold the mutex lock around get/put_read_channel?
It drops the lock while waiting and then regrabs it which seems to
imply that another reader could come in and try to get the channel again
during the wait. So put another way, it may be simpler to shorten the
lock area and then bail out of this function to a place where the lock
isn't held already on the return path.
