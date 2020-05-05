Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C61C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11727206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 08:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="sR9rxrTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgEEIHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 04:07:35 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51328 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725766AbgEEIHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 04:07:34 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0457vVLS020525;
        Tue, 5 May 2020 10:07:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=aIfhRbdeh/NaBeUbm7FmjxAIsbrh2SvuYvtd3MtdPwk=;
 b=sR9rxrTaoSTM2Kxy/l9geSP2SSdAV7iQ5mPwHVKEZm4B8Me9zuTuH4bArIoym9DqQXWR
 zsUUm7rwS6el6VPeHi9Ht4uizeIf3IDKSBNxQQnhx9GG7/4+Wtfc30kHSRGNgvs8JWBA
 DKvrTseWhEqZb4ECu21xtal7YIHvJEu559qMJFsqz1zlDehwxF5OnhP9BXL8sJzDOLbK
 D0EkD2dVUADQftkMeeYGcnxIIbXPS3tq3MCXHFndvQCqziRAQ9kSpXZgLQsdx63BmaYa
 8DGwg2TYwN/cMN9JCd/Tq+H9ktf5GySSxY7KlTSjBoXxcmTC+dTdW1GwR5q/27cD4x49 lQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30ryrj6nnr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 May 2020 10:07:32 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3BC1210002A;
        Tue,  5 May 2020 10:07:25 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2CF7E2A6CD3;
        Tue,  5 May 2020 10:07:25 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.44) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 5 May
 2020 10:07:24 +0200
Subject: Re: [PATCH v4 2/2] rpmsg: core: Add support to retrieve name
 extension
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200504215830.31394-1-mathieu.poirier@linaro.org>
 <20200504215830.31394-3-mathieu.poirier@linaro.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <976bfec3-17bc-1f52-d235-77b34321404c@st.com>
Date:   Tue, 5 May 2020 10:07:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504215830.31394-3-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-05_04:2020-05-04,2020-05-05 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,



On 5/4/20 11:58 PM, Mathieu Poirier wrote:
> After adding support for rpmsg device name extension, this patch
> provides a function that returns the extension portion of an rpmsg
> device name.  That way users of the name extension functionality don't
> have to write the same boiler plate code to extract the information.
I do not test it yet,but LGTM.
I plan to use these patches for the rpmsg_tty.
Please find few remarks below.

> 
> Suggested-by: Suman Anna <s-anna@ti.com>;
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  drivers/rpmsg/rpmsg_core.c | 92 ++++++++++++++++++++++++++++++++++++++
>  include/linux/rpmsg.h      | 13 ++++++
>  2 files changed, 105 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index 5e01e8dede6b..dae87c0cb73d 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -439,6 +439,98 @@ static int rpmsg_dev_match(struct device *dev, struct device_driver *drv)
>  	return of_driver_match_device(dev, drv);
>  }
>  
> +/**
> + * rpmsg_device_get_name_extension() - get the name extension of a rpmsg device
> + * @rpdev: the rpmsg device to work with
> + * @skip: how many characters in the extension should be skipped over
> + *
> + * With function rpmsg_id_match() allowing for extension of the base driver name
> + * in order to differentiate services, this function returns the extension part
> + * of an rpmsg device name.  As such and with the following rpmsg driver device
> + * id table and rpmsg device names:
> + *
> + * static struct rpmsg_device_id rpmsg_driver_sample_id_table[] = {
> + *      { .name = "rpmsg-client-sample" },
> + *      { },
> + * }
> + *
> + * rpdev1->id.name == "rpmsg-client-sample";
> + * rpdev2->id.name == "rpmsg-client-sample_instance0";
> + *
> + * Calling rpmsg_device_get_name_extension() will yields the following:
> + *
> + * rpmsg_device_get_name_extension(rpdev1, 0) == NULL;
> + * rpmsg_device_get_name_extension(rpdev2, 0) == "_instance0";
> + * rpmsg_device_get_name_extension(rpdev2, 1) == "instance0";
> + *
> + *
> + * Note: The name extension should be free'd using kfree_const().
> + *
> + * Return: the name extension if found, NULL if not found and an error
> + * code otherwise.
> + */
> +const char *rpmsg_device_get_name_extension(struct rpmsg_device *rpdev,
> +					    unsigned int skip)
> +{
> +	const char *drv_name, *dev_name, *extension;
> +	const struct rpmsg_device_id *ids;
> +	struct device *dev = &rpdev->dev;
> +	struct rpmsg_driver *rpdrv;
> +	bool match = false;
> +	unsigned int i;
> +
> +	if (!dev->driver)
> +		return ERR_PTR(-EINVAL);
> +
> +	rpdrv = to_rpmsg_driver(dev->driver);
> +
> +	/*
> +	 * No point in going further if the device and the driver don't
> +	 * have a name or a table to work with.
> +	 */
> +	if (!rpdev->id.name[0] || !rpdrv->id_table)
> +		return ERR_PTR(-EINVAL);
> +
> +	ids = rpdrv->id_table;
> +	dev_name = rpdev->id.name;
> +
> +	/*
> +	 * See if any name in the driver's table match the beginning
> +	 * of the rpmsg device's name.
> +	 */
> +	for (i = 0; ids[i].name[0]; i++) {
> +		drv_name = ids[i].name;
> +		if (strncmp(drv_name,
> +			    dev_name, strlen(drv_name)) == 0) {
> +			match = true;
> +			break;
> +		}
> +	}
> +
> +	if (!match)
> +		return NULL;
here i would return an error to differentiate unmatch and name without extension.
> +
> +	 /* No name extension to return if device and driver are the same */
> +	if (strlen(dev_name) == strlen(drv_name))
> +		return NULL;
> +
> +	/*
> +	 * Make sure we were not requested to skip past the end
> +	 * of the device name.
> +	 */
> +	if (strlen(drv_name) + skip >= strlen(dev_name))
> +		return ERR_PTR(-EINVAL);
> +
> +	/*
> +	 * Move past the base name published by the driver and
> +	 * skip any extra characters if needed.
> +	 */
> +	extension = dev_name + strlen(drv_name) + skip;
> +
> +	return kstrdup_const(extension, GFP_KERNEL);
what about just returning the extension pointer? 
rpdev->id.name should be valid until device is unregistered.

Regards
Arnaud

> +}
> +EXPORT_SYMBOL(rpmsg_device_get_name_extension);
> +
>  static int rpmsg_uevent(struct device *dev, struct kobj_uevent_env *env)
>  {
>  	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> index 9fe156d1c018..9537b95ad30a 100644
> --- a/include/linux/rpmsg.h
> +++ b/include/linux/rpmsg.h
> @@ -135,6 +135,9 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>  __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
>  			poll_table *wait);
>  
> +const char *rpmsg_device_get_name_extension(struct rpmsg_device *dev,
> +					    unsigned int skip);
> +
>  #else
>  
>  static inline int register_rpmsg_device(struct rpmsg_device *dev)
> @@ -242,6 +245,16 @@ static inline __poll_t rpmsg_poll(struct rpmsg_endpoint *ept,
>  	return 0;
>  }
>  
> +static inline
> +const char *rpmsg_device_get_name_extension(struct rpmsg_device *dev,
> +					    unsigned int skip)
> +{
> +	/* This shouldn't be possible */
> +	WARN_ON(1);
> +
> +	return NULL;
> +}
> +
>  #endif /* IS_ENABLED(CONFIG_RPMSG) */
>  
>  /* use a macro to avoid include chaining to get THIS_MODULE */
> 
