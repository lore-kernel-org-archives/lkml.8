Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9F8C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3879C2072D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgCDJKn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:10:43 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41335 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgCDJKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:10:43 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1j9Q37-0002Lp-6P; Wed, 04 Mar 2020 10:10:41 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1j9Q36-0004Hh-AQ; Wed, 04 Mar 2020 10:10:40 +0100
Message-ID: <b5b9cdaa87efd4f5f8a93f21581b53c409524156.camel@pengutronix.de>
Subject: Re: [PATCH v2] reset: hi6220: Add support for AO reset controller
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Cc:     Peter Griffin <peter.griffin@linaro.org>,
        Enrico Weigelt <info@metux.net>
Date:   Wed, 04 Mar 2020 10:10:40 +0100
In-Reply-To: <20200302174015.52363-1-john.stultz@linaro.org>
References: <20200302174015.52363-1-john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John, Peter,

thank you for the patch. Just one issue remaining, see below:

On Mon, 2020-03-02 at 17:40 +0000, John Stultz wrote:
> From: Peter Griffin <peter.griffin@linaro.org>
> 
> This is required to bring Mali450 gpu out of reset.
> 
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Peter Griffin <peter.griffin@linaro.org>
> Cc: Enrico Weigelt <info@metux.net>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2:
> * Updated to v2 of Peter's patch from here:
>     https://lkml.org/lkml/2019/4/19/253
> * Added a comment to explain ordering question brought
>   up on the list.
> ---
>  drivers/reset/hisilicon/hi6220_reset.c | 71 +++++++++++++++++++++++++-
>  1 file changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
> index 24e6d420b26b..a85ed276ab83 100644
> --- a/drivers/reset/hisilicon/hi6220_reset.c
> +++ b/drivers/reset/hisilicon/hi6220_reset.c
> @@ -33,6 +33,7 @@
>  enum hi6220_reset_ctrl_type {
>  	PERIPHERAL,
>  	MEDIA,
> +	AO,
>  };
>  
>  struct hi6220_reset_data {
> @@ -92,6 +93,67 @@ static const struct reset_control_ops hi6220_media_reset_ops = {
>  	.deassert = hi6220_media_deassert,
>  };
>  
> +#define AO_SCTRL_SC_PW_CLKEN0     0x800
> +#define AO_SCTRL_SC_PW_CLKDIS0    0x804
> +
> +#define AO_SCTRL_SC_PW_RSTEN0     0x810
> +#define AO_SCTRL_SC_PW_RSTDIS0    0x814
> +
> +#define AO_SCTRL_SC_PW_ISOEN0     0x820
> +#define AO_SCTRL_SC_PW_ISODIS0    0x824
> +#define AO_MAX_INDEX              12
> +
> +static int hi6220_ao_assert(struct reset_controller_dev *rc_dev,
> +			       unsigned long idx)
> +{
> +	struct hi6220_reset_data *data = to_reset_data(rc_dev);
> +	struct regmap *regmap = data->regmap;
> +	int ret;
> +
> +	ret = regmap_write(regmap, AO_SCTRL_SC_PW_RSTEN0, BIT(idx));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(regmap, AO_SCTRL_SC_PW_ISOEN0, BIT(idx));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(regmap, AO_SCTRL_SC_PW_CLKDIS0, BIT(idx));
> +	if (ret)
> +		return ret;


drivers/reset/hisilicon/hi6220_reset.c: In function ‘hi6220_ao_assert’:
drivers/reset/hisilicon/hi6220_reset.c:124:1: warning: control reaches end of non-void function [-Wreturn-type]
 }
 ^

Just "return regmap_write(...)" for the last one, same in
hi6220_ao_deassert().

regards
Philipp
