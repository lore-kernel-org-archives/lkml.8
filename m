Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD23C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52C6D2078E
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgCXU2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:28:42 -0400
Received: from mga02.intel.com ([134.134.136.20]:38276 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgCXU2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:28:41 -0400
IronPort-SDR: jUkO/aiB4XFg5I8KFzD4JbWN+9472nkSTAEyH5FI1i4gavV/38OtZV/s+2PscFAWYBAaLP1FSb
 5HhRuEAxVZAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 13:28:36 -0700
IronPort-SDR: RX1YExsZbu7vv6thxTlS6nm6CXxfaNx9lcGZMBwl7zWY9fWGhYLiMIZOy7gprETyEQ3qYZ6G3S
 rEaaTuW76+XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,301,1580803200"; 
   d="scan'208";a="357540319"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga001.fm.intel.com with ESMTP; 24 Mar 2020 13:28:35 -0700
Received: from [10.125.248.60] (rsudarik-mobl.ccr.corp.intel.com [10.125.248.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 201CE580569;
        Tue, 24 Mar 2020 13:28:31 -0700 (PDT)
Subject: Re: [PATCH v8 1/3] perf x86: Infrastructure for exposing an Uncore
 unit to PMON mapping
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com
Cc:     alexander.antonov@intel.com, roman.sudarikov@linux.intel.com
References: <20200320073110.4761-1-roman.sudarikov@linux.intel.com>
 <20200320073110.4761-2-roman.sudarikov@linux.intel.com>
From:   "Sudarikov, Roman" <roman.sudarikov@linux.intel.com>
Message-ID: <9e26689c-3d50-6bac-909f-041745a44a22@linux.intel.com>
Date:   Tue, 24 Mar 2020 23:28:28 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200320073110.4761-2-roman.sudarikov@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.03.2020 10:31, roman.sudarikov@linux.intel.com wrote:
> From: Roman Sudarikov <roman.sudarikov@linux.intel.com>
>
> Intel® Xeon® Scalable processor family (code name Skylake-SP) makes
> significant changes in the integrated I/O (IIO) architecture. The new
> solution introduces IIO stacks which are responsible for managing traffic
> between the PCIe domain and the Mesh domain. Each IIO stack has its own
> PMON block and can handle either DMI port, x16 PCIe root port, MCP-Link
> or various built-in accelerators. IIO PMON blocks allow concurrent
> monitoring of I/O flows up to 4 x4 bifurcation within each IIO stack.
>
> Software is supposed to program required perf counters within each IIO
> stack and gather performance data. The tricky thing here is that IIO PMON
> reports data per IIO stack but users have no idea what IIO stacks are -
> they only know devices which are connected to the platform.
>
> Understanding IIO stack concept to find which IIO stack that particular
> IO device is connected to, or to identify an IIO PMON block to program
> for monitoring specific IIO stack assumes a lot of implicit knowledge
> about given Intel server platform architecture.
>
> Usage example:
>      ls /sys/devices/uncore_<type>_<pmu_idx>/die*
>
> Each Uncore unit type, by its nature, can be mapped to its own context,
> for example:
> 1. CHA - each uncore_cha_<pmu_idx> is assigned to manage a distinct slice
>     of LLC capacity;
> 2. UPI - each uncore_upi_<pmu_idx> is assigned to manage one link of Intel
>     UPI Subsystem;
> 3. IIO - each uncore_iio_<pmu_idx> is assigned to manage one stack of the
>     IIO module;
> 4. IMC - each uncore_imc_<pmu_idx> is assigned to manage one channel of
>     Memory Controller.
>
> Implementation details:
> Optional callbacks added to struct intel_uncore_type to discover and map
> Uncore units to PMONs:
>      int (*set_mapping)(struct intel_uncore_type *type)
>      void (*cleanup_mapping)(struct intel_uncore_type *type)
>
> Details of IIO Uncore unit mapping to IIO PMON:
> Each IIO stack is either DMI port, x16 PCIe root port, MCP-Link or various
> built-in accelerators. For Uncore IIO Unit type, the mapping file
> holds bus numbers of devices, which can be monitored by that IIO PMON block
> on each die.
>
> Co-developed-by: Alexander Antonov <alexander.antonov@intel.com>
> Signed-off-by: Alexander Antonov <alexander.antonov@intel.com>
> Signed-off-by: Roman Sudarikov <roman.sudarikov@linux.intel.com>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>   arch/x86/events/intel/uncore.c | 8 ++++++++
>   arch/x86/events/intel/uncore.h | 6 ++++++
>   2 files changed, 14 insertions(+)
>
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 86467f85c383..fb693608c223 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -843,10 +843,12 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
>   			.read		= uncore_pmu_event_read,
>   			.module		= THIS_MODULE,
>   			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> +			.attr_update	= pmu->type->attr_update,
>   		};
>   	} else {
>   		pmu->pmu = *pmu->type->pmu;
>   		pmu->pmu.attr_groups = pmu->type->attr_groups;
> +		pmu->pmu.attr_update = pmu->type->attr_update;
>   	}
>   
>   	if (pmu->type->num_boxes == 1) {
> @@ -887,6 +889,9 @@ static void uncore_type_exit(struct intel_uncore_type *type)
>   	struct intel_uncore_pmu *pmu = type->pmus;
>   	int i;
>   
> +	if (type->cleanup_mapping)
> +		type->cleanup_mapping(type);
> +
>   	if (pmu) {
>   		for (i = 0; i < type->num_boxes; i++, pmu++) {
>   			uncore_pmu_unregister(pmu);
> @@ -954,6 +959,9 @@ static int __init uncore_type_init(struct intel_uncore_type *type, bool setid)
>   
>   	type->pmu_group = &uncore_pmu_attr_group;
>   
> +	if (type->set_mapping)
> +		type->set_mapping(type);
> +
>   	return 0;
>   
>   err:
> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
> index bbfdaa720b45..d41f8874adc5 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -72,7 +72,13 @@ struct intel_uncore_type {
>   	struct uncore_event_desc *event_descs;
>   	struct freerunning_counters *freerunning;
>   	const struct attribute_group *attr_groups[4];
> +	const struct attribute_group **attr_update;
>   	struct pmu *pmu; /* for custom pmu ops */
> +	/* PMON's topologies */
> +	u64 *topology;
> +	/* mapping Uncore units to PMON ranges */
> +	int (*set_mapping)(struct intel_uncore_type *type);
> +	void (*cleanup_mapping)(struct intel_uncore_type *type);
>   };
>   
>   #define pmu_group attr_groups[0]
Hello Peter,
are you waiting for some further review/ack on this, or is it just in your
pending review queue?

Sorry for bothering you several times, but the feature will add value to 
users.

Thanks,
Roman


