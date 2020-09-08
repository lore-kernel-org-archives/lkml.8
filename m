Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BBBC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B988F2080C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xlLdRIqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731558AbgIHSp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:45:26 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44342 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731361AbgIHSnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:43:43 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 088Bxpk5003236;
        Tue, 8 Sep 2020 06:59:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599566391;
        bh=GHYJnMapkkdtwKbXaCf924QThmz/JpeI2hL/70NG150=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xlLdRIqazwVVbzo7UeRzA2/7sMEVFq7YrBOd3qDrFyS4bBFAcKmwBXV2FraRpCHE3
         W8efGNVqWeo3YfMaB6LbtIvI/DNgAkYD8fuXwlUwLsRC/jyyDYbCSPxcKlt6PCzZzF
         yVvYn/xstctyldCJuCRHc9cqh/M+TvJH3haidCfY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 088BxpDV112728
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Sep 2020 06:59:51 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Sep
 2020 06:59:51 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Sep 2020 06:59:51 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 088BxmR5107470;
        Tue, 8 Sep 2020 06:59:49 -0500
Subject: Re: [PATCH 1/2] ASoC: tlv320adcx140: Avoid accessing invalid
 gpio_reset
To:     Camel Guo <camel.guo@axis.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <tiwai@suse.com>, <dmurphy@ti.com>
CC:     <alsa-devel@alsa-project.org>, <kernel@axis.com>,
        <linux-kernel@vger.kernel.org>, Camel Guo <camelg@axis.com>
References: <20200908083521.14105-1-camel.guo@axis.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <7bb93489-dbd5-d1a5-5df6-e62470bd2252@ti.com>
Date:   Tue, 8 Sep 2020 14:59:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200908083521.14105-1-camel.guo@axis.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/09/2020 11.35, Camel Guo wrote:
> From: Camel Guo <camelg@axis.com>
>=20
> When gpio_reset is not well defined in devicetree, the
> adcx140->gpio_reset is an error code instead of NULL. In this case,
> adcx140->gpio_reset should not be used by adcx140_reset. This commit
> sets it NULL to avoid accessing an invalid variable.
>=20
> Signed-off-by: Camel Guo <camelg@axis.com>
> ---
>  sound/soc/codecs/tlv320adcx140.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320=
adcx140.c
> index 7ae6ec374be3..597dd1062943 100644
> --- a/sound/soc/codecs/tlv320adcx140.c
> +++ b/sound/soc/codecs/tlv320adcx140.c
> @@ -984,8 +984,10 @@ static int adcx140_i2c_probe(struct i2c_client *i2=
c,
> =20
>  	adcx140->gpio_reset =3D devm_gpiod_get_optional(adcx140->dev,
>  						      "reset", GPIOD_OUT_LOW);
> -	if (IS_ERR(adcx140->gpio_reset))
> +	if (IS_ERR(adcx140->gpio_reset) || adcx140->gpio_reset =3D=3D NULL) {=

>  		dev_info(&i2c->dev, "Reset GPIO not defined\n");
> +		adcx140->gpio_reset =3D NULL;

the correct fix is to:
	dev_err(&i2c->dev, "Reset GPIO not defined\n");
	return PTR_ERR(adcx140->gpio_reset);

If the reset GPIO is specified and you get error when requesting it as
optional, there is a reason for that.
For example deferred probing.

> +	}
> =20
>  	adcx140->supply_areg =3D devm_regulator_get_optional(adcx140->dev,
>  							   "areg");
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

