Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 230A2C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A9420848
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:54:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="py+Rp1rI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCINye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:54:34 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33561 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgCINye (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:54:34 -0400
Received: by mail-qk1-f193.google.com with SMTP id p62so9271902qkb.0
        for <Linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 06:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8pp0THMmMx4UvzN5NEuTvX9hAaXGDE8wNI8e/tQjQoc=;
        b=py+Rp1rIUPeqQJV8bCqBLVOcdh9+tqfOr3l+U0PJFwyw77rP2D1gDlDFgZWN7dQU90
         /U4R/msJCqmTg4vdVMcDWd3P9iIBt7oHkyt0u3rOaO2UqKp22CXU1BP8pNTYbe41xNCE
         49lQqPpyEYoxmrGetjMay2hf0xqr4ExDE3VLqBdyc7er7NZiASxZOnMK5zduD3sSMhKY
         iP4YcK+A3lIZguaLVgTH7u0IEplOKWL2rimKRmkRY+/JQ/hI7tdQl9beHe4YwnUMgqkm
         Elv0NDQXchqsHf+lG4/0QIsYXkVLMgbpzENCASjdHyu3XooluxoAK3iG7TsNUwGDrZ1u
         alOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8pp0THMmMx4UvzN5NEuTvX9hAaXGDE8wNI8e/tQjQoc=;
        b=MWuAOQcx959+WTwCEK09EYdYKR18rXzMsRalM2atCBoByDH9Upoa9X699a740yz1FT
         Nd5mMTySPYVGtpLMHZ5xpG0DY8hmsoOa0H7AaECtV2GYovocgwqK/payS7ByPJBYlV4W
         mVgyNT9J/d56QccHqgGW9pb9HPUhpO2SLmhrifnqbyoRiN+VrWxKbjnltTlwUuW9VoaO
         mm2iZdCZ9rfNIH3SBeRCr3jFRlOiWv5tqqtAOI9rkDHgeP/y34XtkVrfj+UcDYWnGiud
         U5oQ7oXEf3tXas3N/nDn309zQQcZUH/UBPKesZmIJqTFXVhf4hi6sfuLaPbcAhtl9zL5
         X5IA==
X-Gm-Message-State: ANhLgQ2yTxoHEd6XEhAe7Dr9Y7J/xz6fBU6P1i5MwHreHltEQcUUM83N
        6sZVIFCKc31sE1fjOfnpPkmSdxde6/Y=
X-Google-Smtp-Source: ADFU+vtwmok9pRpUEX3bScQH7KlUMjMxjR79VL0ECjcygwxMeJ8aYQtClS0EpxxQCZ157py0Nl5yNA==
X-Received: by 2002:a37:6e84:: with SMTP id j126mr14359500qkc.77.1583762072622;
        Mon, 09 Mar 2020 06:54:32 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id h25sm12307987qtn.30.2020.03.09.06.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 06:54:31 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8A5C040009; Mon,  9 Mar 2020 10:54:29 -0300 (-03)
Date:   Mon, 9 Mar 2020 10:54:29 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 4/4] perf util: Support color ops to print block
 percents in color
Message-ID: <20200309135429.GF477@kernel.org>
References: <20200202141655.32053-1-yao.jin@linux.intel.com>
 <20200202141655.32053-5-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200202141655.32053-5-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Feb 02, 2020 at 10:16:55PM +0800, Jin Yao escreveu:
> It would be nice to print the block percents with colors.
> 
> This patch supports the 'Sampled Cycles%' and 'Avg Cycles%'
> printed in colors.
> 
> For example,
> 
> perf record -b ...
> perf report --total-cycles or perf report --total-cycles --stdio
> 
> percent > 5%, colored in red
> percent > 0.5%, colored in green
> percent < 0.5%, default color
> 
>  v3/v4/v5/v6:
>  ------------
>  No change

Thanks, tested the coloring, all works as advertised, thanks, applied to
perf/core, should be in git.kernel.org soon.

- Arnaldo
 
>  v2:
>  ---
>  No functional change
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/util/block-info.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
> index e0e56f30e6a6..4268c0ffb77a 100644
> --- a/tools/perf/util/block-info.c
> +++ b/tools/perf/util/block-info.c
> @@ -181,6 +181,17 @@ static int block_column_width(struct perf_hpp_fmt *fmt,
>  	return block_fmt->width;
>  }
>  
> +static int color_pct(struct perf_hpp *hpp, int width, double pct)
> +{
> +#ifdef HAVE_SLANG_SUPPORT
> +	if (use_browser) {
> +		return __hpp__slsmg_color_printf(hpp, "%*.2f%%",
> +						 width - 1, pct);
> +	}
> +#endif
> +	return hpp_color_scnprintf(hpp, "%*.2f%%", width - 1, pct);
> +}
> +
>  static int block_total_cycles_pct_entry(struct perf_hpp_fmt *fmt,
>  					struct perf_hpp *hpp,
>  					struct hist_entry *he)
> @@ -188,14 +199,11 @@ static int block_total_cycles_pct_entry(struct perf_hpp_fmt *fmt,
>  	struct block_fmt *block_fmt = container_of(fmt, struct block_fmt, fmt);
>  	struct block_info *bi = he->block_info;
>  	double ratio = 0.0;
> -	char buf[16];
>  
>  	if (block_fmt->total_cycles)
>  		ratio = (double)bi->cycles / (double)block_fmt->total_cycles;
>  
> -	sprintf(buf, "%.2f%%", 100.0 * ratio);
> -
> -	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, buf);
> +	return color_pct(hpp, block_fmt->width, 100.0 * ratio);
>  }
>  
>  static int64_t block_total_cycles_pct_sort(struct perf_hpp_fmt *fmt,
> @@ -248,16 +256,13 @@ static int block_cycles_pct_entry(struct perf_hpp_fmt *fmt,
>  	struct block_info *bi = he->block_info;
>  	double ratio = 0.0;
>  	u64 avg;
> -	char buf[16];
>  
>  	if (block_fmt->block_cycles && bi->num_aggr) {
>  		avg = bi->cycles_aggr / bi->num_aggr;
>  		ratio = (double)avg / (double)block_fmt->block_cycles;
>  	}
>  
> -	sprintf(buf, "%.2f%%", 100.0 * ratio);
> -
> -	return scnprintf(hpp->buf, hpp->size, "%*s", block_fmt->width, buf);
> +	return color_pct(hpp, block_fmt->width, 100.0 * ratio);
>  }
>  
>  static int block_avg_cycles_entry(struct perf_hpp_fmt *fmt,
> @@ -344,7 +349,7 @@ static void hpp_register(struct block_fmt *block_fmt, int idx,
>  
>  	switch (idx) {
>  	case PERF_HPP_REPORT__BLOCK_TOTAL_CYCLES_PCT:
> -		fmt->entry = block_total_cycles_pct_entry;
> +		fmt->color = block_total_cycles_pct_entry;
>  		fmt->cmp = block_info__cmp;
>  		fmt->sort = block_total_cycles_pct_sort;
>  		break;
> @@ -352,7 +357,7 @@ static void hpp_register(struct block_fmt *block_fmt, int idx,
>  		fmt->entry = block_cycles_lbr_entry;
>  		break;
>  	case PERF_HPP_REPORT__BLOCK_CYCLES_PCT:
> -		fmt->entry = block_cycles_pct_entry;
> +		fmt->color = block_cycles_pct_entry;
>  		break;
>  	case PERF_HPP_REPORT__BLOCK_AVG_CYCLES:
>  		fmt->entry = block_avg_cycles_entry;
> -- 
> 2.17.1
> 

-- 

- Arnaldo
