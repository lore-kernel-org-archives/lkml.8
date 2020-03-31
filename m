Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A128DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76096208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxPeOb4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgCaTLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:11:34 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:39349 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgCaTLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:11:34 -0400
Received: by mail-qv1-f66.google.com with SMTP id v38so11484280qvf.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fL1biNgvoH1+FNfduS3c9QcNL+uWGrLrkoUh0P6kv3s=;
        b=KxPeOb4vsLrL/Ib1OXVvbRQixMZLVGzA0MwoEHW3RMKlkRN+ZJpoyngZ8bR37OtflI
         27dKQWRQV+ICqNW7evb8u9sa2cf03v1tOX/plHw1p4wHxvNWVwgryEkLIPge2lFzPhM5
         XYF9tSqj9vE0gyxZUrbO7ZkNGLbqIkUAweuOYd+lGmbnDtinWTPwWgUS5Yr9wZAzxGBG
         DEkvZVjIshfwSqPaJ4V+hlPzNy9HZIz7Y5Vim6AJ/mE4sZrLZQhhPfOT3mddNJoJNiUz
         FyZ+UjY/qZhcnIx8W4T60YCNSVsJIDo0f/1Nv70rWWsbwFDFUMIVBvko/XIeuELfUCtx
         TP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fL1biNgvoH1+FNfduS3c9QcNL+uWGrLrkoUh0P6kv3s=;
        b=nKjxGeboq8+h+zBfRU3fopwv1fUZ9UzfmCsYHUJNb2t+/znOyVzA7AJzsxrwDg0Jls
         gdZevOVY138GuOOs7/bXh9Sd51i7NqzHMHobeTdgWwV4FOQwL4/fSQ3qGy0pyRbt4H1G
         talLpAEcfm/advXD9cf2bzZgMJBkIYWRipWxYO5EOaPvsoMEi/2C0DYSAd+34+Z/03CJ
         UGsm1tTNbp7d8CeOlfGzulKbQoj629Hd78noy+VFfcj204xUR+pPxPMR+2HvwbuuFvar
         shM4wDKUz1Qa66rMXOiByhWJUh57iUjk++4VfaLUQSaZOo9zApvUnRZ0JG0fVOZiwuAf
         Zb6g==
X-Gm-Message-State: ANhLgQ34U8Br2DRe6+R/ZCJ0MwH3RIk8gjxpXXcVLXyMyjdvtPdrfivN
        8Tlq6m/7GltLutH6gJqOTc07wy+3
X-Google-Smtp-Source: ADFU+vtH+2Z6C2+SUGSYr0exEi3nCIg9rG5ijeremf/R0Z5iKiaVoL1bfZcNbomev8N55Z9RLQcuNg==
X-Received: by 2002:a0c:ed4c:: with SMTP id v12mr18664053qvq.120.1585681891579;
        Tue, 31 Mar 2020 12:11:31 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id m67sm13049108qke.101.2020.03.31.12.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:11:30 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 03C44409A3; Tue, 31 Mar 2020 16:11:28 -0300 (-03)
Date:   Tue, 31 Mar 2020 16:11:28 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf/script: allow --symbol to accept hexadecimal
 addresses
Message-ID: <20200331191128.GL9917@kernel.org>
References: <20200325220802.15039-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325220802.15039-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 25, 2020 at 03:08:02PM -0700, Ian Rogers escreveu:
> From: Stephane Eranian <eranian@google.com>
> 
> This patch extends the perf script --symbols option to filter
> on hexadecimal addresses in addition to symbol names. This makes
> it easier to handle cases where symbols are aliased.
> 
> With this patch, it is possible to mix and match symbols and hexadecimal
> addresses using the --symbols option.
> 
> $ perf script --symbols=noploop,0x4007a0

Applied, can you please send a followup patch to the man page stating
that this is supported?

Thanks,

- Arnaldo
 
> Reviewed-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Stephane Eranian <eranian@google.com>
> ---
>  tools/perf/util/event.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index c5447ff516a2..c978a73fe475 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -599,10 +599,23 @@ int machine__resolve(struct machine *machine, struct addr_location *al,
>  		al->sym = map__find_symbol(al->map, al->addr);
>  	}
>  
> -	if (symbol_conf.sym_list &&
> -		(!al->sym || !strlist__has_entry(symbol_conf.sym_list,
> -						al->sym->name))) {
> -		al->filtered |= (1 << HIST_FILTER__SYMBOL);
> +	if (symbol_conf.sym_list) {
> +		int ret = 0;
> +		char al_addr_str[32];
> +		size_t sz = sizeof(al_addr_str);
> +
> +		if (al->sym) {
> +			ret = strlist__has_entry(symbol_conf.sym_list,
> +						al->sym->name);
> +		}
> +		if (!(ret && al->sym)) {
> +			snprintf(al_addr_str, sz, "0x%"PRIx64,
> +				al->map->unmap_ip(al->map, al->sym->start));
> +			ret = strlist__has_entry(symbol_conf.sym_list,
> +						al_addr_str);
> +		}
> +		if (!ret)
> +			al->filtered |= (1 << HIST_FILTER__SYMBOL);
>  	}
>  
>  	return 0;
> -- 
> 2.25.1.696.g5e7596f4ac-goog
> 

-- 

- Arnaldo
