Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A58C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 05:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA6E20874
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 05:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tX4VUWRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgGEFFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 01:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgGEFFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 01:05:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34387C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 22:05:37 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bj10so8844389plb.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 22:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xgO5po79eWxovFEEuw7kMLwjskBHCz/x+ddLprK8PdM=;
        b=tX4VUWRYvoHdrCVERbPNHdPtP+VsHJGj8hyfoSXniwb2cgVmcWux/0VAeBFvPvnDlC
         b+dsGXhmSg/KLkbU95L8fHN88HqT28KNPz633bxJfrWRPI55+rDjTlFYyoeod7v8rAup
         iMPwDxXgdI+fHhLBHufi/DsNk6rrOz6CQf3i5BCIxetHed9MX1MJJwGeEEJbVuoW+Tai
         5f7/oc/n/D/48uOd08Ov0ZN2gNdWlmkxOamo7I0Fycd07ZWxWjp7knw+52CSo3zKwQmC
         GJBrciJOuzIyafBCVQbOOlEeJ6mS4eBewIJF59TodNm5cGgLYBqjx0uN9eKKuVDQEJSp
         Ax9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xgO5po79eWxovFEEuw7kMLwjskBHCz/x+ddLprK8PdM=;
        b=c1whYV+GCORQ7oF6Ifa4wqHfthfCZy+wgOpFuOSioxav8NAjK3mevBWdJ+bv3JUrEJ
         IygMmroT9ksnMA5QNgjJB7o6tryGCThJ50HctZRUDpHkw2cL8t3YL9sHSq9WZDePP4UJ
         yPSzgI+fCeJvVPDeoFb3b/biJ/rHCO/4er4imD1N2fG2s+R2D0nGpfzImJfVY2s27bZN
         +va0GW9QGX+vZxH/ZUnQPMatKLwdJ+MXLeDZcao5yixy2RbvaKe5s0nyUroUjYqbchY+
         16Z+WkB203NVAW3XqNuUZpfhkvctVGT94CCmvRDM8FOVkGxOhO1AR3Uq0y75egZ6Ewip
         +Jkg==
X-Gm-Message-State: AOAM531wA8QUbriIVlj8j6CAYLaD8eflbYZabKxsUk8AQm8ooruQyF3w
        0Ph5+CXoFMr73x5m9Gba/ptq+A==
X-Google-Smtp-Source: ABdhPJwiAXDyeCtORifUigLyfsFxra2XSOawq6pEQMfSZebGAuT/NyTKhNFeJ6zm6pBTtXhlmy57nQ==
X-Received: by 2002:a17:90a:ff03:: with SMTP id ce3mr48875619pjb.174.1593925535924;
        Sat, 04 Jul 2020 22:05:35 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id h6sm15868276pfg.25.2020.07.04.22.05.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Jul 2020 22:05:35 -0700 (PDT)
Date:   Sun, 5 Jul 2020 13:05:27 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Wei Li <liwei391@huawei.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Kim Phillips <kim.phillips@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        James Clark <james.clark@arm.com>
Subject: Re: [PATCH 1/2] perf tools: ARM SPE code cleanup
Message-ID: <20200705050527.GA14142@leoy-ThinkPad-X240s>
References: <20200623123141.27747-1-liwei391@huawei.com>
 <20200623123141.27747-2-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623123141.27747-2-liwei391@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

On Tue, Jun 23, 2020 at 08:31:40PM +0800, Wei Li wrote:
> Remove the useless check code to make it clear.
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  tools/perf/arch/arm/util/auxtrace.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> index 0a6e75b8777a..62b7b03d691a 100644
> --- a/tools/perf/arch/arm/util/auxtrace.c
> +++ b/tools/perf/arch/arm/util/auxtrace.c
> @@ -57,7 +57,7 @@ struct auxtrace_record
>  	struct evsel *evsel;
>  	bool found_etm = false;
>  	bool found_spe = false;
> -	static struct perf_pmu **arm_spe_pmus = NULL;
> +	static struct perf_pmu **arm_spe_pmus;

Here the 'static' should be removed as well.

Just for more complete background info, IIUC, at the beginning to
enable SPE's PMU event, since SPE is micro-architecture dependent
(though it's defined in ARMv8-ARM, but it might be different for
different ARM micro-architectures).  So this is why here it uses
'static' for varaible "arm_spe_pmus", it wants to initialize the
variable with finding all SPE PMU structure at the first time when
invoke the function auxtrace_record__init(), and afterwards we can
reuse the variable "arm_spe_pmus" and without calling
find_all_arm_spe_pmus() anymore.

So I struggled to figure out what's good thing to do with multiple SPE
PMU events, and your change is good thing to me.  The reason is:

- Firstly, the function auxtrace_record__init() will be invoked only
  once, the variable "arm_spe_pmus" will not be used afterwards, thus
  we don't need to check "arm_spe_pmus" is NULL or not;
- Another reason is, even though SPE is micro-architecture dependent,
  but so far it only supports "statistical-profiling-extension-v1" and
  we have no chance to use multiple SPE's PMU events in Perf command.


So after removing 'static' for varaible "arm_spe_pmus":
Reviewed-by: Leo Yan <leo.yan@linaro.org>


P.s. Sorry if it's my reason that James Clark's patch [1] has not been
merged in the mainline kernel and introduced duplicate efforts at here.
James's patch used similiar method to resolve this same issue.

[1] https://lkml.org/lkml/2019/12/20/293

>  	static int nr_spes = 0;
>  	int i = 0;
>  
> @@ -65,9 +65,7 @@ struct auxtrace_record
>  		return NULL;
>  
>  	cs_etm_pmu = perf_pmu__find(CORESIGHT_ETM_PMU_NAME);
> -
> -	if (!arm_spe_pmus)
> -		arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
> +	arm_spe_pmus = find_all_arm_spe_pmus(&nr_spes, err);
>  
>  	evlist__for_each_entry(evlist, evsel) {
>  		if (cs_etm_pmu &&
> -- 
> 2.17.1
> 
