Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACECC47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A49D32082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="NM0ilE1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgEGPwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:52:19 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:64074 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727794AbgEGPwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:52:18 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 047FlQ6J000799;
        Thu, 7 May 2020 17:52:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=4nrPwlooEKXxqANt3eO2v41DucRALo8qLG3CN5HftvE=;
 b=NM0ilE1no1NYlwxIySPJ6mTfapJStGQ24UQ7AP+RE4opFUzTpis+BcupHtBmo8w1nwOF
 wkD5tejKTVn7iXMlI9s+7ZJL+Ta9U/RqPTUU6nhob0qp/54wDo8E16UriX6DXrZGhmNP
 rqCEPOSXJe5+5PbgJ6bqN3+YvaAtKh1lFShej5je5I58v2mMtOOV18F5AxSHO3FC790K
 /I2yr/8B2eUyggsC+ajdYb+1L2k3UgS/5/xfZmFq05CtoAi3WsO411aD3O/PZKU7xoEb
 uAf37BU1KzTt7PRgRjK4aFVwN2V7y17f5klA3iBGgLTuoq76yiziTW47OHvm/JdPewgR Og== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30rxb2cnm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 May 2020 17:52:10 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 231B610002A;
        Thu,  7 May 2020 17:52:10 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0B83A2CB27F;
        Thu,  7 May 2020 17:52:10 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.51) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 7 May
 2020 17:52:09 +0200
Subject: Re: [PATCH v3 1/2] remoteproc: Fall back to using parent memory pool
 if no dedicated available
To:     Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        Tero Kristo <t-kristo@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200420160600.10467-1-s-anna@ti.com>
 <20200420160600.10467-2-s-anna@ti.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <ee210c43-eeda-6980-2c74-6a8e4f4de7f6@st.com>
Date:   Thu, 7 May 2020 17:52:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420160600.10467-2-s-anna@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-07_10:2020-05-07,2020-05-07 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman

On 4/20/20 6:05 PM, Suman Anna wrote:
> From: Tero Kristo <t-kristo@ti.com>
> 
> In some cases, like with OMAP remoteproc, we are not creating dedicated
> memory pool for the virtio device. Instead, we use the same memory pool
> for all shared memories. The current virtio memory pool handling forces
> a split between these two, as a separate device is created for it,
> causing memory to be allocated from bad location if the dedicated pool
> is not available. Fix this by falling back to using the parent device
> memory pool if dedicated is not available.

As it fixes the implementation of the legacy, that seems reasonable to me.
 
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

> 
> Fixes: 086d08725d34 ("remoteproc: create vdev subdevice with specific dma memory pool")
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v3:
>  - Go back to v1 logic (removed the vdevbuf_mem_id variable added in v2)
>  - Revised the comment to remove references to vdevbuf_mem_id
>  - Capitalize the patch header
> v2: https://patchwork.kernel.org/patch/11447651/
> 
>  drivers/remoteproc/remoteproc_virtio.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index e61d738d9b47..44187fe43677 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -376,6 +376,18 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
>  				goto out;
>  			}
>  		}
> +	} else {
> +		struct device_node *np = rproc->dev.parent->of_node;
> +
> +		/*
> +		 * If we don't have dedicated buffer, just attempt to re-assign
> +		 * the reserved memory from our parent. A default memory-region
> +		 * at index 0 from the parent's memory-regions is assigned for
> +		 * the rvdev dev to allocate from. Failure is non-critical and
> +		 * the allocations will fall back to global pools, so don't
> +		 * check return value either.
> +		 */
> +		of_reserved_mem_device_init_by_idx(dev, np, 0);
>  	}
>  
>  	/* Allocate virtio device */
> 
