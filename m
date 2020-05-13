Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C3CCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF0D3204EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVrUINpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387830AbgEMNbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387730AbgEMNbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:31:33 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3D7C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:31:33 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id 4so14114773qtb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MWcY+GP/WKb+ETVVUrnnZlQhn2LXumL/iGbkm4arfKM=;
        b=pVrUINpH6ZYiGOCBXCzWiNFh3kP/zymHTCvkAR8MWUdPZNHuysSUFqKE8lFNoh2ENJ
         JC2VfugeHRog6VR/6LMRXOjnD6Z1pDLEClYQBuRiT1pPGYEGKi0N5L3LPKrybPAzP0sO
         NUdXF9QxsBqStg48t14yPUorsYdmQGHD5lms7EuiM+Dzpo5wGClKmora0KIXVlhuwMp4
         qTfzsOrXsGP9ta4H6xNyKcY5ycd/vW+ed3Bydy0XLFoftGvRoCp70nTHv8X8JNGHQ5rT
         K8EnIUJ3PPTGHGt71svZEdTtgKFFbEUlVMr+cbCjkzRrO764sL5ZvPTwIXWZbNiD6nDW
         u72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MWcY+GP/WKb+ETVVUrnnZlQhn2LXumL/iGbkm4arfKM=;
        b=hOeadxI7uQdJA99ySlNymGa8kK2HYcszKjj4lYiYj5sc3s8Trr2mb4omkye5rYmG6e
         arfphZFjhomS9C6AGPVXtxdozxKZ0BPBWpkqRAEcsSQF4hU5PrUxkW2M3r4fSrUU3Qk/
         Bjc97DXb8sTlS3Kw81GT9IMdi+nM5R7j/KebItiZfhJeArsMIpnjSCwwssclWWbFDv61
         5roVq8urjcb4xgz6wv5l1XwsA1hGFje+xYbuB6NH6y0ZTufFOGisZOHUb1yJDs+iZzRO
         mCxFDcpPda6jFfb8mK6xL9LADHY4jnhP3EKu9Uo4LN1L9cGjjyA3wUlM0uIO5PQCDobz
         mZ/Q==
X-Gm-Message-State: AGi0PubL48MlAso89IQIw2JuKnCNgECk0eFmXQJLJa0mxXNlAt8T48W1
        6ZvqOEK+bbT092glxdAcuGM=
X-Google-Smtp-Source: APiQypIrQxyTUWSPlVm1bJ7fx4NOmIWKtvTPcsyMQB3lKlSUJUd4qpNwdqFXOCTVJJdhOASEqRkf6Q==
X-Received: by 2002:aed:2ce6:: with SMTP id g93mr17679767qtd.264.1589376691404;
        Wed, 13 May 2020 06:31:31 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id n206sm13767812qke.20.2020.05.13.06.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 06:31:30 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AE282410F5; Wed, 13 May 2020 10:31:28 -0300 (-03)
Date:   Wed, 13 May 2020 10:31:28 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf parse-events: Avoid free on non malloc-ed memory
Message-ID: <20200513133128.GB5583@kernel.org>
References: <20200512235202.7619-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512235202.7619-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 12, 2020 at 04:52:02PM -0700, Ian Rogers escreveu:
> Caught by libfuzzer, there is a segfault with:
> $ perf stat -e i/bs,tsc,L2/o sleep 1
> As a config_term is added that isn't a string.

Yeah, I've just applied a similar patch after looking at your private
report, added the same fixes, used your reproducer,

Thanks,

- Arnaldo
 
> Fixes: e8dfb81838b1 (perf parse-events: Fix memory leaks found on parse_events)
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/parse-events.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index e9464b04f149..e37a6a3e6217 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -1480,7 +1480,8 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
>  
>  		list_for_each_entry_safe(pos, tmp, &config_terms, list) {
>  			list_del_init(&pos->list);
> -			zfree(&pos->val.str);
> +			if (pos->free_str)
> +				zfree(&pos->val.str);
>  			free(pos);
>  		}
>  		return -EINVAL;
> -- 
> 2.26.2.645.ge9eca65c58-goog
> 

-- 

- Arnaldo
