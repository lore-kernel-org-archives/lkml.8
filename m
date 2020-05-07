Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF83C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 359AC2078C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PsMl0ahY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgEGGlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:41:39 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54986 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgEGGlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:41:39 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0476fL9O053753;
        Thu, 7 May 2020 01:41:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588833681;
        bh=pTRo7kaUK1OTr2acBrogoDu6jaQLio+S2hubpKGq7hc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PsMl0ahYc8Dx+TpJTMky7ys1siEHpgXMTaguAt/4EJX6GJZtvGXjPhIlmH9ZwHCsk
         n04ArFCUmzshazUgq14d2iZHW4ddXGzBgQ7eLhEtp7DpA/dM8d7vq0bpxU8JxsrCCZ
         21Zd/qIdqK4IdP/qscYoLBYmE6rgX2wy6Av48rmU=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0476fLHG003341
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 May 2020 01:41:21 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 7 May
 2020 01:41:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 7 May 2020 01:41:21 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0476fJPK104179;
        Thu, 7 May 2020 01:41:19 -0500
Subject: Re: [PATCH -next] phy: ti: j721e-wiz: Fix some error return code in
 wiz_probe()
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jyri Sarha <jsarha@ti.com>, Sekhar Nori <nsekhar@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
References: <20200507054109.110849-1-weiyongjun1@huawei.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <f5cd603f-0f0b-23a4-310a-3a40f8f4f69a@ti.com>
Date:   Thu, 7 May 2020 09:41:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507054109.110849-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/05/2020 08:41, Wei Yongjun wrote:
> Fix to return negative error code from some error handling
> cases instead of 0, as done elsewhere in this function.
> 
> Fixes: 091876cc355d ("phy: ti: j721e-wiz: Add support for WIZ module present in TI J721E SoC")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Acked-by: Roger Quadros <rogerq@ti.com>

> ---
>   drivers/phy/ti/phy-j721e-wiz.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
> index 1d12d1b1b63a..30ea5b207285 100644
> --- a/drivers/phy/ti/phy-j721e-wiz.c
> +++ b/drivers/phy/ti/phy-j721e-wiz.c
> @@ -841,8 +841,10 @@ static int wiz_probe(struct platform_device *pdev)
>   	}
>   
>   	base = devm_ioremap(dev, res.start, resource_size(&res));
> -	if (!base)
> +	if (!base) {
> +		ret = -ENOMEM;
>   		goto err_addr_to_resource;
> +	}
>   
>   	regmap = devm_regmap_init_mmio(dev, base, &wiz_regmap_config);
>   	if (IS_ERR(regmap)) {
> @@ -859,6 +861,7 @@ static int wiz_probe(struct platform_device *pdev)
>   
>   	if (num_lanes > WIZ_MAX_LANES) {
>   		dev_err(dev, "Cannot support %d lanes\n", num_lanes);
> +		ret = -ENODEV;
>   		goto err_addr_to_resource;
>   	}
>   
> @@ -948,6 +951,7 @@ static int wiz_probe(struct platform_device *pdev)
>   	serdes_pdev = of_platform_device_create(child_node, NULL, dev);
>   	if (!serdes_pdev) {
>   		dev_WARN(dev, "Unable to create SERDES platform device\n");
> +		ret = -ENOMEM;
>   		goto err_pdev_create;
>   	}
>   	wiz->serdes_pdev = serdes_pdev;
> 
> 
> 

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
