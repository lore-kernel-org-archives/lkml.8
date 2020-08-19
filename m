Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76715C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403162083B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 20:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U12m7mMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgHSU3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 16:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgHSU3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 16:29:24 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BF1C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 13:29:24 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id m8so12269222pfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 13:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gT6aAs2nI4RvDF+uZSm15hbpN7OU0XqOIs46/A9zsC4=;
        b=U12m7mMFbh5DDjt3ATzuw0/ffpQR2TOlorxruFEXWRijOu1Pbty+y8pY4fbSHK5V4t
         Ab1XA5wg1QwaSvwjYXumpyMz83UK1iSbWXjbaGi3bUthXs7o3dxpnZ5VzA08GV1MjKQQ
         1xHfnW5qooRFExwKwCRulDZAI01ykaxN4q+g4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gT6aAs2nI4RvDF+uZSm15hbpN7OU0XqOIs46/A9zsC4=;
        b=BDcRJVDbsW2Io6hnXXOvNEWGAzFb5hqgVp1My88Q5orbShpgoymXB5IMFSF1aHUDmu
         s3zZIKXYmbnwM+T+H90Rmfg0aJ5t7ibhVjXKVPKx5gPULiwHTHGxvN0IYrASnpL3Sw6S
         ZBXw8m2kcJHlSgypmMgfYgKmt/3i61ngxexr2AtfL8+V6ILO46IG9It4nmPSOdVc3+HM
         7KinprpLQRv6rFCjpF0hkv8lCMJlG6GtlfKbUl1jkwvljCNFC1bOqfouZybCc2AIU7vj
         FXTHMOb8DhQHYIOvPM9GwbOfAXwQ6q45aRoMhJR4HqLXcpoEwIqBeLpWP4EI4f1zPVQx
         igHg==
X-Gm-Message-State: AOAM5334rBieM7NvWIhz6CUfIZPkJ1wr17SZB0mK0c1+qkLrQOCc1ohE
        faaKbNOUJvgIl+V/ZoiC2/ddmBJ9RD0ZuA==
X-Google-Smtp-Source: ABdhPJznqVKHkW04KXCfkxetd9/d+V3nV7JLS18kcARu2s3y3AF+SdswWsVudQ55cc055xKAn8QpNQ==
X-Received: by 2002:aa7:8c09:: with SMTP id c9mr17818234pfd.157.1597868963720;
        Wed, 19 Aug 2020 13:29:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id nu14sm3799043pjb.19.2020.08.19.13.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 13:29:22 -0700 (PDT)
Date:   Wed, 19 Aug 2020 13:29:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     kpark3469@gmail.com
Cc:     linux-kernel@vger.kernel.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <guro@fb.com>, akpm@linux-foundation.org,
        keun-o.park@digital14.com
Subject: Re: [PATCH] mm: slub: re-initialize randomized freelist sequence in
 calculate_sizes
Message-ID: <202008191326.833277DC41@keescook>
References: <20200808095030.13368-1-kpark3469@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200808095030.13368-1-kpark3469@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 08, 2020 at 01:50:30PM +0400, kpark3469@gmail.com wrote:
> From: Sahara <keun-o.park@digital14.com>

Hi!

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

The problems here are actually larger than just the freelist pointers,
so this was actually solved by just making these parameters not writable
at runtime:

https://git.kernel.org/linus/ad38b5b1131e2a0e5c46724847da2e1eba31fb68

I wonder if perhaps the above patch needs to be explicitly sent to the
-stable trees?

-Kees

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
> 

-- 
Kees Cook
