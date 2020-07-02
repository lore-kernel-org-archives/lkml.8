Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7666C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB4A20781
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fvYkB0Gr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgGBXD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgGBXD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:03:26 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DF3C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 16:03:26 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x11so11875356plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 16:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C/wKxCmAp8P5+IuEDReF1PhHjU6934D3J4Spbsakypw=;
        b=fvYkB0GrlRYeSsqKY8DfBsHb5+EpJsR1WxZhgotr27Mz85gEm8Z5BsTJde29nk/h1E
         BHK7QPSGOx7VZRR+JfzAmGcukkWdp28+cMSOWMccRubKzRkU0/N7mewl+2fR/9jC7LO3
         dyXtLDDoH+t6Wj0OwsEMiRc3V5sg8zZaOc0TiIrFy59Q9BrPS5FnSNawmGBLpvH2Gxsj
         xxh4j5Ftf5qhMv07igHdA+38g5zACOzhHOynpFMZaDfu55MVUZ6mtDkLIl3P03ukK+Ga
         vM6LSUFknrixnYs9VBRakxbwjk24jelKI4MuTaKLnUOoZzufz0x+7S1Dr+wwgGY5EpHH
         slAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C/wKxCmAp8P5+IuEDReF1PhHjU6934D3J4Spbsakypw=;
        b=Tfw7vrraHSbIpTrj4rqRfn2+fshOdUaYidPsLM/7LVucivvzzHBFhbAFXb7SrFFEKs
         Wn/3ycolp82jx7S71pmQljQAHYe4L8N+ICwJ92MOpsxuUrTv1Gb71ojZznq2EkglaIgh
         l6ZWmLb/i2oX3ZuQOiKs9RbRdYeG6d/vu6pTa/T7Y9Wp5HlELx+QcFyvQ/fitQSMa4+5
         dRAlNE1YbeLpqs61vhLEsbS4MmRziJlI6BP2jteA6uc3thozIgwRkKwp7zMkxD3Svgae
         p+N1c6eWZD29FTIO8jFe33nl5/rNSfOkdJFDcWXZ4Siy8i2KacHE260sfZQK0USFHABF
         9CWw==
X-Gm-Message-State: AOAM532WOZ7OuxoaTRw0lWFxlg354L4w0F7eC6F2V9rmBm2667EoZrMl
        McK7wzdoWaPQfK4QQApBl8GYdg==
X-Google-Smtp-Source: ABdhPJyF1ykGkpqefsktD2Yx+ekgyRNvo0wT3Zm5a/e/Nie0V2q0Tu814ppuAKsBilsKAUqwbstdQA==
X-Received: by 2002:a17:90b:19d4:: with SMTP id nm20mr12314798pjb.206.1593731005454;
        Thu, 02 Jul 2020 16:03:25 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id 198sm10316727pfb.27.2020.07.02.16.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 16:03:24 -0700 (PDT)
Date:   Thu, 2 Jul 2020 17:03:22 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, leo.yan@linaro.org
Subject: Re: [PATCH 2/2] perf tools: Fix record failure when mixed with ARM
 SPE event
Message-ID: <20200702230322.GB471976@xps15>
References: <20200623123141.27747-1-liwei391@huawei.com>
 <20200623123141.27747-3-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623123141.27747-3-liwei391@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

On Tue, Jun 23, 2020 at 08:31:41PM +0800, Wei Li wrote:
> When recording with cache-misses and arm_spe_x event, i found that
> it will just fail without showing any error info if i put cache-misses
> after arm_spe_x event.
> 
> [root@localhost 0620]# perf record -e cache-misses -e \
> arm_spe_0/ts_enable=1,pct_enable=1,pa_enable=1,load_filter=1,\
> jitter=1,store_filter=1,min_latency=0/ sleep 1
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.067 MB perf.data ]
> [root@localhost 0620]# perf record -e \
> arm_spe_0/ts_enable=1,pct_enable=1,pa_enable=1,load_filter=1,jitter=1,\
> store_filter=1,min_latency=0/ -e cache-misses sleep 1
> [root@localhost 0620]#
> 
> Finally, i found the reason is that the parameter 'arm_spe_pmu' passed to
> arm_spe_recording_init() in auxtrace_record__init() is wrong. When the
> arm_spe_x event is not the last event, 'arm_spe_pmus[i]' will be out of
> bounds.

Yes, this indeed broken.  

The current code can only work if the only event to be
traced is an arm_spe_X, or if it is the last event to be specified.
Otherwise the last event type will be checked against all the
arm_spe_pmus[i]->types, none will match and an out of bound i index will be
used in arm_spc_recording_init().

Since this problem is not easy to figure out please include the above
explanation in the changelog.

> 
> It seems that the code can't support concurrent multiple different
> arm_spe_x events currently. So add the code to check and record the
> found 'arm_spe_pmu' to fix this issue.
> 
> In fact, we don't support concurrent multiple same arm_spe_x events either,
> that is checked in arm_spe_recording_options(), and it will show the
> relevant info.
> 
> Fixes: ffd3d18c20b8d ("perf tools: Add ARM Statistical Profiling Extensions (SPE) support")
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  tools/perf/arch/arm/util/auxtrace.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> index 62b7b03d691a..7bb6f29e766c 100644
> --- a/tools/perf/arch/arm/util/auxtrace.c
> +++ b/tools/perf/arch/arm/util/auxtrace.c
> @@ -58,6 +58,7 @@ struct auxtrace_record
>  	bool found_etm = false;
>  	bool found_spe = false;
>  	static struct perf_pmu **arm_spe_pmus;
> +	static struct perf_pmu *arm_spe_pmu;

As far as I can tell the "static" doesn't do anything.

>  	static int nr_spes = 0;
>  	int i = 0;
>  
> @@ -77,6 +78,13 @@ struct auxtrace_record
>  
>  		for (i = 0; i < nr_spes; i++) {
>  			if (evsel->core.attr.type == arm_spe_pmus[i]->type) {
> +				if (found_spe && (arm_spe_pmu != arm_spe_pmus[i])) {
> +					pr_err("Concurrent multiple SPE operation not currently supported\n");
> +					*err = -EOPNOTSUPP;
> +					return NULL;
> +				}

Instead of the above, which as you rightly pointed out, is also done in
arm_spe_recording_options() it might be best to just fix the "if (!nr_spes)"
condition:
                if (!nr_spes || arm_spe_pmu)
                        continue

Furthermore, instead of having a new arm_spe_pmu variable you could simply make
found_spe a struct perf_pmu.  That would be one less variable to take care of.

> +
> +				arm_spe_pmu = arm_spe_pmus[i];
>  				found_spe = true;

Last but not least do you know where the memory allocated for array arm_spe_pmus
is released?  If you can't find it either then we have a memory leak and it
would be nice to have that fixed.

Regards
Mathieu

PS: Leo Yan has spent a fair amount of time in the SPE code - please CC him on
your next revision.


>  				break;
>  			}
> @@ -94,7 +102,7 @@ struct auxtrace_record
>  
>  #if defined(__aarch64__)
>  	if (found_spe)
> -		return arm_spe_recording_init(err, arm_spe_pmus[i]);
> +		return arm_spe_recording_init(err, arm_spe_pmu);
>  #endif
>  
>  	/*
> -- 
> 2.17.1
> 
