Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94A7C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 14:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6969D2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 14:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599663560;
	bh=qa9EuPKN4fDsWqlJndl++hK0zmDjZlqe7DY95AfgI2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XAzjxmvDccMIz1bPSnQAWJOLy4PuMiyvAcb9oE3QHxDSzo+BhtqPprG2fzuLPRrR9
	 sHgZPDCcMS9pTIh3IOJ/9F24GNpNP5J395Vgl6zwfYbaBfE0eJfFHnOfw1ww33nh7i
	 5HYxqPNP8wfjBrOL91sUSQKU7+Qw1qjEQyKHuOfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730395AbgIIO6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 10:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729789AbgIIM3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:29:41 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AC1621D92;
        Wed,  9 Sep 2020 12:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599654552;
        bh=qa9EuPKN4fDsWqlJndl++hK0zmDjZlqe7DY95AfgI2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WYw9+lM6Kak0wPhFkenvh7sm/XPv2clMSRMnRLkO6Wt6sVGSQA40H8COJpeGl7b8R
         gRbIz46plDBo8YdzpPi16bapxPmG8m5lju4mKMlrVLPUS+0XsFxZOi0sv69kxS7s9y
         BztustYWcK2fWRLaosojfYDp19kccg4Cww8H6PjI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C71DB40D3D; Wed,  9 Sep 2020 09:29:10 -0300 (-03)
Date:   Wed, 9 Sep 2020 09:29:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 2/3] perf list: Do not print 'Metric Groups:'
 unnecessarily
Message-ID: <20200909122910.GB3788224@kernel.org>
References: <20200909055849.469612-1-namhyung@kernel.org>
 <20200909055849.469612-2-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909055849.469612-2-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 09, 2020 at 02:58:48PM +0900, Namhyung Kim escreveu:
> It was printed unconditionally even if nothing is printed.
> Check if the output list empty when filter is given.
> 
> Before:
>   $ ./perf list duration
> 
>   List of pre-defined events (to be used in -e):
> 
>     duration_time                                      [Tool event]
> 
>   Metric Groups:
> 
> After:
>   $ ./perf list duration
> 
>   List of pre-defined events (to be used in -e):
> 
>     duration_time                                      [Tool event]
 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

---

Thanks, applied.

- Arnaldo
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index 8831b964288f..38464d7d2d63 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -535,10 +535,12 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
>  		}
>  	}
>  
> -	if (metricgroups && !raw)
> -		printf("\nMetric Groups:\n\n");
> -	else if (metrics && !raw)
> -		printf("\nMetrics:\n\n");
> +	if (!filter || !rblist__empty(&groups)) {
> +		if (metricgroups && !raw)
> +			printf("\nMetric Groups:\n\n");
> +		else if (metrics && !raw)
> +			printf("\nMetrics:\n\n");
> +	}
>  
>  	for (node = rb_first_cached(&groups.entries); node; node = next) {
>  		struct mep *me = container_of(node, struct mep, nd);
> -- 
> 2.28.0.526.ge36021eeef-goog
> 

-- 

- Arnaldo
