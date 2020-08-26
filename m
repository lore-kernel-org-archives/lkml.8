Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2AFDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F6D20738
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgHZPr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:47:59 -0400
Received: from smtpout1.mo803.mail-out.ovh.net ([79.137.123.219]:54677 "EHLO
        smtpout1.mo803.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726739AbgHZPr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:47:57 -0400
X-Greylist: delayed 575 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Aug 2020 11:47:56 EDT
Received: from pro2.mail.ovh.net (unknown [10.109.156.191])
        by mo803.mail-out.ovh.net (Postfix) with ESMTPS id 6EAE963F16E0;
        Wed, 26 Aug 2020 17:38:18 +0200 (CEST)
Received: from localhost (34.103.240.152) by DAG2EX1.emp2.local (172.16.2.11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Wed, 26 Aug
 2020 17:38:17 +0200
Date:   Wed, 26 Aug 2020 17:34:34 +0200
From:   Tomasz Duszynski <tomasz.duszynski@octakon.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>, Kukjin Kim <kgene@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 11/16] iio: chemical: scd30: Simplify with dev_err_probe()
Message-ID: <20200826153434.GA7468@arch>
References: <20200826145153.10444-1-krzk@kernel.org>
 <20200826145153.10444-11-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200826145153.10444-11-krzk@kernel.org>
X-Originating-IP: [34.103.240.152]
X-ClientProxiedBy: CAS2.emp2.local (172.16.1.2) To DAG2EX1.emp2.local
 (172.16.2.11)
X-Ovh-Tracer-Id: 9361576253439499417
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedruddvvddgledtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjihesthdtredttddtjeenucfhrhhomhepvfhomhgrshiiucffuhhsiiihnhhskhhiuceothhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtheevtefhffduteejfedtkeeuheejgeejvdetfffgveekffefgeffueeghefgjeenucfkpheptddrtddrtddrtddpfeegrddutdefrddvgedtrdduhedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepthhomhgrshiirdguuhhsiiihnhhskhhisehotghtrghkohhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqshhtmhefvdesshhtqdhmugdqmhgrihhlmhgrnhdrshhtohhrmhhrvghplhihrdgtohhm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 04:51:48PM +0200, Krzysztof Kozlowski wrote:
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/iio/chemical/scd30_core.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
> index eac76972f83e..92358797796d 100644
> --- a/drivers/iio/chemical/scd30_core.c
> +++ b/drivers/iio/chemical/scd30_core.c
> @@ -705,13 +705,9 @@ int scd30_probe(struct device *dev, int irq, const char *name, void *priv,
>  	indio_dev->available_scan_masks = scd30_scan_masks;
>
>  	state->vdd = devm_regulator_get(dev, "vdd");
> -	if (IS_ERR(state->vdd)) {
> -		if (PTR_ERR(state->vdd) == -EPROBE_DEFER)
> -			return -EPROBE_DEFER;
> -
> -		dev_err(dev, "failed to get regulator\n");
> -		return PTR_ERR(state->vdd);
> -	}
> +	if (IS_ERR(state->vdd))
> +		return dev_err_probe(dev, PTR_ERR(state->vdd),
> +				     "failed to get regulator\n");

I'd say that removing like break would slightly improve readability.
Besides, staying within 100 columns seems socially acceptable now.
Otherwise,

Acked-by: Tomasz Duszynski <tomasz.duszynski@octakon.com>

>
>  	ret = regulator_enable(state->vdd);
>  	if (ret)
> --
> 2.17.1
>
