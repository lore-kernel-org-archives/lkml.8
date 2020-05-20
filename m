Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA327C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6529207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dh2jYroS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728444AbgETBma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 21:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgETBm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:42:28 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2B6C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 18:42:28 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g185so2058029qke.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 18:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2vr8aGGYwB/HzpiRpaqToPdz9s36lt+fxcWLWDvleD8=;
        b=dh2jYroSDrs2fgJmf+QB8OY/8MAtrWcHvOhSn5f+RWyX1ZT0w9ZqoUO3TaFuwWYq7T
         i+mhFPdonZCldWj5fCDAI84nyKiVvzT0OHkrC/3BfcDyZDpWpSaDYf8KYvqB0r/Sfxrp
         sVRH5eWV1OZSU02Dpwc2rmnILl2kgJLISdrv3Q8G7J6AJ0FTBKjTGvWV+v2feqK8hpXc
         mHG3S3TEc36pmbqkKirsbvRyagGP4t1veYkEtamgQG/gOaIndDl8XTsAM6Aru6wlDuDn
         m3adn121MGVVmHErFnpLP/ZijHPP/DKgrNXR6hZPVgSYrBoqH55hZehAgWIaLGlknKom
         68/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2vr8aGGYwB/HzpiRpaqToPdz9s36lt+fxcWLWDvleD8=;
        b=DCB1cNYCAcMxDewQPhIgrURDQHgcuhZncqbivp+wWPLfZF4ZM/+RD+U7tZK++6x/ki
         UxD+D4/Okuw+pZyq6VVsp8HVL/BJLzFTZaEYqv2UpwCB+1oIrlH4DzlzGJN59tuoLAER
         QUJ0z6w9OCd6MWpE42nuDyTvQkcw2R2lVWWlB4HJUBHKVazloMLeGopcxUKqo/XFTMdT
         bbbv/H80Z9JMoC2YUEr1dr3d1Qso+1H67DDY8Prpi4VLaih7DxJv2a1xbYmYVYvl7Pn1
         B1mKP5yKrTUsGPQwvBy0P+xE8367b0S2sdKcAQnNFPaARPLJqTVs0dEd4UtYrlUpQPQV
         SIqg==
X-Gm-Message-State: AOAM532txDz+KWzXShMsRS79FCR2AMuoqtmRtIbnG9otblMbqL1K1tAG
        xDs/446sk/uguBy9WLUyDGyvBEAqhQI=
X-Google-Smtp-Source: ABdhPJxErVB3Og1gGIUQP/T8AIzYpUTGC1AGbL4rET6RdsrrOItH1NSK/OyIZGgl8fXnDSe8mbKH6g==
X-Received: by 2002:a37:46d8:: with SMTP id t207mr2459929qka.102.1589938947221;
        Tue, 19 May 2020 18:42:27 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id e22sm1216372qts.2.2020.05.19.18.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 18:42:26 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 676C840AFD; Tue, 19 May 2020 22:42:24 -0300 (-03)
Date:   Tue, 19 May 2020 22:42:24 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
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
Message-ID: <20200520014224.GH28228@kernel.org>
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
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, May 16, 2020 at 03:35:48PM +0300, Adrian Hunter escreveu:
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

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
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

-- 

- Arnaldo
