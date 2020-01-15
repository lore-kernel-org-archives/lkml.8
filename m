Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B008C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB6FB207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 13:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xwaRsKFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgAONon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 08:44:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50491 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgAONom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 08:44:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so17963079wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 05:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DcJHzfmLyfO+PXyoEt3igYkw68sITV8r5Sdb5sGh2E8=;
        b=xwaRsKFS7Fes0IEXTp1vjMIJjE/rVO9RFvA0q8WfltMr3ulVKI5K4sU8zbq828Fl4G
         62Da4hzYlCgmkJ12Ji5aCjcI1TSdqTBiTAz68tw4thmXj61gE5maaMw6JtI9yHM2PNa4
         Lr6KcSf5rUqcmGM113iOREIuS2CwDWY1Uwyjo1jdM57db/y0QL9I5Hi70cue7hmM2zwY
         CIFT0snU/6QwNWJhTYVK4489biPbTrLixu+Z5ALSXO6jodbfqXdsex3PRkK7uMQ6dvAq
         3tUA9YSUDu7qoYElRHVVflicj4+iJaN8iv+s5xf3GBO22t4MBqa6YvzNVJQhDbikZgu+
         QW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=DcJHzfmLyfO+PXyoEt3igYkw68sITV8r5Sdb5sGh2E8=;
        b=HeIz0adVhjSnSSP4QNGS4EmGO20ENwz4uq4prch02hsSXGvQ5UmybUOU8jPS91mcbg
         ISEwg4kZj/fu4AS9tCeqwSqJt60z5ZeBj+m7PpuVWqufviun/MmJe/qQb2GBbQvKAFlf
         erdUXB+mpTCUKm7duyo8Vnutjn53uy1knD8m6+FG4PZ+rEl3He5sSGVzgvOsH6WAkyEx
         WzWXrS9wkYa1g0NIb+dAZvbLteK+o6+NzbX+AnisBs1fhnnBN9VRk34Fo/BzXBaxtnD9
         +DSPNB8KP+i4Xk7RB8GfytwS0a9zNCOpGiDTSe5aTfmZowtRqJGQmel7nNT9vMV8xZS1
         Ljew==
X-Gm-Message-State: APjAAAWmWqHYT7pLmOORoFnG6ie/nHV+eYanGav/qm1MJndJQOxbr+js
        LxXXzote7ISQcqj0/8qrOcnw0G6bjLylZg==
X-Google-Smtp-Source: APXvYqxWF07joDJbpX7sXA0uags5zKILhMQYR8bGICsr7vlkrQkxjwK531F0AzULsyG3YGp2s8UrwA==
X-Received: by 2002:a05:600c:2290:: with SMTP id 16mr35303062wmf.93.1579095879164;
        Wed, 15 Jan 2020 05:44:39 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:ac8b:fcee:b80:ebae? ([2a01:e34:ed2f:f020:ac8b:fcee:b80:ebae])
        by smtp.googlemail.com with ESMTPSA id e6sm25714241wru.44.2020.01.15.05.44.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 05:44:38 -0800 (PST)
Subject: Re: [PATCH v3] clocksource: Add driver for the Ingenic JZ47xx OST
To:     Paul Cercueil <paul@crapouillou.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     od@zcrc.me, linux-kernel@vger.kernel.org,
        Maarten ter Huurne <maarten@treewalker.org>,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
