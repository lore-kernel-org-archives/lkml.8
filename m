Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40945C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2F0C2145D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 09:26:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MLtuElp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgIIJ0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 05:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgIIJ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:26:13 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BE9C061755
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 02:26:12 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gr14so2569742ejb.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 02:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6DZDXW2YGItYWu3dtFgHpQyQnbLb2FyzRV1Tm+8JvY=;
        b=MLtuElp1YLqmIO7OwQ6l20NeACyG2PIdqREORO+akPvUrIJCNfv+jHg31uTBSo7tvY
         CWEcZxrZOG/vFPhcUp88soN0nhZBwCZS/ZxqylYK2NDagz4mQaUufqceBiMtj5lUOCYC
         hJBvGSk25zG56nS6GkLDsmc/oLxglNmKYqU29+p9CcUCnB/CunbqRkprARZw+gg/67zV
         CAiaQ3H/+18KUUyU5U5TSqVDidt4eCNkNnnDRe4WPtvtlQFi0i/XED+LXl3xyO4HW7Vf
         jp7VUZSBHJvvk0b7RYSAEd99Pq8U03/mtiK3fVP1LH4DnerRYFX89OZBSf+VE2dNMbde
         o27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6DZDXW2YGItYWu3dtFgHpQyQnbLb2FyzRV1Tm+8JvY=;
        b=kl1fV6vhaBMTVh/aGrO2qqk9j3REtaUMhYQxZmXu6Rmy4/vL5NNFPXK8VBj+1jLi3T
         b70aEjPndXzeuoghIyn8nyjKWEiUQ3NRfh7DzfjpPgLKBabx57iIqh5SVnp8iVxuCOf9
         WzC1Lb6oRmIRw8K4OHnU1wQMAKhENtOe9sG6m01jPYStQE3+hm/31DprrbJysYcyw6DT
         Ag0jeM5b3rX4C3aBD2jJK6ZeYElni7hFpFvIvh7GnPRvPbOsTqtcr93fBB6M1NwuEuW5
         VQvjr9Izb8sNCq1QdFk4mtiAN03lUVMrz6n3WSRYziIuFpFz7yE5O+vEgamAWD76FbXe
         +/LQ==
X-Gm-Message-State: AOAM533UhikZqlZYdUmE2B3LzwM5o18xxrf+dswy58TaLSd2gkdRVajz
        w07nXsYOn9E/PSep3vuX3VjuQk4N+Gms8F4CBH/I9A==
X-Google-Smtp-Source: ABdhPJwnH/OaaOXRFuOx08+jmJH/w+WnKzlsJruGsmUcYnh6fd9B+IgiKxG2Pi4LXbnAZHCO/70tnv307RgxU8Bvfw0=
X-Received: by 2002:a17:906:c1c3:: with SMTP id bw3mr2653214ejb.516.1599643571188;
 Wed, 09 Sep 2020 02:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200905133549.24606-1-warthog618@gmail.com> <20200905133549.24606-8-warthog618@gmail.com>
 <20200909092401.GA1431678@sol>
In-Reply-To: <20200909092401.GA1431678@sol>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 9 Sep 2020 11:26:00 +0200
Message-ID: <CAMpxmJXh9pKMAXgPWSCPXeyjP0CSo=A5SgLPrL2eRxX-LAyKag@mail.gmail.com>
Subject: Re: [PATCH v7 07/20] gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL
 and GPIO_V2_LINE_GET_VALUES_IOCTL
To:     Kent Gibson <warthog618@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 11:24 AM Kent Gibson <warthog618@gmail.com> wrote:
>
> On Sat, Sep 05, 2020 at 09:35:36PM +0800, Kent Gibson wrote:
> > Add support for requesting lines using the GPIO_V2_GET_LINE_IOCTL, and
> > returning their current values using GPIO_V2_LINE_GET_VALUES_IOCTL.
> >
> > The struct linereq implementation is based on the v1 struct linehandle
> > implementation.
> >
> > Signed-off-by: Kent Gibson <warthog618@gmail.com>
> > ---
> >
>
> [snip]
>
> >               if (copy_from_user(&offset, ip, sizeof(offset)))
> >                       return -EFAULT;
> > @@ -1104,6 +1505,25 @@ int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
> >                MAJOR(devt), gdev->id);
> >
> >       return 0;
> > +     /*
> > +      * array sizes must ensure 64-bit alignment and not create holes in
> > +      * the struct packing.
> > +      */
> > +     BUILD_BUG_ON(IS_ALIGNED(GPIO_V2_LINES_MAX, 2));
> > +     BUILD_BUG_ON(IS_ALIGNED(GPIO_MAX_NAME_SIZE, 8));
> > +
> > +     /*
> > +      * check that uAPI structs are 64-bit aligned for 32/64-bit
> > +      * compatibility
> > +      */
> > +     BUILD_BUG_ON(IS_ALIGNED(sizeof(struct gpio_v2_line_attribute), 8));
> > +     BUILD_BUG_ON(IS_ALIGNED(sizeof(struct gpio_v2_line_config_attribute), 8));
> > +     BUILD_BUG_ON(IS_ALIGNED(sizeof(struct gpio_v2_line_config), 8));
> > +     BUILD_BUG_ON(IS_ALIGNED(sizeof(struct gpio_v2_line_request), 8));
> > +     BUILD_BUG_ON(IS_ALIGNED(sizeof(struct gpio_v2_line_info), 8));
> > +     BUILD_BUG_ON(IS_ALIGNED(sizeof(struct gpio_v2_line_info_changed), 8));
> > +     BUILD_BUG_ON(IS_ALIGNED(sizeof(struct gpio_v2_line_event), 8));
> > +     BUILD_BUG_ON(IS_ALIGNED(sizeof(struct gpio_v2_line_values), 8));
> >  }
> >
>
> A couple of things here - these should all be !IS_ALIGNED.
> And the BUILD_BUG_ON gets compiled out, and so doesn't fail, if they are
> after the return.
>
> How would you like that fixed - v8 or a patch once v7 is in?
>
> Cheers,
> Kent.

v8 please. Why is it compiled out though? Does it need some config option?

Bart
