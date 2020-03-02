Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98864C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6931B217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbgCBOyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:54:41 -0500
Received: from foss.arm.com ([217.140.110.172]:33784 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbgCBOyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:54:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B595FEC;
        Mon,  2 Mar 2020 06:54:40 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7EB523F534;
        Mon,  2 Mar 2020 06:54:37 -0800 (PST)
Date:   Mon, 2 Mar 2020 14:54:35 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        eranian@google.com, peterz@infradead.org, mpe@ellerman.id.au,
        paulus@samba.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, alexey.budankov@linux.intel.com,
        yao.jin@linux.intel.com, robert.richter@amd.com,
        kim.phillips@amd.com, maddy@linux.ibm.com,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [RFC 02/11] perf/core: Data structure to present hazard data
Message-ID: <20200302145434.GE56497@lakrids.cambridge.arm.com>
References: <20200302052355.36365-1-ravi.bangoria@linux.ibm.com>
 <20200302052355.36365-3-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302052355.36365-3-ravi.bangoria@linux.ibm.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 10:53:46AM +0530, Ravi Bangoria wrote:
> From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> 
> Introduce new perf sample_type PERF_SAMPLE_PIPELINE_HAZ to request kernel
> to provide cpu pipeline hazard data. Also, introduce arch independent
> structure 'perf_pipeline_haz_data' to pass hazard data to userspace. This
> is generic structure and arch specific data needs to be converted to this
> format.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  include/linux/perf_event.h            |  7 ++++++
>  include/uapi/linux/perf_event.h       | 32 ++++++++++++++++++++++++++-
>  kernel/events/core.c                  |  6 +++++
>  tools/include/uapi/linux/perf_event.h | 32 ++++++++++++++++++++++++++-
>  4 files changed, 75 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 547773f5894e..d5b606e3c57d 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1001,6 +1001,7 @@ struct perf_sample_data {
>  	u64				stack_user_size;
>  
>  	u64				phys_addr;
> +	struct perf_pipeline_haz_data	pipeline_haz;
>  } ____cacheline_aligned;

I don't think you can add this here, see below.

>  /* default value for data source */
> @@ -1021,6 +1022,12 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
>  	data->weight = 0;
>  	data->data_src.val = PERF_MEM_NA;
>  	data->txn = 0;
> +	data->pipeline_haz.itype = PERF_HAZ__ITYPE_NA;
> +	data->pipeline_haz.icache = PERF_HAZ__ICACHE_NA;
> +	data->pipeline_haz.hazard_stage = PERF_HAZ__PIPE_STAGE_NA;
> +	data->pipeline_haz.hazard_reason = PERF_HAZ__HREASON_NA;
> +	data->pipeline_haz.stall_stage = PERF_HAZ__PIPE_STAGE_NA;
> +	data->pipeline_haz.stall_reason = PERF_HAZ__SREASON_NA;
>  }
>  
>  extern void perf_output_sample(struct perf_output_handle *handle,
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index 377d794d3105..ff252618ca93 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -142,8 +142,9 @@ enum perf_event_sample_format {
>  	PERF_SAMPLE_REGS_INTR			= 1U << 18,
>  	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
>  	PERF_SAMPLE_AUX				= 1U << 20,
> +	PERF_SAMPLE_PIPELINE_HAZ		= 1U << 21,
>  
> -	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
> +	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
>  
>  	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
>  };
> @@ -870,6 +871,13 @@ enum perf_event_type {
>  	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
>  	 *	{ u64			size;
>  	 *	  char			data[size]; } && PERF_SAMPLE_AUX
> +	 *	{ u8			itype;
> +	 *	  u8			icache;
> +	 *	  u8			hazard_stage;
> +	 *	  u8			hazard_reason;
> +	 *	  u8			stall_stage;
> +	 *	  u8			stall_reason;
> +	 *	  u16			pad;} && PERF_SAMPLE_PIPELINE_HAZ
>  	 * };

The existing comment shows the aux data *immediately* after ther
phys_addr field, where you've placed struct perf_pipeline_haz_data.

If adding to struct perf_sample_data is fine, this needs to come before
the aux data in this comment. If adding to struct perf_sample_data is
not fine. struct perf_pipeline_haz_data cannot live there.

I suspect the latter is true, but you're getting away with it because
you're not using both PERF_SAMPLE_AUX and PERF_SAMPLE_PIPELINE_HAZ
simultaneously.

Thanks,
Mark.

>  	 */
>  	PERF_RECORD_SAMPLE			= 9,
> @@ -1185,4 +1193,26 @@ struct perf_branch_entry {
>  		reserved:40;
>  };
>  
> +struct perf_pipeline_haz_data {
> +	/* Instruction/Opcode type: Load, Store, Branch .... */
> +	__u8	itype;
> +	/* Instruction Cache source */
> +	__u8	icache;
> +	/* Instruction suffered hazard in pipeline stage */
> +	__u8	hazard_stage;
> +	/* Hazard reason */
> +	__u8	hazard_reason;
> +	/* Instruction suffered stall in pipeline stage */
> +	__u8	stall_stage;
> +	/* Stall reason */
> +	__u8	stall_reason;
> +	__u16	pad;
> +};
> +
> +#define PERF_HAZ__ITYPE_NA	0x0
> +#define PERF_HAZ__ICACHE_NA	0x0
> +#define PERF_HAZ__PIPE_STAGE_NA	0x0
> +#define PERF_HAZ__HREASON_NA	0x0
> +#define PERF_HAZ__SREASON_NA	0x0
> +
>  #endif /* _UAPI_LINUX_PERF_EVENT_H */
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index e453589da97c..d00037c77ccf 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -1754,6 +1754,9 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
>  	if (sample_type & PERF_SAMPLE_PHYS_ADDR)
>  		size += sizeof(data->phys_addr);
>  
> +	if (sample_type & PERF_SAMPLE_PIPELINE_HAZ)
> +		size += sizeof(data->pipeline_haz);
> +
>  	event->header_size = size;
>  }
>  
> @@ -6712,6 +6715,9 @@ void perf_output_sample(struct perf_output_handle *handle,
>  			perf_aux_sample_output(event, handle, data);
>  	}
>  
> +	if (sample_type & PERF_SAMPLE_PIPELINE_HAZ)
> +		perf_output_put(handle, data->pipeline_haz);
> +
>  	if (!event->attr.watermark) {
>  		int wakeup_events = event->attr.wakeup_events;
>  
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index 377d794d3105..ff252618ca93 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -142,8 +142,9 @@ enum perf_event_sample_format {
>  	PERF_SAMPLE_REGS_INTR			= 1U << 18,
>  	PERF_SAMPLE_PHYS_ADDR			= 1U << 19,
>  	PERF_SAMPLE_AUX				= 1U << 20,
> +	PERF_SAMPLE_PIPELINE_HAZ		= 1U << 21,
>  
> -	PERF_SAMPLE_MAX = 1U << 21,		/* non-ABI */
> +	PERF_SAMPLE_MAX = 1U << 22,		/* non-ABI */
>  
>  	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
>  };
> @@ -870,6 +871,13 @@ enum perf_event_type {
>  	 *	{ u64			phys_addr;} && PERF_SAMPLE_PHYS_ADDR
>  	 *	{ u64			size;
>  	 *	  char			data[size]; } && PERF_SAMPLE_AUX
> +	 *	{ u8			itype;
> +	 *	  u8			icache;
> +	 *	  u8			hazard_stage;
> +	 *	  u8			hazard_reason;
> +	 *	  u8			stall_stage;
> +	 *	  u8			stall_reason;
> +	 *	  u16			pad;} && PERF_SAMPLE_PIPELINE_HAZ
>  	 * };
>  	 */
>  	PERF_RECORD_SAMPLE			= 9,
> @@ -1185,4 +1193,26 @@ struct perf_branch_entry {
>  		reserved:40;
>  };
>  
> +struct perf_pipeline_haz_data {
> +	/* Instruction/Opcode type: Load, Store, Branch .... */
> +	__u8	itype;
> +	/* Instruction Cache source */
> +	__u8	icache;
> +	/* Instruction suffered hazard in pipeline stage */
> +	__u8	hazard_stage;
> +	/* Hazard reason */
> +	__u8	hazard_reason;
> +	/* Instruction suffered stall in pipeline stage */
> +	__u8	stall_stage;
> +	/* Stall reason */
> +	__u8	stall_reason;
> +	__u16	pad;
> +};
> +
> +#define PERF_HAZ__ITYPE_NA	0x0
> +#define PERF_HAZ__ICACHE_NA	0x0
> +#define PERF_HAZ__PIPE_STAGE_NA	0x0
> +#define PERF_HAZ__HREASON_NA	0x0
> +#define PERF_HAZ__SREASON_NA	0x0
> +
>  #endif /* _UAPI_LINUX_PERF_EVENT_H */
> -- 
> 2.21.1
> 
