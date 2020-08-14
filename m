Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A74C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A61612087D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597409248;
	bh=LWfEJo2yv51g1xPFjTHclS9PxlauBHm3nptze07V1nM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d5XsK8MAnoJ84dkwYJ2IiVpOIWoFBLdIPD9k7egpZkmEzDojplC8CqaOG2t5TkXVG
	 IAFADzcUC7VFTLinM9nhV+6Ktme20K3XWS7O5ikhpap7h2IPN2qJsulxyg1yWEwPJV
	 mgoU1Uqc/PhTXoaNzxfeEFoV7o2z/tDI3SKwPge4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgHNMr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:47:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:53700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbgHNMr0 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 08:47:26 -0400
Received: from quaco.ghostprotocols.net (177.207.136.251.dynamic.adsl.gvt.net.br [177.207.136.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D08E62087D;
        Fri, 14 Aug 2020 12:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597409245;
        bh=LWfEJo2yv51g1xPFjTHclS9PxlauBHm3nptze07V1nM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ceSENNIJg5elCC7plusVsTqf2rls5rYhUd9IVT966zuFXdNwGT+inVwKX9s/+Laty
         n4QLvW0aDtE4VeSxhmomfi9KMiVyS5P0n6teNR5H0uek57Llg7RcbnPE2+HrWd8L4J
         ACCBn/wcezUulZr8HZ+4uvZlvSmmGq8YVdvsIWiA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B720540D3D; Fri, 14 Aug 2020 09:47:22 -0300 (-03)
Date:   Fri, 14 Aug 2020 09:47:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com,
        like.xu@linux.intel.com
Subject: Re: [PATCH v3] perf parse-events: Set exclude_guest=1 for user-space
 counting
Message-ID: <20200814124722.GG13995@kernel.org>
References: <20200814012120.16647-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200814012120.16647-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 14, 2020 at 09:21:20AM +0800, Jin Yao escreveu:
> Currently if we run 'perf record -e cycles:u', exclude_guest=0.
> 
> But it doesn't make sense in most cases that we request for
> user-space counting but we also get the guest report.
> 
> Of course, we also need to consider perf kvm usage case that
> authorized perf users on the host may only want to count guest
> user space events. For example,
> 
> perf kvm --guest record -e cycles:u

Ok, probably this works, but what if I want to record guest user samples
without using 'perf kvm'?

Can we have a 'U' modifier, perhaps, for that?

I.e.

perf record -e cycles:uU would not set exclude_host not exclude_guest,
cycles:u excludes guest user, cycles:U excludes host user, would that be
possible?

Anyway, I think that with what we have, your patch makes sense, having a
way to, without using 'perf kvm' still be able to sample the guest can
be done on top. of this.

Xu, can we get your Reviewed-by if this addresses your concerns?

- Arnaldo
 
> When we have 'exclude_guest=1' for perf kvm usage, we may get
> nothing from guest events.
> 
> To keep perf semantics consistent and clear, this patch sets
> exclude_guest=1 for user-space counting but except for perf
> kvm usage.
> 
> Before:
>   perf record -e cycles:u ./div
>   perf evlist -v
>   cycles:u: ..., exclude_kernel: 1, exclude_hv: 1, ...
> 
> After:
>   perf record -e cycles:u ./div
>   perf evlist -v
>   cycles:u: ..., exclude_kernel: 1, exclude_hv: 1,  exclude_guest: 1, ...
> 
> Before:
>   perf kvm --guest record -e cycles:u -vvv
> 
> perf_event_attr:
>   size                             120
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|ID|CPU|PERIOD
>   read_format                      ID
>   disabled                         1
>   inherit                          1
>   exclude_kernel                   1
>   exclude_hv                       1
>   freq                             1
>   sample_id_all                    1
> 
> After:
>   perf kvm --guest record -e cycles:u -vvv
> 
> perf_event_attr:
>   size                             120
>   { sample_period, sample_freq }   4000
>   sample_type                      IP|TID|TIME|ID|CPU|PERIOD
>   read_format                      ID
>   disabled                         1
>   inherit                          1
>   exclude_kernel                   1
>   exclude_hv                       1
>   freq                             1
>   sample_id_all                    1
> 
> For Before/After, exclude_guest are both 0 for perf kvm usage.
> 
> perf test 6
>  6: Parse event definition strings             : Ok
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  v3:
>  ---
>  For perf kvm, if we have 'exclude_guest=1', we can't get guest
>  events. So we don't set 'exclude_guest=1' for perf kvm.
> 
>  v2:
>  ---
>  Fix the 'perf test 6' failure.
> 
>  tools/perf/tests/parse-events.c | 4 ++--
>  tools/perf/util/parse-events.c  | 3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
> index 7f9f87a470c3..aae0fd9045c1 100644
> --- a/tools/perf/tests/parse-events.c
> +++ b/tools/perf/tests/parse-events.c
> @@ -719,7 +719,7 @@ static int test__group2(struct evlist *evlist)
>  	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  	TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
>  	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
>  	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> @@ -842,7 +842,7 @@ static int test__group3(struct evlist *evlist __maybe_unused)
>  	TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>  	TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
>  	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
> -	TEST_ASSERT_VAL("wrong exclude guest", !evsel->core.attr.exclude_guest);
> +	TEST_ASSERT_VAL("wrong exclude guest", evsel->core.attr.exclude_guest);
>  	TEST_ASSERT_VAL("wrong exclude host", !evsel->core.attr.exclude_host);
>  	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>  	TEST_ASSERT_VAL("wrong leader", evsel__is_group_leader(evsel));
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 9f7260e69113..ff4c23d2a0f3 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -37,6 +37,7 @@
>  #include "util/evsel_config.h"
>  #include "util/event.h"
>  #include "util/pfm.h"
> +#include "perf.h"
>  
>  #define MAX_NAME_LEN 100
>  
> @@ -1794,6 +1795,8 @@ static int get_event_modifier(struct event_modifier *mod, char *str,
>  		if (*str == 'u') {
>  			if (!exclude)
>  				exclude = eu = ek = eh = 1;
> +			if (!exclude_GH && !perf_guest)
> +				eG = 1;
>  			eu = 0;
>  		} else if (*str == 'k') {
>  			if (!exclude)
> -- 
> 2.17.1
> 

-- 

- Arnaldo
