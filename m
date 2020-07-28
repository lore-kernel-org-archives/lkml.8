Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A064C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB422065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iv4onD3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732903AbgG1Tkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732896AbgG1Tkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:40:39 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EF0C0619D4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:40:39 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u185so11559617pfu.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=JnSoXvhnrCfqq1IVWszLYrvihUBdm83Lj44jYdRdMcc=;
        b=iv4onD3Q0axPdhjPEQWHtuqyzI77tyLiN+xmtu+WNHS9v9p/q/rDCJ8iyKFN/gqtxb
         tPgvAIFTgJ2rCYVu0wXWuUe40pCCt/cAMTlQ7haEDHYEJC++ZGQWVET3Bf/wARWgPqN3
         jVE5YRzQGHlUqg+xYBtPJ6PxLXrZ7C23fDmVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=JnSoXvhnrCfqq1IVWszLYrvihUBdm83Lj44jYdRdMcc=;
        b=jFXnsOPVnwUuq9koO1/2jzS/wD/531t8j6K++AmO99TBTq7IyNxAS2G8KOdLqfupi3
         TS+i9oAqhaSU9lwEaKxxrDlsCnM5zSegKIKH5dWPKdT4CT0be2f1mCTrrKlzo+oUX77t
         mIRf7FLWu4ugygLuCfPKLDNoFfy5L5EVI+V5PHUaQOs1JWVUw6CB61vbXhCS99/SmDSa
         PsNrJatffFabpgWs339rfYspKMFmUBGHWZOB4AJYzdmQZLYimNJSywBeFhEbNjuY/XBE
         4NpJw7n74Th8VhLVgODTod3l4oKb2MsdZrpY4vzSvmNiXHD7ME5h8iFdqTLuMCGPY4V/
         v1lQ==
X-Gm-Message-State: AOAM532mf8RBZYtKvn6Mhdoeuyxl7iuEQ1IHgdt+bGclAnpSa941UMlO
        3LTIhwr2igbCn/6osVQUpFKABQ==
X-Google-Smtp-Source: ABdhPJwdqO+peLZuIrIf2EXNYz9eMWKLPKmq06FaQ4DBBzeI8IjM+GcWNrZ8R37eE4hwpm1iVcMfRg==
X-Received: by 2002:a63:d446:: with SMTP id i6mr24699884pgj.438.1595965238995;
        Tue, 28 Jul 2020 12:40:38 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id u23sm18952725pgn.26.2020.07.28.12.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:40:38 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728091057.10.Ibe84fae61cd914c116e6d59ffeb644f1cbecd601@changeid>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid> <20200728151258.1222876-1-campello@chromium.org> <20200728091057.10.Ibe84fae61cd914c116e6d59ffeb644f1cbecd601@changeid>
Subject: Re: [PATCH 10/15] iio: sx9310: Simplify error return handling
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jul 2020 12:40:37 -0700
Message-ID: <159596523705.1360974.7169089810545711557@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Campello (2020-07-28 08:12:53)
> @@ -368,13 +368,13 @@ static int sx9310_wait_for_sample(struct sx9310_dat=
a *data)
>  static int sx9310_read_proximity(struct sx9310_data *data,
>                                  const struct iio_chan_spec *chan, int *v=
al)
>  {
> -       int ret =3D 0;
> +       int ret;
>         __be16 rawval;
> =20
>         mutex_lock(&data->mutex);
> =20
>         ret =3D sx9310_get_read_channel(data, chan->channel);
> -       if (ret < 0)
> +       if (ret)
>                 goto out;
> =20
>         if (data->client->irq) {
> @@ -394,11 +394,11 @@ static int sx9310_read_proximity(struct sx9310_data=
 *data,
> =20
>         mutex_lock(&data->mutex);
> =20
> -       if (ret < 0)
> +       if (ret)
>                 goto out_disable_irq;

Why is this condition checked after grabbing the mutex? Shouldn't it be
checked before grabbing the mutex? Or is that supposed to be a
mutex_unlock()?

> =20
>         ret =3D sx9310_read_prox_data(data, chan, &rawval);
> -       if (ret < 0)
> +       if (ret)
>                 goto out_disable_irq;
> =20
>         *val =3D sign_extend32(be16_to_cpu(rawval),
