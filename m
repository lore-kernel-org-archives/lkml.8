Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E8FC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 00:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F2420752
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 00:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCSAk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 20:40:57 -0400
Received: from foss.arm.com ([217.140.110.172]:56876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgCSAk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 20:40:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B104931B;
        Wed, 18 Mar 2020 17:40:56 -0700 (PDT)
Received: from [10.37.12.148] (unknown [10.37.12.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38AAF3F52E;
        Wed, 18 Mar 2020 17:40:55 -0700 (PDT)
Subject: Re: [PATCH 2/2] perf: arm_dsu: Support DSU ACPI devices.
To:     tuanphan@os.amperecomputing.com
Cc:     patches@amperecomputing.com, will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sudeep.holla@arm.com
References: <1584491323-31436-1-git-send-email-tuanphan@os.amperecomputing.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a571cf7e-c2a5-e8f8-e782-8087249143b0@arm.com>
Date:   Thu, 19 Mar 2020 00:45:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1584491323-31436-1-git-send-email-tuanphan@os.amperecomputing.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


Please find my comments below.

On 03/18/2020 12:28 AM, Tuan Phan wrote:
> Add support for probing device from ACPI node.
> Each DSU ACPI node defines "cpus" package which
> each element is the MPIDR of associated cpu.
> 
> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
> ---
>   drivers/perf/arm_dsu_pmu.c | 53 +++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 45 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c Tua
> index 2622900..6ef762c 100644
> --- a/drivers/perf/arm_dsu_pmu.c
> +++ b/drivers/perf/arm_dsu_pmu.c
> @@ -11,6 +11,7 @@
>   #define DRVNAME		PMUNAME "_pmu"
>   #define pr_fmt(fmt)	DRVNAME ": " fmt
>   
> +#include <linux/acpi.h>
>   #include <linux/bitmap.h>
>   #include <linux/bitops.h>
>   #include <linux/bug.h>
> @@ -603,18 +604,22 @@ static struct dsu_pmu *dsu_pmu_alloc(struct platform_device *pdev)
>   }
>   
>   /**
> - * dsu_pmu_dt_get_cpus: Get the list of CPUs in the cluster.
> + * dsu_pmu_get_cpus: Get the list of CPUs in the cluster.
>    */
> -static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
> +static int dsu_pmu_get_cpus(struct platform_device *pdev)
>   {
> +#ifndef CONFIG_ACPI
> +	/* Get the list of CPUs from device tree */

What if we have a kernel with both:

CONFIG_OF=y
CONFIG_ACPI=y

and boot the kernel on a system with DT ? In other words, the decision
to choose the DT vs ACPI must be runtime decision, not buildtime.

See 
drivers/hwtracing/coresight/coresight-platform.c:coresight_get_platform_data() 
for an example.

>   	int i = 0, n, cpu;
>   	struct device_node *cpu_node;
> +	struct dsu_pmu *dsu_pmu =
> +		(struct dsu_pmu *) platform_get_drvdata(pdev);
>   
> -	n = of_count_phandle_with_args(dev, "cpus", NULL);
> +	n = of_count_phandle_with_args(pdev->dev.of_node, "cpus", NULL);
>   	if (n <= 0)
>   		return -ENODEV;
>   	for (; i < n; i++) {
> -		cpu_node = of_parse_phandle(dev, "cpus", i);
> +		cpu_node = of_parse_phandle(pdev->dev.of_node, "cpus", i);
>   		if (!cpu_node)
>   			break;
>   		cpu = of_cpu_node_to_id(cpu_node);
> @@ -626,9 +631,33 @@ static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
>   		 */
>   		if (cpu < 0)
>   			continue;
> -		cpumask_set_cpu(cpu, mask);
> +		cpumask_set_cpu(cpu, &dsu_pmu->associated_cpus);
>   	}
>   	return 0;
> +#else /* CONFIG_ACPI */
> +	int i, cpu, ret;
> +	const union acpi_object *obj;
> +	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
> +	struct dsu_pmu *dsu_pmu =
> +		(struct dsu_pmu *) platform_get_drvdata(pdev);
> +

> +	ret = acpi_dev_get_property(adev, "cpus", ACPI_TYPE_ANY, &obj);

Is the binding documented somewhere ?


nit: Also, why not :
	ret = acpi_dev_get_propert(adev, "cpus", ACPI_TYPE_PACKAGE, &obj);
	if (ret < 0)
		return ret;
  ?


> +	if (ret < 0)
> +		return -EINVAL;
> +
> +	if (obj->type != ACPI_TYPE_PACKAGE)
> +		return -EINVAL;
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
> +#endif
>   }
>   

Otherwise looks good to me.

Suzuki
