Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7488BC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AFE82080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="woLsoFo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgAMKwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:52:45 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51173 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgAMKwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:52:44 -0500
Received: by mail-wm1-f67.google.com with SMTP id a5so9111719wmb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 02:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZgZbNBWe0oTcqdIBNdNvd74B3ro0WVKyi3/VTdqw3xE=;
        b=woLsoFo8w6H55+I2zLR2KHGqFepzum+orJMMrLzKCgk1ZJK212giD75NsNz8DNfjlP
         vodvnf5v+e7GXZsYfps9azChJyoplTYXHzTXHM6oJ8gDA7ltgi33YYzABGb6l8CIE9c5
         hMv3K6ZPvkOFnsDgXeVZqXsNofOaN8AiM2PHq7+IHOIDZdKR7nbPDShmz6x3+Mf3CWix
         bYGxSqk6ZFO9B7Icj1OsAaDdjqD8AaCjk+XeSlKSNfEIGojIYHc/p9hLrJ9fOIcRGaJF
         i8L4nWE354nw10ZeJTDo5wwrjCjl7fJ905rU03Czk/VeCDLFgkEzPkWz1mCBWhND4DST
         82BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZgZbNBWe0oTcqdIBNdNvd74B3ro0WVKyi3/VTdqw3xE=;
        b=Ui3k/cNeyZW0c8vZjnQwMMQX82wNTIF48ZE/AQiyMPt5P1xm28zUqBRjBhLBT7uF5b
         l6lywpdvuBv72QfzQhGq6Hr3locBtN6IjNvbH4mcTuEr9CmHv1u+uT4iuDkhTYvWvx5P
         C3c4KonZOX5wwfCKqpCzmw++0pgvguIBPLfSDY5RB+uMClyklxNrfMqhrVq1ATpwNJLu
         McF6bLjc2IqYZ0FQQQ1lEhSOpmv6/FrFOrEj5Wyjk87RGuzepP6K86zPsUF+uT7kKPgj
         6a/4Vz3EVsDob4W4lhsSghho3S7KVy9J1AtbC6h3ctV5A5kLo53W1KTKRFgQ/mEO7XNb
         iHEg==
X-Gm-Message-State: APjAAAXhSg3BsrEzgd5M5nDIa7kMijlLoAVAaXRtf7y6AdQzuEQVikky
        vVZnFLSZaYYLFNQK+yfI7ORJYg==
X-Google-Smtp-Source: APXvYqx8Vm7CK6+Z+RiNNpP0t0i/mmfam2P7FFBzWOE/l3fKY62yfP75eVxj2Ys8ub0l0x8bGFfDQQ==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr19619532wmg.110.1578912761970;
        Mon, 13 Jan 2020 02:52:41 -0800 (PST)
Received: from dell ([95.147.198.95])
        by smtp.gmail.com with ESMTPSA id x14sm13574924wmj.42.2020.01.13.02.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 02:52:41 -0800 (PST)
Date:   Mon, 13 Jan 2020 10:53:01 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "jacek.anaszewski@gmail.com" <jacek.anaszewski@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH v8 08/12] regulator: bd718x7: Split driver to common and
 bd718x7 specific parts
Message-ID: <20200113105301.GF5414@dell>
References: <cover.1577694311.git.matti.vaittinen@fi.rohmeurope.com>
 <d247d71e183b388dd7f211aee1235965cff979b4.1577694311.git.matti.vaittinen@fi.rohmeurope.com>
 <20200107124124.GI14821@dell>
 <32f8fa4201ae99df64e7a39c6a69be2bef179f7b.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32f8fa4201ae99df64e7a39c6a69be2bef179f7b.camel@fi.rohmeurope.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Jan 2020, Vaittinen, Matti wrote:

> Hello Lee,
> 
> On Tue, 2020-01-07 at 12:41 +0000, Lee Jones wrote:
> > On Mon, 30 Dec 2019, Matti Vaittinen wrote:
> > 
> > > Few ROHM PMICs allow setting the voltage states for different
> > > system states
> > > like RUN, IDLE, SUSPEND and LPSR. States are then changed via SoC
> > > specific
> > > mechanisms. bd718x7 driver implemented device-tree parsing
> > > functions for
> > > these state specific voltages. The parsing functions can be re-used 
> > > by
> > > other ROHM chip drivers like bd71828. Split the generic functions
> > > from
> > > bd718x7-regulator.c to rohm-regulator.c and export them for other
> > > modules
> > > to use.
> > > 
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > Acked-by: Mark Brown <broonie@kernel.org>
> > > ---

[...]

> > > +#if IS_ENABLED(CONFIG_REGULATOR_ROHM)
> > > +int rohm_regulator_set_dvs_levels(const struct rohm_dvs_config
> > > *dvs,
> > > +				  struct device_node *np,
> > > +				  const struct regulator_desc *desc,
> > > +				  struct regmap *regmap);
> > 
> > Does these really need to live in the parent's header file?
> 
> I don't know what would be a better place?

You don't have a regulator header file?

It seems over-kill to create one for this, so leave it as is.

> > What other call-sites are there?
> 
> After this series the bd718x7-regulator.c and bd71828-regulator.c are
> the in-tree drivers using these. rohm-regulator.c is implementing them.
> And I hope we see yet another driver landing in later this year. 
> 
> Anyways, I will investigate if I can switch this to some common (not
> rohm specific) DT bindings at some point (I've scheduled this study to
> March) - If I can then they should live in regulator core headers.
> 
> But changing the existing properties should again be own set of patches
> and I'd prefer doing that work independently of this series and not
> delaying the BD71828 due to not-yet-evaluated bd718x7 property changes.

That's fine.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
