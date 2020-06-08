Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43950C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 243302074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XHWkmWB3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgFHWra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:47:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56096 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgFHWr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 18:47:29 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 058MlPaE050473;
        Mon, 8 Jun 2020 17:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591656445;
        bh=JTj7H+bWQ50L0w3gmhUU8lvfINHUiaK8WNziobU7SBE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XHWkmWB3ttKSJ5CBrj2IIC5P/UmNkNWd7X/pVJsMdnUTF1aEKcrBrrkvDjr0lPTTs
         7As8+dzP8NuP8mpBidza4PPUumj0PvfrDLdyH1oCCpcOxA/SopVkx/PHXuHBevNUd3
         cttR9MGciO/S15CfieYNqT8cxZMcxC+64nb2m4V4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 058MlPqP006026
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 8 Jun 2020 17:47:25 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 8 Jun
 2020 17:47:25 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 8 Jun 2020 17:47:24 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 058MlOkE124381;
        Mon, 8 Jun 2020 17:47:24 -0500
Subject: Re: [PATCH v6 2/3] rpmsg: core: Add support to retrieve name
 extension
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>
CC:     <arnaud.pouliquen@st.com>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200515205642.13529-1-mathieu.poirier@linaro.org>
 <20200515205642.13529-3-mathieu.poirier@linaro.org>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <632db4a1-74e0-edc4-78ca-53109f11ace8@ti.com>
Date:   Mon, 8 Jun 2020 17:47:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515205642.13529-3-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 5/15/20 3:56 PM, Mathieu Poirier wrote:
> After adding support for rpmsg device name extension, this patch
> provides a function that returns the extension portion of an rpmsg
> device name.  That way users of the name extension functionality don't
> have to write the same boiler plate code to extract the information.
> 
> Suggested-by: Suman Anna <s-anna@ti.com>;
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>

With the below minor nits fixed,

Acked-by: Suman Anna <s-anna@ti.com>

> ---
>   drivers/rpmsg/rpmsg_core.c | 95 ++++++++++++++++++++++++++++++++++++++
>   include/linux/rpmsg.h      | 13 ++++++
>   2 files changed, 108 insertions(+)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index 5e01e8dede6b..9583eb936607 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -439,6 +439,101 @@ static int rpmsg_dev_match(struct device *dev, struct device_driver *drv)
>   	return of_driver_match_device(dev, drv);
>   }
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

can drop the additional blank line here,

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

This does fit on the same line, so no need to use multi-lines for this.

regards
Suman

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
>   static int rpmsg_uevent(struct device *dev, struct kobj_uevent_env *env)
>   {
>   	struct rpmsg_device *rpdev = to_rpmsg_device(dev);
> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
> index 9fe156d1c018..9537b95ad30a 100644
> --- a/include/linux/rpmsg.h
> +++ b/include/linux/rpmsg.h
> @@ -135,6 +135,9 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>   __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
>   			poll_table *wait);
>   
> +const char *rpmsg_device_get_name_extension(struct rpmsg_device *dev,
> +					    unsigned int skip);
> +
>   #else
>   
>   static inline int register_rpmsg_device(struct rpmsg_device *dev)
> @@ -242,6 +245,16 @@ static inline __poll_t rpmsg_poll(struct rpmsg_endpoint *ept,
>   	return 0;
>   }
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
>   #endif /* IS_ENABLED(CONFIG_RPMSG) */
>   
>   /* use a macro to avoid include chaining to get THIS_MODULE */
> 