References: <20200114150619.14611-1-paul@crapouillou.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 xsFNBFv/yykBEADDdW8RZu7iZILSf3zxq5y8YdaeyZjI/MaqgnvG/c3WjFaunoTMspeusiFE
 sXvtg3ehTOoyD0oFjKkHaia1Zpa1m/gnNdT/WvTveLfGA1gH+yGes2Sr53Ht8hWYZFYMZc8V
 2pbSKh8wepq4g8r5YI1XUy9YbcTdj5mVrTklyGWA49NOeJz2QbfytMT3DJmk40LqwK6CCSU0
 9Ed8n0a+vevmQoRZJEd3Y1qXn2XHys0F6OHCC+VLENqNNZXdZE9E+b3FFW0lk49oLTzLRNIq
 0wHeR1H54RffhLQAor2+4kSSu8mW5qB0n5Eb/zXJZZ/bRiXmT8kNg85UdYhvf03ZAsp3qxcr
 xMfMsC7m3+ADOtW90rNNLZnRvjhsYNrGIKH8Ub0UKXFXibHbafSuq7RqyRQzt01Ud8CAtq+w
 P9EftUysLtovGpLSpGDO5zQ++4ZGVygdYFr318aGDqCljKAKZ9hYgRimPBToDedho1S1uE6F
 6YiBFnI3ry9+/KUnEP6L8Sfezwy7fp2JUNkUr41QF76nz43tl7oersrLxHzj2dYfWUAZWXva
 wW4IKF5sOPFMMgxoOJovSWqwh1b7hqI+nDlD3mmVMd20VyE9W7AgTIsvDxWUnMPvww5iExlY
 eIC0Wj9K4UqSYBOHcUPrVOKTcsBVPQA6SAMJlt82/v5l4J0pSQARAQABzSpEYW5pZWwgTGV6
 Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGluYXJvLm9yZz7Cwa4EEwEIAEECGwEFCwkIBwIGFQoJ
 CAsCBBYCAwECHgECF4ACGQEWIQQk1ibyU76eh+bOW/SP9LjScWdVJwUCXAkeagUJDRnjhwAh
 CRCP9LjScWdVJxYhBCTWJvJTvp6H5s5b9I/0uNJxZ1Un69gQAJK0ODuKzYl0TvHPU8W7uOeu
 U7OghN/DTkG6uAkyqW+iIVi320R5QyXN1Tb6vRx6+yZ6mpJRW5S9fO03wcD8Sna9xyZacJfO
 UTnpfUArs9FF1pB3VIr95WwlVoptBOuKLTCNuzoBTW6jQt0sg0uPDAi2dDzf+21t/UuF7I3z
 KSeVyHuOfofonYD85FkQJN8lsbh5xWvsASbgD8bmfI87gEbt0wq2ND5yuX+lJK7FX4lMO6gR
 ZQ75g4KWDprOO/w6ebRxDjrH0lG1qHBiZd0hcPo2wkeYwb1sqZUjQjujlDhcvnZfpDGR4yLz
 5WG+pdciQhl6LNl7lctNhS8Uct17HNdfN7QvAumYw5sUuJ+POIlCws/aVbA5+DpmIfzPx5Ak
 UHxthNIyqZ9O6UHrVg7SaF3rvqrXtjtnu7eZ3cIsfuuHrXBTWDsVwub2nm1ddZZoC530BraS
 d7Y7eyKs7T4mGwpsi3Pd33Je5aC/rDeF44gXRv3UnKtjq2PPjaG/KPG0fLBGvhx0ARBrZLsd
 5CTDjwFA4bo+pD13cVhTfim3dYUnX1UDmqoCISOpzg3S4+QLv1bfbIsZ3KDQQR7y/RSGzcLE
 z164aDfuSvl+6Myb5qQy1HUQ0hOj5Qh+CzF3CMEPmU1v9Qah1ThC8+KkH/HHjPPulLn7aMaK
 Z8t6h7uaAYnGzjMEXZLIEhYJKwYBBAHaRw8BAQdAGdRDglTydmxI03SYiVg95SoLOKT5zZW1
 7Kpt/5zcvt3CwhsEGAEIACAWIQQk1ibyU76eh+bOW/SP9LjScWdVJwUCXZLIEgIbAgCvCRCP
 9LjScWdVJ40gBBkWCAAdFiEEbinX+DPdhovb6oob3uarTi9/eqYFAl2SyBIAIQkQ3uarTi9/
 eqYWIQRuKdf4M92Gi9vqihve5qtOL396pnZGAP0c3VRaj3RBEOUGKxHzcu17ZUnIoJLjpHdk
 NfBnWU9+UgD/bwTxE56Wd8kQZ2e2UTy4BM8907FsJgAQLL4tD2YZggwWIQQk1ibyU76eh+bO
 W/SP9LjScWdVJ5CaD/0YQyfUzjpR1GnCSkbaLYTEUsyaHuWPI/uSpKTtcbttpYv+QmYsIwD9
 8CeH3zwY0Xl/1fE9Hy59z6Vxv9YVapLx0nPDOA1zDVNq2MnutxHb8t+Imjz4ERCxysqtfYrv
 gao3E/h0c8SEeh+bh5MkjwmU8CwZ3doWyiVdULKESe7/Gs5OuhFzaDVPCpWdsKdCAGyUuP/+
 qRWwKGVpWP0Rrt6MTK24Ibeu3xEZO8c3XOEXH5d9nf6YRqBEIizAecoCr00E9c+6BlRS0AqR
 OQC3/Mm7rWtco3+WOridqVXkko9AcZ8AiM5nu0F8AqYGKg0y7vkL2LOP8us85L0p57MqIR1u
 gDnITlTY0x4RYRWJ9+k7led5WsnWlyv84KNzbDqQExTm8itzeZYW9RvbTS63r/+FlcTa9Cz1
 5fW3Qm0BsyECvpAD3IPLvX9jDIR0IkF/BQI4T98LQAkYX1M/UWkMpMYsL8tLObiNOWUl4ahb
 PYi5Yd8zVNYuidXHcwPAUXqGt3Cs+FIhihH30/Oe4jL0/2ZoEnWGOexIFVFpue0jdqJNiIvA
 F5Wpx+UiT5G8CWYYge5DtHI3m5qAP9UgPuck3N8xCihbsXKX4l8bdHfziaJuowief7igeQs/
 WyY9FnZb0tl29dSa7PdDKFWu+B+ZnuIzsO5vWMoN6hMThTl1DxS+jc7ATQRb/8z6AQgAvSkg
 5w7dVCSbpP6nXc+i8OBz59aq8kuL3YpxT9RXE/y45IFUVuSc2kuUj683rEEgyD7XCf4QKzOw
 +XgnJcKFQiACpYAowhF/XNkMPQFspPNM1ChnIL5KWJdTp0DhW+WBeCnyCQ2pzeCzQlS/qfs3
 dMLzzm9qCDrrDh/aEegMMZFO+reIgPZnInAcbHj3xUhz8p2dkExRMTnLry8XXkiMu9WpchHy
 XXWYxXbMnHkSRuT00lUfZAkYpMP7La2UudC/Uw9WqGuAQzTqhvE1kSQe0e11Uc+PqceLRHA2
 bq/wz0cGriUrcCrnkzRmzYLoGXQHqRuZazMZn2/pSIMZdDxLbwARAQABwsGNBBgBCAAgFiEE
 JNYm8lO+nofmzlv0j/S40nFnVScFAlv/zPoCGwwAIQkQj/S40nFnVScWIQQk1ibyU76eh+bO
 W/SP9LjScWdVJ/g6EACFYk+OBS7pV9KZXncBQYjKqk7Kc+9JoygYnOE2wN41QN9Xl0Rk3wri
 qO7PYJM28YjK3gMT8glu1qy+Ll1bjBYWXzlsXrF4szSqkJpm1cCxTmDOne5Pu6376dM9hb4K
 l9giUinI4jNUCbDutlt+Cwh3YuPuDXBAKO8YfDX2arzn/CISJlk0d4lDca4Cv+4yiJpEGd/r
 BVx2lRMUxeWQTz+1gc9ZtbRgpwoXAne4iw3FlR7pyg3NicvR30YrZ+QOiop8psWM2Fb1PKB9
 4vZCGT3j2MwZC50VLfOXC833DBVoLSIoL8PfTcOJOcHRYU9PwKW0wBlJtDVYRZ/CrGFjbp2L
 eT2mP5fcF86YMv0YGWdFNKDCOqOrOkZVmxai65N9d31k8/O9h1QGuVMqCiOTULy/h+FKpv5q
 t35tlzA2nxPOX8Qj3KDDqVgQBMYJRghZyj5+N6EKAbUVa9Zq8xT6Ms2zz/y7CPW74G1GlYWP
 i6D9VoMMi6ICko/CXUZ77OgLtMsy3JtzTRbn/wRySOY2AsMgg0Sw6yJ0wfrVk6XAMoLGjaVt
 X4iPTvwocEhjvrO4eXCicRBocsIB2qZaIj3mlhk2u4AkSpkKm9cN0KWYFUxlENF4/NKWMK+g
 fGfsCsS3cXXiZpufZFGr+GoHwiELqfLEAQ9AhlrHGCKcgVgTOI6NHg==
