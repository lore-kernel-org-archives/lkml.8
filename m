Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CF54C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 07:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D6B2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 07:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590391453;
	bh=VASU5nr6Ba2ffvqLAwvD9IGVryjnzlFpZ2dWFCxDOiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kAiwFeUqg6bf92W/QfyiD4nzwKJYvVhiHA5Axlq3wQuicAHMAutsbbz7ET2KOFfrS
	 vYQeXu+ZMsb1cv5/BLqadJqUvUmoYK32xTRcsFeJEM+1pFw1WrUnMHDZ9sACcnvfg1
	 zznliZ6xZVIWOtDg8Lmhc4vk26RvBeh4eUV/BJeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389070AbgEYHYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 03:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388948AbgEYHYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 03:24:11 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746A8C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 00:24:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id g12so14917927wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 00:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5hUqIRwsEhjP973MdiZw6ZfkOx5BxTr4K49x6S99NKM=;
        b=Q/eqECJOmI6fjqirFw+CN7WwcTy99eM69bu4aBq7+T3+3zBAtIeg600EIHm/aqBg3v
         B4cYk3M/9qfoPYdX2r7hXttbT2SUeH8JKh3WpEzWlk1kxi60xS1sCT+XC3/9iu2IHah6
         suNtwkfrzgD+TfQw9/v3cbNTHWHozpXyXDWUGQQl6HjL4LimW+lTpeO83SP5uot2/fFC
         eTKWKPMMGt+gZjN8xPtsU1OywuUFLdLXK5chRVYtxNsa2FxjThF/wWBt1P0heLOprdbm
         oRoT4IBapySQZWE6mkOJk0b0ZvBGFCnWv7N8OgeW2s/3JHC4dHCidCNJZs/dsjpknBQu
         ZMxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5hUqIRwsEhjP973MdiZw6ZfkOx5BxTr4K49x6S99NKM=;
        b=ML1vaodOjiUzyVO+itzkbDQt59cYeHgQHMd+l4NURD62A/02nnjPlI3QaVRcrkX9Ro
         EUT/LAE18lK29+dCBylEmRlDLbingc/2WdWW3IR3YAdkRfY31Mnyn6v5QPlSOlUFkwwP
         nLQoluJr3rjSHsk5rBFr7E5wXUCx85cu7R+G81j+1zf1YobhRPgpAr0NAf+dyKNViu6X
         yT+AsbC5LuMeTq2ip7tjDbwKSY/tyAbFgqiwR5p47Iz4oTozJxql5oCpZd2DDy/Wgjob
         HdhP/yXs/akz/aPxrEQZ2PfT8/4rywA5hbWn8IGr+GCTW70ysK9YMe3e9TK0oN8F9P+H
         88pQ==
X-Gm-Message-State: AOAM530RVrD1cHrFEraRG1lnAAXVdRvFmni3Cv2M5z4NbHjLKTyYnE+k
        ctQAkm7RI8T/rbbgwh9SAPs=
X-Google-Smtp-Source: ABdhPJw4jTAEIUHCVhOsba5Dypz+M13dBrYkD0k/MStvUfs9idzRUM3vJUWfH1oOL2LeKUZI9j0FDw==
X-Received: by 2002:adf:f4d0:: with SMTP id h16mr13856633wrp.230.1590391450175;
        Mon, 25 May 2020 00:24:10 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id k13sm16795916wmj.40.2020.05.25.00.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 00:24:09 -0700 (PDT)
Date:   Mon, 25 May 2020 09:24:07 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v2 6/7] zram: Allocate struct zcomp_strm as per-CPU memory
Message-ID: <20200525072407.GE329373@gmail.com>
References: <20200524215739.551568-1-bigeasy@linutronix.de>
 <20200524215739.551568-7-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524215739.551568-7-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> zcomp::stream is per-CPU pointer, pointing to struct zcomp_strm which
> contains two pointer. Having struct zcomp_strm allocated directly as
> per-CPU memory would avoid one additional memory allocation and a
> pointer dereference.
> This also also simplifies adding a local_lock to struct zcomp_strm.
> 
> Allocate zcomp::stream directly as per-CPU memory.

Various typo/spelling fixes:

> zcomp::stream is a per-CPU pointer, pointing to struct zcomp_strm 
> which contains two pointers. Having struct zcomp_strm allocated 
> directly as per-CPU memory would avoid one additional memory 
> allocation and a pointer dereference. This also simplifies the 
> addition of a local_lock to struct zcomp_strm.


> diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
> index 1a8564a79d8dc..ae6dc137a1ed8 100644
> --- a/drivers/block/zram/zcomp.c
> +++ b/drivers/block/zram/zcomp.c
> @@ -37,19 +37,17 @@ static void zcomp_strm_free(struct zcomp_strm *zstrm)
>  	if (!IS_ERR_OR_NULL(zstrm->tfm))
>  		crypto_free_comp(zstrm->tfm);
>  	free_pages((unsigned long)zstrm->buffer, 1);
> -	kfree(zstrm);
> +	zstrm->tfm = NULL;
> +	zstrm->buffer = NULL;
>  }
>  
>  /*
>   * allocate new zcomp_strm structure with ->tfm initialized by
>   * backend, return NULL on error
>   */
> -static struct zcomp_strm *zcomp_strm_alloc(struct zcomp *comp)
> +static int zcomp_strm_alloc(struct zcomp_strm *zstrm,
> +			    struct zcomp *comp)

There's no need to put these into two lines, in a single line it's 
only 73 columns long. Leftover from some earlier bloat?

>  void zcomp_stream_put(struct zcomp *comp)
> @@ -159,16 +157,14 @@ int zcomp_cpu_up_prepare(unsigned int cpu, struct hlist_node *node)
>  {
>  	struct zcomp *comp = hlist_entry(node, struct zcomp, node);
>  	struct zcomp_strm *zstrm;
> +	int ret;
>  
> -	if (WARN_ON(*per_cpu_ptr(comp->stream, cpu)))
> -		return 0;
> -
> -	zstrm = zcomp_strm_alloc(comp);
> -	if (IS_ERR_OR_NULL(zstrm)) {
> +	zstrm = per_cpu_ptr(comp->stream, cpu);
> +	ret = zcomp_strm_alloc(zstrm, comp);
> +	if (ret) {
>  		pr_err("Can't allocate a compression stream\n");
>  		return -ENOMEM;

BTW., with the allocation being in a single place and us having a 
proper 'ret', the return -ENOMEM could turn into 'return ret'?

Thanks,

	Ingo
