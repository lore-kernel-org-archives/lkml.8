Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9543C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB262205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wy3VWtqo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgEMPjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgEMPjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:39:51 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA8FCC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:39:50 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id s1so1134303qkf.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DNYx3kfVXhYG38/RgP2TZnldis+8ELqa7KUKPjStpDc=;
        b=Wy3VWtqoX3BvnNmBm2x1fM8mFtt819ps8ys9e3vS9HzCGe21jsTF0OAFwKVSXXWTwO
         lP2ta7fxs31wAaTdClfM+KhlqKtAo4Y6Q7dfFmqf4xiIMS5Fo6Wxsy6h+HvDWMQVwb85
         x1iYymRrPo2Q38/iIiOsLtylroo1XFd/h8osqMIQJ8SwJh/k2e6L5hPTQBIq+vNrnII4
         yuGZk0KFcH6NCdmL1fG5cJW2+HuqSdQqgc8hWfR3/Cfl+YUCmtVshcOnqn9W+KcR8q52
         LWiraLx061TeZxMW3pUI059FUq9IFie8+NS2VREy0/u4umWRTO414N6AZYuuHhzl8PXy
         pvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DNYx3kfVXhYG38/RgP2TZnldis+8ELqa7KUKPjStpDc=;
        b=aEPIwSOZZEeZ5rLTeezlsXD7j3k6QlvaZoGCIQt+XWRUUwLPqYWtkf0hlWnWIYbWnD
         iX+CH4Ta4xGcHFMGs0LqfCEgw59Bm6KmPkIEp8cSUCdiFROM07xMZ5z/bAlyEqWo9+Op
         jaFM13c40rkdv5t+yih8bqA9Uyby8byw+5WZkrvGBrss8j3oKAFCIFB/BS0yfigC8Q1U
         EeW8mck6ss4sKchDZrwnHkkGzal5rsB2EeABQ5LwiH8Gz1sPsqAW1woX8D5YEO9Q7Hjs
         f8ILeJW1tudC2Aoa/swyo7558rWiqoiAtiSzFEEm7xc9YBVbbtHeJWafLfzUufEdi+bX
         NCFw==
X-Gm-Message-State: AOAM530f8Qj/5G0AA1qvYSTq18K4cpSiPluvNPt1NrHycDQxPomSR6d3
        UB+Nr4/F5rndkgMi31RWdmA=
X-Google-Smtp-Source: ABdhPJzFixWyvI4pabGlhzFTZNoCuvN77J3j2qoGZzoyGiUS5vzuR+595LLS8AW7kxyaiRr9k4iTSQ==
X-Received: by 2002:a05:620a:1432:: with SMTP id k18mr247566qkj.71.1589384390157;
        Wed, 13 May 2020 08:39:50 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id d207sm128357qkc.49.2020.05.13.08.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 08:39:49 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BC53340AFD; Wed, 13 May 2020 12:39:47 -0300 (-03)
Date:   Wed, 13 May 2020 12:39:47 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Clarke <pc@us.ibm.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v2 1/2] perf expr: Test parsing of floating point numbers
Message-ID: <20200513153947.GI5583@kernel.org>
References: <20200513062752.3681-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513062752.3681-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 12, 2020 at 11:27:51PM -0700, Ian Rogers escreveu:
> Add test for fix in:
> commit 5741da3dee4c ("perf expr: Parse numbers as doubles")
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/tests/expr.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
> index f9e8e5628836..3f742612776a 100644
> --- a/tools/perf/tests/expr.c
> +++ b/tools/perf/tests/expr.c
> @@ -39,6 +39,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
>  	ret |= test(&ctx, "min(1,2) + 1", 2);
>  	ret |= test(&ctx, "max(1,2) + 1", 3);
>  	ret |= test(&ctx, "1+1 if 3*4 else 0", 2);
> +	ret |= test(&ctx, "1.1 + 2.1", 3.2);
>  
>  	if (ret)
>  		return ret;
> -- 
> 2.26.2.645.ge9eca65c58-goog

Applied.

- Arnaldo
