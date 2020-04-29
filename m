Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26C8C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E512073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="MOaili/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgD2Ow2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:52:28 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:42728 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726775AbgD2Ow1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:52:27 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03TEqKrF025571;
        Wed, 29 Apr 2020 16:52:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=k4HHTwS+8Ljbwqtos9h637MEEsprgCn+OA+4OMP7vFM=;
 b=MOaili/s/VJ0fiUvGwJyitOHHjHTrw54nh0Chwl9+QzytQIlBGkcQzCavUDbaLCgtUqn
 552MnWhqHPq9pZdFCBdi3KR5en+UQi8FaFqHh+q6f3mVuK/jhfHMhyg+wncyvR4XIZmd
 UlLJBdrW11H0bRqWyoLj9xUBGtPNeB0B69AgpyI/4VF6Ku9YfLIClRwpQsQdXttjtPDO
 di18l2lPdHUe+Qaq83dAJjNIOyAsYDp9keWtKqVXPf9k5TnsOhXRjX0Y87kUHsGle7lt
 LecV34D//WmmYfrJ+9FEdKajqgQlxd+oe/Oef6+XDTllvg2LzkOXWjxKewKfHzBGFiwZ Dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30n4j6352n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 16:52:20 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6CAE710002A;
        Wed, 29 Apr 2020 16:52:19 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5AA232AAF70;
        Wed, 29 Apr 2020 16:52:19 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.47) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Apr
 2020 16:52:18 +0200
Subject: Re: [PATCH v2 09/12] remoteproc: stm32: Update M4 state in
 stm32_rproc_stop()
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>
CC:     <loic.pallardy@st.com>, <linux-remoteproc@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200424202505.29562-1-mathieu.poirier@linaro.org>
 <20200424202505.29562-10-mathieu.poirier@linaro.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <f4394e9d-2915-2e15-38e4-80b23baf678e@st.com>
Date:   Wed, 29 Apr 2020 16:52:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200424202505.29562-10-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_07:2020-04-29,2020-04-29 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/20 10:25 PM, Mathieu Poirier wrote:
> Update the M4 co-processor state in function stm32_rproc_stop() so
> that it can be used in synchronisation scenarios.
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
>  drivers/remoteproc/stm32_rproc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
> index 404f17a97095..86d23c35d805 100644
> --- a/drivers/remoteproc/stm32_rproc.c
> +++ b/drivers/remoteproc/stm32_rproc.c
> @@ -493,6 +493,18 @@ static int stm32_rproc_stop(struct rproc *rproc)
>  		}
>  	}
>  
> +	/* update coprocessor state to OFF if available */
> +	if (ddata->m4_state.map) {
> +		err = regmap_update_bits(ddata->m4_state.map,
> +					 ddata->m4_state.reg,
> +					 ddata->m4_state.mask,
> +					 M4_STATE_OFF);
> +		if (err) {
> +			dev_err(&rproc->dev, "failed to set copro state\n");
> +			return err;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -531,6 +543,7 @@ static struct rproc_ops st_rproc_ops = {
>  
>  static __maybe_unused struct rproc_ops st_rproc_sync_ops = {
>  	.start		= stm32_rproc_sync_start,
> +	.stop		= stm32_rproc_stop,
>  };
>  
>  static const struct of_device_id stm32_rproc_match[] = {
> 
