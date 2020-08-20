Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC061C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 979CF2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="W94gZcQe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgHTUo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 16:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbgHTUo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 16:44:57 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4F7C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 13:44:57 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id g15so1578230plj.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 13:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=54ABhVyW2hfQecEnwMQxuYRtT1ryW088E7woHqdZaXY=;
        b=W94gZcQeRoABCsOVtsMwPlJecPyyC9T29k5GLRV7ZJlrnVuSzmQqnfd96ZLHu18XD7
         TpdOUZuNjFfS+knX1eRiy2ZbFNQu3bn584apOPv5PiGDgCmqUXaRiGvyHy15cUsjxuoO
         nT9MAnh/2CcmfNqvYh6a364pYdH/RwbjYTux3pW7cUOgfH9feUnCem0tjPyEW2S62oeh
         DGiB4d1HNWa/3KpuMk+I9AuwoL3MMAReZhNH57d2RF+d1uQMFdFbIXgG3PcGFrmNq/o5
         pRnBXa9E184SV9KgLOWXA2KgJdl4hPhyd9fLkig7NZd28AQ4VjXCMrsSf4OshVtiZYUg
         hGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=54ABhVyW2hfQecEnwMQxuYRtT1ryW088E7woHqdZaXY=;
        b=PIr78LvbdQlPKykTyyN6kV2DQFZKyqyUd4eOY7Qhe1s3Cz/HKrBnXA161TOzuNUhzW
         tZL8VBjAjt4RAVTagD+XbX+uwVdvZ/C4ur8iuh4qNOo2BIw+d+2G9q63E8GygIgN5NfJ
         59UT2U8opcPcP06H2A8NFTmjETg7yJzEjrFgGMTw0RxJWCpv7a/sb2LKvvMoyEuJ8rKk
         s15Umu0/Ol9x2ThIFk+lGqcfMNQ1iQb3WSEMzUth1tlxUrRp9nFc9WP6SjcJ1Wuq+j5E
         tREWAptdVMtpj0D8XQ1L6BV9438PjP8CayX/vOpjJLEQPF1GCPeI5kLD2XneNXZdUpx8
         1QEQ==
X-Gm-Message-State: AOAM531loMWgJmCLoMLD/8iX23kF0MrArY9e8gSTHMMY4PBvH3jur6Uj
        A9Dhl8XZ1z4bqF6CIoqiokK2Zw==
X-Google-Smtp-Source: ABdhPJwqU+99F74bSw1tb/ADlJjEt4yJRkSqYxno9vow94VLDSADcJF13NgH0u6R+z2QFvSFGv2aMw==
X-Received: by 2002:a17:90a:7348:: with SMTP id j8mr51736pjs.137.1597956296618;
        Thu, 20 Aug 2020 13:44:56 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q2sm3590625pgs.90.2020.08.20.13.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 13:44:56 -0700 (PDT)
