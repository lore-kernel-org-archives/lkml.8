Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B307C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D861520671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="vNUDEN/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgEOOnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:43:18 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:41127 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726197AbgEOOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:43:17 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04FDmbr1012555;
        Fri, 15 May 2020 16:43:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=F04sQ1TZ22kgx1zdX1z57bhDQ5bWxO9h2V/DsaC5rcQ=;
 b=vNUDEN/ojcyqtVaByhzXqr/Yx3PXPkqTZuZ6NKWK2vIZNTfKEQGY/n/Z4AX11lFBYlSM
 O8G/9TQLdsLbKm0Oq6gwg417YllRM9CChzyqcrtV6QBccZhLmbKoCdODkfepFzfnYIVN
 7s+wniXR+GTppWmDKECASuKAuEuFq1pJ2NCJ5XuGep4khzENQZ6V6ckm+G6trKhMqcCp
 FGD5zTy4lEzNvAXRQO2KKl8IerrcNxGy7rH4pTMmx2Mn8x5Ul16e09eImpqZ4BipUe9Z
 zSHJz/Ma08MjwykCRzRMjfmCoT0hNydkJLrWOW8H8b53Sdcvtoxb1zC15gFjTgXse5Q/ Qw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3100vqtjjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 May 2020 16:43:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C76AA10002A;
        Fri, 15 May 2020 16:43:12 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B44AD2CD9CF;
        Fri, 15 May 2020 16:43:12 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.48) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 15 May
 2020 16:43:11 +0200
Subject: Re: [PATCH v5 2/2] rpmsg: core: Add support to retrieve name
 extension
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200514204022.24233-1-mathieu.poirier@linaro.org>
 <20200514204022.24233-3-mathieu.poirier@linaro.org>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <24a100a8-5244-aedc-6742-16173cf429ce@st.com>
Date:   Fri, 15 May 2020 16:43:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200514204022.24233-3-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-15_05:2020-05-15,2020-05-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu


On 5/14/20 10:40 PM, Mathieu Poirier wrote:
> After adding support for rpmsg device name extension, this patch
> provides a function that returns the extension portion of an rpmsg
> device name.  That way users of the name extension functionality don't
> have to write the same boiler plate code to extract the information.
> 
> Suggested-by: Suman Anna <s-anna@ti.com>;
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>

Probably what is missing now it is an upstreamed client. :)
If a client is mandatory sample/rpmsg/rpmsg_client_sample.c could be 
a good candidate, using extension to construct the "Hello" message...

Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

Regards,
Arnaud

> ---
>  drivers/rpmsg/rpmsg_core.c | 95 ++++++++++++++++++++++++++++++++++++++
>  include/linux/rpmsg.h      | 13 ++++++
>  2 files changed, 108 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index 5e01e8dede6b..9583eb936607 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -439,6 +439,101 @@ static int rpmsg_dev_match(struct device *dev, struct device_driver *drv)
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
> + * Return: The name extension if found, NULL if the name of the RPMSG device
> + *	   equals the name of the RPMSG driver and an error if no match is
> + *	   found or a validation problem has occurred.
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
> +	 * No point in going further if the device doesn't have name or
> +	 * the driver doesn't have a table to work with.
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
> +	/*
> +	 * A match was not found, return an error to differentiate with cases
> +	 * where a match was found but the name has no extension (see below).
> +	 */
> +	if (!match)
> +		return ERR_PTR(-ENOENT);
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
> +	return extension;
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
