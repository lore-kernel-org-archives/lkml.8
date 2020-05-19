Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01926C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD180207D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 18:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589914288;
	bh=N3Rmqnyt3Hn0BZxaSJAf/VpirlsfY1fOubhrpANcMDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W8DdofyAwzDUjcAuvKZZoENSB6SMDxx6G3R/iD/PSjy/v0onsBPuZZBPggRjGWr4G
	 Raw7unKF91Jj9GPmakw3jyxpci+rRS26VopSR0RK3Ic/l9ME7EzNewzT5JAsFmTgst
	 DX4ZkmFgeLlqmYVMxjD8u8HUxw3WJ9u1C5522bPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgESSv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 14:51:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:37071 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbgESSv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 14:51:27 -0400
Received: by mail-io1-f67.google.com with SMTP id t15so320973ios.4;
        Tue, 19 May 2020 11:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y+rThpqnouaarZJBNHrzhWUMK5mQzFEpA9EtnE8iwrE=;
        b=JALg8fx4kdUu8MZyNLhRo2f4/1XrR0mXmwcXB6tQIxvNxRCP6g+9ek475V0739sBKk
         DhiOkwaTEqYg3AL5ij/+NcjXxu9rOWdN3NzjT1oEgyT9d/LiFclMxd16cS34LqSbDIE8
         5U3e+SjhymvgIiax2OkVRQfNPNzS+N84P8SVAHQSZSlvMAoFUN1+Zcq+oQFi55J/KnwH
         LRw/CKkUxO5Nc50M77dqk8fHfj80biFDPmv31FRfbHJiRAW+Yn63pDU3iIgbE5KDft+s
         ay+yFBuC0VFBuU4gIHpWrbiNHzCwxjl6+KvFuFmLHoRVHHuA2MgP3arN2KtM7O5kyUy7
         m/lg==
X-Gm-Message-State: AOAM5339z/5pfSZg2mbEh2iQazLcn/2sOilawr47vv+eHtJLuQKzP9MV
        /sIv2GYhn2w2Gf7Lrqe4EA==
X-Google-Smtp-Source: ABdhPJwPb2x/YMEXlek6x8vMJYuRaAHgny4Tr3Xx9zRdVi6oySA91PyJNTmhCwbd10bu5cIqYa1+5Q==
X-Received: by 2002:a5d:9d51:: with SMTP id k17mr300495iok.85.1589914286772;
        Tue, 19 May 2020 11:51:26 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id f18sm176314ioh.30.2020.05.19.11.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 11:51:26 -0700 (PDT)
Received: (nullmailer pid 463879 invoked by uid 1000);
        Tue, 19 May 2020 18:51:25 -0000
Date:   Tue, 19 May 2020 12:51:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     john.garry@huawei.com, will@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 RESEND 1/3] perf/imx_ddr: Add system PMU identifier
 for userspace
Message-ID: <20200519185125.GB453195@bogus>
References: <20200512073115.14177-1-qiangqing.zhang@nxp.com>
 <20200512073115.14177-2-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512073115.14177-2-qiangqing.zhang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 03:31:13PM +0800, Joakim Zhang wrote:
> The DDR Perf for i.MX8 is a system PMU whose axi id would different from
> SoC to SoC. Need expose system PMU identifier for userspace which refer
> to /sys/bus/event_source/devices/<PMU DEVICE>/identifier.

Why not just expose the AXI ID if that's what's different?

> 
> Reviewed-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  drivers/perf/fsl_imx8_ddr_perf.c | 45 +++++++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
> index 95dca2cb5265..88addbffbbd0 100644
> --- a/drivers/perf/fsl_imx8_ddr_perf.c
> +++ b/drivers/perf/fsl_imx8_ddr_perf.c
> @@ -50,21 +50,38 @@ static DEFINE_IDA(ddr_ida);
>  
>  struct fsl_ddr_devtype_data {
>  	unsigned int quirks;    /* quirks needed for different DDR Perf core */
> +	const char *identifier;	/* system PMU identifier for userspace */
>  };
>  
> -static const struct fsl_ddr_devtype_data imx8_devtype_data;
> +static const struct fsl_ddr_devtype_data imx8_devtype_data = {
> +	.identifier = "i.MX8",
> +};
> +
> +static const struct fsl_ddr_devtype_data imx8mq_devtype_data = {
> +	.quirks = DDR_CAP_AXI_ID_FILTER,
> +	.identifier = "i.MX8MQ",
> +};
> +
> +static const struct fsl_ddr_devtype_data imx8mm_devtype_data = {
> +	.quirks = DDR_CAP_AXI_ID_FILTER,
> +	.identifier = "i.MX8MM",
> +};
>  
> -static const struct fsl_ddr_devtype_data imx8m_devtype_data = {
> +static const struct fsl_ddr_devtype_data imx8mn_devtype_data = {
>  	.quirks = DDR_CAP_AXI_ID_FILTER,
> +	.identifier = "i.MX8MN",
>  };
>  
>  static const struct fsl_ddr_devtype_data imx8mp_devtype_data = {
>  	.quirks = DDR_CAP_AXI_ID_FILTER_ENHANCED,
> +	.identifier = "i.MX8MP",
>  };
>  
>  static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
>  	{ .compatible = "fsl,imx8-ddr-pmu", .data = &imx8_devtype_data},
> -	{ .compatible = "fsl,imx8m-ddr-pmu", .data = &imx8m_devtype_data},

You need to keep the old one for compatibility.

> +	{ .compatible = "fsl,imx8mq-ddr-pmu", .data = &imx8mq_devtype_data},
> +	{ .compatible = "fsl,imx8mm-ddr-pmu", .data = &imx8mm_devtype_data},
> +	{ .compatible = "fsl,imx8mn-ddr-pmu", .data = &imx8mn_devtype_data},
>  	{ .compatible = "fsl,imx8mp-ddr-pmu", .data = &imx8mp_devtype_data},
>  	{ /* sentinel */ }
>  };
> @@ -84,6 +101,27 @@ struct ddr_pmu {
>  	int id;
>  };
>  
> +static ssize_t ddr_perf_identifier_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *page)
> +{
> +	struct ddr_pmu *pmu = dev_get_drvdata(dev);
> +
> +	return sprintf(page, "%s\n", pmu->devtype_data->identifier);

Why do we need yet another way to identify the SoC from userspace?

> +}
> +
> +static struct device_attribute ddr_perf_identifier_attr =
> +	__ATTR(identifier, 0444, ddr_perf_identifier_show, NULL);

sysfs attributes are supposed to be documented.

> +
> +static struct attribute *ddr_perf_identifier_attrs[] = {
> +	&ddr_perf_identifier_attr.attr,
> +	NULL,
> +};
> +
> +static struct attribute_group ddr_perf_identifier_attr_group = {
> +	.attrs = ddr_perf_identifier_attrs,
> +};
> +
>  enum ddr_perf_filter_capabilities {
>  	PERF_CAP_AXI_ID_FILTER = 0,
>  	PERF_CAP_AXI_ID_FILTER_ENHANCED,
> @@ -237,6 +275,7 @@ static const struct attribute_group *attr_groups[] = {
>  	&ddr_perf_format_attr_group,
>  	&ddr_perf_cpumask_attr_group,
>  	&ddr_perf_filter_cap_attr_group,
> +	&ddr_perf_identifier_attr_group,
>  	NULL,
>  };
>  
> -- 
> 2.17.1
> 
