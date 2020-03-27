Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF894C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976E5206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgC0IX4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:23:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:2951 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgC0IXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:23:55 -0400
IronPort-SDR: mmRYE7U9zTs6atOpVytrvU/I7UKoeZ1kna7qNZ/TLD+V6TZCaLn0rME6cQ2FQQRYBRsn93gHEL
 To9yk030xUvA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 01:23:55 -0700
IronPort-SDR: 05dIRXvkF77XEIekzdwiijag+StEUJxIAOu+dx+0rOQvg2TIJ8jrxSk/47Oe9LHWGWrWD08TwH
 97FSHUwSb80g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; 
   d="scan'208";a="447329830"
Received: from um.fi.intel.com (HELO um) ([10.237.72.57])
  by fmsmga005.fm.intel.com with ESMTP; 27 Mar 2020 01:23:51 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     roman.sudarikov@linux.intel.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com
Cc:     alexander.antonov@intel.com, roman.sudarikov@linux.intel.com,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH v8 1/3] perf x86: Infrastructure for exposing an Uncore unit to PMON mapping
In-Reply-To: <20200320073110.4761-2-roman.sudarikov@linux.intel.com>
References: <20200320073110.4761-1-roman.sudarikov@linux.intel.com> <20200320073110.4761-2-roman.sudarikov@linux.intel.com>
Date:   Fri, 27 Mar 2020 10:23:51 +0200
Message-ID: <878sjm6wa0.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

roman.sudarikov@linux.intel.com writes:

> From: Roman Sudarikov <roman.sudarikov@linux.intel.com>

My comments for 2/3 also apply here. Also, check out the
Documentation/process/submitting-patches.rst.

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
>     ls /sys/devices/uncore_<type>_<pmu_idx>/die*
>
> Each Uncore unit type, by its nature, can be mapped to its own context,
> for example:
> 1. CHA - each uncore_cha_<pmu_idx> is assigned to manage a distinct slice
>    of LLC capacity;
> 2. UPI - each uncore_upi_<pmu_idx> is assigned to manage one link of Intel
>    UPI Subsystem;
> 3. IIO - each uncore_iio_<pmu_idx> is assigned to manage one stack of the
>    IIO module;
> 4. IMC - each uncore_imc_<pmu_idx> is assigned to manage one channel of
>    Memory Controller.

This is indeed very informative. I'd say it belongs more in a
Documentation/ than commit message. In a nutshell, we have uncore PMUs
that monitor integrated IO and the first task is to map those to the
actual devices in the system, right? A lot of the time commit messages
are way too short and missing important details, this one is tending
towards the other end of the spectrum.

At the same time, you don't seem to mention the one thing that this
patch does do: extend the uncore PMU to support integrated IO
monitoning, if my understanding is correct.

Also, the acronyms are unexplained. I'm not sure if they even need to be
here. 

> Implementation details:
> Optional callbacks added to struct intel_uncore_type to discover and map
> Uncore units to PMONs:
>     int (*set_mapping)(struct intel_uncore_type *type)
>     void (*cleanup_mapping)(struct intel_uncore_type *type)

Most of the time, you don't need to verbalize the code in the commit
message, you can do it in the comments or Documentation. Here, we can
just scroll down for the implementation details. If you want to explain
the new callbacks, add comments to the structure definition.

> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
> index 86467f85c383..fb693608c223 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -843,10 +843,12 @@ static int uncore_pmu_register(struct intel_uncore_pmu *pmu)
>  			.read		= uncore_pmu_event_read,
>  			.module		= THIS_MODULE,
>  			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
> +			.attr_update	= pmu->type->attr_update,
>  		};
>  	} else {
>  		pmu->pmu = *pmu->type->pmu;
>  		pmu->pmu.attr_groups = pmu->type->attr_groups;
> +		pmu->pmu.attr_update = pmu->type->attr_update;

So you need the attr_update to create the mapping attributes on the fly,
right? May be worth mentioning.

> diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
> index bbfdaa720b45..d41f8874adc5 100644
> --- a/arch/x86/events/intel/uncore.h
> +++ b/arch/x86/events/intel/uncore.h
> @@ -72,7 +72,13 @@ struct intel_uncore_type {
>  	struct uncore_event_desc *event_descs;
>  	struct freerunning_counters *freerunning;
>  	const struct attribute_group *attr_groups[4];
> +	const struct attribute_group **attr_update;
>  	struct pmu *pmu; /* for custom pmu ops */
> +	/* PMON's topologies */
> +	u64 *topology;
> +	/* mapping Uncore units to PMON ranges */

This can be more elaborate, like the "implementation details" paragraph
from the commit message.

> +	int (*set_mapping)(struct intel_uncore_type *type);
> +	void (*cleanup_mapping)(struct intel_uncore_type *type);
>  };
>  
>  #define pmu_group attr_groups[0]
> -- 
> 2.19.1