Message-ID: <8026844b-75d2-edfb-c3ed-fdabd34a9aa0@linaro.org>
Date:   Wed, 15 Jan 2020 14:44:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114150619.14611-1-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/2020 16:06, Paul Cercueil wrote:
> From: Maarten ter Huurne <maarten@treewalker.org>
> 
> OST is the OS Timer, a 64-bit timer/counter with buffered reading.
> 
> SoCs before the JZ4770 had (if any) a 32-bit OST; the JZ4770 and
> JZ4780 have a 64-bit OST.
> 
> This driver will register both a clocksource and a sched_clock to the
> system.

Is the JZ47xx OST really a mfd needing a regmap? (Note regmap_read will
take a lock).


> Signed-off-by: Maarten ter Huurne <maarten@treewalker.org>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Mathieu Malaterre <malat@debian.org>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
> 
> Notes:
>     v2: local_irq_save/restore were moved within sched_clock_register
>     v3: Only register as 32-bit clocksource to simplify things
> 
>  drivers/clocksource/Kconfig       |   8 ++
>  drivers/clocksource/Makefile      |   1 +
>  drivers/clocksource/ingenic-ost.c | 183 ++++++++++++++++++++++++++++++
>  3 files changed, 192 insertions(+)
>  create mode 100644 drivers/clocksource/ingenic-ost.c
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index 5fdd76cb1768..5be2f876f64f 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -697,4 +697,12 @@ config INGENIC_TIMER
>  	help
>  	  Support for the timer/counter unit of the Ingenic JZ SoCs.
>  
> +config INGENIC_OST
> +	bool "Ingenic JZ47xx Operating System Timer"
> +	depends on MIPS || COMPILE_TEST
> +	depends on COMMON_CLK
> +	select MFD_SYSCON
> +	help
> +	  Support for the OS Timer of the Ingenic JZ4770 or similar SoC.
> +
>  endmenu
> diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
> index 4dfe4225ece7..6bc97a6fd229 100644
> --- a/drivers/clocksource/Makefile
> +++ b/drivers/clocksource/Makefile
> @@ -80,6 +80,7 @@ obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
>  obj-$(CONFIG_H8300_TMR8)		+= h8300_timer8.o
>  obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
>  obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
> +obj-$(CONFIG_INGENIC_OST)		+= ingenic-ost.o
>  obj-$(CONFIG_INGENIC_TIMER)		+= ingenic-timer.o
>  obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
>  obj-$(CONFIG_X86_NUMACHIP)		+= numachip.o
> diff --git a/drivers/clocksource/ingenic-ost.c b/drivers/clocksource/ingenic-ost.c
> new file mode 100644
> index 000000000000..2c91e3b34572
> --- /dev/null
> +++ b/drivers/clocksource/ingenic-ost.c
> @@ -0,0 +1,183 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * JZ47xx SoCs TCU Operating System Timer driver
> + *
> + * Copyright (C) 2016 Maarten ter Huurne <maarten@treewalker.org>
> + * Copyright (C) 2020 Paul Cercueil <paul@crapouillou.net>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clocksource.h>
> +#include <linux/mfd/ingenic-tcu.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/sched_clock.h>
> +
> +#define TCU_OST_TCSR_MASK	0xffc0
> +#define TCU_OST_TCSR_CNT_MD	BIT(15)
> +
> +#define TCU_OST_CHANNEL		15
> +
> +struct ingenic_ost_soc_info {
> +	bool is64bit;
> +};
> +
> +struct ingenic_ost {
> +	struct regmap *map;
> +	struct clk *clk;
> +
> +	struct clocksource cs;
> +};
> +
> +static struct ingenic_ost *ingenic_ost;
> +
> +static u64 notrace ingenic_ost_read_cntl(void)
> +{
> +	u32 val;
> +
> +	regmap_read(ingenic_ost->map, TCU_REG_OST_CNTL, &val);
> +
> +	return val;
> +}
> +
> +static u64 notrace ingenic_ost_read_cnth(void)
> +{
> +	u32 val;
> +
> +	regmap_read(ingenic_ost->map, TCU_REG_OST_CNTH, &val);
> +
> +	return val;
> +}
> +
> +static u64 notrace ingenic_ost_clocksource_readl(struct clocksource *cs)
> +{
> +	return ingenic_ost_read_cntl();
> +}
> +
> +static u64 notrace ingenic_ost_clocksource_readh(struct clocksource *cs)
> +{
> +	return ingenic_ost_read_cnth();
> +}
> +
> +static int __init ingenic_ost_probe(struct platform_device *pdev)
> +{
> +	const struct ingenic_ost_soc_info *soc_info;
> +	struct device *dev = &pdev->dev;
> +	struct ingenic_ost *ost;
> +	struct clocksource *cs;
> +	unsigned long rate;
> +	int err;
> +
> +	soc_info = device_get_match_data(dev);
> +	if (!soc_info)
> +		return -EINVAL;
> +
> +	ost = devm_kzalloc(dev, sizeof(*ost), GFP_KERNEL);
> +	if (!ost)
> +		return -ENOMEM;
> +
> +	ingenic_ost = ost;
> +
> +	ost->map = device_node_to_regmap(dev->parent->of_node);
> +	if (!ost->map) {
> +		dev_err(dev, "regmap not found\n");
> +		return -EINVAL;
> +	}
> +
> +	ost->clk = devm_clk_get(dev, "ost");
> +	if (IS_ERR(ost->clk))
> +		return PTR_ERR(ost->clk);
> +
> +	err = clk_prepare_enable(ost->clk);
> +	if (err)
> +		return err;
> +
> +	/* Clear counter high/low registers */
> +	if (soc_info->is64bit)
> +		regmap_write(ost->map, TCU_REG_OST_CNTL, 0);
> +	regmap_write(ost->map, TCU_REG_OST_CNTH, 0);
> +
> +	/* Don't reset counter at compare value. */
> +	regmap_update_bits(ost->map, TCU_REG_OST_TCSR,
> +			   TCU_OST_TCSR_MASK, TCU_OST_TCSR_CNT_MD);
> +
> +	rate = clk_get_rate(ost->clk);
> +
> +	/* Enable OST TCU channel */
> +	regmap_write(ost->map, TCU_REG_TESR, BIT(TCU_OST_CHANNEL));
> +
> +	cs = &ost->cs;
> +	cs->name	= "ingenic-ost";
> +	cs->rating	= 320;
> +	cs->flags	= CLOCK_SOURCE_IS_CONTINUOUS;
> +	cs->mask	= CLOCKSOURCE_MASK(32);
> +
> +	if (soc_info->is64bit)
> +		cs->read = ingenic_ost_clocksource_readl;
> +	else
> +		cs->read = ingenic_ost_clocksource_readh;
> +
> +	err = clocksource_register_hz(cs, rate);
> +	if (err) {
> +		dev_err(dev, "clocksource registration failed: %d\n", err);
> +		clk_disable_unprepare(ost->clk);
> +		return err;
> +	}
> +
> +	if (soc_info->is64bit)
> +		sched_clock_register(ingenic_ost_read_cntl, 32, rate);
> +	else
> +		sched_clock_register(ingenic_ost_read_cnth, 32, rate);
> +	return 0;
> +}
> +
> +static int __maybe_unused ingenic_ost_suspend(struct device *dev)
> +{
> +	struct ingenic_ost *ost = dev_get_drvdata(dev);
> +
> +	clk_disable(ost->clk);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused ingenic_ost_resume(struct device *dev)
> +{
> +	struct ingenic_ost *ost = dev_get_drvdata(dev);
> +
> +	return clk_enable(ost->clk);
> +}
> +
> +static const struct dev_pm_ops __maybe_unused ingenic_ost_pm_ops = {
> +	/* _noirq: We want the OST clock to be gated last / ungated first */
> +	.suspend_noirq = ingenic_ost_suspend,
> +	.resume_noirq  = ingenic_ost_resume,
> +};
> +
> +static const struct ingenic_ost_soc_info jz4725b_ost_soc_info = {
> +	.is64bit = false,
> +};
> +
> +static const struct ingenic_ost_soc_info jz4770_ost_soc_info = {
> +	.is64bit = true,
> +};
> +
> +static const struct of_device_id ingenic_ost_of_match[] = {
> +	{ .compatible = "ingenic,jz4725b-ost", .data = &jz4725b_ost_soc_info, },
> +	{ .compatible = "ingenic,jz4770-ost", .data = &jz4770_ost_soc_info, },
> +	{ }
> +};
> +
> +static struct platform_driver ingenic_ost_driver = {
> +	.driver = {
> +		.name = "ingenic-ost",
> +#ifdef CONFIG_PM_SUSPEND
> +		.pm = &ingenic_ost_pm_ops,
> +#endif
> +		.of_match_table = ingenic_ost_of_match,
> +	},
> +};
> +builtin_platform_driver_probe(ingenic_ost_driver, ingenic_ost_probe);
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

