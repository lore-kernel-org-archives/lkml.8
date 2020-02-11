Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849CBC35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 20:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59CD820708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 20:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbgBKUJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 15:09:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:14520 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbgBKUJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:09:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 12:09:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,428,1574150400"; 
   d="scan'208";a="222051011"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 11 Feb 2020 12:09:31 -0800
Received: from [10.251.4.129] (kliang2-mobl.ccr.corp.intel.com [10.251.4.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id EF237580696;
        Tue, 11 Feb 2020 12:09:29 -0800 (PST)
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v5_3/3=5d_perf_x86=3a_Exposing_an_Uncore_u?=
 =?UTF-8?Q?nit_to_PMON_for_Intel_Xeon=c2=ae_server_platform?=
To:     roman.sudarikov@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, bgregg@netflix.com, ak@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     alexander.antonov@intel.com
References: <20200211161549.19828-1-roman.sudarikov@linux.intel.com>
 <20200211161549.19828-4-roman.sudarikov@linux.intel.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
Message-ID: <45504018-6a4c-0ec0-9637-2eb79a4be36b@linux.intel.com>
Date:   Tue, 11 Feb 2020 15:09:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200211161549.19828-4-roman.sudarikov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/2020 11:15 AM, roman.sudarikov@linux.intel.com wrote:
> From: Roman Sudarikov <roman.sudarikov@linux.intel.com>
> 
> Current version supports a server line starting Intel® Xeon® Processor
> Scalable Family and introduces mapping for IIO Uncore units only.
> Other units can be added on demand.
> 
> IIO stack to PMON mapping is exposed through:
>      /sys/devices/uncore_iio_<pmu_idx>/nodeX
>      where nodeX is file which holds PCIe root bus.

I think the mapping information is from die to BUS#.
Can we change the name nodeX to dieX?


Thanks,
Kan
> 
> Details are explained in Documentation/ABI/testing/sysfs-devices-mapping
> 
> Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
> Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>
> Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
> ---
>   .../ABI/testing/sysfs-devices-mapping         |  32 +++
>   arch/x86/events/intel/uncore_snbep.c          | 183 ++++++++++++++++++
>   2 files changed, 215 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-devices-mapping
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-mapping b/Documentation/ABI/testing/sysfs-devices-mapping
> new file mode 100644
> index 000000000000..c26e4e0b6ca8
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-mapping
> @@ -0,0 +1,32 @@
> +What:           /sys/devices/uncore_iio_x/nodeX
> +Date:           February 2020
> +Contact:        Roman Sudarikov <roman.sudarikov@linux.intel.com>
> +Description:
> +                Each IIO stack (PCIe root port) has its own IIO PMON block, so
> +                each nodeX file (where X node number) holds PCIe root port,
> +                which can be monitored by that IIO PMON block.
> +                For example, on 4-node Xeon platform with up to 6 IIO stacks per
> +                node and, therefore, 6 IIO PMON blocks per node, the mapping of
> +                IIO PMON block 0 exposes as the following:
> +
> +                $ ls /sys/devices/uncore_iio_0/node*
> +                -r--r--r-- /sys/devices/uncore_iio_0/node0
> +                -r--r--r-- /sys/devices/uncore_iio_0/node1
> +                -r--r--r-- /sys/devices/uncore_iio_0/node2
> +                -r--r--r-- /sys/devices/uncore_iio_0/node3
> +
> +                $ tail /sys/devices/uncore_iio_0/node*
> +                ==> /sys/devices/uncore_iio_0/node0 <==
> +                0000:00
> +                ==> /sys/devices/uncore_iio_0/node1 <==
> +                0000:40
> +                ==> /sys/devices/uncore_iio_0/node2 <==
> +                0000:80
> +                ==> /sys/devices/uncore_iio_0/node3 <==
> +                0000:c0
> +
> +                Which means:
> +                IIO PMU 0 on node 0 belongs to PCI RP on bus 0x00, domain 0x0000
> +                IIO PMU 0 on node 1 belongs to PCI RP on bus 0x40, domain 0x0000
> +                IIO PMU 0 on node 2 belongs to PCI RP on bus 0x80, domain 0x0000
> +                IIO PMU 0 on node 3 belongs to PCI RP on bus 0xc0, domain 0x0000
> \ No newline at end of file
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index ad20220af303..96fca1ac22a4 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -273,6 +273,30 @@
>   #define SKX_CPUNODEID			0xc0
>   #define SKX_GIDNIDMAP			0xd4
>   
> +/*
> + * The CPU_BUS_NUMBER MSR returns the values of the respective CPUBUSNO CSR
> + * that BIOS programmed. MSR has package scope.
> + * |  Bit  |  Default  |  Description
> + * | [63]  |    00h    | VALID - When set, indicates the CPU bus
> + *                       numbers have been initialized. (RO)
> + * |[62:48]|    ---    | Reserved
> + * |[47:40]|    00h    | BUS_NUM_5 — Return the bus number BIOS assigned
> + *                       CPUBUSNO(5). (RO)
> + * |[39:32]|    00h    | BUS_NUM_4 — Return the bus number BIOS assigned
> + *                       CPUBUSNO(4). (RO)
> + * |[31:24]|    00h    | BUS_NUM_3 — Return the bus number BIOS assigned
> + *                       CPUBUSNO(3). (RO)
> + * |[23:16]|    00h    | BUS_NUM_2 — Return the bus number BIOS assigned
> + *                       CPUBUSNO(2). (RO)
> + * |[15:8] |    00h    | BUS_NUM_1 — Return the bus number BIOS assigned
> + *                       CPUBUSNO(1). (RO)
> + * | [7:0] |    00h    | BUS_NUM_0 — Return the bus number BIOS assigned
> + *                       CPUBUSNO(0). (RO)
> + */
> +#define SKX_MSR_CPU_BUS_NUMBER		0x300
> +#define SKX_MSR_CPU_BUS_VALID_BIT	(1ULL << 63)
> +#define BUS_NUM_STRIDE			8
> +
>   /* SKX CHA */
>   #define SKX_CHA_MSR_PMON_BOX_FILTER_TID		(0x1ffULL << 0)
>   #define SKX_CHA_MSR_PMON_BOX_FILTER_LINK	(0xfULL << 9)
> @@ -3575,6 +3599,163 @@ static struct intel_uncore_ops skx_uncore_iio_ops = {
>   	.read_counter		= uncore_msr_read_counter,
>   };
>   
> +static inline u8 skx_iio_stack(struct intel_uncore_pmu *pmu, int die)
> +{
> +	return pmu->type->topology[die] >> (pmu->pmu_idx * BUS_NUM_STRIDE);
> +}
> +
> +static umode_t
> +skx_iio_mapping_visible(struct kobject *kobj, struct attribute *attr, int die)
> +{
> +	struct intel_uncore_pmu *pmu = dev_get_drvdata(kobj_to_dev(kobj));
> +
> +	//Root bus 0x00 is valid only for die 0 AND pmu_idx = 0.
> +	return (!skx_iio_stack(pmu, die) && pmu->pmu_idx) ? 0 : attr->mode;
> +}
> +
> +static ssize_t skx_iio_mapping_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct pmu *pmu = dev_get_drvdata(dev);
> +	struct intel_uncore_pmu *uncore_pmu =
> +		container_of(pmu, struct intel_uncore_pmu, pmu);
> +
> +	struct dev_ext_attribute *ea =
> +		container_of(attr, struct dev_ext_attribute, attr);
> +	long die = (long)ea->var;
> +
> +	return sprintf(buf, "0000:%02x\n", skx_iio_stack(uncore_pmu, die));
> +}
> +
> +static int skx_msr_cpu_bus_read(int cpu, u64 *topology)
> +{
> +	u64 msr_value;
> +
> +	if (rdmsrl_on_cpu(cpu, SKX_MSR_CPU_BUS_NUMBER, &msr_value) ||
> +			!(msr_value & SKX_MSR_CPU_BUS_VALID_BIT))
> +		return -ENXIO;
> +
> +	*topology = msr_value;
> +
> +	return 0;
> +}
> +
> +static int die_to_cpu(int die)
> +{
> +	int res = 0, cpu, current_die;
> +	/*
> +	 * Using cpus_read_lock() to ensure cpu is not going down between
> +	 * looking at cpu_online_mask.
> +	 */
> +	cpus_read_lock();
> +	for_each_online_cpu(cpu) {
> +		current_die = topology_logical_die_id(cpu);
> +		if (current_die == die) {
> +			res = cpu;
> +			break;
> +		}
> +	}
> +	cpus_read_unlock();
> +	return res;
> +}
> +
> +static int skx_iio_get_topology(struct intel_uncore_type *type)
> +{
> +	int i, ret;
> +	struct pci_bus *bus = NULL;
> +
> +	/*
> +	 * Verified single-segment environments only; disabled for multiple
> +	 * segment topologies for now except VMD domains.
> +	 * VMD domains start at 0x10000 to not clash with ACPI _SEG domains.
> +	 */
> +	while ((bus = pci_find_next_bus(bus))
> +		&& (!pci_domain_nr(bus) || pci_domain_nr(bus) > 0xffff))
> +		;
> +	if (bus)
> +		return -EPERM;
> +
> +	type->topology = kcalloc(uncore_max_dies(), sizeof(u64), GFP_KERNEL);
> +	if (!type->topology)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < uncore_max_dies(); i++) {
> +		ret = skx_msr_cpu_bus_read(die_to_cpu(i), &type->topology[i]);
> +		if (ret) {
> +			kfree(type->topology);
> +			type->topology = NULL;
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static struct attribute *uncore_empry_attr;
> +
> +static struct attribute_group skx_iio_mapping_group = {
> +	.attrs		= &uncore_empry_attr,
> +	.is_visible	= skx_iio_mapping_visible,
> +};
> +
> +const static struct attribute_group *skx_iio_attr_update[] = {
> +	&skx_iio_mapping_group,
> +	NULL,
> +};
> +
> +static int skx_iio_set_mapping(struct intel_uncore_type *type)
> +{
> +	char buf[64];
> +	int ret = 0;
> +	long die;
> +	struct attribute **attrs;
> +	struct dev_ext_attribute *eas;
> +
> +	ret = skx_iio_get_topology(type);
> +	if (ret)
> +		return ret;
> +
> +	// One more for NULL.
> +	attrs = kzalloc((uncore_max_dies() + 1) * sizeof(*attrs), GFP_KERNEL);
> +	if (!attrs) {
> +		kfree(type->topology);
> +		return -ENOMEM;
> +	}
> +
> +	eas = kzalloc(sizeof(*eas) * uncore_max_dies(), GFP_KERNEL);
> +	if (!eas) {
> +		kfree(attrs);
> +		kfree(type->topology);
> +		return -ENOMEM;
> +	}
> +	for (die = 0; die < uncore_max_dies(); die++) {
> +		sprintf(buf, "node%ld", die);
> +		eas[die].attr.attr.name = kstrdup(buf, GFP_KERNEL);
> +		if (!eas[die].attr.attr.name) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +		eas[die].attr.attr.mode = 0444;
> +		eas[die].attr.show = skx_iio_mapping_show;
> +		eas[die].attr.store = NULL;
> +		eas[die].var = (void *)die;
> +		attrs[die] = &eas[die].attr.attr;
> +	}
> +
> +	skx_iio_mapping_group.attrs = attrs;
> +
> +	return 0;
> +
> +err:
> +	for (; die >= 0; die--)
> +		kfree(eas[die].attr.attr.name);
> +	kfree(eas);
> +	kfree(attrs);
> +	kfree(type->topology);
> +
> +	return ret;
> +}
> +
>   static struct intel_uncore_type skx_uncore_iio = {
>   	.name			= "iio",
>   	.num_counters		= 4,
> @@ -3589,6 +3770,8 @@ static struct intel_uncore_type skx_uncore_iio = {
>   	.constraints		= skx_uncore_iio_constraints,
>   	.ops			= &skx_uncore_iio_ops,
>   	.format_group		= &skx_uncore_iio_format_group,
> +	.attr_update		= skx_iio_attr_update,
> +	.set_mapping		= skx_iio_set_mapping,
>   };
>   
>   enum perf_uncore_iio_freerunning_type_id {
> 
