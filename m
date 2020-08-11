Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62968C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DF9A20786
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NF9nDofa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgHKVkS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgHKVkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:40:17 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D237EC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:40:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d188so8335665pfd.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xh1nFmiFsyPig921Fwk7pCd225ZkH0tJsK6GH0jcq9Q=;
        b=NF9nDofa//83sJtBUpVI2eC0Kf/qGVDT+X35ri144puGnCvGTfZJ6RgZxtEcRnp4eY
         Pbq/3SQIFzN0UySOyqMQfvQn8Ao2+zgiUuCSiV9Lo87/6Bqh8P6CfIHVx3NArVEGCk30
         SlG3Ra8q9tR0JsITHSC2K4bdr/IVIuDPD544ywmn4iZq8ns1zfx9Qjf6e+8VfrR3b5kS
         K0fej6N70MA7/2OK2TIG4OFhogiydqY3JuSewDBDGCMMnlSb1CQZqXG47EPmKxTtjU3O
         BwQyJQY5A0HJGHk8zaTMuWkqCRFu6nAOQuYlmUbfhCbK/83tTNkcbJODqq3N8etyGNFI
         SflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xh1nFmiFsyPig921Fwk7pCd225ZkH0tJsK6GH0jcq9Q=;
        b=rs7Ls60+rpSNaiefFdvJBCw8JjBSt7e5x5aDRtDcEWOLHkc1X98pcExFBOv0sFBpVr
         nNQzxcVjYSO+KlR/Z1LVkQ8ri/xWl4Wk6BTZJzTZCqjDcevtkIB4wUVpopEaV0ZivlOD
         xUAJ0Ed5q4PF2lNiElB1mAmk6OByZTpo1oz2m7wHJUEzYA/lLOGFstOXpjw7fjlifw7l
         vcoU69YBThALxHqx55PuZi/4gJCtgP2np3U8gMk2CwVSC5+Nt3DUXJr3AdK/0huhd1Iv
         ecAv42/IHKWFimEJFDg4UUMJmUZenJiIq4zsrr6EzxonAY8ta0m0oB7F/BjZ4TrdXpsG
         kMOQ==
X-Gm-Message-State: AOAM530mgrrPY4n+cxvO+UxVVg1T2kcy7yS4qRxPzutAj9xE/gMwqL6O
        Jg6VqfHsNEYY7VbQnxmU1+ueWw==
X-Google-Smtp-Source: ABdhPJyEA7lC5GKVFyT2NcG/5JHdpnv77bPF4IxLESV+U/UJuN955B9GPwSnjylIiwsvAopuI9cxeQ==
X-Received: by 2002:aa7:96c5:: with SMTP id h5mr8025042pfq.195.1597182016109;
        Tue, 11 Aug 2020 14:40:16 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id w6sm96744pgr.82.2020.08.11.14.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 14:40:15 -0700 (PDT)
Date:   Tue, 11 Aug 2020 14:40:14 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Abel Wu <wuyun.wu@huawei.com>
cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        hewenliang4@huawei.com, hushiyuan@huawei.com,
        "open list:SLAB ALLOCATOR" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/slub: fix missing ALLOC_SLOWPATH stat when bulk
 alloc
In-Reply-To: <20200811022427.1363-1-wuyun.wu@huawei.com>
Message-ID: <alpine.DEB.2.23.453.2008111435300.3428139@chino.kir.corp.google.com>
References: <20200811022427.1363-1-wuyun.wu@huawei.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Aug 2020, wuyun.wu@huawei.com wrote:

> From: Abel Wu <wuyun.wu@huawei.com>
> 
> The ALLOC_SLOWPATH statistics is missing in bulk allocation now.
> Fix it by doing statistics in alloc slow path.
> 
> Signed-off-by: Abel Wu <wuyun.wu@huawei.com>
> ---
>  mm/slub.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index df93a5a0e9a4..5d89e4064f83 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2600,6 +2600,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  	void *freelist;
>  	struct page *page;
>  
> +	stat(s, ALLOC_SLOWPATH);
> +
>  	page = c->page;
>  	if (!page) {
>  		/*
> @@ -2788,7 +2790,6 @@ static __always_inline void *slab_alloc_node(struct kmem_cache *s,
>  	page = c->page;
>  	if (unlikely(!object || !node_match(page, node))) {
>  		object = __slab_alloc(s, gfpflags, node, addr, c);
> -		stat(s, ALLOC_SLOWPATH);
>  	} else {
>  		void *next_object = get_freepointer_safe(s, object);
>  

Acked-by: David Rientjes <rientjes@google.com>

> -- 
> 2.28.0.windows.1

Lol :)
