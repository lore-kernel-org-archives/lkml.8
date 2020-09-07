Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B23BCC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7914B208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599501394;
	bh=5LnHy+uS2JT8LQglM7XzLIkWp4JKXPHRBbX6klDBkg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JLo7rr7ScOmwFYm+zzqwdpbdsQXF7VtdR4ZIRxzXhG4ctOFYr9vWUJzmlM4qSlFmn
	 hWMNpMHMgw+1UcfYkm/mB47DyBpOPpLEO2P1P1YO4bti4kuZlcn0ptQEW7eAX0rDLI
	 VO564/q+z1UQ9z+iM+UC3bv7F36WXl+EjV944il0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730697AbgIGR4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:56:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:46832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbgIGLUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:20:43 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A825121473;
        Mon,  7 Sep 2020 11:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599476561;
        bh=5LnHy+uS2JT8LQglM7XzLIkWp4JKXPHRBbX6klDBkg8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WuU9qRi8sYGjNywoL7UYUJslezd7VyaemYbf0n59dKheUMNgiGZcGyL0iIA+ekKMr
         1n0OxJUCDNmE9jatlVJMFMrPu7ZTVbtmOwlniSc1ceecRfVkZWf2cBfkel6un0Q1Ry
         fOi6tQehwaxjsT3805WgwTU/n/v0XNj+5Jspsmck=
Date:   Mon, 7 Sep 2020 12:02:37 +0100
From:   Will Deacon <will@kernel.org>
To:     Tuan Phan <tuanphan@os.amperecomputing.com>, suzuki.poulose@arm.com
Cc:     patches@amperecomputing.com, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf: arm_dsu: Support DSU ACPI devices
Message-ID: <20200907110236.GA12174@willie-the-truck>
References: <1597451980-11405-1-git-send-email-tuanphan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597451980-11405-1-git-send-email-tuanphan@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+ Suzuki as I'd like his Ack on this]

On Fri, Aug 14, 2020 at 05:39:40PM -0700, Tuan Phan wrote:
> Add support for probing device from ACPI node.
> Each DSU ACPI node and its associated cpus are inside a cluster node.
> 
> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
> ---
> Changes in v3:
> - Based on the latest ARM ACPI binding at: https://developer.arm.com/documentation/den0093/c/
> 
> Changes in v2:
> - Removed IRQF_SHARED.
> - Fixed ACPI runtime detection.
> 
>  drivers/perf/arm_dsu_pmu.c | 68 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 60 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
> index 96ed93c..4be355d 100644
> --- a/drivers/perf/arm_dsu_pmu.c
> +++ b/drivers/perf/arm_dsu_pmu.c
> @@ -11,6 +11,7 @@
>  #define DRVNAME		PMUNAME "_pmu"
>  #define pr_fmt(fmt)	DRVNAME ": " fmt
>  
> +#include <linux/acpi.h>
>  #include <linux/bitmap.h>
>  #include <linux/bitops.h>
>  #include <linux/bug.h>
> @@ -603,18 +604,21 @@ static struct dsu_pmu *dsu_pmu_alloc(struct platform_device *pdev)
>  }
>  
>  /**
> - * dsu_pmu_dt_get_cpus: Get the list of CPUs in the cluster.
> + * dsu_pmu_dt_get_cpus: Get the list of CPUs in the cluster
> + * from device tree.
>   */
> -static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
> +static int dsu_pmu_dt_get_cpus(struct platform_device *pdev)
>  {
>  	int i = 0, n, cpu;
>  	struct device_node *cpu_node;
> +	struct dsu_pmu *dsu_pmu =
> +		(struct dsu_pmu *) platform_get_drvdata(pdev);
>  
> -	n = of_count_phandle_with_args(dev, "cpus", NULL);
> +	n = of_count_phandle_with_args(pdev->dev.of_node, "cpus", NULL);
>  	if (n <= 0)
>  		return -ENODEV;
>  	for (; i < n; i++) {
> -		cpu_node = of_parse_phandle(dev, "cpus", i);
> +		cpu_node = of_parse_phandle(pdev->dev.of_node, "cpus", i);
>  		if (!cpu_node)
>  			break;
>  		cpu = of_cpu_node_to_id(cpu_node);
> @@ -626,11 +630,51 @@ static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
>  		 */
>  		if (cpu < 0)
>  			continue;
> -		cpumask_set_cpu(cpu, mask);
> +		cpumask_set_cpu(cpu, &dsu_pmu->associated_cpus);
>  	}
>  	return 0;
>  }
>  
> +/**
> + * dsu_pmu_acpi_get_cpus: Get the list of CPUs in the cluster
> + * from ACPI.
> + */
> +static int dsu_pmu_acpi_get_cpus(struct platform_device *pdev)
> +{
> +	int cpu;
> +	struct dsu_pmu *dsu_pmu = (struct dsu_pmu *) platform_get_drvdata(pdev);
> +
> +	/*
> +	 * A dsu pmu node is inside a cluster parent node along with cpu nodes.
> +	 * We need to find out all cpus that have the same parent with this pmu.
> +	 */
> +	for_each_possible_cpu(cpu) {
> +		struct acpi_device *acpi_dev = ACPI_COMPANION(get_cpu_device(cpu));
> +
> +		if (acpi_dev &&
> +			acpi_dev->parent == ACPI_COMPANION(&pdev->dev)->parent)
> +			cpumask_set_cpu(cpu, &dsu_pmu->associated_cpus);
> +	}
> +
> +	return 0;
> +}
> +
> +static int dsu_pmu_platform_get_cpus(struct platform_device *pdev)
> +{
> +	int ret = -ENOENT;
> +	struct fwnode_handle *fwnode = dev_fwnode(&pdev->dev);
> +
> +	if (IS_ERR_OR_NULL(fwnode))
> +		return ret;
> +
> +	if (is_of_node(fwnode))
> +		ret = dsu_pmu_dt_get_cpus(pdev);
> +	else if (is_acpi_device_node(fwnode))
> +		ret = dsu_pmu_acpi_get_cpus(pdev);
> +
> +	return ret;
> +}
> +
>  /*
>   * dsu_pmu_probe_pmu: Probe the PMU details on a CPU in the cluster.
>   */
> @@ -683,7 +727,9 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
>  	if (IS_ERR(dsu_pmu))
>  		return PTR_ERR(dsu_pmu);
>  
> -	rc = dsu_pmu_dt_get_cpus(pdev->dev.of_node, &dsu_pmu->associated_cpus);
> +	platform_set_drvdata(pdev, dsu_pmu);

