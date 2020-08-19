Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E486C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 410412083B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597868794;
	bh=9mkNXL3qxuTKmxf4J9KypFPk3CQwCYHT9w9PsOO+DTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=g+1urxl2zKJAa/FqicQizQrSJWgW4V8ZWweyoaL5B+Ce6H1pCNh4h6OuTtMdC2y2H
	 i63IDZzf6EyyKeg1K8wtpZFjGHYFwYfHtPcnRTKGK1zoyxMxSYqwoBYOnIxvLOIfgg
	 +bSqdMZ8sx6MFeo8XMLE62HFy7XpucEpw3JdYviY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgHSU0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 16:26:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgHSU0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 16:26:32 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49112207DE;
        Wed, 19 Aug 2020 20:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597868791;
        bh=9mkNXL3qxuTKmxf4J9KypFPk3CQwCYHT9w9PsOO+DTM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ogYz+tB2oT7tA+9+9cnWc0TnEfTegSQY3aCypno2mo++dWppK7qqJSAw1qmjEY0fA
         gby5Hv9Exyh40ojcVXRd+vUpDXN9AWm3/mWRSnuR5OCt5H9ZE7HO4l2VLx7ybDhVn9
         Hn81oKCfhqOGfTdVFm6UqD6+VZyLL49dfGhqynoY=
Date:   Wed, 19 Aug 2020 13:26:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kpark3469@gmail.com
Cc:     linux-kernel@vger.kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        keun-o.park@digital14.com, linux-mm@kvack.org,
        Thomas Garnier <thgarnie@google.com>
Subject: Re: [PATCH] mm: slub: re-initialize randomized freelist sequence in
 calculate_sizes
Message-Id: <20200819132630.7b26964cc8946189ab5b1a70@linux-foundation.org>
In-Reply-To: <20200808095030.13368-1-kpark3469@gmail.com>
References: <20200808095030.13368-1-kpark3469@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


(cc Thomas and linux-mm)

On Sat,  8 Aug 2020 13:50:30 +0400 kpark3469@gmail.com wrote:

> From: Sahara <keun-o.park@digital14.com>
> 
> Slab cache flags are exported to sysfs and are allowed to get modified
> from userspace. Some of those may call calculate_sizes function because
> the changed flag can take an effect on slab object size and layout,
> which means kmem_cache may have different order and objects.
> The freelist pointer corruption occurs if some slab flags are modified
> while CONFIG_SLAB_FREELIST_RANDOM is turned on.
> 
>  $ echo 0 > /sys/kernel/slab/zs_handle/store_user
>  $ echo 0 > /sys/kernel/slab/zspage/store_user
>  $ mkswap /dev/block/zram0
>  $ swapon /dev/block/zram0 -p 32758
> 
>  =============================================================================
>  BUG zs_handle (Not tainted): Freepointer corrupt
>  -----------------------------------------------------------------------------
> 
>  Disabling lock debugging due to kernel taint
>  INFO: Slab 0xffffffbf29603600 objects=102 used=102 fp=0x0000000000000000 flags=0x0200
>  INFO: Object 0xffffffca580d8d78 @offset=3448 fp=0xffffffca580d8ed0
> 
>  Redzone 00000000f3cddd6c: bb bb bb bb bb bb bb bb                          ........
>  Object 0000000082d5d74e: 6b 6b 6b 6b 6b 6b 6b a5                          kkkkkkk.
>  Redzone 000000008fd80359: bb bb bb bb bb bb bb bb                          ........
>  Padding 00000000c7f56047: 5a 5a 5a 5a 5a 5a 5a 5a                          ZZZZZZZZ
> 
> In this example, an Android device tries to use zram as a swap and to
> turn off store_user in order to reduce the slub object size.
> When calculate_sizes is called in kmem_cache_open, size, order and
> objects for zs_handle is:
>  size:360, order:0, objects:22
> However, if the SLAB_STORE_USER bit is cleared in store_user_store:
>  size: 56, order:1, objects:73
> 
> All the size, order, and objects is changed by calculate_sizes(), but
> the size of the random_seq array is still old value(22). As a result,
> out-of-bound array access can occur at shuffle_freelist() when slab
> allocation is requested.
> 
> This patch fixes the problem by re-allocating the random_seq array
> with re-calculated correct objects value.
> 
> Fixes: 210e7a43fa905 ("mm: SLUB freelist randomization")
> Reported-by: Ari-Pekka Verta <ari-pekka.verta@digital14.com>
> Reported-by: Timo Simola <timo.simola@digital14.com>
> Signed-off-by: Sahara <keun-o.park@digital14.com>
> ---
>  mm/slub.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index f226d66408ee..be1e4d6682b8 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -3704,7 +3704,22 @@ static int calculate_sizes(struct kmem_cache *s, int forced_order)
>  	if (oo_objects(s->oo) > oo_objects(s->max))
>  		s->max = s->oo;
>  
> -	return !!oo_objects(s->oo);
> +	if (!oo_objects(s->oo))
> +		return 0;
> +
> +	/*
> +	 * Initialize the pre-computed randomized freelist if slab is up.
> +	 * If the randomized freelist random_seq is already initialized,
> +	 * free and re-initialize it with re-calculated value.
> +	 */
> +	if (slab_state >= UP) {
> +		if (s->random_seq)
> +			cache_random_seq_destroy(s);
> +		if (init_cache_random_seq(s))
> +			return 0;
> +	}
> +
> +	return 1;
>  }
>  
>  static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
> @@ -3748,12 +3763,6 @@ static int kmem_cache_open(struct kmem_cache *s, slab_flags_t flags)
>  	s->remote_node_defrag_ratio = 1000;
>  #endif
>  
> -	/* Initialize the pre-computed randomized freelist if slab is up */
> -	if (slab_state >= UP) {
> -		if (init_cache_random_seq(s))
> -			goto error;
> -	}
> -
>  	if (!init_kmem_cache_nodes(s))
>  		goto error;
>  
> -- 
> 2.17.1
