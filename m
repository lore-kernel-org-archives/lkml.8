Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B14C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0AF222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:48:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LgehsBu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgBNOsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:48:53 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37212 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgBNOsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 09:48:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id p14so5008989pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 06:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=olN8im+33HDqKbRJqnea6LkxJhw3pbEDMRYZ+Bg9A0o=;
        b=LgehsBu4GmRcJRFfehryqOAWWmQ2jRD2iuHOtHWZZGoloCEYuNTHv8hWjbBOFHVCEU
         StAgd0cSlGnRNXva3TE8gN1bA52YhLa44rM4mHS7SAC9wJgse7/QNI6i85IlrZOzJdDE
         q1jh9ORLr4Rr75SJKR76L5gpO6GfsZTfX4k4M60tPeDWLnNWy0cc87RlSb/vWQldhxNe
         6FMIhDQAJtyIHjqRSgDK5ADbNUAOZ8XsRTrxsCTOqfkqS1B353TLDYa6Fw7GrmslWFHU
         B0Npn9NW/Nb7F3IuMJS/tGJ9zMkjG1Q2SfN6zNQeZzQnQTrtUA0yWpP4RmP68cuvAHcF
         cdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=olN8im+33HDqKbRJqnea6LkxJhw3pbEDMRYZ+Bg9A0o=;
        b=dF83fHVrDhXl5sIyDydp0KLfusKp6ZuCu3Whz1mTRa0jqNlwOdG8uF3/T7mbayDwZG
         NkoDa3R1WQlX5n6nHPQtZ6VgMLzW+Q19yvDgWNNC5hAG9Cc/wMjAYaZLcK8QYAkdnk8w
         v834xrCaeRLkuC5yqdVdfEcrBFbC493vao8E+QvIrSaxc+EApoX9vM2iJNZUkSHMCKaN
         kD06nyk/prPCASUcmkbH/fZLx3rHiwjWt8neSHMQ1jRay2g38WqD9bZ43VtmmKRuI0Ed
         TqryIBeYxLdcnW9PDjxgXDNw6nI97cMaYJT+T1ENsCjvVVZdun461O0MnbgbV8VQqxDJ
         cPAA==
X-Gm-Message-State: APjAAAWw/QbXbFgZ/J8cIN1+XDABJi8e2ODO1vebIncdgmBnNZxPKAiN
        RHkCnlt7TSByhRALE0iCemQraA==
X-Google-Smtp-Source: APXvYqxuJuFgTXYTRoyYwsvQtR17qGcjcZNGD7OjGZzEIrzr1HmULF/+Z5tiTZZ0vTd3/maG3dwHHw==
X-Received: by 2002:a62:d44a:: with SMTP id u10mr3643464pfl.191.1581691731498;
        Fri, 14 Feb 2020 06:48:51 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id e16sm7189722pgk.77.2020.02.14.06.48.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Feb 2020 06:48:50 -0800 (PST)
Date:   Fri, 14 Feb 2020 22:48:23 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Wei Li <liwei391@huawei.com>
Subject: Re: [PATCH 5/5] perf auxtrace: Add auxtrace_record__read_finish()
Message-ID: <20200214144823.GC30041@leoy-ThinkPad-X240s>
References: <20200214132654.20395-1-adrian.hunter@intel.com>
 <20200214132654.20395-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214132654.20395-6-adrian.hunter@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 03:26:54PM +0200, Adrian Hunter wrote:
