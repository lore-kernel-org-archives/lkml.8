Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E34CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EDDA2220D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp6r62/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387975AbgEMNgc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgEMNgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:36:32 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16646C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:36:31 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id i5so1076660qkl.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lmITFjsR21MwwfP3n1tM0be86PHBqAQG1lx6vKEzNCI=;
        b=Sp6r62/unXkVQ9RdT5jPUQ+DFrt+Lpdl8ytL1qU87fZyFpuwY7NrUkvLth9ivA3yi8
         VTZF2nmLrpct0i52FeFjbs/g0Y9AzejFF/Pbwy42opFeRn6kpxpkklapKCqERcCiUbar
         6xt8op2ImJjoFWh4BjxELxK4h4y3hzUYd4evurYjAv6uOvRG8v9BA8/obYJw0BRzdQic
         J+PNpGbOzIEo7mRthy9pcdGiNaZlPC9IZI6zmnZ2YUF8CaCJPSUnzBLgrxeVnjH1Aopt
         mSlAHY70Uf3jgXfHIUwSadkgQJergXLfp4pIq5v0KNcRXgckmz8q6USUdso+DV1ohDkw
         U0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lmITFjsR21MwwfP3n1tM0be86PHBqAQG1lx6vKEzNCI=;
        b=CKkeiIMx319FIHJR7JpqSt2OFIMyek7wcf6sP6cwfqVga/3oyTx1dCvEugdnmDazqf
         aNz42ru8LAtMVeg25/Qwr5ydS3iXIhe80+UnB5sNPEbsZbjQ8anvsHfRLytprysIp1pK
         milwxmDX1/X7i6iMSAxpXaVbfoKCeX4WLk6OcRSmaLlSZQMBD+/2zp1dawx5eMKSgM3m
         saCzYRmP4OYTBoz/L956wm7Bc7cP6FHukrF9bSVq9QKQ11Me1sbhtYfm5YhfnbfPTq7v
         HNdKLwDLm6Oevcn4Gf8umSbxAL0bPgZuGzZGcqq6q1eZzlS2I0R4VflSN82e9yCicce0
         gE7A==
X-Gm-Message-State: AGi0PuY3z/8d08iLE0Yh39hOwk7pk5TKLLfuN0PeyZA+gQTXltvEOdmc
        B5pVzyAJKB4Y7HczYvVXiJw=
X-Google-Smtp-Source: APiQypLH7NxZ1IbbN8SdlyfV46MwB7Ry3KDpa/bScPo9CnLGdlrpLdg+21+wFFFZbyJFde/5Gc/kEQ==
X-Received: by 2002:ae9:ebd2:: with SMTP id b201mr26017288qkg.80.1589376990262;
        Wed, 13 May 2020 06:36:30 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id a1sm15121254qtj.65.2020.05.13.06.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:36:29 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2B8A2410F5; Wed, 13 May 2020 10:36:27 -0300 (-03)
Date:   Wed, 13 May 2020 10:36:27 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf evsel: Fix 2 memory leaks
Message-ID: <20200513133627.GC5583@kernel.org>
References: <20200512235918.10732-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512235918.10732-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 12, 2020 at 04:59:18PM -0700, Ian Rogers escreveu:
> If allocated, perf_pkg_mask and metric_events need freeing.

Applied, were those found with some tool? Or just by visual inspection?

Also I noticed that evsel->metric_events is correctly initialized to
NULL in evsel__init(), but evsel->per_pkg_mask isn't, and while
evsel__new() uses zalloc() it is possible, IIRC, for evsels associated
with hists to be part of a larger struct, so I think the safest way is
to initialize evsel->per_pkg_mask to NULL in evsel__init(), will do it
in a follow up patch.

- Arnaldo
 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/evsel.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index a2397ca4d57a..654b79c1f4ac 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -1266,6 +1266,8 @@ void evsel__exit(struct evsel *evsel)
>  	zfree(&evsel->group_name);
>  	zfree(&evsel->name);
>  	zfree(&evsel->pmu_name);
> +	zfree(&evsel->per_pkg_mask);
> +	zfree(&evsel->metric_events);
>  	perf_evsel__object.fini(evsel);
>  }
>  
> -- 
> 2.26.2.645.ge9eca65c58-goog
> 

-- 

- Arnaldo
