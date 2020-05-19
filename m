Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C8ADC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E45D207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 19:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589915296;
	bh=s0ggLM8TcUO/MB4Ceot/umDdgZQTbNFjRtm+3RpgAyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1zNLWr2PJcFO6lbXDYLdfNeoeqH1c/D3CcrwWOrxl+r1p327+hk7C2zzsxxxrp5g8
	 v8ud0/WXcsmqagkwmom+ucKqDWoEf6KTC9mQEPExeS1PIRYmjfpsol41b9+UTA0lC7
	 xcaTSmutcjkuBhdOErI/kedWNh62v5V+fI+Bqd6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgESTIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 15:08:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgESTIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 15:08:13 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E03E02075F;
        Tue, 19 May 2020 19:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589915292;
        bh=s0ggLM8TcUO/MB4Ceot/umDdgZQTbNFjRtm+3RpgAyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HTZ3gDYsbeLgq1PsNyq6EQJky8wcaDS2aKtrh+XAeVuvH4zzL79qNR06nv1dhqQgr
         I1OFEASOgalOyOStY7pf6+KowStVGu8TcZ4pi1PDueiwaa4+aTVnJ5RbXtwITSe4R/
         RtXZclU5NC8Yamae33t5exrHcpW94u28E2FkE4CQ=
Date:   Tue, 19 May 2020 14:12:59 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH perf/core] perf intel-pt: Fix clang build failure in
 intel_pt_synth_pebs_sample
Message-ID: <20200519191259.GB10690@embeddedor>
References: <20200513234738.GA21211@embeddedor>
 <20200514131030.GL5583@kernel.org>
 <20200514150601.GS4897@embeddedor>
 <CAP-5=fWTCFx80Hd_97_4AxFV4KsRyYptLbQfw=XVw_j8i-EAyg@mail.gmail.com>
 <20200514220934.GT4897@embeddedor>
 <CAP-5=fV5URsHn+SpW8N4XjkKT1vt2T1Us5FsqaJsoOW0zn=OxQ@mail.gmail.com>
 <20200515001025.GU4897@embeddedor>
 <20200515164153.GD9335@kernel.org>
 <2540ed9a-89f1-6d59-10c9-a66cc90db5d2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2540ed9a-89f1-6d59-10c9-a66cc90db5d2@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 03:35:48PM +0300, Adrian Hunter wrote:
> On 15/05/20 7:41 pm, Arnaldo Carvalho de Melo wrote:
> > Sorry for the top post: Adrian, can you take a look at this?
> > 
> > Adrian Hunter was not CCed, Adrian?
> 
> From: Adrian Hunter <adrian.hunter@intel.com>
> Date: Sat, 16 May 2020 15:12:28 +0300
> Subject: [PATCH] perf intel-pt: Use allocated branch stack for PEBS sample
> 
> To avoid having struct branch_stack as a non-last structure member,
> use allocated branch stack for PEBS sample.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>>

Thanks, Adrian.
--
Gustavo

> ---
>  tools/perf/util/intel-pt.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index f17b1e769ae4..e4dd8bf610ce 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -913,11 +913,11 @@ static void intel_pt_add_callchain(struct intel_pt *pt,
>  	sample->callchain = pt->chain;
>  }
>  
> -static struct branch_stack *intel_pt_alloc_br_stack(struct intel_pt *pt)
> +static struct branch_stack *intel_pt_alloc_br_stack(unsigned int entry_cnt)
>  {
>  	size_t sz = sizeof(struct branch_stack);
>  
> -	sz += pt->br_stack_sz * sizeof(struct branch_entry);
> +	sz += entry_cnt * sizeof(struct branch_entry);
>  	return zalloc(sz);
>  }
>  
> @@ -930,7 +930,7 @@ static int intel_pt_br_stack_init(struct intel_pt *pt)
>  			evsel->synth_sample_type |= PERF_SAMPLE_BRANCH_STACK;
>  	}
>  
> -	pt->br_stack = intel_pt_alloc_br_stack(pt);
> +	pt->br_stack = intel_pt_alloc_br_stack(pt->br_stack_sz);
>  	if (!pt->br_stack)
>  		return -ENOMEM;
>  
> @@ -951,6 +951,9 @@ static void intel_pt_add_br_stack(struct intel_pt *pt,
>  	sample->branch_stack = pt->br_stack;
>  }
>  
> +/* INTEL_PT_LBR_0, INTEL_PT_LBR_1 and INTEL_PT_LBR_2 */
> +#define LBRS_MAX (INTEL_PT_BLK_ITEM_ID_CNT * 3U)
> +
>  static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
>  						   unsigned int queue_nr)
>  {
> @@ -968,8 +971,10 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
>  			goto out_free;
>  	}
>  
> -	if (pt->synth_opts.last_branch) {
> -		ptq->last_branch = intel_pt_alloc_br_stack(pt);
> +	if (pt->synth_opts.last_branch || pt->synth_opts.other_events) {
> +		unsigned int entry_cnt = max(LBRS_MAX, pt->br_stack_sz);
> +
> +		ptq->last_branch = intel_pt_alloc_br_stack(entry_cnt);
>  		if (!ptq->last_branch)
>  			goto out_free;
>  	}
> @@ -1720,9 +1725,6 @@ static void intel_pt_add_lbrs(struct branch_stack *br_stack,
>  	}
>  }
>  
> -/* INTEL_PT_LBR_0, INTEL_PT_LBR_1 and INTEL_PT_LBR_2 */
> -#define LBRS_MAX (INTEL_PT_BLK_ITEM_ID_CNT * 3)
> -
>  static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
>  {
>  	const struct intel_pt_blk_items *items = &ptq->state->items;
> @@ -1798,25 +1800,18 @@ static int intel_pt_synth_pebs_sample(struct intel_pt_queue *ptq)
>  	}
>  
>  	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
> -		struct {
> -			struct branch_stack br_stack;
> -			struct branch_entry entries[LBRS_MAX];
> -		} br;
> -
>  		if (items->mask[INTEL_PT_LBR_0_POS] ||
>  		    items->mask[INTEL_PT_LBR_1_POS] ||
>  		    items->mask[INTEL_PT_LBR_2_POS]) {
> -			intel_pt_add_lbrs(&br.br_stack, items);
> -			sample.branch_stack = &br.br_stack;
> +			intel_pt_add_lbrs(ptq->last_branch, items);
>  		} else if (pt->synth_opts.last_branch) {
>  			thread_stack__br_sample(ptq->thread, ptq->cpu,
>  						ptq->last_branch,
>  						pt->br_stack_sz);
> -			sample.branch_stack = ptq->last_branch;
>  		} else {
> -			br.br_stack.nr = 0;
> -			sample.branch_stack = &br.br_stack;
> +			ptq->last_branch->nr = 0;
>  		}
> +		sample.branch_stack = ptq->last_branch;
>  	}
>  
>  	if (sample_type & PERF_SAMPLE_ADDR && items->has_mem_access_address)
> -- 
> 2.17.1
> 
> 
> 
