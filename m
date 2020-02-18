Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A794BC34044
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771E32067D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 16:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="fMgarB9+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgBRQbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 11:31:47 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:55164 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726551AbgBRQbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 11:31:46 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01IGHdkb028483;
        Tue, 18 Feb 2020 17:31:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=t/OxLpCsatGa1v4ymDUwZfqV30WdkujxocNYoetsmo4=;
 b=fMgarB9+LTfT9QIK37UPCosD4ZpvS1OoDQJ1Z42evEK1nslu0tWzIvAruIMMFFwX7JG5
 2pbVGZ2gjSqodI9KLUAKUr/t5mG47EJXH83cwpnXwi0M684zlVObtQucGXQ/+wA2lZb2
 HgyOdJCOLrD7DwXgSAWyeaXI+rZqF7eeAZEg/tXBydmvMUgeQ8HSyHR/qwvWAjIn37Bc
 n/06scQ4iA6ex/oDMuqJXmKcOBuhSROWwaG/jBB5xA0WigRgmcF6g/vi1yV51aK5BXMx
 KPZ4c9uxCJv0KIaUb30N0lODUpqszeI+zXWmzc4GPemXZMrOPPyYU3KetIkP6N7jMv9U 9w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y6705u94m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Feb 2020 17:31:37 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5183810002A;
        Tue, 18 Feb 2020 17:31:32 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 398AD2B2E0F;
        Tue, 18 Feb 2020 17:31:32 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.47) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Feb
 2020 17:31:31 +0100
Subject: Re: [PATCH v5 3/5] remoteproc: Add prepare/unprepare callbacks
To:     Paul Cercueil <paul@crapouillou.net>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <od@zcrc.me>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200211142614.13567-1-paul@crapouillou.net>
 <20200211142614.13567-3-paul@crapouillou.net>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <daf58c35-c240-e50a-da50-48b14c0e097c@st.com>
Date:   Tue, 18 Feb 2020 17:31:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211142614.13567-3-paul@crapouillou.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-18_04:2020-02-18,2020-02-18 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

I still wonder about the use of pm_runtime mechanism as a more generic alternative...

Else just a minor remark inline.

On 2/11/20 3:26 PM, Paul Cercueil wrote:
> The .prepare() callback is called before the firmware is loaded to
> memory. This is useful for instance in the case where some setup is
> required for the memory to be accessible.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>     v2-v4: No change
>     v5: Move calls to prepare/unprepare to rproc_fw_boot/rproc_shutdown
> 
>  drivers/remoteproc/remoteproc_core.c | 16 +++++++++++++++-
>  include/linux/remoteproc.h           |  4 ++++
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> index fe5c7a2f9767..022b927e176b 100644
> --- a/drivers/remoteproc/remoteproc_core.c
> +++ b/drivers/remoteproc/remoteproc_core.c
> @@ -1373,6 +1373,14 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  
>  	dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
>  
> +	if (rproc->ops->prepare) {
> +		ret = rproc->ops->prepare(rproc);
> +		if (ret) {
> +			dev_err(dev, "Failed to prepare rproc: %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>  	/*
>  	 * if enabling an IOMMU isn't relevant for this rproc, this is
>  	 * just a nop
> @@ -1380,7 +1388,7 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  	ret = rproc_enable_iommu(rproc);
>  	if (ret) {
>  		dev_err(dev, "can't enable iommu: %d\n", ret);
> -		return ret;
> +		goto unprepare_rproc;
>  	}
>  
>  	rproc->bootaddr = rproc_get_boot_addr(rproc, fw);
> @@ -1424,6 +1432,9 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>  	rproc->table_ptr = NULL;
>  disable_iommu:
>  	rproc_disable_iommu(rproc);
> +unprepare_rproc:
> +	if (rproc->ops->unprepare)
> +		rproc->ops->unprepare(rproc);
>  	return ret;
>  }
>  
> @@ -1823,6 +1834,9 @@ void rproc_shutdown(struct rproc *rproc)
>  
>  	rproc_disable_iommu(rproc);
>  
> +	if (rproc->ops->unprepare)
> +		rproc->ops->unprepare(rproc);
> +
>  	/* Free the copy of the resource table */
>  	kfree(rproc->cached_table);
>  	rproc->cached_table = NULL;
> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
> index 5f201f0c86c3..a6272d1ba384 100644
> --- a/include/linux/remoteproc.h
> +++ b/include/linux/remoteproc.h
> @@ -355,6 +355,8 @@ enum rsc_handling_status {
>  
>  /**
>   * struct rproc_ops - platform-specific device handlers
> + * @prepare:	prepare the device for power up (before the firmware is loaded)
> + * @unprepare:	unprepare the device after it is stopped

Would be nice here to precise that these functions are optional
you can look at rproc_ops struct for example.

Regards,
Arnaud

>   * @start:	power on the device and boot it
>   * @stop:	power off the device
>   * @kick:	kick a virtqueue (virtqueue id given as a parameter)
> @@ -371,6 +373,8 @@ enum rsc_handling_status {
>   * @get_boot_addr:	get boot address to entry point specified in firmware
>   */
>  struct rproc_ops {
> +	int (*prepare)(struct rproc *rproc);
> +	void (*unprepare)(struct rproc *rproc);
>  	int (*start)(struct rproc *rproc);
>  	int (*stop)(struct rproc *rproc);
>  	void (*kick)(struct rproc *rproc, int vqid);
> 