Date:   Thu, 20 Aug 2020 13:44:56 -0700 (PDT)
X-Google-Original-Date: Thu, 20 Aug 2020 13:35:06 PDT (-0700)
Subject:     Re: [PATCH 1/3] riscv: Set more data to cacheinfo
In-Reply-To: <3ca47cfde607516e51f78f1645357ca739e775d0.1593766028.git.zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-cb490336-f234-42e9-b799-c429284963ea@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Jul 2020 01:57:53 PDT (-0700), zong.li@sifive.com wrote:
> Set cacheinfo.{size,sets,line_size} for each cache node, then we can
> get these information from userland through auxiliary vector.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/kernel/cacheinfo.c | 59 ++++++++++++++++++++++++++---------
>  1 file changed, 44 insertions(+), 15 deletions(-)
>
> diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> index 4c90c07d8c39..cdd35e53fd98 100644
> --- a/arch/riscv/kernel/cacheinfo.c
> +++ b/arch/riscv/kernel/cacheinfo.c
> @@ -8,12 +8,46 @@
>  #include <linux/of.h>
>  #include <linux/of_device.h>
>
> -static void ci_leaf_init(struct cacheinfo *this_leaf,
> -			 struct device_node *node,
> -			 enum cache_type type, unsigned int level)
> +static void ci_leaf_init(struct cacheinfo *this_leaf, enum cache_type type,
> +			 unsigned int level, unsigned int size,
> +			 unsigned int sets, unsigned int line_size)
>  {
>  	this_leaf->level = level;
>  	this_leaf->type = type;
> +	this_leaf->size = size;
> +	this_leaf->number_of_sets = sets;
> +	this_leaf->coherency_line_size = line_size;
> +
> +	/*
> +	 * If the cache is fully associative, there is no need to
> +	 * check the other properties.
> +	 */
> +	if (!(sets == 1) && (sets > 0 && size > 0 && line_size > 0))
> +		this_leaf->ways_of_associativity = (size / sets) / line_size;
> +}
> +
> +static void fill_cacheinfo(struct cacheinfo **this_leaf,
> +			   struct device_node *node, unsigned int level)
> +{
> +	unsigned int size, sets, line_size;
> +
> +	if (!of_property_read_u32(node, "cache-size", &size)) {
> +		of_property_read_u32(node, "cache-block-size", &line_size);
> +		of_property_read_u32(node, "cache-sets", &sets);

Presumably we should be checking for errors here as well, rather than just
passing arbitrary values to userspace?

> +		ci_leaf_init((*this_leaf)++, CACHE_TYPE_UNIFIED, level, size, sets, line_size);
> +	}
> +
> +	if (!of_property_read_u32(node, "i-cache-size", &size)) {
> +		of_property_read_u32(node, "i-cache-sets", &sets);
> +		of_property_read_u32(node, "i-cache-block-size", &line_size);
> +		ci_leaf_init((*this_leaf)++, CACHE_TYPE_INST, level, size, sets, line_size);
> +	}
> +
> +	if (!of_property_read_u32(node, "d-cache-size", &size)) {
> +		of_property_read_u32(node, "d-cache-sets", &sets);
> +		of_property_read_u32(node, "d-cache-block-size", &line_size);
> +		ci_leaf_init((*this_leaf)++, CACHE_TYPE_DATA, level, size, sets, line_size);
> +	}
>  }
>
>  static int __init_cache_level(unsigned int cpu)
> @@ -66,29 +100,24 @@ static int __populate_cache_leaves(unsigned int cpu)
>  	struct device_node *prev = NULL;
>  	int levels = 1, level = 1;
>
> -	if (of_property_read_bool(np, "cache-size"))
> -		ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
> -	if (of_property_read_bool(np, "i-cache-size"))
> -		ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
> -	if (of_property_read_bool(np, "d-cache-size"))
> -		ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
> +	/* Level 1 caches in cpu node */
> +	fill_cacheinfo(&this_leaf, np, level);
>
> +	/* Next level caches in cache nodes */
>  	prev = np;
>  	while ((np = of_find_next_cache_node(np))) {
>  		of_node_put(prev);
>  		prev = np;
> +
>  		if (!of_device_is_compatible(np, "cache"))
>  			break;
>  		if (of_property_read_u32(np, "cache-level", &level))
>  			break;
>  		if (level <= levels)
>  			break;
> -		if (of_property_read_bool(np, "cache-size"))
> -			ci_leaf_init(this_leaf++, np, CACHE_TYPE_UNIFIED, level);
> -		if (of_property_read_bool(np, "i-cache-size"))
> -			ci_leaf_init(this_leaf++, np, CACHE_TYPE_INST, level);
> -		if (of_property_read_bool(np, "d-cache-size"))
> -			ci_leaf_init(this_leaf++, np, CACHE_TYPE_DATA, level);
> +
> +		fill_cacheinfo(&this_leaf, np, level);
> +
>  		levels = level;
>  	}
>  	of_node_put(np);