Hmm, this is a bit nasty because we haven't finished initialising the
dsu_pmu yet. I think it would actually be cleaner if you kept:

	static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)

for the DT case and added:

	static int dsu_pmu_acpi_get_cpus(struct device *dev, cpumask_t *mask)

for the ACPI case. I suppose the DT case could take the struct device * too
if you wanted the prototypes to be the same.

> +	rc = dsu_pmu_platform_get_cpus(pdev);
>  	if (rc) {
>  		dev_warn(&pdev->dev, "Failed to parse the CPUs\n");
>  		return rc;
> @@ -705,7 +751,6 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
>  	}
>  
>  	dsu_pmu->irq = irq;
> -	platform_set_drvdata(pdev, dsu_pmu);
>  	rc = cpuhp_state_add_instance(dsu_pmu_cpuhp_state,
>  						&dsu_pmu->cpuhp_node);
>  	if (rc)
> @@ -752,11 +797,19 @@ static const struct of_device_id dsu_pmu_of_match[] = {
>  	{ .compatible = "arm,dsu-pmu", },
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, dsu_pmu_of_match);
> +
> +static const struct acpi_device_id dsu_pmu_acpi_match[] = {
> +	{ "ARMHD500", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, dsu_pmu_acpi_match);
>  
>  static struct platform_driver dsu_pmu_driver = {
>  	.driver = {
>  		.name	= DRVNAME,
>  		.of_match_table = of_match_ptr(dsu_pmu_of_match),
> +		.acpi_match_table = ACPI_PTR(dsu_pmu_acpi_match),
>  		.suppress_bind_attrs = true,
>  	},
>  	.probe = dsu_pmu_device_probe,
> @@ -826,7 +879,6 @@ static void __exit dsu_pmu_exit(void)
>  module_init(dsu_pmu_init);
>  module_exit(dsu_pmu_exit);
>  
> -MODULE_DEVICE_TABLE(of, dsu_pmu_of_match);

Why have you moved this line?

Will
