Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91479C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E7E20722
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 13:51:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byT7XxKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbgCTNvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 09:51:12 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:44664 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTNvL (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 09:51:11 -0400
Received: by mail-qv1-f68.google.com with SMTP id w5so2939055qvp.11
        for <Linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 06:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ItqKl2HqUVxhA/7rGjJzyOrjGNTdaJc0YGesSQo74jk=;
        b=byT7XxKqtR8U6GsRjXRwu68jPsv6iJACodJj3YgA0hz+ugu6Aym8AMBG+mrBuNysM6
         Brn5YdfRpQLbJzEYpOi6QePA/znwm37dNLPxBlWzLCxPSaeVC+gMNNW3OyU4fEkZZCzR
         AbH1etPO3JZ5yTK+H6jyA1YFtODJXveVHs2t/hBacgx6/udl/CyU3qBnX1fTLT1m5FLk
         JYKhXgGUwPcKfKG4jo0aJmENqPDykVEXL+/NPNrFMwKZVAbkHD2iu+OKT75xr5iloC5L
         zNkwulBEA6Il6CwtXILtpob+PIZ8tFqpisIynk+U41pYQ2rdu+U4WOEiMO/54ZqSHMMc
         bmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ItqKl2HqUVxhA/7rGjJzyOrjGNTdaJc0YGesSQo74jk=;
        b=PJynDbr2KATAozdhxzNpVj+lhBq00C+RRmXRMUJzzjp3DDlvx2eupk1KnL+PLzDp7p
         9g26qts1zvaUvnICCDZbod/shKw6YgcTnbSUuoY8S66VumvbiwVUqwIuFZ6Qekqk6ai8
         YYvTbhY+DURBe1iJrESTynUBD1wnFFbTLA8IxCqabKsSgQ9X3Lxp9SF3hXPIEAuGWlVJ
         GoK0iyTR0c9RwlyTcRJ0Muq1R3gpEsS5tfIqnwBR3fg51TycaSyBdYCWHDoqGZaqp+mZ
         0XKmhgsTfwLqiG0wN/eQvpRtx+MI+cHtNZTQQ/HrjjUXCtdaedHZ+r/0e7MB7m5cJ2k8
         A12g==
X-Gm-Message-State: ANhLgQ3hrHU3Layu6EcCGHzS/lIbIIuLfEVnQKbJr+e/SuFUTm7E//75
        b7fG6lPVotldeQTa+dz2H6UCRNnM
X-Google-Smtp-Source: ADFU+vvcTHM0e8XimwggD4ctJkhpmVqrhjndIGp6bnM7Smw/sno/cAyrOzN+HoYH8fWwTGfwRslM8g==
X-Received: by 2002:a0c:a181:: with SMTP id e1mr3175081qva.19.1584712268833;
        Fri, 20 Mar 2020 06:51:08 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x5sm4519459qti.5.2020.03.20.06.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 06:51:08 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 32E5240F77; Fri, 20 Mar 2020 10:51:06 -0300 (-03)
Date:   Fri, 20 Mar 2020 10:51:06 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH 2/2] perf top: support hotkey to change sort order
Message-ID: <20200320135106.GB29833@kernel.org>
References: <20200320072414.25551-1-yao.jin@linux.intel.com>
 <20200320072414.25551-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320072414.25551-2-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 20, 2020 at 03:24:14PM +0800, Jin Yao escreveu:
> It would be nice if we can use a hotkey in perf top browser to
> select a event for sorting.
> 
> For example,
> perf top --group -e cycles,instructions,cache-misses
> 
> Samples
>                 Overhead  Shared Object             Symbol
>   40.03%  45.71%   0.03%  div                       [.] main
>   20.46%  14.67%   0.21%  libc-2.27.so              [.] __random_r
>   20.01%  19.54%   0.02%  libc-2.27.so              [.] __random
>    9.68%  10.68%   0.00%  div                       [.] compute_flag
>    4.32%   4.70%   0.00%  libc-2.27.so              [.] rand
>    3.84%   3.43%   0.00%  div                       [.] rand@plt
>    0.05%   0.05%   2.33%  libc-2.27.so              [.] __strcmp_sse2_unaligned
>    0.04%   0.08%   2.43%  perf                      [.] perf_hpp__is_dynamic_en
>    0.04%   0.02%   6.64%  perf                      [.] rb_next
>    0.04%   0.01%   3.87%  perf                      [.] dso__find_symbol
>    0.04%   0.04%   1.77%  perf                      [.] sort__dso_cmp
> 
> When user press hotkey '2' (event index, starting from 0), it indicates
> to sort output by the third event in group (cache-misses).
> 
> Samples
>                 Overhead  Shared Object               Symbol
>    4.07%   1.28%   6.68%  perf                        [.] rb_next
>    3.57%   3.98%   4.11%  perf                        [.] __hists__insert_output
>    3.67%  11.24%   3.60%  perf                        [.] perf_hpp__is_dynamic_e
>    3.67%   3.20%   3.20%  perf                        [.] hpp__sort_overhead
>    0.81%   0.06%   3.01%  perf                        [.] dso__find_symbol
>    1.62%   5.47%   2.51%  perf                        [.] hists__match
>    2.70%   1.86%   2.47%  libc-2.27.so                [.] _int_malloc
>    0.19%   0.00%   2.29%  [kernel]                    [k] copy_page
>    0.41%   0.32%   1.98%  perf                        [.] hists__decay_entries
>    1.84%   3.67%   1.68%  perf                        [.] sort__dso_cmp
>    0.16%   0.00%   1.63%  [kernel]                    [k] clear_page_erms
> 
> Now the output is sorted by cache-misses.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-top.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 144043637cec..b39f6ffb874e 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -616,6 +616,7 @@ static void *display_thread_tui(void *arg)
>  		.arg		= top,
>  		.refresh	= top->delay_secs,
>  	};
> +	int ret;
>  
>  	/* In order to read symbols from other namespaces perf to  needs to call
>  	 * setns(2).  This isn't permitted if the struct_fs has multiple users.
> @@ -626,6 +627,7 @@ static void *display_thread_tui(void *arg)
>  
>  	prctl(PR_SET_NAME, "perf-top-UI", 0, 0, 0);
>  
> +repeat:
>  	perf_top__sort_new_samples(top);
>  
>  	/*
> @@ -638,13 +640,17 @@ static void *display_thread_tui(void *arg)
>  		hists->uid_filter_str = top->record_opts.target.uid_str;
>  	}
>  
> -	perf_evlist__tui_browse_hists(top->evlist, help, &hbt,
> +	ret = perf_evlist__tui_browse_hists(top->evlist, help, &hbt,
>  				      top->min_percent,
>  				      &top->session->header.env,
>  				      !top->record_opts.overwrite,
>  				      &top->annotation_opts);
>  
> -	stop_top();
> +	if (ret == K_RELOAD)
> +		goto repeat;
> +	else
> +		stop_top();
> +

That is really nice and small, but shouldn't we flush all the histograms
that were in place, sorted by the previous key? I think we have a 'z'
for zeroing samples that may be what we need, take a look, please,

- Arnaldo

>  	return NULL;
>  }
>  
> -- 
> 2.17.1
> 

-- 

- Arnaldo
