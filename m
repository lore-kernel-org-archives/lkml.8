Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3131BC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7D9206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 17:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbgAJRbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 12:31:08 -0500
Received: from mga05.intel.com ([192.55.52.43]:49934 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgAJRbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 12:31:08 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 09:31:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,417,1571727600"; 
   d="scan'208";a="224255940"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga003.jf.intel.com with ESMTP; 10 Jan 2020 09:31:07 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B07C5300DE4; Fri, 10 Jan 2020 09:31:07 -0800 (PST)
Date:   Fri, 10 Jan 2020 09:31:07 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jann Horn <jannh@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: Re: [PATCH] perf tools: Setup initial evlist::all_cpus value
Message-ID: <20200110173107.GU15478@tassilo.jf.intel.com>
References: <20200110151537.153012-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110151537.153012-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 04:15:37PM +0100, Jiri Olsa wrote:
> Jann Horn reported crash in perf ftrace because evlist::all_cpus
> isn't initialized if there's evlist without events, which is the
> case for perf ftrace.
> 
> Adding initial initialization of evlist::all_cpus from given cpus,
> regardless of events in the evlist.

Acked-by: Andi Kleen <ak@linux.intel.com>

> 
> Reported-by: Jann Horn <jannh@google.com>
> Link: https://lkml.kernel.org/n/tip-kzioebqr5c3u4t7tafju8pbx@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/perf/evlist.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
> index ae9e65aa2491..5b9f2ca50591 100644
> --- a/tools/lib/perf/evlist.c
> +++ b/tools/lib/perf/evlist.c
> @@ -164,6 +164,9 @@ void perf_evlist__set_maps(struct perf_evlist *evlist,
>  		evlist->threads = perf_thread_map__get(threads);
>  	}
>  
> +	if (!evlist->all_cpus && cpus)
> +		evlist->all_cpus = perf_cpu_map__get(cpus);
> +
>  	perf_evlist__propagate_maps(evlist);
>  }
>  
> -- 
> 2.24.1
> 
