Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AA3C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4518208CA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598981310;
	bh=JU0HmHTW0+SAz5aWhKsyhRbAns5tITtLG2IJlfNOZLo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NSxI/OMbzyLwq0zfC49su8ZRw9w8w+qacpke+S65V4mn6zZ7fdyVGel4r1qWZjVuZ
	 D+pM5d8MhqHLJ2hyZEYmn5KtjCQaEzXoE4xFdJt+1MIPirqGwlodup96cTNtGPrYme
	 ZxvH7+6GVpde5ZIxrkNp2cedKCybIJ/4Z6ilzeRM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgIAR23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728799AbgIAR20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:28:26 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A6DC2071B;
        Tue,  1 Sep 2020 17:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598981305;
        bh=JU0HmHTW0+SAz5aWhKsyhRbAns5tITtLG2IJlfNOZLo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mh531gRaL6Uab01cmtChdt9B1a5Y+PXf5TC8WVV17FTjINzRtb8XIzzdHJt70fS5Y
         4y3F4ZxkfmTD0hFisyEsnYy1Qtv0JLr9tuHCmBt6WGgoIdju2I/jATysF4ZyOF/Vh4
         Id2wmKxOVKg772H+p7HaHjRaMqfunhRktW9MYPow=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AC4A040D3D; Tue,  1 Sep 2020 14:28:23 -0300 (-03)
Date:   Tue, 1 Sep 2020 14:28:23 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Al Grant <al.grant@foss.arm.com>, Jiri Olsa <jolsa@kernel.org>,
        Joe Mario <jmario@redhat.com>
Cc:     David Ahern <dsahern@gmail.com>, Don Zickus <dzickus@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, andi.kleen@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf c2c report: count remote loads correctly
Message-ID: <20200901172823.GF1424523@kernel.org>
References: <6282053a-d813-8638-531d-56e852d582a2@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6282053a-d813-8638-531d-56e852d582a2@foss.arm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 20, 2020 at 02:48:58PM +0100, Al Grant escreveu:
> "perf c2c report" can show load counts for cache lines, which don't match
> the actual number of load samples, e.g. as displayed by "perf script". This
> is specific to "Remote Any cache hit" loads. Firstly, these loads are
> counted twice, because if the "remote" flag is set, rmt_dram is always
> incremented, and then rmt_hitm or rmt_hit may also be incremented. These are
> then totalled in the overall load count, causing double-counting. "Remote
> Any cache hit" should not increment rmt_dram. Instead, use LVLNUM to
> discriminate between remote cache and remote DRAM. Also, non-HITM loads to
> remote cache are not being counted as hits (the last column in the cache
> line report is zero), when the SNOOP field is unset. This causes
> under-reporting of the load count. The code currently only increments
> counters if the SNOOP field is set to either HIT or HITM. Instead, for
> access to remote cache (as indicated by LVLNUM), increment rmt_hitm if
> SNOOP=HITM, increment rmt_hit otherwise.

Hi Joe, Jiri, can you please take a look and provide your Acked-by or
better, Reviewed-by?

- Arnaldo
 
> From: Al Grant <al.grant@arm.com>

Al, please provide Signed-off-by: lines for code your write,

Thanks,

- Arnaldo
 
>  tools/perf/util/mem-events.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index ea0af0bc4314..c6bb86fd4330 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -332,11 +332,13 @@ int c2c_decode_stats(struct c2c_stats *stats, struct
> mem_info *mi)
>         u64 lvl    = data_src->mem_lvl;
>         u64 snoop  = data_src->mem_snoop;
>         u64 lock   = data_src->mem_lock;
> +       u64 lvlnum = data_src->mem_lvl_num;
>         /*
>          * Skylake might report unknown remote level via this
>          * bit, consider it when evaluating remote HITMs.
>          */
>         bool mrem  = data_src->mem_remote;
> +       bool mmem = (lvlnum == PERF_MEM_LVLNUM_RAM || lvlnum ==
> PERF_MEM_LVLNUM_PMEM);
>         int err = 0;
> 
>  #define HITM_INC(__f)          \
> @@ -383,7 +385,7 @@ do {                                \
> 
>                         if ((lvl & P(LVL, REM_RAM1)) ||
>                             (lvl & P(LVL, REM_RAM2)) ||
> -                            mrem) {
> +                            (mrem && mmem)) {
>                                 stats->rmt_dram++;
>                                 if (snoop & P(SNOOP, HIT))
>                                         stats->ld_shared++;
> @@ -394,11 +396,11 @@ do {                              \
> 
>                 if ((lvl & P(LVL, REM_CCE1)) ||
>                     (lvl & P(LVL, REM_CCE2)) ||
> -                    mrem) {
> -                       if (snoop & P(SNOOP, HIT))
> -                               stats->rmt_hit++;
> -                       else if (snoop & P(SNOOP, HITM))
> +                    (mrem && !mmem)) {
> +                       if (snoop & P(SNOOP, HITM))
>                                 HITM_INC(rmt_hitm);
> +                       else
> +                               stats->rmt_hit++;
>                 }
> 
>                 if ((lvl & P(LVL, MISS)))

-- 

- Arnaldo
