Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA1ECC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:56:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F597206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729588AbgEUN4D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:56:03 -0400
Received: from foss.arm.com ([217.140.110.172]:47304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728060AbgEUN4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:56:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5CBCD6E;
        Thu, 21 May 2020 06:56:02 -0700 (PDT)
Received: from bogus (unknown [10.37.12.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A43143F305;
        Thu, 21 May 2020 06:56:00 -0700 (PDT)
Date:   Thu, 21 May 2020 14:55:57 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, patches@amperecomputing.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] perf: arm_dsu: Support DSU ACPI devices.
Message-ID: <20200521135557.GB12282@bogus>
References: <1589229160-18558-1-git-send-email-tuanphan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589229160-18558-1-git-send-email-tuanphan@os.amperecomputing.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
> 
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

I don't see any property "cpus" in the document:
DEN 0093 A (Generic ACPI for Arm Components 1.0) [1]

Is there any newer updates that I need to look at ?

-- 
Regards,
Sudeep

[1] https://static.docs.arm.com/den0093/a/DEN0093_ACPI_Arm_Components_1.0.pdf
