Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B44C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CF192081E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578926304;
	bh=4bNoXg8jhshK9CKDDmz3/Jsf3DHVzMl2p6pFs3DuqeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I6rqoy/hldVzUg3dquGTc2j2QlJoBVfMdQsf9gzYvSiqRNSZU8qA+T8qxj8BbpHIo
	 JgiHFpsiKvQggmc+Fcy+SRqmpAoAWY1jJ02/1y51l/L7Td4J6q77PL8igsxurCN4sD
	 Vg9RwzI0Ac5Jsfq7Ucvs0GWSO39ckmU8Wbkx2peU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728819AbgAMOiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:38:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgAMOiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:38:22 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C94420678;
        Mon, 13 Jan 2020 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578926301;
        bh=4bNoXg8jhshK9CKDDmz3/Jsf3DHVzMl2p6pFs3DuqeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NpxeMZ4EvljDFiJD+L5Vd0a3Su1/devid9A2gQ5c0ZYwxP5Pjr0mZpkSiz3OSPAzS
         rmAT4d0w/yqhbI5CYWg5yB7elEFKNe/As32r14nx3wvFB7qtu4DQrur74lYhjs5CmX
         aq9wFN/QK8qJXrWuI9ghHI6ii9IGIJNCGgaKXci4=
Date:   Mon, 13 Jan 2020 15:38:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     roman.sudarikov@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        alexander.antonov@intel.com
Subject: Re: [PATCH v3 2/2] perf =?iso-8859-1?Q?x86?=
 =?iso-8859-1?Q?=3A_Exposing_an_Uncore_unit_to_PMON_for_Intel_Xeon?=
 =?iso-8859-1?Q?=AE?= server platform
Message-ID: <20200113143818.GB390411@kroah.com>
References: <20200113135444.12027-1-roman.sudarikov@linux.intel.com>
 <20200113135444.12027-3-roman.sudarikov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113135444.12027-3-roman.sudarikov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 04:54:44PM +0300, roman.sudarikov@linux.intel.com wrote:
> From: Roman Sudarikov <roman.sudarikov@linux.intel.com>
> 
> Current version supports a server line starting Intel® Xeon® Processor
> Scalable Family and introduces mapping for IIO Uncore units only.
> Other units can be added on demand.
> 
> IIO stack to PMON mapping is exposed through:
>     /sys/devices/uncore_iio_<pmu_idx>/platform_mapping
>     in the following format: domain:bus
> 
> For example, on a 4-die Intel Xeon® server platform:
>     $ cat /sys/devices/uncore_iio_0/platform_mapping
>     0000:00,0000:40,0000:80,0000:c0

That's horrid to parse.  Sysfs should be one value per file, why not
have individual files for all of these things?

> Which means:
> IIO PMON block 0 on die 0 belongs to IIO stack on bus 0x00, domain 0x0000
> IIO PMON block 0 on die 1 belongs to IIO stack on bus 0x40, domain 0x0000
> IIO PMON block 0 on die 2 belongs to IIO stack on bus 0x80, domain 0x0000
> IIO PMON block 0 on die 3 belongs to IIO stack on bus 0xc0, domain 0x0000

Where did you get the die number from the above data?



> 
> Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>
> Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
> ---
>  arch/x86/events/intel/uncore.c       |   2 +-
>  arch/x86/events/intel/uncore.h       |   1 +
>  arch/x86/events/intel/uncore_snbep.c | 162 +++++++++++++++++++++++++++
>  3 files changed, 164 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 2c53ad44b51f..c0d86bc8e786 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -16,7 +16,7 @@ struct pci_driver *uncore_pci_driver;
>  DEFINE_RAW_SPINLOCK(pci2phy_map_lock);
>  struct list_head pci2phy_map_head = LIST_HEAD_INIT(pci2phy_map_head);
>  struct pci_extra_dev *uncore_extra_pci_dev;
> -static int max_dies;
> +int max_dies;

Horrible global variable name :(

"unicore_max_dies" instead please.

>  /* mask of cpus that collect uncore events */
>  static cpumask_t uncore_cpu_mask;
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
> index f52dd3f112a7..94eacca6f485 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -523,6 +523,7 @@ extern raw_spinlock_t pci2phy_map_lock;
>  extern struct list_head pci2phy_map_head;
>  extern struct pci_extra_dev *uncore_extra_pci_dev;
>  extern struct event_constraint uncore_constraint_empty;
> +extern int max_dies;
>  
>  /* uncore_snb.c */
>  int snb_uncore_pci_init(void);
> diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
> index b10a5ec79e48..2562fde2e5b8 100644
> --- a/arch/x86/events/intel/uncore_snbep.c
> +++ b/arch/x86/events/intel/uncore_snbep.c
> @@ -273,6 +273,30 @@
>  #define SKX_CPUNODEID			0xc0
>  #define SKX_GIDNIDMAP			0xd4
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
>  /* SKX CHA */
>  #define SKX_CHA_MSR_PMON_BOX_FILTER_TID		(0x1ffULL << 0)
>  #define SKX_CHA_MSR_PMON_BOX_FILTER_LINK	(0xfULL << 9)
> @@ -3580,6 +3604,9 @@ static struct intel_uncore_ops skx_uncore_iio_ops = {
>  	.read_counter		= uncore_msr_read_counter,
>  };
>  
> +static int skx_iio_get_topology(struct intel_uncore_type *type);
> +static int skx_iio_set_mapping(struct intel_uncore_type *type);
> +
>  static struct intel_uncore_type skx_uncore_iio = {
>  	.name			= "iio",
>  	.num_counters		= 4,
> @@ -3594,6 +3621,8 @@ static struct intel_uncore_type skx_uncore_iio = {
>  	.constraints		= skx_uncore_iio_constraints,
>  	.ops			= &skx_uncore_iio_ops,
>  	.format_group		= &skx_uncore_iio_format_group,
> +	.get_topology		= skx_iio_get_topology,
> +	.set_mapping		= skx_iio_set_mapping,
>  };
>  
>  enum perf_uncore_iio_freerunning_type_id {
> @@ -3780,6 +3809,139 @@ static int skx_count_chabox(void)
>  	return hweight32(val);
>  }
>  
> +static inline int skx_msr_cpu_bus_read(int cpu, u64 *topology)
> +{
> +	u64 msr_value;
> +
> +	if (rdmsrl_on_cpu(cpu, SKX_MSR_CPU_BUS_NUMBER, &msr_value) ||
> +			!(msr_value & SKX_MSR_CPU_BUS_VALID_BIT))
> +		return -1;
> +
> +	*topology = msr_value;
> +
> +	return 0;
> +}
> +
> +static int skx_iio_get_topology(struct intel_uncore_type *type)
> +{
> +	int ret, cpu, die, current_die;
> +	struct pci_bus *bus = NULL;
> +
> +	/*
> +	 * Verified single-segment environments only; disabled for multiple
> +	 * segment topologies for now.
> +	 */
> +	while ((bus = pci_find_next_bus(bus)) && !pci_domain_nr(bus))
> +		;
> +	if (bus) {
> +		pr_info("I/O stack mapping is not supported for multi-seg\n");
> +		return -1;

Do not make up random negative error values, use a #defined one please.

And shouldn't this be dev_err()?  What happens if a user gets this, who
do they complain to, their BIOS vendor?

thanks,

greg k-h