> All ->read_finish() implementations are doing the same thing. Add a
> helper function so that they can share the same implementation.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/arch/arm/util/cs-etm.c    | 21 ++-------------------
>  tools/perf/arch/arm64/util/arm-spe.c | 20 ++------------------
>  tools/perf/arch/x86/util/intel-bts.c | 20 ++------------------
>  tools/perf/arch/x86/util/intel-pt.c  | 20 ++------------------
>  tools/perf/util/auxtrace.c           | 22 +++++++++++++++++++++-
>  tools/perf/util/auxtrace.h           |  6 ++++++
>  6 files changed, 35 insertions(+), 74 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 60141c3007a9..00126e7df465 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -858,24 +858,6 @@ static void cs_etm_recording_free(struct auxtrace_record *itr)
>  	free(ptr);
>  }
>  
> -static int cs_etm_read_finish(struct auxtrace_record *itr, int idx)
> -{
> -	struct cs_etm_recording *ptr =
> -			container_of(itr, struct cs_etm_recording, itr);
> -	struct evsel *evsel;
> -
> -	evlist__for_each_entry(ptr->evlist, evsel) {
> -		if (evsel->core.attr.type == ptr->cs_etm_pmu->type) {
> -			if (evsel->disabled)
> -				return 0;
> -			return perf_evlist__enable_event_idx(ptr->evlist,
> -							     evsel, idx);
> -		}
> -	}
> -
> -	return -EINVAL;
> -}
> -
>  struct auxtrace_record *cs_etm_record_init(int *err)
>  {
>  	struct perf_pmu *cs_etm_pmu;
> @@ -895,6 +877,7 @@ struct auxtrace_record *cs_etm_record_init(int *err)
>  	}
>  
>  	ptr->cs_etm_pmu			= cs_etm_pmu;
> +	ptr->itr.cs_etm_pmu		= cs_etm_pmu;

Should change to:
        ptr->itr.pmu                    = cs_etm_pmu;

With this change:
Reviewed-and-Tested-by: Leo Yan <leo.yan@linaro.org>

