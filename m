Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052FAC33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFA7E2072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 10:21:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cd4EHkuZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgAQKVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 05:21:14 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37507 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgAQKVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 05:21:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so22180949wru.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 02:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mZtLP4TF2DQa4kM6aWD8dXahaAIco0BNSoaIocAnb5A=;
        b=Cd4EHkuZG/hB65hooW72qjpibWL8vCibrANu3y0wxb4ne8tJYxzzGXhWRsSr14VVgW
         s47dP0HN/s6CpLzXIT/H4sWazukfC5WmPNB8s6Nbi+/mP9EtUcflQ/m0BcUQ+y0lmZWJ
         2lndVQ0FbWMHCpjYO/LJxfxwpDDCEACulCfnDNHg+aCD86QuJlAqSBJN0MlBnIIcStnR
         gubRP0kOgxTKVOzdfEq8OuT7LoaeMmYPl/cl7Sy1ndbwDEXuwaLAix2Z9ezMc+VxYaNq
         uznP5Fd5AdP74eKcYYQglPaI8TUTHPm4ufdRVW5heAmr8vvabPtIfCsxMhWEJ31KnnYv
         6AHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mZtLP4TF2DQa4kM6aWD8dXahaAIco0BNSoaIocAnb5A=;
        b=Qm+2Lhnzyu93+0mCNTStYoyU28aJEhhoW/eWOpn6a41w2Pnv4PGTXJkt3pUUc16rIs
         vS6U62RwWzOhIfCZY0llbwbNVDyneDysfV38UtO4u11ASaLh6kebTDdQISCoe28gQ8hK
         oyOXlO2sOmd7pPvxTl5QjXibXy6Dy4BclvKpDk/BtrQhLRctnU2YS5GzXU4OIfRy3lST
         q0/dUAXC+wOkm4ll41RgchzLFT58xAV0npM3onxb3n0JNy9Qt/k4HRQ/MTOgA1hV0y/1
         B3tmAFNAL3cCg88spHOIwIKY4Rh5LIV9Qp4z4Momq5yHBqhslL/cjkxBzXqMlNsV5mur
         gZbQ==
X-Gm-Message-State: APjAAAV5xDEWNk9B78XMyJadz6sejHfwu0lp1xmp8tLX7ekTVyOWcmiz
        Pro/IBDNxOfMnJvIVsh7G65c9VJ+3go=
X-Google-Smtp-Source: APXvYqyVa2FGtDblyP5Np3GyAl5Q+tTxMbe2sQTuTQwaCp7lmF6Cq26++iwlzp5gif2p7MajB+J13A==
X-Received: by 2002:adf:e290:: with SMTP id v16mr2368769wri.16.1579256471100;
        Fri, 17 Jan 2020 02:21:11 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id t5sm32760070wrr.35.2020.01.17.02.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 02:21:10 -0800 (PST)
Date:   Fri, 17 Jan 2020 10:21:27 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v10 11/13] gpio: bd71828: Initial support for ROHM
 BD71828 PMIC GPIOs
Message-ID: <20200117102127.GD15507@dell>
References: <cover.1579249511.git.matti.vaittinen@fi.rohmeurope.com>
 <c8ed62a1efa0c6fde93a8a08fe6bc74a450a34f3.1579249511.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8ed62a1efa0c6fde93a8a08fe6bc74a450a34f3.1579249511.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020, Matti Vaittinen wrote:

> ROHM BD71828 PMIC contains 4 pins which can be configured by OTP
> to be used for general purposes. First 3 can be used as outputs
> and 4.th pin can be used as input. Allow them to be controlled
> via GPIO framework.
> 
> The driver assumes all of the pins are configured as GPIOs and
> trusts that the reserved pins in other OTP configurations are
> excluded from control using "gpio-reserved-ranges" device tree
> property (or left untouched by GPIO users).
> 
> Typical use for 4.th pin (input) is to use it as HALL sensor
> input so that this pin state is toggled when HALL sensor detects
> LID position change (from close to open or open to close). PMIC
> HW implements some extra logic which allows PMIC to power-up the
> system when this pin is toggled. Please see the data sheet for
> details of GPIO options which can be selected by OTP settings.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Linus, Is that an Ack?

> ---
> no changes since v9
> 
>  drivers/gpio/Kconfig        |  12 +++
>  drivers/gpio/Makefile       |   1 +
>  drivers/gpio/gpio-bd71828.c | 159 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 172 insertions(+)
>  create mode 100644 drivers/gpio/gpio-bd71828.c

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
