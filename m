Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE98C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 08:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640DF20739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 08:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="gn7N3NGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgCTIkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 04:40:07 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43948 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726527AbgCTIkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 04:40:06 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02K8dVYs003478;
        Fri, 20 Mar 2020 09:40:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=32GzffpVzc2cB9jvdwHMX6tkDUH2CCvIKSWhuyXMbvU=;
 b=gn7N3NGai+0NH3ScQstPM9Yta9NDaXcZyEpQ+1LpBysPMjDIB8WRWYZdiTg6sIqlx5Bm
 jwEeRhJjaraO7SO/OwCVTyvANsjZOCxA8D3hoxukb0jVBi4aY6ccfSzoZwV2d/6u28t4
 2fol0Z4shtjXXnKfr5+cdyCQp4ezpB5bi3338BI63BNgEv0Sc8djDIMZRl74sxIFXKOb
 W1T/qMvWn84jd3s7rY0UiWsIncx7dFrpFpr2fHEIzhGURFAqgj8ILwgqTcEiumyLFVj1
 g4uC6tWlZyUljY5AMqkDgrVmbgmc1uAhzaq5yehVB3I5Ld1CPFUNIuIveDOL/GrQ1l9f MQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yu95ux9e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Mar 2020 09:40:01 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5CC26100034;
        Fri, 20 Mar 2020 09:39:56 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3C4EC220999;
        Fri, 20 Mar 2020 09:39:56 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.50) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 20 Mar
 2020 09:39:55 +0100
Subject: Re: [PATCH v2 1/2] remoteproc: fall back to using parent memory pool
 if no dedicated available
To:     Suman Anna <s-anna@ti.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tero Kristo <t-kristo@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200319162321.20632-1-s-anna@ti.com>
 <20200319162321.20632-2-s-anna@ti.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <4fa1d2a9-c4a0-28f6-fd7a-5f54ee12531a@st.com>
Date:   Fri, 20 Mar 2020 09:39:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200319162321.20632-2-s-anna@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-20_01:2020-03-19,2020-03-20 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman,

On 3/19/20 5:23 PM, Suman Anna wrote:
> From: Tero Kristo <t-kristo@ti.com>
> 
> In some cases, like with OMAP remoteproc, we are not creating dedicated
> memory pool for the virtio device. Instead, we use the same memory pool
> for all shared memories. The current virtio memory pool handling forces
> a split between these two, as a separate device is created for it,
> causing memory to be allocated from bad location if the dedicated pool
> is not available. Fix this by falling back to using the parent device
> memory pool if dedicated is not available.
> 
> Fixes: 086d08725d34 ("remoteproc: create vdev subdevice with specific dma memory pool")
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
> v2:
>  - Address Arnaud's concerns about hard-coded memory-region index 0
>  - Update the comment around the new code addition
> v1: https://patchwork.kernel.org/patch/11422721/
> 
>  drivers/remoteproc/remoteproc_virtio.c | 15 +++++++++++++++
>  include/linux/remoteproc.h             |  2 ++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
> index eb817132bc5f..b687715cdf4b 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -369,6 +369,21 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
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
> +		 * the rvdev dev to allocate from, and this can be customized
> +		 * by updating the vdevbuf_mem_id in platform drivers if
> +		 * desired. Failure is non-critical and the allocations will
> +		 * fall back to global pools, so don't check return value
> +		 * either.
> +		 */
> +		of_reserved_mem_device_init_by_idx(dev, np,
> +						   rproc->vdevbuf_mem_id);
>  	}
>  
>  	/* Allocate virtio device */
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index ed127b2d35ca..07bd73a6d72a 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -481,6 +481,7 @@ struct rproc_dump_segment {
>   * @auto_boot: flag to indicate if remote processor should be auto-started
>   * @dump_segments: list of segments in the firmware
>   * @nb_vdev: number of vdev currently handled by rproc
> + * @vdevbuf_mem_id: default memory-region index for allocating vdev buffers
>   */
>  struct rproc {
>  	struct list_head node;
> @@ -514,6 +515,7 @@ struct rproc {
>  	bool auto_boot;
>  	struct list_head dump_segments;
>  	int nb_vdev;
> +	u8 vdevbuf_mem_id;
>  	u8 elf_class;
>  };
>

LGTM, just a minor remark concerning the name. As this memory region could be used for
different allocations (e.g rpmsg device allocation, vrings...) i would suggest you to rename
it with a more generic name such as shared_mem_id or default_shmem_id.
Anyway, first let's wait for further feedback on your solution. 

Thanks,
Arnaud
 
