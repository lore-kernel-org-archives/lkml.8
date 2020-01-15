Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE56C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FFA2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:06:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="1OD0s/Tx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgAOOGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:06:48 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1298 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726473AbgAOOGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:06:47 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00FE3wLA006867;
        Wed, 15 Jan 2020 15:06:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=Hxuc5YAXTcBUIwfsIhpo6BkPpdeKLFwzrVUlZwxB7N0=;
 b=1OD0s/TxxqyAY8iMVxN3651QEN7Ol0BWUuIV70eHw8QH/Go3T9xloervygtc6Cu/E7BY
 /r2sZI/jhZ0DBFx1S9h6lhodQL3Ec2i/3+0ZWTLncadk6VK+QM9fqDaUU2HOBzNAUuov
 wKB3M46ma6iwDBHTqfPCtDLdwmMEHWCcyGLID5f1UTzP+F+TapULNcjJhN8TgD8tKic0
 2nHgIq68jRuPXucLigUIYtYZOGpOq5CBY6JWq0vyDhF6yt5cZg1fYldOc0V3bJ2A7bHI
 P3m8PPgoSxugwAIJckHtLWF/ADUcZNxbupWn4aCGaXJ6DMUWpAyc4rO3ORaRc0vMv2Br MA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xf78sbpwa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jan 2020 15:06:37 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1A4AC10003D;
        Wed, 15 Jan 2020 15:06:35 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D80342B7735;
        Wed, 15 Jan 2020 15:06:35 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.44) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 15 Jan
 2020 15:06:35 +0100
Subject: Re: [PATCH] remoteproc: Add support for predefined notifyids
To:     Clement Leger <cleger@kalray.eu>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200115102142.11229-1-cleger@kalray.eu>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <088ceab9-f135-6e70-dcf6-f75ec46110b1@st.com>
Date:   Wed, 15 Jan 2020 15:06:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115102142.11229-1-cleger@kalray.eu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-15_02:2020-01-15,2020-01-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clément,

On 1/15/20 11:21 AM, Clement Leger wrote:
> In order to support preallocated notify ids, if their value is
> equal to FW_RSC_NOTIFY_ID_ANY, then do no allocate a notify id
> dynamically but try to allocate the requested one. This is useful when
> using custom ids to bind them to custom vendor resources. For instance,
> it allow to assign a group of queues to a specific interrupti in order
> to dispatch notifications.
> 
> Signed-off-by: Clement Leger <cleger@kalray.eu>
> ---
>  drivers/remoteproc/remoteproc_core.c | 27 +++++++++++++++++++--------
>  include/linux/remoteproc.h           |  1 +
>  2 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index 307df98347ba..b1485fcd0f11 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -351,14 +351,27 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
>  	/*
>  	 * Assign an rproc-wide unique index for this vring
>  	 * TODO: assign a notifyid for rvdev updates as well
> -	 * TODO: support predefined notifyids (via resource table)
>  	 */
> -	ret = idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
> -	if (ret < 0) {
> -		dev_err(dev, "idr_alloc failed: %d\n", ret);
> -		return ret;
> +	if (rsc->vring[i].notifyid == FW_RSC_NOTIFY_ID_ANY) {
> +		ret = idr_alloc(&rproc->notifyids, rvring, 0, 0, GFP_KERNEL);
> +		if (ret < 0) {
> +			dev_err(dev, "idr_alloc failed: %d\n", ret);
> +			return ret;
> +		}
> +		notifyid = ret;
> +
> +		/* Let the rproc know the notifyid of this vring.*/
> +		rsc->vring[i].notifyid = notifyid;
> +	} else {
> +		/* Reserve requested notify_id */
> +		notifyid = rsc->vring[i].notifyid;
> +		ret = idr_alloc(&rproc->notifyids, rvring, notifyid,
> +				notifyid + 1, GFP_KERNEL);
> +		if (ret < 0) {
> +			dev_err(dev, "idr_alloc failed: %d\n", ret);
> +			return ret;
> +		}
>  	}
> -	notifyid = ret;
>  
>  	/* Potentially bump max_notifyid */
>  	if (notifyid > rproc->max_notifyid)
> @@ -366,8 +379,6 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
>  
>  	rvring->notifyid = notifyid;
>  
> -	/* Let the rproc know the notifyid of this vring.*/
> -	rsc->vring[i].notifyid = notifyid;
>  	return 0;
>  }
The rproc_free_vring function resets the notifyid to -1 on free.
This could generate a side effect if the resource table is not reloaded.

>  
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 16ad66683ad0..dcae3394243e 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -123,6 +123,7 @@ enum fw_resource_type {
>  };
>  
>  #define FW_RSC_ADDR_ANY (-1)
> +#define FW_RSC_NOTIFY_ID_ANY (-1)This define can also be used in rproc_free_vring

Regards,
Arnaud
>  
>  /**
>   * struct fw_rsc_carveout - physically contiguous memory request
> 
