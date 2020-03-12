Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 656D9C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35F30206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+QO3CVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgCLOb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:31:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38276 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbgCLOb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:31:56 -0400
Received: by mail-qk1-f194.google.com with SMTP id h14so6490606qke.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 07:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8K1nRjda5Jf8KV6nORlPAQfyPeNMrEcZMVlTTaj3j5Q=;
        b=P+QO3CVSGjhT46g+Gzae1jKKuDqsG0FTLyJ9AzZ6iS0mQ2BdQN1V52PQdbzAdhsjpo
         xSdoCCn6GV9eKWhC9OBgMaJjMvS2gokcpxwqe1FpZv0/2RALmNqJpGATqfqzP2Rg4fpd
         zdHj9sHtKxWVp3B68yxf0YHluBbr9EZZwkGy+BRP4IbCC3q5BgYZu6HU7isXrKD8D4W6
         pVeXdyFc0N//hBnA3EWxoXKuW8PlSFrgipyU5fsj9LOIQ5jC8vJuWtbfiGIXa4KI03x0
         lz1ffo8vKZKC3YR37ki3BzHZcuao5wRbbFqQijX4As0dyuZOk1gwpzlDrrG2J+56rVr9
         3cxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8K1nRjda5Jf8KV6nORlPAQfyPeNMrEcZMVlTTaj3j5Q=;
        b=Ce3E6Xs5FXZ9nefuWFBrXhAvMJklm/OCXXK14AbuKI3CNAH2V709RcWRKgRaH8F8ZK
         uLKTck7eCjxfd16RwqTz3rGsncCdm1MQr1kW7xpJA0JM8UP1gFrbGzVp68+JKTvx3w7A
         lG9z0QAI9q8JselpOlQtA6bfsfJ1x1Gd6vrvjUlSa9FjOpjB+Ao6WjvEy/EGwkhHOFHW
         hTG1pbgHIGAy1epT0GcdvQU6dDeT1ln3CZJlN6MipOXBrBwZA8yAldZsKCSNwqNrJLXi
         ARyHC+I6riyj3MTLKSdI14i3hAzBCwfEYxeEjQ6Cg26VoZfLYVsaBoA4TgpHX3Mvu5vk
         t2uQ==
X-Gm-Message-State: ANhLgQ0U/N1QyHwit+bMLiXHLOX5J/bcKkYCmRKvrcDCIhyaj5eFua0e
        Cd77VCv1IWDmxu59eqTQnE3NXMij
X-Google-Smtp-Source: ADFU+vtHwQ/KY53TSMzwr9IoQrmqbxKor/wsBaHgQdYXoM+NyU0OSRI10dDSiE7cTnpo3ghXhJlEBQ==
X-Received: by 2002:a37:6ec7:: with SMTP id j190mr7658411qkc.301.1584023515356;
        Thu, 12 Mar 2020 07:31:55 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x19sm27017389qtm.47.2020.03.12.07.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 07:31:54 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 46EF840009; Thu, 12 Mar 2020 11:31:52 -0300 (-03)
Date:   Thu, 12 Mar 2020 11:31:52 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] perf record: fix binding of AIO user space buffers to
 nodes
Message-ID: <20200312143152.GA28601@kernel.org>
References: <c7ea8ffe-1357-bf9e-3a89-1da1d8e9b75b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7ea8ffe-1357-bf9e-3a89-1da1d8e9b75b@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 12, 2020 at 03:21:45PM +0300, Alexey Budankov escreveu:
> 
> Correct maxnode parameter value passed to mbind() syscall to be
> the amount of node mask bits to analyze plus 1. Dynamically allocate
> node mask memory depending on the index of node of cpu being profiled.
> Fixes: c44a8b44ca9f ("perf record: Bind the AIO user space buffers to nodes")
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/util/mmap.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
> index 3b664fa673a6..6d604cd67a95 100644
> --- a/tools/perf/util/mmap.c
> +++ b/tools/perf/util/mmap.c
> @@ -98,20 +98,29 @@ static int perf_mmap__aio_bind(struct mmap *map, int idx, int cpu, int affinity)
>  {
>  	void *data;
>  	size_t mmap_len;
> -	unsigned long node_mask;
> +	unsigned long *node_mask;
> +	unsigned long node_index;
> +	int err = 0;
>  
>  	if (affinity != PERF_AFFINITY_SYS && cpu__max_node() > 1) {
>  		data = map->aio.data[idx];
>  		mmap_len = mmap__mmap_len(map);
> -		node_mask = 1UL << cpu__get_node(cpu);
> -		if (mbind(data, mmap_len, MPOL_BIND, &node_mask, 1, 0)) {
> -			pr_err("Failed to bind [%p-%p] AIO buffer to node %d: error %m\n",
> -				data, data + mmap_len, cpu__get_node(cpu));
> +		node_index = cpu__get_node(cpu);
> +		node_mask = bitmap_alloc(node_index + 1);
> +		if (!node_mask) {
> +			pr_err("Failed to allocate node mask for mbind: error %m\n");
>  			return -1;
>  		}
> +		set_bit(node_index, node_mask);
> +		if (mbind(data, mmap_len, MPOL_BIND, node_mask, node_index + 1 + 1/*nr_bits + 1*/, 0)) {

                                                                                  ^^^^^^^^^^^^^^
										  Leftover?

> +			pr_err("Failed to bind [%p-%p] AIO buffer to node %lu: error %m\n",
> +				data, data + mmap_len, node_index);
> +			err = -1;
> +		}
> +		bitmap_free(node_mask);
>  	}
>  
> -	return 0;
> +	return err;
>  }
>  #else /* !HAVE_LIBNUMA_SUPPORT */
>  static int perf_mmap__aio_alloc(struct mmap *map, int idx)
> -- 
> 2.24.1
> 

-- 

- Arnaldo
