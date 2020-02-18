Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE01DC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E5AB2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="E8o1r3gs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgBRMpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 07:45:02 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:23974 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726512AbgBRMpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 07:45:01 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IChkDH012049;
        Tue, 18 Feb 2020 13:44:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=k7lT4JiHZjcRlL3CLHgK7w2auTnnYEAi4jW68DE+cfg=;
 b=E8o1r3gsaX8mHd0y2t0TyuE1YwyIXuKXSSifnj2CiBekDyLskriStwD3xeko0q0nlref
 Wx5e6Z+A9z10Ah8naTvk8CmrvNOdF9g01ZzvkJlkjIN7lZy5qwPIHvfC9CMht76Eq0s/
 1k0RiBqlA2RnqD386uDBq+jfB45TsEicf05/4mrLy/CzXp5Gv/nHCeh2AjheY1uaK4Gu
 WqubKHhCZV5D8v56t8m0j35cTA+4ezfZHbpi2jfp8CE/OrJuf3vW/BId/PlJGArbQqY/
 j2U8pSBOwZm1xGTHXPqz8BOjOe+FULizj1EoPELsfhJMFqeMUjv7yWNKcKoDTG6Digo9 dw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y6705t52s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Feb 2020 13:44:54 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 10D10100034;
        Tue, 18 Feb 2020 13:44:54 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 06FC82AEFF4;
        Tue, 18 Feb 2020 13:44:54 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.47) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 18 Feb
 2020 13:44:53 +0100
Subject: Re: [PATCH] phy: core: Fix phy_get() to not return error on link
 creation failure
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>, youling257 <youling257@gmail.com>
References: <20200218121418.6292-1-kishon@ti.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <9051ea53-29d4-bd7a-675b-9c534794b7af@st.com>
Date:   Tue, 18 Feb 2020 13:44:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218121418.6292-1-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_02:2020-02-17,2020-02-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon

On 2/18/20 1:14 PM, Kishon Vijay Abraham I wrote:
> commit 987351e1ea77 ("phy: core: Add consumer device link support")
> added device link support between PHY consumer and PHY provider.
> However certain peripherals (DWC3 ULPI) have cyclic dependency
> between the PHY provider and PHY consumer causing the device link
> creation to fail.
> 
> Instead of erroring out on failure to create device link, only add a
> debug print to indicate device link creation failed to get USB
> working again in multiple platforms.
> 
> Fixes: 987351e1ea77 ("phy: core: Add consumer device link support")
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---

I was close to send it also :). Thanks for it.

Reviewed-by: Alexandre TORGUE <alexandre.torgue@st.com>

Thanks
Alex

>   drivers/phy/phy-core.c | 18 ++++++------------
>   1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index cd5a6c95dbdc..a27b8d578d7f 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -688,11 +688,9 @@ struct phy *phy_get(struct device *dev, const char *string)
>   	get_device(&phy->dev);
>   
>   	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
> -	if (!link) {
> -		dev_err(dev, "failed to create device link to %s\n",
> +	if (!link)
> +		dev_dbg(dev, "failed to create device link to %s\n",
>   			dev_name(phy->dev.parent));
> -		return ERR_PTR(-EINVAL);
> -	}
>   
>   	return phy;
>   }
> @@ -803,11 +801,9 @@ struct phy *devm_of_phy_get(struct device *dev, struct device_node *np,
>   	}
>   
>   	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
> -	if (!link) {
> -		dev_err(dev, "failed to create device link to %s\n",
> +	if (!link)
> +		dev_dbg(dev, "failed to create device link to %s\n",
>   			dev_name(phy->dev.parent));
> -		return ERR_PTR(-EINVAL);
> -	}
>   
>   	return phy;
>   }
> @@ -852,11 +848,9 @@ struct phy *devm_of_phy_get_by_index(struct device *dev, struct device_node *np,
>   	devres_add(dev, ptr);
>   
>   	link = device_link_add(dev, &phy->dev, DL_FLAG_STATELESS);
> -	if (!link) {
> -		dev_err(dev, "failed to create device link to %s\n",
> +	if (!link)
> +		dev_dbg(dev, "failed to create device link to %s\n",
>   			dev_name(phy->dev.parent));
> -		return ERR_PTR(-EINVAL);
> -	}
>   
>   	return phy;
>   }
> 
