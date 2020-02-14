Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A369AC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 785442187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rxh1KN5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729336AbgBNOna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:43:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35906 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgBNOna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 09:43:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id a6so3820239plm.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 06:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ec7LAw2UYNity1cyY/MgCg1nPG6E4Z2Db2nANQfWqWM=;
        b=rxh1KN5iyh4F0uWLBOxfbrFT4L35EpMdsOC+285OOcLRkOKagndQS+yOUp7Qyn1Ssn
         QdRQQL72JXtYp9QF/FhBrrYGJwUlQSEldPQf4h7/Gd0MFxD7uuVM+15tcBkTBsO+bgQz
         juufteqHzTUCoi8ahNRCtPt0zCfJrYap0nMVapDUHK39qXSCOb1LwPdShFoQMTUBeuTa
         H8jykihpP6tUnWGNcYdCX1WYRe1Q4EbDRJCqJwmJNknAPUSDl0CuIGCVFrrlJc/COPGO
         H7OpsNm5q5w2h3SRndbPY6umlCEbAgqCRFBaRWqOiBa1jkYMYptaOmPIWjs6XoGXynzy
         pYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ec7LAw2UYNity1cyY/MgCg1nPG6E4Z2Db2nANQfWqWM=;
        b=dqNOmMIiJivwsRaBTaNpkrkIWpK6C/piJQ6aeDMBSCJ5LqRvFr1k6Znmm9hHjZk7tR
         yjIe4+bAatYIGgmwQi6dETYmt/wJvwNWk2IznnIjlyhXFvztYZNTELAxW0Q7BZNfR8JC
         QVwj/0jsozZ3kntngbZopI6+GrD+9aYRUQXFX7sW76Vlfq9YrgbCenyfDdbPI3sIXEXw
         QRkTgrBHVxED80uvIEJ1bcmRouu/t1N4K2ln2jXWNturBjhCua3lO3YRseishZ0Hi34g
         +OPLxtLf3CZlzisCI+sHy7u4Ra61rofeWGTJ0+VvHE4SqnlA5JqmNI0Q97dXen9tPHWm
         BYvA==
X-Gm-Message-State: APjAAAXE3Z5NcSEYiNuAvh5y4dq2wNeiMUXat/HXVD3p3PmE3kJldq4J
        tOSWltpRhQSM5TF2DEZg+93ipg==
X-Google-Smtp-Source: APXvYqwfQ9BkVlguY4bJQ51PVjwEObawGU/X9nNI6Fxg/0UrPIQDyMZo5Gx2xRHNLco9mPP3Cced2Q==
X-Received: by 2002:a17:902:8d94:: with SMTP id v20mr3817091plo.259.1581691409698;
        Fri, 14 Feb 2020 06:43:29 -0800 (PST)
Received: from leoy-ThinkPad-X240s (li1441-214.members.linode.com. [45.118.134.214])
        by smtp.gmail.com with ESMTPSA id x8sm7124962pfr.104.2020.02.14.06.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Feb 2020 06:43:29 -0800 (PST)
Date:   Fri, 14 Feb 2020 22:43:08 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Wei Li <liwei391@huawei.com>
Subject: Re: [PATCH V2 3/5] perf tools: cs-etm: fix endless record after
 being terminated
Message-ID: <20200214144308.GB30041@leoy-ThinkPad-X240s>
References: <20200214132654.20395-1-adrian.hunter@intel.com>
 <20200214132654.20395-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214132654.20395-4-adrian.hunter@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 03:26:52PM +0200, Adrian Hunter wrote:
> From: Wei Li <liwei391@huawei.com>
> 
> In __cmd_record(), when receiving SIGINT(ctrl + c), a done flag will
> be set and the event list will be disabled by evlist__disable() once.
> 
> While in auxtrace_record.read_finish(), the related events will be
> enabled again, if they are continuous, the recording seems to be endless.
> 
> If the cs_etm event is disabled, we don't enable it again here.
> 
> Note: This patch is NOT tested since i don't have such a machine with
> coresight feature, but the code seems buggy same as arm-spe and intel-pt.
> 
> Signed-off-by: Wei Li <liwei391@huawei.com>
> [ahunter: removed redundant 'else' after 'return']
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable@vger.kernel.org # 5.4+

Thanks for looping, Adrian.  Applied this patch and tested with
CoreSight on juno board, it works well:

Reviewed-and-Tested-by: Leo Yan <leo.yan@linaro.org>


> ---
>  tools/perf/arch/arm/util/cs-etm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 2898cfdf8fe1..60141c3007a9 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -865,9 +865,12 @@ static int cs_etm_read_finish(struct auxtrace_record *itr, int idx)
>  	struct evsel *evsel;
>  
>  	evlist__for_each_entry(ptr->evlist, evsel) {
> -		if (evsel->core.attr.type == ptr->cs_etm_pmu->type)
> +		if (evsel->core.attr.type == ptr->cs_etm_pmu->type) {
> +			if (evsel->disabled)
> +				return 0;
>  			return perf_evlist__enable_event_idx(ptr->evlist,
>  							     evsel, idx);
> +		}
>  	}
>  
>  	return -EINVAL;
> -- 
> 2.17.1
> 
