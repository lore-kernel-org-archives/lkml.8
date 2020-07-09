Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2B3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F012D2078B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="HkDX4rmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgGIQPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:15:13 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43314 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726357AbgGIQPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:15:13 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 069GEBCo008176;
        Thu, 9 Jul 2020 18:15:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=PvTNGDZ0be+vJCmUKWvf45L2Y7bPIKD11ulb+yNAmMw=;
 b=HkDX4rmZzFLeDS9Ggayis9LyciC0OW03baW3gF5qjMtrOT4U0bqf6/u/W1ud5Wwvq7JG
 +rFdtIPTQ7f5htdykixP5By/O04+z+yykIS9rUfWoULOtF5VOPCP6TaD70IdVSdPcE7i
 4LlmZP9WnaVa69MDQ8ex9IJ6E8ziHunHEG0S6mvglFWYe+wranzmacpnRyeFZT8R50jV
 m5zPgkCkJEg5wqz5YmysER7M2qS3YY3yR6rrkjcm7KewWFUH1Rxgj0jb8t7xBMnRE9An
 iPEPZWYpNfOCo/T1ylKo/F1Hr6Y39zq7YkoGeegNypcZA4DpT8jky1dRtLZUjYhbAJxr gw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 325k3wwudt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 18:15:09 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1E33410002A;
        Thu,  9 Jul 2020 18:15:09 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 127852CA1C7;
        Thu,  9 Jul 2020 18:15:09 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.50) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jul
 2020 18:15:07 +0200
Subject: Re: [PATCH v5 08/11] remoteproc: stm32: Split function
 stm32_rproc_parse_fw()
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200707213112.928383-1-mathieu.poirier@linaro.org>
 <20200707213112.928383-9-mathieu.poirier@linaro.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <c28c34be-6650-6a07-d7ed-9d6c5e673b0c@st.com>
Date:   Thu, 9 Jul 2020 18:15:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707213112.928383-9-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_08:2020-07-09,2020-07-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/20 11:31 PM, Mathieu Poirier wrote:
> Split function stm32_rproc_parse_fw() in two parts, the first one
> to parse the memory regions and the second one to load the
> resource table.  That way parsing of the memory regions can be
> re-used when attaching to the remote processor.
> 
> Mainly based on the work published by Arnaud Pouliquen [1].
> 
> [1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=239877
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/remoteproc/stm32_rproc.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index cbeb5ceb15c5..9ab58fae252f 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -213,7 +213,7 @@ static int stm32_rproc_elf_load_rsc_table(struct rproc *rproc,
>  	return 0;
>  }
>  
> -static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
> +static int stm32_rproc_parse_memory_regions(struct rproc *rproc)
>  {
>  	struct device *dev = rproc->dev.parent;
>  	struct device_node *np = dev->of_node;
> @@ -266,6 +266,16 @@ static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
>  		index++;
>  	}
>  
> +	return 0;
> +}
> +
> +static int stm32_rproc_parse_fw(struct rproc *rproc, const struct firmware *fw)
> +{
> +	int ret = stm32_rproc_parse_memory_regions(rproc);
> +
> +	if (ret)
> +		return ret;
> +
>  	return stm32_rproc_elf_load_rsc_table(rproc, fw);
>  }
>  
> @@ -693,15 +703,20 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto free_rproc;
>  
> -	if (state == M4_STATE_CRUN)
> +	if (state == M4_STATE_CRUN) {
>  		rproc->state = RPROC_DETACHED;
>  
> +		ret = stm32_rproc_parse_memory_regions(rproc);
> +		if (ret)
> +			goto free_resources;
> +	}
> +
Here you do more than the split, you add the memory registration in the probe
i think updating the commit title and message should be sufficient

>  	rproc->has_iommu = false;
>  	ddata->workqueue = create_workqueue(dev_name(dev));
>  	if (!ddata->workqueue) {
>  		dev_err(dev, "cannot create workqueue\n");
>  		ret = -ENOMEM;
> -		goto free_rproc;
> +		goto free_resources;
>  	}
>  
>  	platform_set_drvdata(pdev, rproc);
> @@ -720,6 +735,8 @@ static int stm32_rproc_probe(struct platform_device *pdev)
>  	stm32_rproc_free_mbox(rproc);
>  free_wkq:
>  	destroy_workqueue(ddata->workqueue);
> +free_resources:
> +	rproc_resource_cleanup(rproc);
>  free_rproc:
>  	if (device_may_wakeup(dev)) {
>  		dev_pm_clear_wake_irq(dev);
> 
