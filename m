Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2698CC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F130520767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="d4G7qqP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgIBO3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:29:41 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35204 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgIBOY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:24:59 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 082EOa2Z123302;
        Wed, 2 Sep 2020 09:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599056676;
        bh=CqP4NhGh7o1w/3Pi3oiKGtX3gGAk0+fcZXuBWvmIbR0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=d4G7qqP4sFoXC4+X/1sxQJNJnGvylvV9lWQCyodhulSJxWSGkqIx+FUbNrcQu5/fg
         6LxhZfXHBOjeXMqWUeJsTbCIopLyNcGojMa05Tb+/DLl4bA1u8R44K4hK3qmkdY5A2
         ux4+u04989jP8GnV9fO+h5c4kMI22mCShj4OZ9vg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 082EOaMc119573
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Sep 2020 09:24:36 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 2 Sep
 2020 09:24:35 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 2 Sep 2020 09:24:35 -0500
Received: from [10.250.34.112] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 082EOZRi056117;
        Wed, 2 Sep 2020 09:24:35 -0500
Subject: Re: [PATCH -next] remoteproc: k3-dsp: Fix return value check in
 k3_dsp_rproc_of_get_memories()
To:     YueHaibing <yuehaibing@huawei.com>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200902140614.28636-1-yuehaibing@huawei.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <53dc15d3-c101-77fc-c58d-f9634a649a48@ti.com>
Date:   Wed, 2 Sep 2020 09:24:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902140614.28636-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 9:06 AM, YueHaibing wrote:
> In case of error, the function devm_ioremap_wc() returns NULL pointer
> not ERR_PTR(). The IS_ERR() test in the return value check should be
> replaced with NULL test.

Thanks for the fix.

> 
> Fixes: 87218f96c21a ("remoteproc: k3-dsp: Add support for C71x DSPs")

This should instead be
Fixes: 6edbe024ba17 ("remoteproc: k3-dsp: Add a remoteproc driver of K3 C66x DSPs")

With that,
Acked-by: Suman Anna <s-anna@ti.com>

> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/remoteproc/ti_k3_dsp_remoteproc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> index 9011e477290c..f373df35d7d0 100644
> --- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> @@ -445,10 +445,10 @@ static int k3_dsp_rproc_of_get_memories(struct platform_device *pdev,
>  
>  		kproc->mem[i].cpu_addr = devm_ioremap_wc(dev, res->start,
>  							 resource_size(res));
> -		if (IS_ERR(kproc->mem[i].cpu_addr)) {
> +		if (!kproc->mem[i].cpu_addr) {
>  			dev_err(dev, "failed to map %s memory\n",
>  				data->mems[i].name);
> -			return PTR_ERR(kproc->mem[i].cpu_addr);
> +			return -EBUSY;
>  		}
>  		kproc->mem[i].bus_addr = res->start;
>  		kproc->mem[i].dev_addr = data->mems[i].dev_addr;
> 

