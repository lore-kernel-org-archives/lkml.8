Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D03C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B4E622CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JYKmQbrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbgHJToz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728217AbgHJToy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:44:54 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D53EEC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 12:44:54 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m8so6237119pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 12:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ycRnnbR2xZeCpTpBLfZzGVZNgr0ToOaSohq7rnXna0I=;
        b=JYKmQbrKCDsHxauoJypFkiLT0h6Jgug1DSYi+poxXXWFufbUXTk6KJ2Kt+2XK1GNe8
         S4rDGZ25MXBHYIILZASSvlBGv/CXEPBhfEdq8xNvoJhyrVjWKTpyPyDPysR44olyfslV
         mGw6KuM3u/OUbmJTlOzvIJpWwWPnrvYIUHHFwen7otkcfX3uda6M2XmnnjQVAKBwKZ26
         hAz1MIYlsn7XkSI143g67BMmFe1dwr5CYuEf/dZbSG87/0vpxXe+x8aURE3Fu7ZqWC4F
         kC+umJq3FudKz6uQnMsap2KZcBh6Rnqqu0HebEBEfgQPUczCqToaclrgdDy3kGDcXB9x
         zlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ycRnnbR2xZeCpTpBLfZzGVZNgr0ToOaSohq7rnXna0I=;
        b=f7vXauZK0xDRTh9x7PxXAJ0B+hMF2AtD30IM226/tpdw/Ukdm1nrPGUA6Iov4oQ1lf
         l8ySE/R9vOstLrh8xT5YWnHlaKW2fjFYLitG0dM9St+ffxzVO2BSpn5RrjfJntdeiT7C
         yV/qgTS8TuWU/e7aj0DAvyqXkDqjrgCJ83iRnALFutrxq1HaQ0UKW7j8cwUUqn3MLh4V
         BrqbOU7Kl332Qu8Ls5wRWk5my0vLr4dtXzNcY0hpVwgvV4RLQkkVPyc6ubzVzhqt/9EE
         kGuTBRG+ESuWhwpzSUO7IdUwlnVrn9NLJ3RNiYD5FcUslDQeJL3Gyf5gIJAY7ZOP8AYy
         AWlg==
X-Gm-Message-State: AOAM530wMdNICuHhkZ3eYK5zwBskQgV9negFQS39jw8TsGeHY4PqIdxc
        vzVW/X3nyeXQ7mWcorJHtLBTDQ==
X-Google-Smtp-Source: ABdhPJy6hXHCDwsIGBTEOxp8Qe62ivXMZvSl8Sag+97i4QZwzsrGlgdtaP+BQ9p0b1bhpL9o9Q5Etw==
X-Received: by 2002:aa7:9ad3:: with SMTP id x19mr2587166pfp.158.1597088693871;
        Mon, 10 Aug 2020 12:44:53 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id j10sm13106401pff.171.2020.08.10.12.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 12:44:53 -0700 (PDT)
Date:   Mon, 10 Aug 2020 12:44:52 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Abel Wu <wuyun.wu@huawei.com>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        liu.xiang6@zte.com.cn,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/slub: remove useless kmem_cache_debug
In-Reply-To: <20200810080758.940-1-wuyun.wu@huawei.com>
Message-ID: <alpine.DEB.2.23.453.2008101244090.2938695@chino.kir.corp.google.com>
References: <20200810080758.940-1-wuyun.wu@huawei.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020, wuyun.wu@huawei.com wrote:

> From: Abel Wu <wuyun.wu@huawei.com>
> 
> The commit below is incomplete, as it didn't handle the add_full() part.
> commit a4d3f8916c65 ("slub: remove useless kmem_cache_debug() before remove_full()")
> 
> Signed-off-by: Abel Wu <wuyun.wu@huawei.com>
> ---
>  mm/slub.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index fe81773..0b021b7 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2182,7 +2182,8 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
>  		}
>  	} else {
>  		m = M_FULL;
> -		if (kmem_cache_debug(s) && !lock) {
> +#ifdef CONFIG_SLUB_DEBUG
> +		if (!lock) {
>  			lock = 1;
>  			/*
>  			 * This also ensures that the scanning of full
> @@ -2191,6 +2192,7 @@ static void deactivate_slab(struct kmem_cache *s, struct page *page,
>  			 */
>  			spin_lock(&n->list_lock);
>  		}
> +#endif
>  	}
> 
>  	if (l != m) {

This should be functionally safe, I'm wonder if it would make sense to 
only check for SLAB_STORE_USER here instead of kmem_cache_debug(), 
however, since that should be the only context in which we need the 
list_lock for add_full()?  It seems more explicit.
