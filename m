Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1143FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC9D92085B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 21:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NQvtGT/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgGAVVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 17:21:40 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60074 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbgGAVVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 17:21:38 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 061LLXxS130492;
        Wed, 1 Jul 2020 16:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593638493;
        bh=rLRInyM1HUBSe42k9HXIZL+IrIZT1shCKCGOH7tBuOA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NQvtGT/ZG8cPpHc0YuQ+p+9b1vhq5YCipHI6/SYBsD7VZ89xI6JSjhmmGAZ3vdfRM
         pAvBkzy2HXQ83NEJmgL6ed2dSkMGtGuXurAmgiFyd9+N30wGt6Ik5/KIlaGzKUDZVs
         S6rQR1fmb7ywdo1URRKpUo5B6uPA4rE0bXwvKf7c=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 061LLXCX129314
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Jul 2020 16:21:33 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 1 Jul
 2020 16:21:33 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 1 Jul 2020 16:21:33 -0500
Received: from [10.250.70.56] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 061LLWww081460;
        Wed, 1 Jul 2020 16:21:32 -0500
Subject: Re: [PATCH 2/2] Revert "remoteproc: Add support for runtime PM"
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <paul@crapouillou.net>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200630163118.3830422-1-mathieu.poirier@linaro.org>
 <20200630163118.3830422-3-mathieu.poirier@linaro.org>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <14cdd336-a2d9-537d-cc61-f47e01f89e9c@ti.com>
Date:   Wed, 1 Jul 2020 16:21:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630163118.3830422-3-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 6/30/20 11:31 AM, Mathieu Poirier wrote:
> This reverts commit a99a37f6cd5a74d5b22c08544aa6c5890813c8ba.
> 
> Removing PM runtime operations from the remoteproc core in order to:
> 
> 1) Keep all power management operations in platform drivers.  That way we
> do not loose flexibility in an area that is very HW specific.
> 
> 2) Avoid making the support for remote processor managed by external
> entities more complex that it already is.
> 
> 3) Fix regression introduced for the Omap remoteproc driver.

Thanks for following up on the discussion, I have verified that the 
autosuspend regression is fixed.

> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Tested-by: Suman Anna <s-anna@ti.com>
Acked-by: Suman Anna <s-anna@ti.com>

regards
Suman

> ---
>   drivers/remoteproc/remoteproc_core.c | 17 +----------------
>   1 file changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 9f04c30c4aaf..0f95e025ba03 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -29,7 +29,6 @@
>   #include <linux/devcoredump.h>
>   #include <linux/rculist.h>
>   #include <linux/remoteproc.h>
> -#include <linux/pm_runtime.h>
>   #include <linux/iommu.h>
>   #include <linux/idr.h>
>   #include <linux/elf.h>
> @@ -1383,12 +1382,6 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>   	if (ret)
>   		return ret;
>   
> -	ret = pm_runtime_get_sync(dev);
> -	if (ret < 0) {
> -		dev_err(dev, "pm_runtime_get_sync failed: %d\n", ret);
> -		return ret;
> -	}
> -
>   	dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
>   
>   	/*
> @@ -1398,7 +1391,7 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>   	ret = rproc_enable_iommu(rproc);
>   	if (ret) {
>   		dev_err(dev, "can't enable iommu: %d\n", ret);
> -		goto put_pm_runtime;
> +		return ret;
>   	}
>   
>   	/* Prepare rproc for firmware loading if needed */
> @@ -1452,8 +1445,6 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>   	rproc_unprepare_device(rproc);
>   disable_iommu:
>   	rproc_disable_iommu(rproc);
> -put_pm_runtime:
> -	pm_runtime_put(dev);
>   	return ret;
>   }
>   
> @@ -1891,8 +1882,6 @@ void rproc_shutdown(struct rproc *rproc)
>   
>   	rproc_disable_iommu(rproc);
>   
> -	pm_runtime_put(dev);
> -
>   	/* Free the copy of the resource table */
>   	kfree(rproc->cached_table);
>   	rproc->cached_table = NULL;
> @@ -2183,9 +2172,6 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>   
>   	rproc->state = RPROC_OFFLINE;
>   
> -	pm_runtime_no_callbacks(&rproc->dev);
> -	pm_runtime_enable(&rproc->dev);
> -
>   	return rproc;
>   
>   put_device:
> @@ -2205,7 +2191,6 @@ EXPORT_SYMBOL(rproc_alloc);
>    */
>   void rproc_free(struct rproc *rproc)
>   {
> -	pm_runtime_disable(&rproc->dev);
>   	put_device(&rproc->dev);
>   }
>   EXPORT_SYMBOL(rproc_free);
> 

