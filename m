Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E72C433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57F44214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kMw1t4Fo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389357AbgEMPBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389141AbgEMPB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:01:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A88C061A0C;
        Wed, 13 May 2020 08:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=DmrZcraATTKpezV6Q30kyckoxm8JSVjW6okXPFLe6l8=; b=kMw1t4FoBCZOGmkMPomMQwnW+Z
        Jr+jmw5I+1xdHsW6TD8v0jNvwLNCwTh6c4fDjCBrzI1ZJVnDxOJEgzJfGenUZa6dhVQ9citzzKhtz
        9/ALc0ixW2HXGlPdsA2qd+c95eb36/i7CDRh5vi7s/zsVuhmX0e+5YKH4SvsubEUY6y8j9ZiMqtEO
        k4GGYrre1ohw7DjuF3xw08FidcSJ1s6kPZnAJFuGqTqJ0PUKIutKGA7w/tZZqkNSZ2VxLyZK2eWDk
        QsyJAAg8cMwOyhcnAgar9sw8t+kwwEcspANvFdUN0STxP95t+xj9SeCqxaTzej2NAuQZQGRtqw8JF
        rDFlGqIg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYsss-0007Ms-QN; Wed, 13 May 2020 15:01:22 +0000
Subject: Re: [PATCH 2/3] pinctrl: mchp-sgpio: Add pinctrl driver for Microsemi
 Serial GPIO
List-Id: <soc.lore.kernel.org>
To:     Lars Povlsen <lars.povlsen@microchip.com>,
        SoC Team <soc@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
References: <20200513141134.25819-1-lars.povlsen@microchip.com>
 <20200513141134.25819-3-lars.povlsen@microchip.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fb104436-69c1-3f5a-85d9-af0aee35547f@infradead.org>
Date:   Wed, 13 May 2020 08:01:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513141134.25819-3-lars.povlsen@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/13/20 7:11 AM, Lars Povlsen wrote:
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index 834c59950d1cf..2b0e9021fd7e0 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -396,6 +396,23 @@ config PINCTRL_OCELOT
>  	select OF_GPIO
>  	select REGMAP_MMIO
> 
> +config PINCTRL_MSCC_SGPIO
> +	bool "Pinctrl driver for Microsemi Serial GPIO"
> +	depends on OF
> +	depends on HAS_IOMEM
> +	select GPIOLIB
> +	select GENERIC_PINCONF
> +	select GENERIC_PINCTRL_GROUPS
> +	select GENERIC_PINMUX_FUNCTIONS
> +	select OF_GPIO
> +	help
> +          Support for the VCoreIII SoC serial GPIO device. By using a

Line above should be indented with one tab + 2 spaces...
like the lines below.

> +	  serial interface, the SIO controller significantly extends
> +	  the number of available GPIOs with a minimum number of
> +	  additional pins on the device. The primary purpose of the
> +	  SIO controller is to connect control signals from SFP
> +	  modules and to act as an LED controller.
> +

thanks.
-- 
~Randy

