Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1668C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EBC5208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgIGRwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:52:40 -0400
Received: from foss.arm.com ([217.140.110.172]:33980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729056AbgIGL5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:57:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4472E1045;
        Mon,  7 Sep 2020 04:57:52 -0700 (PDT)
Received: from [10.57.6.175] (unknown [10.57.6.175])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D51103F66E;
        Mon,  7 Sep 2020 04:57:50 -0700 (PDT)
Subject: Re: [PATCH v3] perf: arm_dsu: Support DSU ACPI devices
To:     will@kernel.org, tuanphan@os.amperecomputing.com
Cc:     patches@amperecomputing.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1597451980-11405-1-git-send-email-tuanphan@os.amperecomputing.com>
 <20200907110236.GA12174@willie-the-truck>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f82e8c4d-a270-0452-4071-35b22c9d2d9b@arm.com>
Date:   Mon, 7 Sep 2020 13:02:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200907110236.GA12174@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2020 12:02 PM, Will Deacon wrote:
> [+ Suzuki as I'd like his Ack on this]
> 

Thanks Will !

> On Fri, Aug 14, 2020 at 05:39:40PM -0700, Tuan Phan wrote:
>> Add support for probing device from ACPI node.
>> Each DSU ACPI node and its associated cpus are inside a cluster node.
>>
>> Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
>> ---
>> Changes in v3:
>> - Based on the latest ARM ACPI binding at: https://developer.arm.com/documentation/den0093/c/
>>
>> Changes in v2:
>> - Removed IRQF_SHARED.
>> - Fixed ACPI runtime detection.
>>
>>   drivers/perf/arm_dsu_pmu.c | 68 ++++++++++++++++++++++++++++++++++++++++------
>>   1 file changed, 60 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
>> index 96ed93c..4be355d 100644
>> --- a/drivers/perf/arm_dsu_pmu.c
>> +++ b/drivers/perf/arm_dsu_pmu.c
>> @@ -11,6 +11,7 @@
>>   #define DRVNAME		PMUNAME "_pmu"
>>   #define pr_fmt(fmt)	DRVNAME ": " fmt
>>   
>> +#include <linux/acpi.h>
>>   #include <linux/bitmap.h>
>>   #include <linux/bitops.h>
>>   #include <linux/bug.h>
>> @@ -603,18 +604,21 @@ static struct dsu_pmu *dsu_pmu_alloc(struct platform_device *pdev)
>>   }
>>   
>>   /**
>> - * dsu_pmu_dt_get_cpus: Get the list of CPUs in the cluster.
>> + * dsu_pmu_dt_get_cpus: Get the list of CPUs in the cluster
>> + * from device tree.
>>    */
>> -static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
>> +static int dsu_pmu_dt_get_cpus(struct platform_device *pdev)
>>   {
>>   	int i = 0, n, cpu;
>>   	struct device_node *cpu_node;
>> +	struct dsu_pmu *dsu_pmu =
>> +		(struct dsu_pmu *) platform_get_drvdata(pdev);
>>   
>> -	n = of_count_phandle_with_args(dev, "cpus", NULL);
>> +	n = of_count_phandle_with_args(pdev->dev.of_node, "cpus", NULL);
>>   	if (n <= 0)
>>   		return -ENODEV;
>>   	for (; i < n; i++) {
>> -		cpu_node = of_parse_phandle(dev, "cpus", i);
>> +		cpu_node = of_parse_phandle(pdev->dev.of_node, "cpus", i);
>>   		if (!cpu_node)
>>   			break;
>>   		cpu = of_cpu_node_to_id(cpu_node);
>> @@ -626,11 +630,51 @@ static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
>>   		 */
>>   		if (cpu < 0)
>>   			continue;
>> -		cpumask_set_cpu(cpu, mask);
>> +		cpumask_set_cpu(cpu, &dsu_pmu->associated_cpus);
>>   	}
>>   	return 0;
>>   }
>>   
>> +/**
>> + * dsu_pmu_acpi_get_cpus: Get the list of CPUs in the cluster
>> + * from ACPI.
>> + */
>> +static int dsu_pmu_acpi_get_cpus(struct platform_device *pdev)
>> +{
>> +	int cpu;
>> +	struct dsu_pmu *dsu_pmu = (struct dsu_pmu *) platform_get_drvdata(pdev);
>> +
>> +	/*
>> +	 * A dsu pmu node is inside a cluster parent node along with cpu nodes.
>> +	 * We need to find out all cpus that have the same parent with this pmu.
>> +	 */
>> +	for_each_possible_cpu(cpu) {
>> +		struct acpi_device *acpi_dev = ACPI_COMPANION(get_cpu_device(cpu));

minor nit: Please could we split this into :
		
		struct acpi_device *acpi_dev;
		struct device *cpu_dev = get_cpu_device(cpu);

		if (!cpu_dev)
			continue;

		acpi_dev = ACPI_COMPANION(cpu_dev); ...

So that we are explicitly clear that we don't end up in NULL pointer 
dereferences (ACPI_COMPANION() is safe btw). Otherwise, with Will's
comments addressed, looks fine to me.

Appreciate a Cc in the next posting.

Suzuki
