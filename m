Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99036C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7355B206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CTHytnE2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgENHk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 03:40:27 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45846 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgENHk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 03:40:26 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04E7eLFN125466;
        Thu, 14 May 2020 02:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589442021;
        bh=KG3memjsCcwE/u1z7H7YBFsNgxZt+svqBex7nCFVKpE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CTHytnE2rppXj7kocZdax12mZ/nnkBlHwpK+0Fqn4TYklkDFHYad9/Un2+J18cE6d
         BQGf7D9/IE6lPc/omfJ/e8XkG3hQNA83W/GxNiwziMRxn4dH4SLsdYq658taMaofSc
         gm4Cw3bqVaFvq6bOqZfRjEBX91A8F73gETubfTts=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04E7eLso027858;
        Thu, 14 May 2020 02:40:21 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 14
 May 2020 02:40:21 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 14 May 2020 02:40:21 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04E7eIsV043167;
        Thu, 14 May 2020 02:40:19 -0500
Subject: Re: [PATCH 3/3] usb: dwc3: keystone: Turn on USB3 PHY before
 controller
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     <balbi@kernel.org>, <robh+dt@kernel.org>, <vigneshr@ti.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200513130709.10239-1-rogerq@ti.com>
 <20200513130709.10239-4-rogerq@ti.com> <1589420265.5899.0.camel@mhfsdcap03>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <baaaf89c-4baf-4218-e22e-53cd1a64ec02@ti.com>
Date:   Thu, 14 May 2020 10:40:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1589420265.5899.0.camel@mhfsdcap03>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/05/2020 04:37, Chunfeng Yun wrote:
> On Wed, 2020-05-13 at 16:07 +0300, Roger Quadros wrote:
>> The Local Power Sleep Controller (LPSC) dependency on AM65
>> requires SERDES0 to be powered on before USB.
>>
>> We need to power up SERDES0 power domain and hold it on
>> throughout the reset, init, power on sequence.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   drivers/usb/dwc3/dwc3-keystone.c | 47 +++++++++++++++++++++++++++++++-
>>   1 file changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
>> index 1e14a6f4884b..46d46f3507fc 100644
>> --- a/drivers/usb/dwc3/dwc3-keystone.c
>> +++ b/drivers/usb/dwc3/dwc3-keystone.c
>> @@ -14,6 +14,7 @@
>>   #include <linux/dma-mapping.h>
>>   #include <linux/io.h>
>>   #include <linux/of_platform.h>
>> +#include <linux/phy/phy.h>
>>   #include <linux/pm_runtime.h>
>>   
>>   /* USBSS register offsets */
>> @@ -34,6 +35,7 @@
>>   struct dwc3_keystone {
>>   	struct device			*dev;
>>   	void __iomem			*usbss;
>> +	struct phy			*usb3_phy;
>>   };
>>   
>>   static inline u32 kdwc3_readl(void __iomem *base, u32 offset)
>> @@ -95,8 +97,44 @@ static int kdwc3_probe(struct platform_device *pdev)
>>   	if (IS_ERR(kdwc->usbss))
>>   		return PTR_ERR(kdwc->usbss);
>>   
>> -	pm_runtime_enable(kdwc->dev);
>> +	/* PSC dependency on AM65 needs SERDES0 to be powered before USB0 */
>> +	kdwc->usb3_phy = devm_phy_get(dev, "usb3-phy");
> Use devm_phy_optional_get() instead?

Indeed, it seems better suited.

cheers,
-roger

> 
>> +	if (IS_ERR(kdwc->usb3_phy)) {
>> +		error = PTR_ERR(kdwc->usb3_phy);
>> +		if (error == -ENOSYS || error == -ENODEV) {
>> +			kdwc->usb3_phy = NULL;
>> +		} else {
>> +			if (error != -EPROBE_DEFER) {
>> +				dev_err(dev, "couldn't get usb3 phy: %d\n",
>> +					error);
>> +			}
>> +
>> +			return error;
>> +		}
>> +	}
>> +
>> +	phy_pm_runtime_get_sync(kdwc->usb3_phy);
>> +
>> +	error = phy_reset(kdwc->usb3_phy);
>> +	if (error < 0) {
>> +		dev_err(dev, "usb3 phy reset failed: %d\n", error);
>> +		return error;
>> +	}
>> +
>> +	error = phy_init(kdwc->usb3_phy);
>> +	if (error < 0) {
>> +		dev_err(dev, "usb3 phy init failed: %d\n", error);
>> +		return error;
>> +	}
>>   
>> +	error = phy_power_on(kdwc->usb3_phy);
>> +	if (error < 0) {
>> +		dev_err(dev, "usb3 phy power on failed: %d\n", error);
>> +		phy_exit(kdwc->usb3_phy);
>> +		return error;
>> +	}
>> +
>> +	pm_runtime_enable(kdwc->dev);
>>   	error = pm_runtime_get_sync(kdwc->dev);
>>   	if (error < 0) {
>>   		dev_err(kdwc->dev, "pm_runtime_get_sync failed, error %d\n",
>> @@ -138,6 +176,9 @@ static int kdwc3_probe(struct platform_device *pdev)
>>   err_irq:
>>   	pm_runtime_put_sync(kdwc->dev);
>>   	pm_runtime_disable(kdwc->dev);
>> +	phy_power_off(kdwc->usb3_phy);
>> +	phy_exit(kdwc->usb3_phy);
>> +	phy_pm_runtime_put_sync(kdwc->usb3_phy);
>>   
>>   	return error;
>>   }
>> @@ -163,6 +204,10 @@ static int kdwc3_remove(struct platform_device *pdev)
>>   	pm_runtime_put_sync(kdwc->dev);
>>   	pm_runtime_disable(kdwc->dev);
>>   
>> +	phy_power_off(kdwc->usb3_phy);
>> +	phy_exit(kdwc->usb3_phy);
>> +	phy_pm_runtime_put_sync(kdwc->usb3_phy);
>> +
>>   	platform_set_drvdata(pdev, NULL);
>>   
>>   	return 0;
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
