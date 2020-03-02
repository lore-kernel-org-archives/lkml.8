Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80629C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 577BC21D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbgCBOst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:48:49 -0500
Received: from foss.arm.com ([217.140.110.172]:33684 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbgCBOst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:48:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DDBF2F;
        Mon,  2 Mar 2020 06:48:48 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 807FB3F534;
        Mon,  2 Mar 2020 06:48:45 -0800 (PST)
Date:   Mon, 2 Mar 2020 14:48:43 +0000
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
Message-ID: <20200302144842.GD56497@lakrids.cambridge.arm.com>
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
>  
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

Can we please have perf_event_open() reject this sample flag for PMUs
without the new callback (introduced in the next patch)?

That way it'll be possible to detect whether the PMU exposes this.

Thanks,
Mark.
