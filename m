Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EAAC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:53:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FD2E20644
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJ+aF75q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgDUNxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgDUNxd (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:53:33 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F2DC061A10
        for <Linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:53:32 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id m67so14428643qke.12
        for <Linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 06:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sIzMD90wdhlz29Usu9hjR5AJbMPjlL1OFwKgIPvdbGo=;
        b=AJ+aF75qW8wfNsqRMY54zHBAtGqtRfMk1P2geMUB9sFCdxEeZL+3ZUn1u9dr3Vpf97
         ukFfsQArIKiyXyX8TGen025ZUvBQKyO0BIDx+02N8VTsCXkE78hXfQVMS9lngMsaXNST
         1lybZ8yi8E6n4zv+nergHsiGsUBr9Zye+WsFXhcjas3SC765gxH66l3KG98aZKsH30fr
         5FKu4XBwz90ZnAH9wHzz74vIBgOmdDf2iiq2T4eGqd8z35rMcoRyIMYPyys/RYLKYcwK
         bXwO5FshzMfD4b9B7uAaxyUaZLP181LCvCMCwcNKzE9Ass8u2UbEOHyOpIq73MCaOep1
         ySxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sIzMD90wdhlz29Usu9hjR5AJbMPjlL1OFwKgIPvdbGo=;
        b=sri+mW1Xu2myh1byDoP+zq3jSC6EYgjkCJkFzgIOqmCeLxFE7E+5TGEueq+avFrSH3
         eZNNbB32hu4VC660zxDH6GxLyZO1IlzIqXuTgEiFdXKhpfw7RUvZ2ecAob7rtwKWFMbc
         VTBx1chOHWcX6lRsohlWETB5n0w38zPSd3GYOZH3fSgT5dUkYzgLBkxU8+hwXtmMqJIq
         7U8IBwnQgFeMuSVis16wjKFM+F9SzSa8G57u0M7GA+TehNoAQGslpXQ7pM07QpvlS11U
         tsk3nvlgsCgVLwnmqR596zbRIey4TJShG12G26imd8TbEYX/sbD1q+nlUuxieeOGHp0i
         nZXA==
X-Gm-Message-State: AGi0PuY5qDP+EZdePQ57RlxctTaMW4QUCqwZvahFePuI6durpeiGP/DW
        o8/gUImz4mHjtDEvW6KsizE=
X-Google-Smtp-Source: APiQypKnucdRo+eDIdJvONYI+xpuPD1QbqLiJq+YJXYpYHBJW/nA48iUf4dDPwkWESNH1m2Rm2xw8A==
X-Received: by 2002:a37:9b4f:: with SMTP id d76mr21364941qke.268.1587477211848;
        Tue, 21 Apr 2020 06:53:31 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id q6sm1736159qtd.61.2020.04.21.06.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 06:53:31 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4288E409A3; Tue, 21 Apr 2020 10:53:29 -0300 (-03)
Date:   Tue, 21 Apr 2020 10:53:29 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf stat: Improve runtime stat for interval mode
Message-ID: <20200421135329.GA9110@kernel.org>
References: <20200420145417.6864-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420145417.6864-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 20, 2020 at 10:54:17PM +0800, Jin Yao escreveu:
> For interval mode, the metric is printed after # if it exists. But
> it's not calculated by the counts generated in this interval. See
> following examples,
> 
>  root@kbl-ppc:~# perf stat -M CPI -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000422803            764,809      inst_retired.any          #      2.9 CPI
>       1.000422803          2,234,932      cycles
>       2.001464585          1,960,061      inst_retired.any          #      1.6 CPI
>       2.001464585          4,022,591      cycles
> 
> The second CPI should not be 1.6 (4,022,591/1,960,061 is 2.1)
> 
>  root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000429493          2,869,311      cycles
>       1.000429493            816,875      instructions              #    0.28  insn per cycle
>       2.001516426          9,260,973      cycles
>       2.001516426          5,250,634      instructions              #    0.87  insn per cycle
> 
> The second 'insn per cycle' should not be 0.87 (5,250,634/9,260,973 is 0.57).
> 
> The current code uses a global variable rt_stat for tracking and
> updating the std dev of runtime stat. Unlike the counts, rt_stat is
> not reset for interval. While the counts are reset for interval.
> 
> perf_stat_process_counter()
> {
>         if (config->interval)
>                 init_stats(ps->res_stats);
> }
> 
> So for interval, the rt_stat should be reset either.

                              s/either/too/g right?

And please try and find what was the cset that introduced the problem,
so that we can have a Fixes: line and the stable series can pick it, ok?

- Arnaldo
 
> This patch resets rt_stat before read_counters, so the runtime
> stat is only calculated by the counts generated in this interval.
> 
> With this patch,
> 
>  root@kbl-ppc:~# perf stat -M CPI -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000420924          2,408,818      inst_retired.any          #      2.1 CPI
>       1.000420924          5,010,111      cycles
>       2.001448579          2,798,407      inst_retired.any          #      1.6 CPI
>       2.001448579          4,599,861      cycles
> 
>  root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
>  #           time             counts unit events
>       1.000428555          2,769,714      cycles
>       1.000428555            774,462      instructions              #    0.28  insn per cycle
>       2.001471562          3,595,904      cycles
>       2.001471562          1,243,703      instructions              #    0.35  insn per cycle
> 
> Now the second 'insn per cycle' and CPI are calculated by the counts
> generated in this interval.
> 
>  v2:
>  ---
>  Use just existing perf_stat__reset_shadow_per_stat(&rt_stat).
>  We don't need to define new function perf_stat__reset_rt_stat.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-stat.txt | 2 ++
>  tools/perf/builtin-stat.c              | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 4d56586b2fb9..3fb5028aef08 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -176,6 +176,8 @@ Print count deltas every N milliseconds (minimum: 1ms)
>  The overhead percentage could be high in some cases, for instance with small, sub 100ms intervals.  Use with caution.
>  	example: 'perf stat -I 1000 -e cycles -a sleep 5'
>  
> +If the metric exists, it is calculated by the counts generated in this interval and the metric is printed after #.
> +
>  --interval-count times::
>  Print count deltas for fixed number of times.
>  This option should be used together with "-I" option.
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 9207b6c45475..3f050d85c277 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -359,6 +359,7 @@ static void process_interval(void)
>  	clock_gettime(CLOCK_MONOTONIC, &ts);
>  	diff_timespec(&rs, &ts, &ref_time);
>  
> +	perf_stat__reset_shadow_per_stat(&rt_stat);
>  	read_counters(&rs);
>  
>  	if (STAT_RECORD) {
> -- 
> 2.17.1
> 

-- 

- Arnaldo
