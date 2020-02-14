Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0C4C3B1B5
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177052086A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y5+mnE9D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405655AbgBNSZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:25:07 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:36105 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394936AbgBNSZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:25:00 -0500
Received: by mail-yb1-f196.google.com with SMTP id u26so1641917ybd.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 10:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vjCBA5XQv6rcne2yiKVQsdPWWjnEIwi/mOgMqqe0NpE=;
        b=Y5+mnE9DzMyJMRvwZiq82Km6lKaPBooOpJ1ZKLee8hMXxAoxN2UHazyCU6rKchv6c5
         clTmI5EW9hB+q76Rgo5ivfUftRQTklnI17XENCByDFPta4eS4VZKUvM0FF/MNEXzBPsN
         ETVZqrVkiYAE7xHr8G67rlH0INFiTqWgSeQA88x3ybKngddfXgp+xbkzDtaBV6Ovg/ZE
         mKiZr+BbiY+7mkqE10utci/uUDY7nNcaTqZkXUPeapPj4r0o1Y3kT/rgOvGw2r2OfB+u
         g0fDThzMLneUpvz04QD0xSdbeSV0Q00PIRD2cSY5lq5bUkrHM9Fk4wZHX+Cqcj/Aei5Y
         xBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vjCBA5XQv6rcne2yiKVQsdPWWjnEIwi/mOgMqqe0NpE=;
        b=J0S9vD8MVrhk80M1NpxhYOjGJNKz3cgTa5V9aogGwrkFgTYQpcfauyRR7vHk1Ls1rz
         LiBAvZ9LESEhEj1r0NYtJCdP1wM65tuqRzkMMHUojLX+5AP4OdfiidbyIa0ywph86+lN
         DMKQJQXQXKR8XUgpY3k3J+8PhDK3F99Yht7yMVo3mDGNxKRL77cTitF/tNNtseKWF5mD
         f5dzn0og8ZdQeofpbXtXsN7rlQ7Hqa7c3psWmKBT9oBC3lUmd8lJgl9y/bEhi68wo+da
         9PbWfOgoGIuEegdxn4qKuqFHkv0N2Dh8r2AolWm7iZRVHD6Y0pcGxsK+H68nMUildPZH
         pKAA==
X-Gm-Message-State: APjAAAUoRwU58i8fUBsFe6iHX8mrY+twqoNjkaWdYRbl161/v1D46t6q
        1WSAwMI73Vz5ixg2i1duOsO+xg==
X-Google-Smtp-Source: APXvYqxsgAgsobiE/ABFND8g7p4vtTRLhj590ZkFKGG2GfwYRMPfRaC0PvZFpbOq7Wcjwh7i/9M13w==
X-Received: by 2002:a25:8b82:: with SMTP id j2mr3771255ybl.53.1581704699369;
        Fri, 14 Feb 2020 10:24:59 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m62sm2789371ywb.107.2020.02.14.10.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 10:24:58 -0800 (PST)
Date:   Fri, 14 Feb 2020 11:24:56 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Wei Li <liwei391@huawei.com>
Subject: Re: [PATCH V2 3/5] perf tools: cs-etm: fix endless record after
 being terminated
Message-ID: <20200214182456.GA7746@xps15>
References: <20200214132654.20395-1-adrian.hunter@intel.com>
 <20200214132654.20395-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214132654.20395-4-adrian.hunter@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  	}
>  
>  	return -EINVAL;
> -- 
> 2.17.1
> 
