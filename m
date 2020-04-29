Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E5EC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 742A92083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="qPTpZJMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgD2OuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:50:14 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:36066 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2OuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:50:13 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03TEmXHb002888;
        Wed, 29 Apr 2020 16:50:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=Kr1XXbzLTlBBBZ4y6p9Pc2Y8Dqf2pHM8kUu97rhSPs8=;
 b=qPTpZJMYIZCSukhS/KRaf8VGAJz9sKiwwCb9HtlYB140Ftw1hKr8cNT5kJvVRAJ6a/dl
 Id4LZpXwdHSqRYfaE/zGkwrulkDbfo8TurbuXsWnv8feUSvRAYxktZKYdFvZbpePPmzX
 41fN5Ag0pm2JGHcbjV2nXmPB6LQfIRAH2HXgQL4UdR10joFX2A3ehFmRzRiAh5/1FggC
 7CYp+YEkzbugb7IulSzL0L5J0W5JynnCkJeBjXp3DPvCvPvwYazJXtznWoobr9cRbdgg
 k+Vt8M94UsN5UPHP6UzatGrkG6M0bTvA4Rtheg6Q/Pmbt26ir3geY9oK2gr+8E63foKv wg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30mhjwy0tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 16:50:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 20E06100034;
        Wed, 29 Apr 2020 16:50:05 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 10E532AAF6B;
        Wed, 29 Apr 2020 16:50:05 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.46) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Apr
 2020 16:50:03 +0200
Subject: Re: [PATCH v2 08/12] remoteproc: stm32: Introduce new start ops for
 synchronisation
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <loic.pallardy@st.com>, <linux-remoteproc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200424202505.29562-1-mathieu.poirier@linaro.org>
 <20200424202505.29562-9-mathieu.poirier@linaro.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <d9df6dba-6e99-d3cb-56e5-d7b9be0925f8@st.com>
Date:   Wed, 29 Apr 2020 16:50:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424202505.29562-9-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_07:2020-04-29,2020-04-29 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/20 10:25 PM, Mathieu Poirier wrote:
> Introduce new start functions to be used when synchonising with an MCU.
> 
> Mainly based on the work published by Arnaud Pouliquen [1].
> 
> [1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=239877
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Thanks,
Arnaud

> ---
>  drivers/remoteproc/stm32_rproc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index 8ba69e903851..404f17a97095 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -449,6 +449,13 @@ static int stm32_rproc_start(struct rproc *rproc)
>  	return stm32_rproc_set_hold_boot(rproc, true);
>  }
>  
> +static int stm32_rproc_sync_start(struct rproc *rproc)
> +{
> +	stm32_rproc_add_coredump_trace(rproc);
> +
> +	return stm32_rproc_set_hold_boot(rproc, true);
> +}
> +
>  static int stm32_rproc_stop(struct rproc *rproc)
>  {
>  	struct stm32_rproc *ddata = rproc->priv;
> @@ -522,6 +529,10 @@ static struct rproc_ops st_rproc_ops = {
>  	.get_boot_addr	= rproc_elf_get_boot_addr,
>  };
>  
> +static __maybe_unused struct rproc_ops st_rproc_sync_ops = {
> +	.start		= stm32_rproc_sync_start,
> +};
> +
>  static const struct of_device_id stm32_rproc_match[] = {
>  	{ .compatible = "st,stm32mp1-m4" },
>  	{},
> 
