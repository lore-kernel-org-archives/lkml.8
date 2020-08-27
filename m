Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAA7C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3272222B40
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgH0MCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:02:39 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2697 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728869AbgH0Loh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:44:37 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 386C1FEB9735C037E07C;
        Thu, 27 Aug 2020 12:26:06 +0100 (IST)
Received: from localhost (10.227.96.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 27 Aug
 2020 12:26:05 +0100
Date:   Thu, 27 Aug 2020 12:26:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>, Kukjin Kim <kgene@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Kevin Hilman" <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        "Tomasz Duszynski" <tomasz.duszynski@octakon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Bakker <xc-racer2@live.ca>,
        "Alexandru Ardelean" <alexandru.ardelean@analog.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 01/16] iio: accel: bma180: Simplify with dev_err_probe()
Message-ID: <20200827122605.0000770f@huawei.com>
In-Reply-To: <20200826145153.10444-1-krzk@kernel.org>
References: <20200826145153.10444-1-krzk@kernel.org>
Organization: Huawei tech. R&D (UK)  Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.227.96.57]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Aug 2020 16:51:38 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Please make sure to send v2 to linux-iio@vger.kernel.org

> ---
>  drivers/iio/accel/bma180.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 5b7a467c7b27..448faed001fd 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -1000,19 +1000,15 @@ static int bma180_probe(struct i2c_client *client,
>  		return ret;
>  
>  	data->vdd_supply = devm_regulator_get(dev, "vdd");
> -	if (IS_ERR(data->vdd_supply)) {
> -		if (PTR_ERR(data->vdd_supply) != -EPROBE_DEFER)
> -			dev_err(dev, "Failed to get vdd regulator %d\n",
> -				(int)PTR_ERR(data->vdd_supply));
> -		return PTR_ERR(data->vdd_supply);
> -	}
> +	if (IS_ERR(data->vdd_supply))
> +		return dev_err_probe(dev, PTR_ERR(data->vdd_supply),
> +				     "Failed to get vdd regulator\n");
> +
>  	data->vddio_supply = devm_regulator_get(dev, "vddio");
> -	if (IS_ERR(data->vddio_supply)) {
> -		if (PTR_ERR(data->vddio_supply) != -EPROBE_DEFER)
> -			dev_err(dev, "Failed to get vddio regulator %d\n",
> -				(int)PTR_ERR(data->vddio_supply));
> -		return PTR_ERR(data->vddio_supply);
> -	}
> +	if (IS_ERR(data->vddio_supply))
> +		return dev_err_probe(dev, PTR_ERR(data->vddio_supply),
> +				     "Failed to get vddio regulator\n");
> +
>  	/* Typical voltage 2.4V these are min and max */
>  	ret = regulator_set_voltage(data->vdd_supply, 1620000, 3600000);
>  	if (ret)

