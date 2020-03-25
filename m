Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4C7C2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F5420719
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9nO1NB9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbgCYTZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:25:44 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:46690 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbgCYTZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:25:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id u4so3837457qkj.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 12:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sPcjbSNBesC/NdOsDtyVCyVgM7ZVzEXz0TUVmUnVG4c=;
        b=M9nO1NB9KKYpUDscsJaXpuptFiRPZqCtWp6z3B43ZCTyT+9p4OAA3HymZ58sJjt3yh
         YvOycDVoEcmLr1PmtfLuZ49l9ixhR3AhisSZsg5y2OviJdCzqTchnZPLHmzryHBKx9Wv
         JNzvspTYoxzI97k3IDo14s74oifnGQH3PnW0B1alyBv7YqO8KvQ9zCBrFWFwrOmvgzrb
         nkSTcazSNy/XCpnUYg3RhhxaK2bNHKRj7jIUSAu7ZXk9I2/zn2bhvR8IHg4CtIDzXrGY
         4PFS9h0B9gGoMTuMv4io4BVlYiqTkaLcT2ceuPCVRuBCwtCM3nC+EzjCEEZmbycX5+H5
         bmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sPcjbSNBesC/NdOsDtyVCyVgM7ZVzEXz0TUVmUnVG4c=;
        b=EHmkhs6362Q5GWPncts7eHC5k164/1BVNt/7hdwR3U+E1LWBaSWSplUYGwj3eFw82a
         sxOQyiFugTYtdie27mSICxT2ALZsCIHUcdDgTUpD0PZnQSu3NMQl0MvgM5vyBeaqJqlm
         h5vcN3qMxuZCY41UaKmD4xwE3aEkfo5JwCZzlbDcqEDuP6zPgezk4lvTcKevwzNP7727
         Etn9stdNTG0igV3un54hDPViJXNQM3shMXwIEuPrucxopTWsoO42gMMW3MYFRApBnHhz
         4rq/PXcAQeor9PrTV3Gie/0GM8TTGa4+OTcqGF5/fEgIodSJVZU6snl+rVj6lXLndHEs
         R/oA==
X-Gm-Message-State: ANhLgQ1oj4mXa/7Q2KPDhPSNX0ELE+vGLiWxBUvKySrM89ukOi2v9zUG
        NexNUHsRC7NPHk/goE5tojM=
X-Google-Smtp-Source: ADFU+vuNGT8wOtdVZTntx/FEY5Czblcce9Wbj03L8QOWZ+/fH2bcLR89xgBDwQNnh+V63FrwWQqDhA==
X-Received: by 2002:a37:8645:: with SMTP id i66mr4441647qkd.91.1585164342411;
        Wed, 25 Mar 2020 12:25:42 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id d185sm16747255qkf.46.2020.03.25.12.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 12:25:41 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C8BD640F77; Wed, 25 Mar 2020 16:25:39 -0300 (-03)
Date:   Wed, 25 Mar 2020 16:25:39 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf parse-events: add defensive null check
Message-ID: <20200325192539.GH14102@kernel.org>
References: <20200325164022.41385-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325164022.41385-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 25, 2020 at 09:40:22AM -0700, Ian Rogers escreveu:
> Terms may have a null config in which case a strcmp will segv. This can
> be reproduced with:
>   perf stat -e '*/event=?,nr/' sleep 1
> Add a null check to avoid this. This was caught by LLVM's libfuzzer.

Adding the NULL check doesn't hurt, I guess, but I coudln't repro it:

  [root@seventh ~]# perf stat -e '*/event=?,nr/' sleep 1
  WARNING: multiple event parsing errors
  event syntax error: '*/event=?,nr/'
                      \___ 'nr' is not usable in 'perf stat'
  
  Initial error:
  event syntax error: '*/event=?,nr/'
                       \___ Cannot find PMU `*'. Missing kernel support?
  Run 'perf list' for a list of valid events
  
   Usage: perf stat [<options>] [<command>]
  
      -e, --event <event>   event selector. use 'perf list' to list available events
  [root@seventh ~]#

Does this take place only when libfuzzer is being used?

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmu.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 616fbda7c3fc..ef6a63f3d386 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -984,12 +984,11 @@ static int pmu_resolve_param_term(struct parse_events_term *term,
>  	struct parse_events_term *t;
>  
>  	list_for_each_entry(t, head_terms, list) {
> -		if (t->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
> -			if (!strcmp(t->config, term->config)) {
> -				t->used = true;
> -				*value = t->val.num;
> -				return 0;
> -			}
> +		if (t->type_val == PARSE_EVENTS__TERM_TYPE_NUM &&
> +		    t->config && !strcmp(t->config, term->config)) {
> +			t->used = true;
> +			*value = t->val.num;
> +			return 0;
>  		}
>  	}
>  
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 

-- 

- Arnaldo
