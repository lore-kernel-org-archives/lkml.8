Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EACAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 132B3206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EXoygTtg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgG2Gv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 02:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgG2Gv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 02:51:57 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8458C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 23:51:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id r4so745150pls.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 23:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nSv3tkRuZvIrkpS1YdM3QTGiWHU+CEt2ITw4/vvmoto=;
        b=EXoygTtg9dHzed/G/lfFb/7gmmAiWUOW1Mi+xUYfhGTYRPny4l4+7QW/K64Yt1mFP5
         8YARsTH8Yx0dWH2to7Z1WPRrcSNyLXwS1WqzqNFxPGbo1deUYltWAakAZN4iHf2kCLgw
         MUWmLZWNhdB50KGtnzcjV02/n+7Wkfpece+Z9nhz/RhVbEqsF9jPHC6TxBFVyz5SiR75
         AZcMxYU/kFbLuTpaT+fOPQuFpemXaMMa/WEqUW0TLCIwGv9ijQfXNTpI6Zw8uFFTYcj6
         hxHIWfvjCAhrZfe6uB2bYDuWCm+mnrabnu4Kw4UcxhgC+4lqaoGnTriwAdg4ICTymkqF
         eAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nSv3tkRuZvIrkpS1YdM3QTGiWHU+CEt2ITw4/vvmoto=;
        b=RR/91zkRYwNJb6EASi542z7tScpQ5u/EmNHVllJJkmklMsVfaUcy996tYRxyY2n525
         AFCm08sQB5354kHmXTno1NuJMuXb9Uo0osmBwxdBo9SW6LRFkpZprb7+hDEuvgkLPE7W
         xqO1x+SzEuUR0N08OPKXXgvFJ57nNysCV5/WP/wjamOyrC3dEiepQ8FjVv0pBvyxgMbe
         JU79Fb6MpHovi9Mjup8I8fYI5LiSu/d9dBQuid1jN8x7QjiHk902xWXgcMAG75GtGBxf
         JCCvIbeU/Ovaq8sRP5MPl5jIeprVnNVI1dyT0lrBXx686JPSSGlyn320mQDIjNFiqc3I
         z7Ww==
X-Gm-Message-State: AOAM532iFol+cybCXnDdw7aCwm6AGNO0+JrTu2xtodHcxI4EdhgJdrd4
        ObpMz8I+OoA6rrXNt4HZUTD4FQ==
X-Google-Smtp-Source: ABdhPJzpwdzGweCLBvO3IPK08GNulv18V8iBAX6quXtUuLtJy5gzyLc+Bu73Ju/DvdoU1Tc9ugsmYg==
X-Received: by 2002:a17:90a:f290:: with SMTP id fs16mr8151036pjb.35.1596005515277;
        Tue, 28 Jul 2020 23:51:55 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id t63sm1094162pfb.210.2020.07.28.23.51.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Jul 2020 23:51:54 -0700 (PDT)
Date:   Wed, 29 Jul 2020 14:51:48 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, zhangshaokun@hisilicon.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, guohanjun@huawei.com
Subject: Re: [PATCH 3/4] perf auxtrace: Add new itrace options for ARMv8.3-SPE
Message-ID: <20200729065148.GF4343@leoy-ThinkPad-X240s>
References: <20200724091607.41903-1-liwei391@huawei.com>
 <20200724091607.41903-4-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724091607.41903-4-liwei391@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 05:16:06PM +0800, Wei Li wrote:
> This patch is to add two options to synthesize events which are
> described as below:
> 
>  'u': synthesize unaligned address access events
>  'v': synthesize partial/empty predicated SVE events
> 
> This two options will be used by ARM SPE as their first consumer.
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  tools/perf/Documentation/itrace.txt | 2 ++
>  tools/perf/util/auxtrace.c          | 8 ++++++++
>  tools/perf/util/auxtrace.h          | 4 ++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
> index e817179c5027..25bcf3622709 100644
> --- a/tools/perf/Documentation/itrace.txt
> +++ b/tools/perf/Documentation/itrace.txt
> @@ -13,6 +13,8 @@
>  		m	synthesize last level cache events
>  		t	synthesize TLB events
>  		a	synthesize remote access events
> +		u	synthesize unaligned address access events
> +		v	synthesize partial/empty predicated SVE events
>  		g	synthesize a call chain (use with i or x)
>  		G	synthesize a call chain on existing event records
>  		l	synthesize last branch entries (use with i or x)
> diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> index 25c639ac4ad4..2033eb3708ec 100644
> --- a/tools/perf/util/auxtrace.c
> +++ b/tools/perf/util/auxtrace.c
> @@ -1334,6 +1334,8 @@ void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
>  	synth_opts->llc = true;
>  	synth_opts->tlb = true;
>  	synth_opts->remote_access = true;
> +	synth_opts->alignment = true;
> +	synth_opts->sve = true;
>  
>  	if (no_sample) {
>  		synth_opts->period_type = PERF_ITRACE_PERIOD_INSTRUCTIONS;
> @@ -1507,6 +1509,12 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
>  		case 'a':
>  			synth_opts->remote_access = true;
>  			break;
> +		case 'u':
> +			synth_opts->alignment = true;
> +			break;
> +		case 'v':
> +			synth_opts->sve = true;
> +			break;
>  		case ' ':
>  		case ',':
>  			break;
> diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> index 142ccf7d34df..972df7b06b0d 100644
> --- a/tools/perf/util/auxtrace.h
> +++ b/tools/perf/util/auxtrace.h
> @@ -116,6 +116,8 @@ struct itrace_synth_opts {
>  	bool			llc;
>  	bool			tlb;
>  	bool			remote_access;
> +	bool			alignment;

Patch 03 and 04 are directive, it's good for me.

The naming 'unalignment' would be more clear and avoid confusion.

> +	bool			sve;
>  	unsigned int		callchain_sz;
>  	unsigned int		last_branch_sz;
>  	unsigned long long	period;
> @@ -617,6 +619,8 @@ bool auxtrace__evsel_is_auxtrace(struct perf_session *session,
>  "				m:	    		synthesize last level cache events\n" \
>  "				t:	    		synthesize TLB events\n" \
>  "				a:	    		synthesize remote access events\n" \
> +"				u:	    		synthesize unaligned address access events\n" \

The 'unalignment' events are for 'unaligned address access and size of data'.

Otherwise, looks good to me:
Reviewed-by: Leo Yan <leo.yan@linaro.org>

Thanks,
Leo

> +"				v:	    		synthesize partial/empty predicated SVE events\n" \
>  "				g[len]:     		synthesize a call chain (use with i or x)\n" \
>  "				l[len]:     		synthesize last branch entries (use with i or x)\n" \
>  "				sNUMBER:    		skip initial number of events\n"		\
> -- 
> 2.17.1
> 
