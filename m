Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB20C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F179C2074B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="uGkiyGUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgGIIc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:32:57 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:56139 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726193AbgGIIc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:32:56 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0698TmA4019421;
        Thu, 9 Jul 2020 10:32:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=W2Iv6Br/F8a/XpQJdQSfkI1+6W8aMHIof4Dwn81Y06I=;
 b=uGkiyGUY4AoGwwW0yy5r/Pb2V5LYzbTTwZCIQtbXZFVOzjeVm7KY0Qj7gaaZ8UFOTMar
 T1QRa/KlB3TKpcJQCcLTwDxQHDsYKUwFBeyV1ECzX+SYHTOSjVFxjRiv+g/kR/FkKK+A
 sIv/mHtoZS4ywT6GS1EjVtBc22ny0VofG9n1My2UOcJvRc8DnNnakvpvRyqAyl4n+D1k
 /aUOj+6S5Qzqr5EUvL4P2ONfgY1CqG+PL26AnhgG52zDJEdVZYe1a8dFsJlOwil2CSYv
 bbcGOI8T04kFkvi7wSiO1lnkKShMBugFvPVnuh5GD657+nrMTOOBJlDHCG7Ptvt+JJAf vQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 325k3vuf8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Jul 2020 10:32:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3FD3C10002A;
        Thu,  9 Jul 2020 10:32:53 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3198E2A934B;
        Thu,  9 Jul 2020 10:32:53 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.51) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jul
 2020 10:32:52 +0200
Subject: Re: [PATCH v5 5/9] remoteproc: Introducing function rproc_validate()
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>
CC:     "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200707210014.927691-1-mathieu.poirier@linaro.org>
 <20200707210014.927691-6-mathieu.poirier@linaro.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <5f81f8cb-bf29-40cb-57e1-918e0d997431@st.com>
Date:   Thu, 9 Jul 2020 10:32:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707210014.927691-6-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-09_04:2020-07-08,2020-07-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/20 11:00 PM, Mathieu Poirier wrote:
> Add a new function to assert the general health of the remote
> processor before handing it to the remoteproc core.
> 
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Thanks,
Arnaud

> ---
>  drivers/remoteproc/remoteproc_core.c | 41 ++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index fd424662801f..ad500c291d5f 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -2040,6 +2040,43 @@ struct rproc *rproc_get_by_phandle(phandle phandle)
>  #endif
>  EXPORT_SYMBOL(rproc_get_by_phandle);
>  
> +static int rproc_validate(struct rproc *rproc)
> +{
> +	switch (rproc->state) {
> +	case RPROC_OFFLINE:
> +		/*
> +		 * An offline processor without a start()
> +		 * function makes no sense.
> +		 */
> +		if (!rproc->ops->start)
> +			return -EINVAL;
> +		break;
> +	case RPROC_DETACHED:
> +		/*
> +		 * A remote processor in a detached state without an
> +		 * attach() function makes not sense.
> +		 */
> +		if (!rproc->ops->attach)
> +			return -EINVAL;
> +		/*
> +		 * When attaching to a remote processor the device memory
> +		 * is already available and as such there is no need to have a
> +		 * cached table.
> +		 */
> +		if (rproc->cached_table)
> +			return -EINVAL;
> +		break;
> +	default:
> +		/*
> +		 * When adding a remote processor, the state of the device
> +		 * can be offline or detached, nothing else.
> +		 */
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  /**
>   * rproc_add() - register a remote processor
>   * @rproc: the remote processor handle to register
> @@ -2069,6 +2106,10 @@ int rproc_add(struct rproc *rproc)
>  	if (ret < 0)
>  		return ret;
>  
> +	ret = rproc_validate(rproc);
> +	if (ret < 0)
> +		return ret;
> +
>  	dev_info(dev, "%s is available\n", rproc->name);
>  
>  	/* create debugfs entries */
> 
