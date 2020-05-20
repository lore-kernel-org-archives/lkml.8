Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A390C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35026207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589960521;
	bh=lF7qPacJPzgODON1dCxvm8X9ZeJrLrmX+CSPXciqLRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dxBEZZfx2fjcuSrdHtDTWf14mO+mVH5826bLDjMN2CZiB5TtxUCT22f0n11yJQ8Lz
	 Tvm40FVSy6OqTIrmsPwjBY4c1arh74M8R8h+otasHeAQ/jniEKJK29IScyUFEMcWb+
	 3vXGjLqueRi8eZRwzCAhZwvOo8u9Yft95O89pkdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgETHmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 03:42:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726566AbgETHmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:42:00 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0B8D207D3;
        Wed, 20 May 2020 07:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589960519;
        bh=lF7qPacJPzgODON1dCxvm8X9ZeJrLrmX+CSPXciqLRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ia0TwmQnc6ZZdJmV24OWMsg7Vr8OSYGwWaXu49hX7APgJbDlXdtnE8XRmdPZjh+Td
         mFYmbVMbkVbN3pv+cP8dO4Et3zp18+lTpVb30ob/KP+nfQxSRhq06XtSKbJJr8Yi5M
         GeVUWLlfMFOIL0vYqmCLv4LzDGdHbWIH2bBizYf0=
Date:   Wed, 20 May 2020 08:41:54 +0100
From:   Will Deacon <will@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     john.garry@huawei.com, mark.rutland@arm.com, robh+dt@kernel.org,
        shawnguo@kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/3] perf/imx_ddr: Add system PMU identifier for
 userspace
Message-ID: <20200520074154.GA23818@willie-the-truck>
References: <20200520025619.687-1-qiangqing.zhang@nxp.com>
 <20200520025619.687-3-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520025619.687-3-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 10:56:18AM +0800, Joakim Zhang wrote:
> The DDR Perf for i.MX8 is a system PMU whose axi id would different from
> SoC to SoC. Need expose system PMU identifier for userspace which refer
> to /sys/bus/event_source/devices/<PMU DEVICE>/identifier.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  drivers/perf/fsl_imx8_ddr_perf.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
> index 90884d14f95f..ba523a94f4d7 100644
> --- a/drivers/perf/fsl_imx8_ddr_perf.c
> +++ b/drivers/perf/fsl_imx8_ddr_perf.c
> @@ -76,6 +76,7 @@ struct ddr_pmu {
>  	unsigned int cpu;
>  	struct	hlist_node node;
>  	struct	device *dev;
> +	const char *identifier;
>  	struct perf_event *events[NUM_COUNTERS];
>  	int active_events;
>  	enum cpuhp_state cpuhp_state;
> @@ -84,6 +85,27 @@ struct ddr_pmu {
>  	int id;
>  };
>  
> +static ssize_t ddr_perf_identifier_show(struct device *dev,
> +					struct device_attribute *attr,
> +					char *page)
> +{
> +	struct ddr_pmu *pmu = dev_get_drvdata(dev);
> +
> +	return sprintf(page, "%s\n", pmu->identifier);
> +}
> +
> +static struct device_attribute ddr_perf_identifier_attr =
> +	__ATTR(identifier, 0444, ddr_perf_identifier_show, NULL);
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
> @@ -237,6 +259,7 @@ static const struct attribute_group *attr_groups[] = {
>  	&ddr_perf_format_attr_group,
>  	&ddr_perf_cpumask_attr_group,
>  	&ddr_perf_filter_cap_attr_group,
> +	&ddr_perf_identifier_attr_group,
>  	NULL,
>  };
>  
> @@ -601,6 +624,7 @@ static int ddr_perf_probe(struct platform_device *pdev)
>  	struct ddr_pmu *pmu;
>  	struct device_node *np;
>  	void __iomem *base;
> +	const char *identifier = NULL;
>  	char *name;
>  	int num;
>  	int ret;
> @@ -620,6 +644,11 @@ static int ddr_perf_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pmu);
>  
> +	ret = of_property_read_string(np, "identifier", &identifier);
> +	if (ret < 0)
> +		dev_warn(&pdev->dev, "Failed to get identifier\n");
> +	pmu->identifier = identifier;

I think this is exactly what Rob was objecting to when he said "yet another
way to identify the SoC from userspace". I've asked him on the other thread
as to what the best way to do this is.

Will
