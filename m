Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADD6C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 21:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 663CC20714
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 21:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l6hUntl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbgG1VYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 17:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729322AbgG1VYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 17:24:09 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3E7C0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 14:24:09 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id o18so1451060eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A40P7qvWDr7hSDOUUBLZppAbSNbGdWqbtbvvJ8/dneg=;
        b=l6hUntl9Y1jAFAvRM3OZ07jD1ncrYLjRRWnW80nV17Xay1+XqKIYJY8f4s7XOS7gvf
         LBoRYt9/GuIYjVwqGCaSfSzZRvzCBPQtJSGB3HyLhDgUeQLBCkzsPt5zUnFzQLQxBuOF
         i7m583btWK9pCPqDWcZPEummRV7tcoi+UVTBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A40P7qvWDr7hSDOUUBLZppAbSNbGdWqbtbvvJ8/dneg=;
        b=hn0Q0Ky7lE7KU1xIEvf7MQB6k3FfvxXkcw7IgWALjnVvYnfc8r5eNeVIAfovM0gGte
         20IZS47DaaPEma3dgvfFwGdBHPz+Og2K3zRu4e3HYSGKsFIDzpO/lnosU25ENB8K7Mo2
         ToFwrD4yzYPkha7+IY+f/BxU226z5DR9mtrIps5RGH7oZ8KkAyD7jUsbayd5J8Q4pSoL
         dL9imESU5OFQQhp8lhudpghJzS0aR4rQwoH9IIfGQtbIZd/GTBWxoxrqBeVj7ptBo9OT
         FbVKR/v7MKbVZlGWsivQ6u92ps8Dz1OxygCD4R1zj+RukQ5NZ6zzaCxj31ZCIJ4YyFMp
         hPRQ==
X-Gm-Message-State: AOAM531XhofOYvcCIiNwHqj+9b2mpgUtC2tc8Mwj6gX98HsFKwc5ENx2
        PiHQwqpI4g3+Cz8IbJvKhlynGETIXvs=
X-Google-Smtp-Source: ABdhPJyaQ/Yr8BxwoLdHJ+xlZ2Ad1qOiIQfN1ivVitmwv5RiA/qZfF3ySeZ9GH+s4zbYCbPHbcHz8g==
X-Received: by 2002:a05:6402:13d9:: with SMTP id a25mr28634494edx.325.1595971447062;
        Tue, 28 Jul 2020 14:24:07 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id x16sm98608edr.52.2020.07.28.14.24.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jul 2020 14:24:06 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id y3so19636241wrl.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 14:24:06 -0700 (PDT)
X-Received: by 2002:a5d:6641:: with SMTP id f1mr26569681wrw.307.1595971445556;
 Tue, 28 Jul 2020 14:24:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
 <20200728151258.1222876-1-campello@chromium.org> <20200728091057.10.Ibe84fae61cd914c116e6d59ffeb644f1cbecd601@changeid>
 <159596523705.1360974.7169089810545711557@swboyd.mtv.corp.google.com>
In-Reply-To: <159596523705.1360974.7169089810545711557@swboyd.mtv.corp.google.com>
From:   Daniel Campello <campello@chromium.org>
Date:   Tue, 28 Jul 2020 15:23:29 -0600
X-Gmail-Original-Message-ID: <CAHcu+VbYrbWStNNaidDygY=d4f6F5tXUxWtsuH0x3oVeELGWVA@mail.gmail.com>
Message-ID: <CAHcu+VbYrbWStNNaidDygY=d4f6F5tXUxWtsuH0x3oVeELGWVA@mail.gmail.com>
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

On Tue, Jul 28, 2020 at 1:40 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Daniel Campello (2020-07-28 08:12:53)
> > @@ -368,13 +368,13 @@ static int sx9310_wait_for_sample(struct sx9310_data *data)
> >  static int sx9310_read_proximity(struct sx9310_data *data,
> >                                  const struct iio_chan_spec *chan, int *val)
> >  {
> > -       int ret = 0;
> > +       int ret;
> >         __be16 rawval;
> >
> >         mutex_lock(&data->mutex);
> >
> >         ret = sx9310_get_read_channel(data, chan->channel);
> > -       if (ret < 0)
> > +       if (ret)
> >                 goto out;
> >
> >         if (data->client->irq) {
> > @@ -394,11 +394,11 @@ static int sx9310_read_proximity(struct sx9310_data *data,
> >
> >         mutex_lock(&data->mutex);
> >
> > -       if (ret < 0)
> > +       if (ret)
> >                 goto out_disable_irq;
>
> Why is this condition checked after grabbing the mutex? Shouldn't it be
> checked before grabbing the mutex? Or is that supposed to be a
> mutex_unlock()?
We acquire the lock before jumping to out_disable_irq which is before
a mutex_unlock()
>
> >
> >         ret = sx9310_read_prox_data(data, chan, &rawval);
> > -       if (ret < 0)
> > +       if (ret)
> >                 goto out_disable_irq;
> >
> >         *val = sign_extend32(be16_to_cpu(rawval),
