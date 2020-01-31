Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A528C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 049D9206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 08:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AraOrygP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgAaIc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 03:32:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36255 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728099AbgAaIc1 (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 03:32:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id z3so7603849wru.3
        for <Linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 00:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+qMfTROjHoWeyXe9kiOwtSb5udJw382aKy2z1ykz+mI=;
        b=AraOrygPgu/RzIW/L2QmuXlu8B+LsXuMZEO2E2UVEZmktB2ZW/G6hNtJ7vnnccKxmS
         Lr5d6byXxJSQMYUr3FdVQPMsVPz10B77wUs1NxclI70VTNeN9Y2xQh5DRnoFcsZvg51u
         PljtO9B38/BCV5n3joJDXhNrNeHhnU70Ai9MR0WodChlgOu9e7Z2qcWYxkOQpYyEqIlM
         f4GCCKEuQLPSLQMkDBrDHAorDnnOo8A9oKjaRGOG0sgbriY33Kq+f8lm1m83pgR3FWL+
         Wvyq5mMuPHrSaQUDi9MuK73dpsPLE13OcfunIpnf8DC9DnINlTv82gZ2D9wFNc9q/vW+
         gLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+qMfTROjHoWeyXe9kiOwtSb5udJw382aKy2z1ykz+mI=;
        b=Dp2EESHNSkfOTMYaCdc0n9xKxcp3Qu7K4ZxpcD5lrYSIIIX1VEbONUl5aou7GvkB3s
         TyFEL66Td+QdEMUHMmMxfYxNksl8jxNKW/H6alfV709l5S9Ykc8+AO9nxVzl82EUYc6m
         1pke/YAN6HlbfF6GKEk64DeI39lA7jCJxaQyBYfyHk0FISljGvYqSzD6OQAeSty8DVfv
         u0ar0yUUXZSCutf/Y0ktNtlH53rAy9Ps17iqHLP91Z5l20ilSN1Rs1l+IflAAmTqoxTa
         FHnFi6tXEU0dtsPdTwFSj8sOHx2ioH3pY5jcnYqr9GUMdSWywzR1s36e2/eGwtZumgwh
         vVtw==
X-Gm-Message-State: APjAAAWYgs2Wv+botTaH4P1mBePsWcQARikhfzuETVEQvc7pN8iLiSsv
        UXE5F4D8Ujt1dme70pZJJWCLTWOHjys=
X-Google-Smtp-Source: APXvYqyRzDYAggdfzuv2AmRPB87twZEKSQBqC6CRnQWGVp9ikhJPZynT4gn0d5Wi8YGXoIGefDVifQ==
X-Received: by 2002:a5d:62d0:: with SMTP id o16mr10700133wrv.197.1580459545440;
        Fri, 31 Jan 2020 00:32:25 -0800 (PST)
Received: from quaco.ghostprotocols.net (catv-212-96-54-169.catv.broadband.hu. [212.96.54.169])
        by smtp.gmail.com with ESMTPSA id l17sm10578777wro.77.2020.01.31.00.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 00:32:24 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6499440A7D; Fri, 31 Jan 2020 09:32:23 +0100 (CET)
Date:   Fri, 31 Jan 2020 09:32:23 +0100
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v5 1/4] perf util: Move block_pair_cmp to block-info
Message-ID: <20200131083223.GF3841@kernel.org>
References: <20200128125556.25498-1-yao.jin@linux.intel.com>
 <20200128125556.25498-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128125556.25498-2-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jan 28, 2020 at 08:55:53PM +0800, Jin Yao escreveu:
> block_pair_cmp() is a function which is used to compare
> two blocks. Moving it from builtin-diff.c to block-info.c
> to let it can be used by other builtins.
> 
>  v4/v5:
>  ------
>  No change.
> 
>  v3:
>  ---
>  Separate it from original patch for good tracking.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-diff.c    | 17 -----------------
>  tools/perf/util/block-info.c | 17 +++++++++++++++++
>  tools/perf/util/block-info.h |  2 ++
>  3 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index f8b6ae557d8b..5ff1e21082cb 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -572,23 +572,6 @@ static void init_block_hist(struct block_hist *bh)
>  	bh->valid = true;
>  }
>  
> -static int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)
> -{
> -	struct block_info *bi_a = a->block_info;
> -	struct block_info *bi_b = b->block_info;
> -	int cmp;
> -
> -	if (!bi_a->sym || !bi_b->sym)
> -		return -1;
> -
> -	cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
> -
> -	if ((!cmp) && (bi_a->start == bi_b->start) && (bi_a->end == bi_b->end))
> -		return 0;
> -
> -	return -1;
> -}
> -
>  static struct hist_entry *get_block_pair(struct hist_entry *he,
>  					 struct hists *hists_pair)
>  {
> diff --git a/tools/perf/util/block-info.c b/tools/perf/util/block-info.c
> index c4b030bf6ec2..f0f38bdd496a 100644
> --- a/tools/perf/util/block-info.c
> +++ b/tools/perf/util/block-info.c
> @@ -475,3 +475,20 @@ float block_info__total_cycles_percent(struct hist_entry *he)
>  
>  	return 0.0;
>  }
> +
> +int block_pair_cmp(struct hist_entry *a, struct hist_entry *b)

First thing that came to mind was that hist_entry comparision functions
had been changed to return int64_t recently, when I went to look at it I
found this:

tools/perf/util/block-info.c

int64_t block_info__cmp(struct perf_hpp_fmt *fmt __maybe_unused,
                        struct hist_entry *left, struct hist_entry *right)
{
        struct block_info *bi_l = left->block_info;
        struct block_info *bi_r = right->block_info;
        int cmp;
.
.
.

Which look a bit more complete, can you check if that can be used
instead or explain why my quick analysis of this is b0rken?

Perhaps we can have a __block_info__cmp() that doesn't receive the
perf_hpp_fmt (that isn't even used above) so that the previous use of
block_pair_cmp() can be replaced with __block_info__cmp() instead?

Thanks,

- Arnaldo

> +{
> +	struct block_info *bi_a = a->block_info;
> +	struct block_info *bi_b = b->block_info;
> +	int cmp;
> +
> +	if (!bi_a->sym || !bi_b->sym)
> +		return -1;
> +
> +	cmp = strcmp(bi_a->sym->name, bi_b->sym->name);
> +
> +	if ((!cmp) && (bi_a->start == bi_b->start) && (bi_a->end == bi_b->end))
> +		return 0;
> +
> +	return -1;
> +}
> diff --git a/tools/perf/util/block-info.h b/tools/perf/util/block-info.h
> index bef0d75e9819..4fa91eeae92e 100644
> --- a/tools/perf/util/block-info.h
> +++ b/tools/perf/util/block-info.h
> @@ -76,4 +76,6 @@ int report__browse_block_hists(struct block_hist *bh, float min_percent,
>  
>  float block_info__total_cycles_percent(struct hist_entry *he);
>  
> +int block_pair_cmp(struct hist_entry *a, struct hist_entry *b);
> +
>  #endif /* __PERF_BLOCK_H */
> -- 
> 2.17.1
> 

-- 

- Arnaldo
