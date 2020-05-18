Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39121C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B84207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589822499;
	bh=r5GpIZm99JIcJLaW6N8soEyvPIfJsbLCLSFGc1rY7XI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=n/8xsYPMwBGkgGwTzBnmEJa4aLoi4hylXrOILA5Hbn/8TO3/6tM4h0MAFka7jBSVz
	 SRlp5e3xD2HzhmMLBGjqETg7nNYGRq2wldL6Azona5h8oD0EiBg4NTdk0mmXme/dHO
	 8KBOSQUFnbx50N/jyVFQqezzs8neGnK3swxj9L2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgERRVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERRVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:21:38 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F7602070A;
        Mon, 18 May 2020 17:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589822497;
        bh=r5GpIZm99JIcJLaW6N8soEyvPIfJsbLCLSFGc1rY7XI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RdQQF5HSiiTdxmfa2jxGtQZABy79/T5D7pilxBhd9EF/9DEQ/5cNBPaFbSspQkGQZ
         h7LepYdnHzb8rYcXfYdUi/11hv/A9yj/nD1neWb6qD8Iw4SB0Ez4tjnV71pwM6KxGy
         CwOwBf3+6PM+z5C+Q2PgjNqrUB/ZUFWtxUa3sjDQ=
Date:   Mon, 18 May 2020 18:21:32 +0100
From:   Will Deacon <will@kernel.org>
To:     Tuan Phan <tuanphan@os.amperecomputing.com>, suzuki.poulose@arm.com
Cc:     patches@amperecomputing.com, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf: arm_dsu: Support DSU ACPI devices.
Message-ID: <20200518172132.GA2601@willie-the-truck>
References: <1589229160-18558-1-git-send-email-tuanphan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589229160-18558-1-git-send-email-tuanphan@os.amperecomputing.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 01:32:40PM -0700, Tuan Phan wrote:
> Add ACPI node probing device support. Each DSU ACPI node
> defines a "cpus" package with a per cpu MPIDR element.
> 
> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
> ---
> Changes in v2:
> - Removed IRQF_SHARED.
> - Fixed ACPI runtime detection.
> 
> The ACPI binding spec for DSU ACPI node is under beta and located
> in ARM server group under project "ACPI on ARM".
> 
>  drivers/perf/arm_dsu_pmu.c | 71 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 63 insertions(+), 8 deletions(-)

I've added Suzuki to cc, because I'd like his ack on this before I merge it.

Thanks,

Will

> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
> index 70968c8..784d177 100644
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
> @@ -626,11 +630,54 @@ static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
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
> +	int i, cpu, ret;
> +	const union acpi_object *obj;
> +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
> +	struct dsu_pmu *dsu_pmu =
> +		(struct dsu_pmu *) platform_get_drvdata(pdev);
> +
> +	ret = acpi_dev_get_property(adev, "cpus", ACPI_TYPE_PACKAGE, &obj);
> +	if (ret < 0)
> +		return ret;
> +
> +	for (i = 0; i < obj->package.count; i++) {
> +		/* Each element is the MPIDR of associated cpu */
> +		for_each_possible_cpu(cpu) {
> +			if (cpu_physical_id(cpu) ==
> +				obj->package.elements[i].integer.value)
> +				cpumask_set_cpu(cpu, &dsu_pmu->associated_cpus);
> +		}
> +	}
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
> @@ -683,7 +730,9 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
>  	if (IS_ERR(dsu_pmu))
>  		return PTR_ERR(dsu_pmu);
>  
> -	rc = dsu_pmu_dt_get_cpus(pdev->dev.of_node, &dsu_pmu->associated_cpus);
> +	platform_set_drvdata(pdev, dsu_pmu);
> +
> +	rc = dsu_pmu_platform_get_cpus(pdev);
>  	if (rc) {
>  		dev_warn(&pdev->dev, "Failed to parse the CPUs\n");
>  		return rc;
> @@ -707,7 +756,6 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
>  	}
>  
>  	dsu_pmu->irq = irq;
> -	platform_set_drvdata(pdev, dsu_pmu);
>  	rc = cpuhp_state_add_instance(dsu_pmu_cpuhp_state,
>  						&dsu_pmu->cpuhp_node);
>  	if (rc)
> @@ -754,11 +802,19 @@ static const struct of_device_id dsu_pmu_of_match[] = {
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
>  	},
>  	.probe = dsu_pmu_device_probe,
>  	.remove = dsu_pmu_device_remove,
> @@ -827,7 +883,6 @@ static void __exit dsu_pmu_exit(void)
>  module_init(dsu_pmu_init);
>  module_exit(dsu_pmu_exit);
>  
> -MODULE_DEVICE_TABLE(of, dsu_pmu_of_match);
>  MODULE_DESCRIPTION("Perf driver for ARM DynamIQ Shared Unit");
>  MODULE_AUTHOR("Suzuki K Poulose <suzuki.poulose@arm.com>");
>  MODULE_LICENSE("GPL v2");
> -- 
> 2.7.4
> 
