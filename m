Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC18C433E8
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC9C122B49
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFzP6Xcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgG1HZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgG1HZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:25:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1A5C0619D4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 00:25:08 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r4so14249642wrx.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 00:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CVyOqzD82VIbTbSOwbuQWHWMh9I7YtQWOzBVoRyLodQ=;
        b=fFzP6XcpfIKbOqzLN633RcbKQaEYrqDx9NZIAyxMRbtlvCHmfNFzaoyDqDAftrQzkq
         7zm75Ps4/6uVSjbVFQ80njWz+F/t/LLUoLR0b8RTj8V6q4VQDsHQBM5QxnN3ixSinjov
         XwB5Rm2vIQNVv+7KI7v6z5cdRmBPkwtVqRvYJGR0iIJu4rS0v84NtrU4CAo/wHJgiIyQ
         ijRUbBfxZ9y79NR6JT9OJHgT2j+ZdyBt92llChHlXmpBlmgDj0hm2zK2zOwWYvK/pjik
         D3ZbDDUJE5x1ODeYJqipPGA5Zfzu1pQhsTSPDUfe+UV5a5lMt+IiisIdMqOgQx+49ThV
         1pIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CVyOqzD82VIbTbSOwbuQWHWMh9I7YtQWOzBVoRyLodQ=;
        b=Qv6nvSPIrvv9rg8KXDdyPgs/nnkZjtLujW2UMI2n7I/Xdde6IAcOaELxbtZgXhaP/R
         YYAjNJmW2ykBod7VPTlq/DF33W20R+zr7PPPtEN8nOyWsUwdYHCpg+zjX0PB784iJn5F
         UPkWD3vx9gvLHRjiz4Nq0D8B6xXkUFtjNNFc8RmeBSYEgSa6kLzyj1Vzn60baMfUWBZA
         E9MLj6PIXkwQOwL+Q0kplk6kQPDHweNsl171O/mqv/qbR+Wwb17dKIZVpNYzuKyC9frw
         tYyLFhkPtiKx171U3dq6kguAu2aoZ0/p96volES9Xn/sQPGgYKR6Vdr0jhPPw60FgTk5
         vfcA==
X-Gm-Message-State: AOAM531e7WhChqWIrVg1GJMVVtKTfZP7VSMP5KTU22mJKBtPyXqJsrkm
        GNRlUMaPGtgwGu816O4FXnjxQg==
X-Google-Smtp-Source: ABdhPJz1YpTqlbDUFXDsWyUGZXPtHayhFsSxxtFIDbZ7aMjyWiFvHpMffWGAyH6vvBmAU2ji9WSF0w==
X-Received: by 2002:a5d:6990:: with SMTP id g16mr23041965wru.131.1595921106735;
        Tue, 28 Jul 2020 00:25:06 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id k126sm2849116wme.17.2020.07.28.00.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 00:25:06 -0700 (PDT)
Date:   Tue, 28 Jul 2020 08:25:04 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v6 03/13] mfd: simple-mfd-i2c: add sl28cpld support
Message-ID: <20200728072504.GG1850026@dell>
References: <20200725231834.25642-1-michael@walle.cc>
 <20200725231834.25642-4-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200725231834.25642-4-michael@walle.cc>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jul 2020, Michael Walle wrote:

> Add the core support for the board management controller found on the
> SMARC-sAL28 board.
> 
> At the moment, this controller is used on the Kontron SMARC-sAL28 board.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
> Changes since v5:
>  - none
> 
> Changes since v4:
>  - new patch
> 
>  drivers/mfd/simple-mfd-i2c.c | 1 +
>  1 file changed, 1 insertion(+)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
