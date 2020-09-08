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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CE3C2BC11
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:45:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61EC22080A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:45:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JN0XmYmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731698AbgIHSp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:45:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44342 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbgIHSnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:43:42 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 088BtjZr002439;
        Tue, 8 Sep 2020 06:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599566145;
        bh=8S2NCJwrsPCuX+GyPBMxHmMN2Snkw/AKa06O2GPbjc0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JN0XmYmYYG+sh7kBGsZ4FEmWIKB3YGVEglGhg9FQvt5MJYCHlDHnInnbAK6Cm3Kwq
         NdOd7v39ZhWpwkZEieJuoFBwJ/MmKew7rJYgpXu0Vu7KRNTUUCkshGaV3L4lmDrMpG
         XQibWpzYEYT83NDjh2ci+7FZgciLc+49zW9B7iFw=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 088Btj0O103436
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Sep 2020 06:55:45 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 8 Sep
 2020 06:55:44 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 8 Sep 2020 06:55:44 -0500
Received: from [10.250.38.37] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 088BtiiB092847;
        Tue, 8 Sep 2020 06:55:44 -0500
Subject: Re: [PATCH 1/2] ASoC: tlv320adcx140: Avoid accessing invalid
 gpio_reset
To:     Camel Guo <camel.guo@axis.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Camel Guo <camelg@axis.com>
References: <20200908083521.14105-1-camel.guo@axis.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <c1036c8f-9ddc-1e02-4668-1dd0d081b6cf@ti.com>
Date:   Tue, 8 Sep 2020 06:55:44 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908083521.14105-1-camel.guo@axis.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200908115544.qh0mveYhX6wx1AYqFKlji4KWR5nfcnYZQKHjAcZSNEA@z>

Camel

On 9/8/20 3:35 AM, Camel Guo wrote:
> From: Camel Guo <camelg@axis.com>
>
> When gpio_reset is not well defined in devicetree, the
> adcx140->gpio_reset is an error code instead of NULL. In this case,
> adcx140->gpio_reset should not be used by adcx140_reset. This commit
> sets it NULL to avoid accessing an invalid variable.
>
> Signed-off-by: Camel Guo <camelg@axis.com>
> ---
>   sound/soc/codecs/tlv320adcx140.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
> index 7ae6ec374be3..597dd1062943 100644
> --- a/sound/soc/codecs/tlv320adcx140.c
> +++ b/sound/soc/codecs/tlv320adcx140.c
> @@ -984,8 +984,10 @@ static int adcx140_i2c_probe(struct i2c_client *i2c,
>   
>   	adcx140->gpio_reset = devm_gpiod_get_optional(adcx140->dev,
>   						      "reset", GPIOD_OUT_LOW);
> -	if (IS_ERR(adcx140->gpio_reset))
> +	if (IS_ERR(adcx140->gpio_reset) || adcx140->gpio_reset == NULL) {

This looks a bit off and seems like the NULL check was added just to 
print the message.

I would suggest removing the "or" check and just set the gpio_reset to 
NULL in an error case.

This avoids noise in the log especially if the gpio_reset is 
intentionally not populated in the DT

Dan

