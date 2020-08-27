Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416F0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134532078A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 06:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598509078;
	bh=5YIDpfZB6MI9rzG942H97ZhO24uA2f81DXB8mKBx5YI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y2oMepTLUIoDsKndXDGRK4x3XPUFeIg1urGWFsjnyOwfdCUBf4zg28X+BbcuthP6N
	 7Y9AeDKHOjIKZ3hiE0LzijL0faqgIlVteoF4JQSc91sTCubthTTkBC6Iw+c8oV+kvq
	 SQJAI+UytGKsnjmiZWHNG34JIt46HUtjvqePK9ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgH0GRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:17:55 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:41993 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgH0GRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 02:17:49 -0400
Received: by mail-ej1-f65.google.com with SMTP id j25so6064004ejk.9;
        Wed, 26 Aug 2020 23:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JZG8HBT8DE1dNj4xlJRchHMwVc5I9x4bxVIe8VtVQDc=;
        b=UXUv+jnTxbHy2LAlYAONTH9CHB1AfEiRsupiLK3RLc8PG/0S3HtrMcEcZ/E34Bu1hO
         jAeOagMCWDI/+cnWvwSOccNtbPFAfRsrbiofgdQ5j98OicG5i4AHv9QIGR5bBSYHteei
         sHrRg3A4U5GPgWBBbb7fLXfmfvAF9hbAkw6cobhHkiDhsP2ED3SL9nUNdPJpUyDMWvHs
         ywbA9mNftSK6CyK1ItrHwy3OCm33w5zgM/rMBV48qjCosNf1pzA2VgmQmqG5/P9qfXAA
         y80Wz6gHIv6BkD/QDFawBk9YuDZcSMTGiKmBXVwUFxvUD2pCusUYOoPKHLw3h2kFmm2c
         9gBQ==
X-Gm-Message-State: AOAM531vwMk2XvBBGm4wdFn3PhYX+abgwA5scyGv0yxTNfr5xDqRnNI1
        /FVaC6NoIyOoZZ7JLfKvj0k=
X-Google-Smtp-Source: ABdhPJwtnm3Q3rP55hJh0omZ1VciZFvqj06f/eN1729A2GVqJHVD8CL1kk2xojDHBSTSUILxlI74Pg==
X-Received: by 2002:a17:906:fcc8:: with SMTP id qx8mr1203962ejb.13.1598509066941;
        Wed, 26 Aug 2020 23:17:46 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id r15sm764343edv.94.2020.08.26.23.17.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Aug 2020 23:17:46 -0700 (PDT)
Date:   Thu, 27 Aug 2020 08:17:44 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Input: gpio_keys - Simplify with dev_err_probe()
Message-ID: <20200827061744.GB3355@kozik-lap>
References: <20200826200827.30931-1-krzk@kernel.org>
 <20200826200827.30931-2-krzk@kernel.org>
 <CAHp75VcgE+HJOKkV6-crzH1w+qOtSKR8=i1Y3ufnhTiAcYV=7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VcgE+HJOKkV6-crzH1w+qOtSKR8=i1Y3ufnhTiAcYV=7A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 12:05:51AM +0300, Andy Shevchenko wrote:
> On Wednesday, August 26, 2020, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> 
> > Common pattern of handling deferred probe can be simplified with
> > dev_err_probe() and devm_fwnode_gpiod_get_optional().   Less code and
> > the error value gets printed.
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> >
> > ---
> >
> > Changes since v1:
> > 1. Use devm_fwnode_gpiod_get_optional
> > ---
> >  drivers/input/keyboard/gpio_keys.c | 21 ++++-----------------
> >  1 file changed, 4 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/input/keyboard/gpio_keys.c
> > b/drivers/input/keyboard/gpio_keys.c
> > index f2d4e4daa818..a07ac6fa25ed 100644
> > --- a/drivers/input/keyboard/gpio_keys.c
> > +++ b/drivers/input/keyboard/gpio_keys.c
> > @@ -494,23 +494,10 @@ static int gpio_keys_setup_key(struct
> > platform_device *pdev,
> >         spin_lock_init(&bdata->lock);
> >
> >         if (child) {
> > -               bdata->gpiod = devm_fwnode_gpiod_get(dev, child,
> > -                                                    NULL, GPIOD_IN, desc);
> > -               if (IS_ERR(bdata->gpiod)) {
> > -                       error = PTR_ERR(bdata->gpiod);
> > -                       if (error == -ENOENT) {
> > -                               /*
> > -                                * GPIO is optional, we may be dealing with
> > -                                * purely interrupt-driven setup.
> > -                                */
> 
> 
> Can we preserve this comment?

Sure.

Best regards,
Krzysztof
