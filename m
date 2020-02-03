Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 933E7C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 12:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70DDD20658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 12:28:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgBCM2W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 07:28:22 -0500
Received: from gloria.sntech.de ([185.11.138.130]:48566 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbgBCM2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 07:28:22 -0500
Received: from ip5f5a5d2f.dynamic.kabel-deutschland.de ([95.90.93.47] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iyapr-0004kZ-FK; Mon, 03 Feb 2020 13:28:15 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Markus Reichl <m.reichl@fivetechno.de>
Cc:     linux-rockchip@lists.infradead.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: mp8859: add supply entry
Date:   Mon, 03 Feb 2020 13:28:14 +0100
Message-ID: <2041997.mfULgpQ279@diego>
In-Reply-To: <20200203110034.1448-1-m.reichl@fivetechno.de>
References: <20200203110034.1448-1-m.reichl@fivetechno.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 3. Februar 2020, 12:00:33 CET schrieb Markus Reichl:
> Add vin_supply to the regulator description to support a nice
> regulator tree.
> 
> Signed-off-by: Markus Reichl <m.reichl@fivetechno.de>

double checked the datasheet for the supply name and all is correct, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/regulator/mp8859.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/regulator/mp8859.c b/drivers/regulator/mp8859.c
> index 1d26b506ee5b..6ed987648188 100644
> --- a/drivers/regulator/mp8859.c
> +++ b/drivers/regulator/mp8859.c
> @@ -95,6 +95,7 @@ static const struct regulator_desc mp8859_regulators[] = {
>  		.id = 0,
>  		.type = REGULATOR_VOLTAGE,
>  		.name = "mp8859_dcdc",
> +		.supply_name = "vin",
>  		.of_match = of_match_ptr("mp8859_dcdc"),
>  		.n_voltages = VOL_MAX_IDX + 1,
>  		.linear_ranges = mp8859_dcdc_ranges,
> 




