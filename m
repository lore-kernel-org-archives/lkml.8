Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBBEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9CD9207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591717005;
	bh=8jxQ4UoOVCXFybvExCDuNuK2icpIb8M2qVUBiuG5s4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IKSYKTwHpOigbnR8LKQjtLse2fhc6wXm+urSWEC9Xg+Sb7NyrQ+F08iAqeksOW6pf
	 WxEi0UpPTxmlvP29ALY3FVL+1nknV73kzfCwnmBYTkxCfO/Xj9J9yaplyELUgJ9SNz
	 TvgxHQX7hibqh17Md/WyH1NFe5QazBe+C64zcYP8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgFIPgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:36:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728944AbgFIPgo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:36:44 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A611420774;
        Tue,  9 Jun 2020 15:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591717003;
        bh=8jxQ4UoOVCXFybvExCDuNuK2icpIb8M2qVUBiuG5s4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GJ8XxCq7LNSwdBtg6GkheDzfgXxEqiiVPgS1En+mEIw/DfevEWgjfnO6yOaAUd3JQ
         etawWoLPW0tvEUzt4M1F/a3zcglZYz/GsCUR1jKDMPoPlETuiI4fbZCsdJcamrlm6a
         o6n4hYBrvVDesYg5JHMNp87GeYdSf/wgFCjkaLtY=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D3CFD40AFD; Tue,  9 Jun 2020 12:36:41 -0300 (-03)
Date:   Tue, 9 Jun 2020 12:36:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 1/2] perf parse-events: fix an incompatible pointer
Message-ID: <20200609153641.GG24868@kernel.org>
References: <20200609053610.206588-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609053610.206588-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jun 08, 2020 at 10:36:09PM -0700, Ian Rogers escreveu:
> Arrays are pointer types and don't need their address taking.
> Fixes: 8255718f4bed (perf pmu: Expand PMU events by prefix match)

Thanks, applied.

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.y | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index c4ca932d092d..d4e076c9c2ab 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -349,7 +349,7 @@ PE_PMU_EVENT_PRE '-' PE_PMU_EVENT_SUF sep_dc
>  	struct list_head *list;
>  	char pmu_name[128];
>  
> -	snprintf(&pmu_name, 128, "%s-%s", $1, $3);
> +	snprintf(pmu_name, sizeof(pmu_name), "%s-%s", $1, $3);
>  	free($1);
>  	free($3);
>  	if (parse_events_multi_pmu_add(_parse_state, pmu_name, &list) < 0)
> -- 
> 2.27.0.278.ge193c7cf3a9-goog
> 

-- 

- Arnaldo
