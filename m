Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E3BC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A7D320B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 13:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hN7fEaQJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730772AbgDQNuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 09:50:04 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55610 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730731AbgDQNuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 09:50:03 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03HDo2eg071207;
        Fri, 17 Apr 2020 08:50:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587131402;
        bh=j5wFi+TfsuaZTYKTgVJ0AgTcn5CS2jUXSCWPWYserYA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hN7fEaQJnfqxgIrmOCII/XwEr9pPT9kgJwL83JjyNKZqLqaFbOLGDTTgIrsVQ3hXw
         UWuKBTthtgQ0R8pXphV8MNIUNRGtO3yuY9MA8bY9VJCLBcOTNF4Hut9VVBxvVQhJkB
         WH4Dw/TMoXZAI8bW1HEoDxLNDtui4m4Q58Vkej3w=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03HDo2J5125957;
        Fri, 17 Apr 2020 08:50:02 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 17
 Apr 2020 08:50:02 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 17 Apr 2020 08:50:01 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03HDo14D124693;
        Fri, 17 Apr 2020 08:50:01 -0500
Subject: Re: [PATCH v2 7/7] remoteproc: Get rid of tedious error path
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        <bjorn.andersson@linaro.org>, <ohad@wizery.com>
CC:     <elder@linaro.org>, <Markus.Elfring@web.de>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200415204858.2448-1-mathieu.poirier@linaro.org>
 <20200415204858.2448-8-mathieu.poirier@linaro.org>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <6b21d836-a31c-eeaa-efff-aff589861775@ti.com>
Date:   Fri, 17 Apr 2020 08:50:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415204858.2448-8-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/15/20 3:48 PM, Mathieu Poirier wrote:
> Get rid of tedious error management by moving firmware and operation
> allocation after calling device_initialize().  That way we take advantage
> of the automatic call to rproc_type_release() to cleanup after ourselves
> when put_device() is called.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Reviewed-by: Alex Elder <elder@linaro.org>

Acked-by: Suman Anna <s-anna@ti.com>

regards
Suman

> ---
>   drivers/remoteproc/remoteproc_core.c | 22 +++++++++-------------
>   1 file changed, 9 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index a5a0ceb86b3f..405c94f151a7 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2056,12 +2056,6 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>   	if (!rproc)
>   		return NULL;
>   
> -	if (rproc_alloc_firmware(rproc, name, firmware))
> -		goto free_rproc;
> -
> -	if (rproc_alloc_ops(rproc, ops))
> -		goto free_firmware;
> -
>   	rproc->name = name;
>   	rproc->priv = &rproc[1];
>   	rproc->auto_boot = true;
> @@ -2074,12 +2068,17 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>   	rproc->dev.driver_data = rproc;
>   	idr_init(&rproc->notifyids);
>   
> +	if (rproc_alloc_firmware(rproc, name, firmware))
> +		goto put_device;
> +
> +	if (rproc_alloc_ops(rproc, ops))
> +		goto put_device;
> +
>   	/* Assign a unique device index and name */
>   	rproc->index = ida_simple_get(&rproc_dev_index, 0, 0, GFP_KERNEL);
>   	if (rproc->index < 0) {
>   		dev_err(dev, "ida_simple_get failed: %d\n", rproc->index);
> -		put_device(&rproc->dev);
> -		return NULL;
> +		goto put_device;
>   	}
>   
>   	dev_set_name(&rproc->dev, "remoteproc%d", rproc->index);
> @@ -2100,11 +2099,8 @@ struct rproc *rproc_alloc(struct device *dev, const char *name,
>   	rproc->state = RPROC_OFFLINE;
>   
>   	return rproc;
> -
> -free_firmware:
> -	kfree(rproc->firmware);
> -free_rproc:
> -	kfree(rproc);
> +put_device:
> +	put_device(&rproc->dev);
>   	return NULL;
>   }
>   EXPORT_SYMBOL(rproc_alloc);
> 

