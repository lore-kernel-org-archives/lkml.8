Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A784C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C8BB2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 15:22:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ftnj5nzs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgGPPWL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 11:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728911AbgGPPWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 11:22:10 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89461C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 08:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=tMW+FSjHDJDd5sV7mMP8PFIFsHf/Bo6cCti4h2al50Y=; b=Ftnj5nzs4K7ODC7QCGM0rkVVkN
        wcbHZpBzkKKlK/7BMXiwAGjl1hT1Vy0e99SZxNHhZEkcDDk4iVgf/pGy4H+GQ5C+mzMWwFcZmEdCV
        I8xR9z12UhzHMB5j4b5LUTL9cr4BENvkCxiTv8k+pR703OrGzmwNE5LQ7xA0cJ/haNnhULehsKl39
        /2xsYix8hmiW2htwfu5p3jcGk/JurDBWh3r7YwesHFfjSO0qk/6/jQaYrKZXuY6S5ji2MEFOwS0Kv
        0aThAb4icQMHfk98+G1LXtWO5KH8qITNS6jrDfi/wNlZb41JVcLAE3b3S1BROzMboDvWjS5jTWJg9
        F3kd+zDw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jw5i1-0007Za-5R; Thu, 16 Jul 2020 15:22:05 +0000
Subject: Re: [PATCH] phy: sun4i-usb: explicitly include gpio/consumer.h
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-kernel@lists.infradead.org
References: <20200716062427.71763-1-vkoul@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7d4fa99a-627b-67bb-33d6-85655deb15a5@infradead.org>
Date:   Thu, 16 Jul 2020 08:22:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200716062427.71763-1-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/20 11:24 PM, Vinod Koul wrote:
> Driver uses GPIO functions but doesn't include the header explcitly. Add
> that to fix build errors when GPIOLIB is disabled.
> 
> drivers/phy/allwinner/phy-sun4i-usb.c:367:11: error: implicit
> declaration of function ‘gpiod_get_value_cansleep’; did you mean
> ‘gpio_get_value_cansleep’? [-Werror=implicit-function-declaration]
> drivers/phy/allwinner/phy-sun4i-usb.c:707:22: error: implicit
> declaration of function ‘devm_gpiod_get_optional’; did you mean
> ‘devm_clk_get_optional’? [-Werror=implicit-function-declaration]
> drivers/phy/allwinner/phy-sun4i-usb.c:708:11: error: ‘GPIOD_IN’
> undeclared (first use in this function); did you mean ‘GPIOF_IN’?
> drivers/phy/allwinner/phy-sun4i-usb.c:815:21: error: implicit
> declaration of function ‘gpiod_to_irq’; did you mean ‘gpio_to_irq’?
> [-Werror=implicit-function-declaration]
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Vinod Koul <vkoul@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/phy/allwinner/phy-sun4i-usb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
> index 7e09ad6a0b42..585d0a59e712 100644
> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> @@ -16,6 +16,7 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/extcon-provider.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/io.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> 


-- 
~Randy
