Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C83C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB9A7207EA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599775275;
	bh=eLv0acndV7FadmxKGqnqISythFg+9YR3Bfr/HW6YiiY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=P0tEM15t21AL1F5G5uaOnXVqYi9FnurdXovFe9tnKtfHXgF8GdlepbuHy/LbWfYQV
	 6I2nH/oGkRyid/r69UmToMQqQIS0HfzMMj3TgXicNog4PdxjhZLrmZCKmuapqpW4TK
	 dR1n42rlxGscfvrEzvZz7Qj0l2W37YN2PA4j6AYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbgIJWBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:01:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgIJWBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 18:01:08 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFDB020719;
        Thu, 10 Sep 2020 22:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599775267;
        bh=eLv0acndV7FadmxKGqnqISythFg+9YR3Bfr/HW6YiiY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ecMjRku/krPzWiOFKeM/DQiIU/uQ64xNQFsumr+L1SD6PxLM2asC10ifsuy7QbIL/
         ZgZg8SUnfi1/cMFmqbl0ZF0c0LFetJGhDYIgB/BEHkkpgxJYDxWWDEFfOUF0Cu4P+F
         PEUcT+wOc/pwHQCrNOqMsZIKKPAg4Tk/N+lNjuL8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200902150348.14465-4-krzk@kernel.org>
References: <20200902150348.14465-1-krzk@kernel.org> <20200902150348.14465-4-krzk@kernel.org>
Subject: Re: [PATCH 04/10] clk: gpio: Simplify with dev_err_probe()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        David Lechner <david@lechnology.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 10 Sep 2020 15:01:06 -0700
Message-ID: <159977526650.2295844.8933765686946237404@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2020-09-02 08:03:42)
> diff --git a/drivers/clk/clk-gpio.c b/drivers/clk/clk-gpio.c
> index 38755a241ab7..a3cc53edcb11 100644
> --- a/drivers/clk/clk-gpio.c
> +++ b/drivers/clk/clk-gpio.c
> @@ -211,17 +210,10 @@ static int gpio_clk_driver_probe(struct platform_de=
vice *pdev)
> =20
>         gpio_name =3D is_mux ? "select" : "enable";
>         gpiod =3D devm_gpiod_get(dev, gpio_name, GPIOD_OUT_LOW);
> -       if (IS_ERR(gpiod)) {
> -               ret =3D PTR_ERR(gpiod);
> -               if (ret =3D=3D -EPROBE_DEFER)
> -                       pr_debug("%pOFn: %s: GPIOs not yet available, ret=
ry later\n",
> -                                       node, __func__);
> -               else
> -                       pr_err("%pOFn: %s: Can't get '%s' named GPIO prop=
erty\n",
> -                                       node, __func__,
> -                                       gpio_name);
> -               return ret;
> -       }
> +       if (IS_ERR(gpiod))
> +               return dev_err_probe(dev, PTR_ERR(gpiod),

This is cool! I wonder if we could make it even more simplified with

	ret =3D dev_err_probe_ptr(dev, ptr, ...)
	if (ret)
		return ret;

then we don't have to do the PTR_ERR() or IS_ERR() dance in all the
drivers. It could already be changed here to look at the return value of
dev_err_probe() so please do that at the least.

It would also even be more super duper cool if we had a way to save some
sort of cookie when the provider can't find it and is returning the
-EPROBE_DEFER value. Maybe the provider could use
device_set_deferred_probe_reason() on error and then if dev_err_probe()
is called without any string it can print what is in the device's
deferred probe reason? Or append to it whatever string is passed from
the device driver? Sometimes the provider has more info like the DT
property is malformed or the provider isn't probed yet which would
probably help understand the deferred problem more.