>  	ptr->itr.parse_snapshot_options	= cs_etm_parse_snapshot_options;
>  	ptr->itr.recording_options	= cs_etm_recording_options;
>  	ptr->itr.info_priv_size		= cs_etm_info_priv_size;
> @@ -904,7 +887,7 @@ struct auxtrace_record *cs_etm_record_init(int *err)
>  	ptr->itr.snapshot_finish	= cs_etm_snapshot_finish;
>  	ptr->itr.reference		= cs_etm_reference;
>  	ptr->itr.free			= cs_etm_recording_free;
> -	ptr->itr.read_finish		= cs_etm_read_finish;
> +	ptr->itr.read_finish		= auxtrace_record__read_finish;
>  
>  	*err = 0;
>  	return &ptr->itr;
> diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
> index 1d993c27242b..8d6821d9c3f6 100644
> --- a/tools/perf/arch/arm64/util/arm-spe.c
> +++ b/tools/perf/arch/arm64/util/arm-spe.c
> @@ -158,23 +158,6 @@ static void arm_spe_recording_free(struct auxtrace_record *itr)
>  	free(sper);
>  }
>  
> -static int arm_spe_read_finish(struct auxtrace_record *itr, int idx)
> -{
> -	struct arm_spe_recording *sper =
> -			container_of(itr, struct arm_spe_recording, itr);
> -	struct evsel *evsel;
> -
> -	evlist__for_each_entry(sper->evlist, evsel) {
> -		if (evsel->core.attr.type == sper->arm_spe_pmu->type) {
> -			if (evsel->disabled)
> -				return 0;
> -			return perf_evlist__enable_event_idx(sper->evlist,
> -							     evsel, idx);
> -		}
> -	}
> -	return -EINVAL;
> -}
> -
>  struct auxtrace_record *arm_spe_recording_init(int *err,
>  					       struct perf_pmu *arm_spe_pmu)
>  {
> @@ -192,12 +175,13 @@ struct auxtrace_record *arm_spe_recording_init(int *err,
>  	}
>  
>  	sper->arm_spe_pmu = arm_spe_pmu;
> +	sper->itr.pmu = arm_spe_pmu;
>  	sper->itr.recording_options = arm_spe_recording_options;
>  	sper->itr.info_priv_size = arm_spe_info_priv_size;
>  	sper->itr.info_fill = arm_spe_info_fill;
>  	sper->itr.free = arm_spe_recording_free;
>  	sper->itr.reference = arm_spe_reference;
> -	sper->itr.read_finish = arm_spe_read_finish;
> +	sper->itr.read_finish = auxtrace_record__read_finish;
>  	sper->itr.alignment = 0;
>  
>  	*err = 0;
> diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
> index 39e363151ad7..26cee1052179 100644
> --- a/tools/perf/arch/x86/util/intel-bts.c
> +++ b/tools/perf/arch/x86/util/intel-bts.c
> @@ -413,23 +413,6 @@ static int intel_bts_find_snapshot(struct auxtrace_record *itr, int idx,
>  	return err;
>  }
>  
> -static int intel_bts_read_finish(struct auxtrace_record *itr, int idx)
> -{
> -	struct intel_bts_recording *btsr =
> -			container_of(itr, struct intel_bts_recording, itr);
> -	struct evsel *evsel;
> -
> -	evlist__for_each_entry(btsr->evlist, evsel) {
> -		if (evsel->core.attr.type == btsr->intel_bts_pmu->type) {
> -			if (evsel->disabled)
> -				return 0;
> -			return perf_evlist__enable_event_idx(btsr->evlist,
> -							     evsel, idx);
> -		}
> -	}
> -	return -EINVAL;
> -}
> -
>  struct auxtrace_record *intel_bts_recording_init(int *err)
>  {
>  	struct perf_pmu *intel_bts_pmu = perf_pmu__find(INTEL_BTS_PMU_NAME);
> @@ -450,6 +433,7 @@ struct auxtrace_record *intel_bts_recording_init(int *err)
>  	}
>  
>  	btsr->intel_bts_pmu = intel_bts_pmu;
> +	btsr->itr.pmu = intel_bts_pmu;
>  	btsr->itr.recording_options = intel_bts_recording_options;
>  	btsr->itr.info_priv_size = intel_bts_info_priv_size;
>  	btsr->itr.info_fill = intel_bts_info_fill;
> @@ -459,7 +443,7 @@ struct auxtrace_record *intel_bts_recording_init(int *err)
>  	btsr->itr.find_snapshot = intel_bts_find_snapshot;
>  	btsr->itr.parse_snapshot_options = intel_bts_parse_snapshot_options;
>  	btsr->itr.reference = intel_bts_reference;
> -	btsr->itr.read_finish = intel_bts_read_finish;
> +	btsr->itr.read_finish = auxtrace_record__read_finish;
>  	btsr->itr.alignment = sizeof(struct branch);
>  	return &btsr->itr;
>  }
> diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
> index 2f0a0832907f..acadaa10c65d 100644
> --- a/tools/perf/arch/x86/util/intel-pt.c
> +++ b/tools/perf/arch/x86/util/intel-pt.c
> @@ -1170,23 +1170,6 @@ static u64 intel_pt_reference(struct auxtrace_record *itr __maybe_unused)
>  	return rdtsc();
>  }
>  
> -static int intel_pt_read_finish(struct auxtrace_record *itr, int idx)
> -{
> -	struct intel_pt_recording *ptr =
> -			container_of(itr, struct intel_pt_recording, itr);
> -	struct evsel *evsel;
> -
> -	evlist__for_each_entry(ptr->evlist, evsel) {
> -		if (evsel->core.attr.type == ptr->intel_pt_pmu->type) {
> -			if (evsel->disabled)
> -				return 0;
> -			return perf_evlist__enable_event_idx(ptr->evlist, evsel,
> -							     idx);
> -		}
> -	}
> -	return -EINVAL;
> -}
> -
>  struct auxtrace_record *intel_pt_recording_init(int *err)
>  {
>  	struct perf_pmu *intel_pt_pmu = perf_pmu__find(INTEL_PT_PMU_NAME);
> @@ -1207,6 +1190,7 @@ struct auxtrace_record *intel_pt_recording_init(int *err)
>  	}
>  
>  	ptr->intel_pt_pmu = intel_pt_pmu;
> +	ptr->itr.pmu = intel_pt_pmu;
>  	ptr->itr.recording_options = intel_pt_recording_options;
>  	ptr->itr.info_priv_size = intel_pt_info_priv_size;
>  	ptr->itr.info_fill = intel_pt_info_fill;
> @@ -1216,7 +1200,7 @@ struct auxtrace_record *intel_pt_recording_init(int *err)
>  	ptr->itr.find_snapshot = intel_pt_find_snapshot;
>  	ptr->itr.parse_snapshot_options = intel_pt_parse_snapshot_options;
>  	ptr->itr.reference = intel_pt_reference;
> -	ptr->itr.read_finish = intel_pt_read_finish;
> +	ptr->itr.read_finish = auxtrace_record__read_finish;
>  	/*
>  	 * Decoding starts at a PSB packet. Minimum PSB period is 2K so 4K
>  	 * should give at least 1 PSB per sample.
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index eb087e7df6f4..3571ce72ca28 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -629,8 +629,10 @@ int auxtrace_record__options(struct auxtrace_record *itr,
>  			     struct evlist *evlist,
>  			     struct record_opts *opts)
>  {
> -	if (itr)
> +	if (itr) {
> +		itr->evlist = evlist;
>  		return itr->recording_options(itr, evlist, opts);
> +	}
>  	return 0;
>  }
>  
> @@ -664,6 +666,24 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
>  	return -EINVAL;
>  }
>  
> +int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx)
> +{
> +	struct evsel *evsel;
> +
> +	if (!itr->evlist || !itr->pmu)
> +		return -EINVAL;
> +
> +	evlist__for_each_entry(itr->evlist, evsel) {
> +		if (evsel->core.attr.type == itr->pmu->type) {
> +			if (evsel->disabled)
> +				return 0;
> +			return perf_evlist__enable_event_idx(itr->evlist, evsel,
> +							     idx);
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
>  /*
>   * Event record size is 16-bit which results in a maximum size of about 64KiB.
>   * Allow about 4KiB for the rest of the sample record, to give a maximum
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 749d72cd9c7b..e58ef160b599 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -29,6 +29,7 @@ struct record_opts;
>  struct perf_record_auxtrace_error;
>  struct perf_record_auxtrace_info;
>  struct events_stats;
> +struct perf_pmu;
>  
>  enum auxtrace_error_type {
>         PERF_AUXTRACE_ERROR_ITRACE  = 1,
> @@ -322,6 +323,8 @@ struct auxtrace_mmap_params {
>   * @read_finish: called after reading from an auxtrace mmap
>   * @alignment: alignment (if any) for AUX area data
>   * @default_aux_sample_size: default sample size for --aux sample option
> + * @pmu: associated pmu
> + * @evlist: selected events list
>   */
>  struct auxtrace_record {
>  	int (*recording_options)(struct auxtrace_record *itr,
> @@ -346,6 +349,8 @@ struct auxtrace_record {
>  	int (*read_finish)(struct auxtrace_record *itr, int idx);
>  	unsigned int alignment;
>  	unsigned int default_aux_sample_size;
> +	struct perf_pmu *pmu;
> +	struct evlist *evlist;
>  };
>  
>  /**
> @@ -537,6 +542,7 @@ int auxtrace_record__find_snapshot(struct auxtrace_record *itr, int idx,
>  				   struct auxtrace_mmap *mm,
>  				   unsigned char *data, u64 *head, u64 *old);
>  u64 auxtrace_record__reference(struct auxtrace_record *itr);
> +int auxtrace_record__read_finish(struct auxtrace_record *itr, int idx);
>  
>  int auxtrace_index__auxtrace_event(struct list_head *head, union perf_event *event,
>  				   off_t file_offset);
> -- 
> 2.17.1
> 
