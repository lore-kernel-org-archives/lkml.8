Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA225C2D0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F8820714
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vmW/z2lw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgEMCXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 22:23:43 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42528 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgEMCXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 22:23:43 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04D2NWkT017956;
        Tue, 12 May 2020 21:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589336612;
        bh=Y2b2td/dgG3mv8QkpPXvhABe6AB0Z2lXZW74es4K0x0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=vmW/z2lw4crt15DU/pQvKyYaDDLKZeaWhHQ2eBCiDHZc2FcTKKlLgUwiStiCGxWDN
         6lqZCVbVwEN28toEbukrmHLYg/fRUmnidBssA3LzUtSIWF7RzGqLaI+OjS5FXeFg/x
         JB8VAkMoEUQcOfo5dOL9T8e50+6kxmmchQQNgP14=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04D2NWFC006884
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 21:23:32 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 May 2020 21:23:31 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 May 2020 21:23:31 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04D2NSaU111706;
        Tue, 12 May 2020 21:23:29 -0500
Subject: Re: [PATCH -next] phy: ti: j721e-wiz: Fix some error return code in
 wiz_probe()
To:     Roger Quadros <rogerq@ti.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jyri Sarha <jsarha@ti.com>, Sekhar Nori <nsekhar@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hulk Robot <hulkci@huawei.com>
References: <20200507054109.110849-1-weiyongjun1@huawei.com>
 <f5cd603f-0f0b-23a4-310a-3a40f8f4f69a@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <fc4b4490-c3d1-aad0-59ee-76585b562ed3@ti.com>
Date:   Wed, 13 May 2020 07:53:28 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f5cd603f-0f0b-23a4-310a-3a40f8f4f69a@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/2020 12:11 PM, Roger Quadros wrote:
> 
> 
> On 07/05/2020 08:41, Wei Yongjun wrote:
>> Fix to return negative error code from some error handling
>> cases instead of 0, as done elsewhere in this function.
>>
>> Fixes: 091876cc355d ("phy: ti: j721e-wiz: Add support for WIZ module present
>> in TI J721E SoC")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Acked-by: Roger Quadros <rogerq@ti.com>

merged, thanks!

-Kishon
> 
>> ---
>>   drivers/phy/ti/phy-j721e-wiz.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
>> index 1d12d1b1b63a..30ea5b207285 100644
>> --- a/drivers/phy/ti/phy-j721e-wiz.c
>> +++ b/drivers/phy/ti/phy-j721e-wiz.c
>> @@ -841,8 +841,10 @@ static int wiz_probe(struct platform_device *pdev)
>>       }
>>         base = devm_ioremap(dev, res.start, resource_size(&res));
>> -    if (!base)
>> +    if (!base) {
>> +        ret = -ENOMEM;
>>           goto err_addr_to_resource;
>> +    }
>>         regmap = devm_regmap_init_mmio(dev, base, &wiz_regmap_config);
>>       if (IS_ERR(regmap)) {
>> @@ -859,6 +861,7 @@ static int wiz_probe(struct platform_device *pdev)
>>         if (num_lanes > WIZ_MAX_LANES) {
>>           dev_err(dev, "Cannot support %d lanes\n", num_lanes);
>> +        ret = -ENODEV;
>>           goto err_addr_to_resource;
>>       }
>>   @@ -948,6 +951,7 @@ static int wiz_probe(struct platform_device *pdev)
>>       serdes_pdev = of_platform_device_create(child_node, NULL, dev);
>>       if (!serdes_pdev) {
>>           dev_WARN(dev, "Unable to create SERDES platform device\n");
>> +        ret = -ENOMEM;
>>           goto err_pdev_create;
>>       }
>>       wiz->serdes_pdev = serdes_pdev;
>>
>>
>>
> 
> cheers,
> -roger
