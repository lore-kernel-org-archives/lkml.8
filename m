Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5477C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6EC206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 17:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yhv+Hz2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732712AbgDARL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 13:11:56 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36033 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731749AbgDARL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 13:11:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id c23so379606pgj.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 10:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ywdn6l6e79P51vHdgecSOxS4zrcLOxx18s21Mj2y7ps=;
        b=Yhv+Hz2oABjk7BKrt6qg5xfPrivu0TcnP8vMRm+7jyihELFRTcTdSAhIKSy5lNVSA2
         8YO9HLQueqtkif7qArWq8LTRbNzz4cUj8yQCV2dL/lzwmbR1OhqiIfNkNh6TDBTdIO3X
         KxmynXcOupREvKmYKe3rGk6Fq6WQ0y2jDY6kSCpoOVcyDQAvEi3eFMzCq/qHZ+wmkc9W
         aXyfXpmYXKBozFm8g9qaPhJvxNE+ptEGVDd0rr2xx0XLkpLG1gzk2WgTeZ3mZ+40b2kb
         lSCUP+NTTYdNFAbXfX1sdtCwhugsbiIhV8gfv/ciXinEuhG7ge+uXMbgBb5og6R9+pe6
         DIgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ywdn6l6e79P51vHdgecSOxS4zrcLOxx18s21Mj2y7ps=;
        b=HQ7SPH0PsqSNEDd8VwUR7ZNhaiYkk6bMEdoJGBcw2o5FXZZl0sPDD8ZWqeV+74/5VD
         Y1/y+ZnW5mx72Pb5WuyVAVd20TCYjRtMCslm9G8G+7K9f8ZnPZfd6WqVaxiJHuEzYl6w
         4aLTyONf5xOcUcBEH3iWvf/kwwnZMz/e9nfKw6i5WX811tq8pFuUaf2sdUMUhg1lZjb1
         ByF23CYq7+J6de0Yn1zxYe4tv3xmVBX5BqOiTiy7GhAmq0VRBFDuO/7KGX/0SAVkx7KG
         5h8tJ4w1rlNhoKIJ59C34MwCVoFTQImJCKtkXjkyquI34JxiW0KVranGRyy/icx5FLoS
         +ekw==
X-Gm-Message-State: ANhLgQ0voPtaXz/dgp0uWcVZji1u8gxNUnsWTvhC4dQsBRR8dAKjl1O6
        2CS8G8OrzWpX7gBYn2Y3g3qyPqmVxos=
X-Google-Smtp-Source: ADFU+vvFXPFLSMH5htgZcgYj1rKspo8NCiNyZwvpJ2FfIcCZdwMSvk+So2KkHg0oeHBfsbpDa8Oe/w==
X-Received: by 2002:a63:e856:: with SMTP id a22mr22432040pgk.283.1585761114870;
        Wed, 01 Apr 2020 10:11:54 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id b11sm567585pfr.155.2020.04.01.10.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 10:11:54 -0700 (PDT)
Date:   Wed, 1 Apr 2020 11:11:52 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/16] perf cs-etm: Implement ->evsel_is_auxtrace()
 callback
Message-ID: <20200401171152.GA12742@xps15>
References: <20200401101613.6201-1-adrian.hunter@intel.com>
 <20200401101613.6201-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401101613.6201-6-adrian.hunter@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 01:16:02PM +0300, Adrian Hunter wrote:
> Implement ->evsel_is_auxtrace() callback.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 62d2f9b9ce1b..3c802fde4954 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -631,6 +631,16 @@ static void cs_etm__free(struct perf_session *session)
>  	zfree(&aux);
>  }
>  
> +static bool cs_etm__evsel_is_auxtrace(struct perf_session *session,
> +				      struct evsel *evsel)
> +{
> +	struct cs_etm_auxtrace *aux = container_of(session->auxtrace,
> +						   struct cs_etm_auxtrace,
> +						   auxtrace);
> +
> +	return evsel->core.attr.type == aux->pmu_type;
> +}
> +
>  static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address)
>  {
>  	struct machine *machine;
> @@ -2618,6 +2628,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
>  	etm->auxtrace.flush_events = cs_etm__flush_events;
>  	etm->auxtrace.free_events = cs_etm__free_events;
>  	etm->auxtrace.free = cs_etm__free;
> +	etm->auxtrace.evsel_is_auxtrace = cs_etm__evsel_is_auxtrace;
>  	session->auxtrace = &etm->auxtrace;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

>  
>  	etm->unknown_thread = thread__new(999999999, 999999999);
> -- 
> 2.17.1
> 
