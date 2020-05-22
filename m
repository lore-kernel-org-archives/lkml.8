Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DACC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7FC20723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SnJlPkD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbgEVQrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:47:42 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:54074 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgEVQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:47:42 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04MGlZIb117219;
        Fri, 22 May 2020 11:47:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590166055;
        bh=pYwktcJiAsM0iNsRKmiwzrjZxKYcIFGjM0IA3yskkG0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SnJlPkD2VYXbTIp2OEoYMhjFILCuu8JQs3uL+WUkjk7RBsr8VE/9CgBFKcIJNIVb+
         IDtbXIUgQBwtqcOm1+76sh8n2nqC12pj65wlbyOt/RjOydWaycvQD+ShXo5aIzp7no
         Rj7ILVB6SrfGg+E1gaOVpXrtULIKcjnP0ykN2Mlo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04MGlYuN071450
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 11:47:35 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 22
 May 2020 11:47:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 22 May 2020 11:47:34 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04MGlYXP095594;
        Fri, 22 May 2020 11:47:34 -0500
Subject: Re: [PATCH v7 3/5] remoteproc: Add support for runtime PM
To:     Paul Cercueil <paul@crapouillou.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>
CC:     <od@zcrc.me>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>
References: <20200515104340.10473-1-paul@crapouillou.net>
 <20200515104340.10473-3-paul@crapouillou.net>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <035bf8ad-3ef0-8314-ae5c-a94a24c230c8@ti.com>
Date:   Fri, 22 May 2020 11:47:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515104340.10473-3-paul@crapouillou.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 5/15/20 5:43 AM, Paul Cercueil wrote:
> Call pm_runtime_get_sync() before the firmware is loaded, and
> pm_runtime_put() after the remote processor has been stopped.
> 
> Even though the remoteproc device has no PM callbacks, this allows the
> parent device's PM callbacks to be properly called.

I see this patch staged now for 5.8, and the latest -next branch has 
broken the pm-runtime autosuspend feature we have in the OMAP remoteproc 
driver. See commit 5f31b232c674 ("remoteproc/omap: Add support for 
runtime auto-suspend/resume").

What was the original purpose of this patch, because there can be 
differing backends across different SoCs.

regards
Suman

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>      v2-v4: No change
>      v5: Move calls to prepare/unprepare to rproc_fw_boot/rproc_shutdown
>      v6: Instead of prepare/unprepare callbacks, use PM runtime callbacks
>      v7: Check return value of pm_runtime_get_sync()
> 
>   drivers/remoteproc/remoteproc_core.c | 17 ++++++++++++++++-
>   1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index a7f96bc98406..e33d1ef27981 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -29,6 +29,7 @@
>   #include <linux/devcoredump.h>
>   #include <linux/rculist.h>
>   #include <linux/remoteproc.h>
> +#include <linux/pm_runtime.h>
>   #include <linux/iommu.h>
>   #include <linux/idr.h>
>   #include <linux/elf.h>
> @@ -1382,6 +1383,12 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>   	if (ret)
>   		return ret;
>   
> +	ret = pm_runtime_get_sync(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "pm_runtime_get_sync failed: %d\n", ret);
> +		return ret;
> +	}
> +
>   	dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
>   
>   	/*
> @@ -1391,7 +1398,7 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>   	ret = rproc_enable_iommu(rproc);
>   	if (ret) {
>   		dev_err(dev, "can't enable iommu: %d\n", ret);
> -		return ret;
> +		goto put_pm_runtime;
>   	}
>   
>   	rproc->bootaddr = rproc_get_boot_addr(rproc, fw);
> @@ -1435,6 +1442,8 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>   	rproc->table_ptr = NULL;
>   disable_iommu:
>   	rproc_disable_iommu(rproc);
> +put_pm_runtime:
> +	pm_runtime_put(dev);
>   	return ret;
>   }
>   
> @@ -1840,6 +1849,8 @@ void rproc_shutdown(struct rproc *rproc)
>   
>   	rproc_disable_iommu(rproc);
>   
> +	pm_runtime_put(dev);
> +
>   	/* Free the copy of the resource table */
>   	kfree(rproc->cached_table);
>   	rproc->cached_table = NULL;
> @@ -2118,6 +2129,9 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>   
>   	rproc->state = RPROC_OFFLINE;
>   
> +	pm_runtime_no_callbacks(&rproc->dev);
> +	pm_runtime_enable(&rproc->dev);
> +
>   	return rproc;
>   }
>   EXPORT_SYMBOL(rproc_alloc);
> @@ -2133,6 +2147,7 @@ EXPORT_SYMBOL(rproc_alloc);
>    */
>   void rproc_free(struct rproc *rproc)
>   {
> +	pm_runtime_disable(&rproc->dev);
>   	put_device(&rproc->dev);
>   }
>   EXPORT_SYMBOL(rproc_free);
> 

