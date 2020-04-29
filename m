Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D651C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 073DA21BE5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQS7n5nu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgD2MWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726676AbgD2MWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:22:21 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF90BC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:22:20 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y4so2359080ljn.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 05:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=At5ArdEmNIKZnLbAQqmTh2Ohaa/8dGvC7QareFwEvY8=;
        b=MQS7n5nuZTWdcxXIV56plb9rF9f9lngEzjbv7WBiph/u9R2qkYx1KF8S/g2cSwvu3M
         B1nfcxz4/AlJWpMA5qTadMjqffbfz+Bxf3wDWQI0w9HvczmgFRyaf/qchZWmoMSHOozQ
         ixF+dOQmdcUgICh15t1g4qQ+kCFbdgR0VUuZXUj6vbrAfD3Lot9Fd68x5HA+WSSGfGlR
         1V/3K0pyTixPGvePUXT1RbEUowyDiT+VFIKnvBmriwNYyfr5sLXfQYNLQahgyiRI7b3W
         c9jAyCenWXVZ+0dSZ4GG7YlHS9nkOP2NJZS35BOF6ZmX2CFGTMb5h+hzhvQlJD2AK5Fi
         dVgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=At5ArdEmNIKZnLbAQqmTh2Ohaa/8dGvC7QareFwEvY8=;
        b=BD+q2kAUXUWzSm2fXXCCmsz+UVQiAhgdDSxcI3WaWIahJm00DrbggoOcAai6mInyTQ
         hT0aKuikgvEya0bcmi0IgszJq0wzsvuVmpOWUO5AeOSxV0M9LLJWUsmPP1HRG2Q81yQ6
         vRqaU0DkEgCDSAkJoyfmeeBo6Q7aPdV7BDuOaSGV9RR6ML4kNMtQLI0j4ZwagM+vDjJ+
         8L4FAtk7qR/DvgfAT4pGn9AFyPxYPW5dIzN6APLgtmT0ktDhtAbu/Mo732GY8EyNX2jZ
         L26t4kyNJuxkTpT5/XLGYabE3YvuPWxZ0yuaZrzMdcj93W5bmeOa2RaMbfUdgnNP0hjz
         pa7Q==
X-Gm-Message-State: AGi0PuabOpfjh/sI9OcAPBKK+rJJxznMB12+ps6wF3MGYXs8FP8tXjJD
        tHXzHUMSWaJFxmukzz2e0YIQg6j1SZ4rNFky/wUX0Q==
X-Google-Smtp-Source: APiQypIczOCMTP+eucvr3s4LVVfkVX9Na79HgVpaZC6m5PHomFMH3wc8ZCLx1Mc8QyfmmC2U1yOL1Hu7gzWAaAaX/gE=
X-Received: by 2002:a2e:8087:: with SMTP id i7mr19238440ljg.99.1588162939136;
 Wed, 29 Apr 2020 05:22:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200428213035.3108649-1-arnd@arndb.de>
In-Reply-To: <20200428213035.3108649-1-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 29 Apr 2020 14:22:08 +0200
Message-ID: <CACRpkdbfWvgDXEcsubYcEZ9hV+2xxK48fK06-OVJ-hcFUDgouA@mail.gmail.com>
Subject: Re: [PATCH] HID: mcp2221: add gpiolib dependency
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Rishi Gupta <gupt21@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
        Bastien Nocera <bnocera@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux Input <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 11:30 PM Arnd Bergmann <arnd@arndb.de> wrote:

> Without gpiolib, this driver fails to link:
>
> arm-linux-gnueabi-ld: drivers/hid/hid-mcp2221.o: in function `mcp2221_probe':
> hid-mcp2221.c:(.text+0x1b0): undefined reference to `devm_gpiochip_add_data'
> arm-linux-gnueabi-ld: drivers/hid/hid-mcp2221.o: in function `mcp_gpio_get':
> hid-mcp2221.c:(.text+0x30c): undefined reference to `gpiochip_get_data'
>
> Fixes: 328de1c519c5 ("HID: mcp2221: add GPIO functionality support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

>  config HID_MCP2221
>         tristate "Microchip MCP2221 HID USB-to-I2C/SMbus host support"
>         depends on USB_HID && I2C
> +       depends on GPIOLIB

These days we can even do select GPIOLIB, but I suppose
that would make the driver selectable on platforms with no
native GPIO support at all (like UM) so I suppose this
is better.

Yours,
Linus Walleij
