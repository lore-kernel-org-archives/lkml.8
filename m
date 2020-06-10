Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A47C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B2A820760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591796792;
	bh=hUBaQttDSu0Gi3BR/8qUxcD7F4i+pqM2NvBPU4dzkqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rMvPzUd/Y4NjB2yl+m0dBydHr83nll3q95aaHkWPE3qUqfvQzBvFh8Q82OUftaCwJ
	 FCR1sGXF0g9ZlIij5e/Zp62R4V9EBIDaCLFs4rezNSYCeQHEg+NEuQHgOguzVs1J1L
	 cAP9LAM19QtkuUnguKZFA9+hnEDuPooa6wjG3WKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbgFJNqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:46:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgFJNq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:46:28 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09A4320734;
        Wed, 10 Jun 2020 13:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591796788;
        bh=hUBaQttDSu0Gi3BR/8qUxcD7F4i+pqM2NvBPU4dzkqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b0p4jl14C+zKcMjp4nFCT0+2wLAzxq6GL2HRFgU9nZKiXped7aWATv1Nv20Y/mtyc
         GZfYrcEWoQsuXzMyMh0bwI9l2P8NK1YK3jioPRpLYzBe6O1BiQial+gBqB5P4+oqXY
         e3DX3cp+EQ36r/w8bEpt6B8IwJMnpXKc/gsUFEAs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0F90B40AFD; Wed, 10 Jun 2020 10:46:26 -0300 (-03)
Date:   Wed, 10 Jun 2020 10:46:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/2] perf pmu: remove unused declaration
Message-ID: <20200610134626.GJ24868@kernel.org>
References: <20200609234344.3795-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609234344.3795-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 09, 2020 at 04:43:43PM -0700, Ian Rogers escreveu:
> This avoids multiple declarations if the flex header is included.

Thanks, applied,

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/pmu.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 85e0c7f2515c..f971d9aa4570 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -86,7 +86,6 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
>  			  struct perf_pmu_info *info);
>  struct list_head *perf_pmu__alias(struct perf_pmu *pmu,
>  				  struct list_head *head_terms);
> -int perf_pmu_wrap(void);
>  void perf_pmu_error(struct list_head *list, char *name, char const *msg);
>  
>  int perf_pmu__new_format(struct list_head *list, char *name,
> -- 
> 2.27.0.278.ge193c7cf3a9-goog
> 

-- 

- Arnaldo
