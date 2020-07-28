Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42BABC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:46:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F109207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g0MbWG+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732969AbgG1TqJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732958AbgG1TqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:46:09 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466D2C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:46:09 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t15so535674pjq.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=CcfvoFL7aJEulqwwTYjAtmM4mTbUznShrvhOhRcbiJ4=;
        b=g0MbWG+Z2VyMhmBmNaSfj94wMWmzF14QrIOiZbbusdMfkMpd2OYfLufJvgWBm6laan
         AWvEJUjSK/+ZaYwgkGS69i2l4BsvcmJe6fkS8OzN9v+Csv34WY6lba6pDhFSwOjjqAQm
         jpAE6od3r/7yj6oPlqsnVvjzqn96hPkJgnLXha614YEX+93fh8uaAHIwuGuQUhkNsZjo
         yeyAbwSxrvg1nVfQPs6jrTiNVINtSdGVna6TARs2fRt/UoBEGDIUqmz4odIKXVK0FrLq
         nyriSswCPQumzxAFtokW6BVp8Eu5HH4wzurRuFAyau4bwZBVEbltwHPG/SqNvRMV3yKW
         en9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=CcfvoFL7aJEulqwwTYjAtmM4mTbUznShrvhOhRcbiJ4=;
        b=UvY906XSOkLqjRbxK6VaUd5TfcXZHWXjs2eK440gGewKFPsc4y6EvnZ6oVClqtxfW4
         g7GnwMRmP94FlLPyPWCqdrYVUr1jPRfY5R+RJuajxjI4sTKEaW9j5X4cFUQ6BdCtEgpl
         2lync/DUOemFBN59PooVe6Je7rO5pSdLZkOgaRkmXo2R1i2IwLcbwjr73p71ip09IMeJ
         Hy3vTH6NTe7zxJyZ7bcO12gAMN2NFUD2F4em78kvl0CUkGiuDeN+dxODJeTjP42CxS0w
         o860LgRP+Pj6Zpg1iCiHgt3B11p44q3gxT5MI0PF2xVOsqYpTRVHnOlHeFOafCmA3Wp8
         fSWw==
X-Gm-Message-State: AOAM531L5l1/UIV7oeVIaQdGWVBG70NsVa+yGkDM4QrcqY8/hz359ZsH
        SGVySGhhi/r3LkqjPUrG9sVXVA==
X-Google-Smtp-Source: ABdhPJxpt5JQVmgBPnYf4Y4KhQFY8WRyAIyKEPvlPItSlrgq906zB6TAsovA0eaDTxxBPgXCQO5elA==
X-Received: by 2002:a17:90a:3e02:: with SMTP id j2mr6283098pjc.47.1595965568586;
        Tue, 28 Jul 2020 12:46:08 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id z9sm9533146pfn.59.2020.07.28.12.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:46:08 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:46:07 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     qiang.zhang@windriver.com
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab.c: add node spinlock protect in
 __cache_free_alien
In-Reply-To: <20200728095551.30634-1-qiang.zhang@windriver.com>
Message-ID: <alpine.DEB.2.23.453.2007281238580.2664959@chino.kir.corp.google.com>
References: <20200728095551.30634-1-qiang.zhang@windriver.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020, qiang.zhang@windriver.com wrote:

> From: Zhang Qiang <qiang.zhang@windriver.com>
> 
> We should add node spinlock protect "n->alien" which may be
> assigned to NULL in cpuup_canceled func. cause address access
> exception.
> 

Hi, do you have an example NULL pointer dereference where you have hit 
this?

This rather looks like something to fix up in cpuup_canceled() since it's 
currently manipulating the alien cache for the canceled cpu's node.

> Fixes: 18bf854117c6 ("slab: use get_node() and kmem_cache_node() functions")
> Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
> ---
>  mm/slab.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/slab.c b/mm/slab.c
> index a89633603b2d..290523c90b4e 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -759,8 +759,10 @@ static int __cache_free_alien(struct kmem_cache *cachep, void *objp,
>  
>  	n = get_node(cachep, node);
>  	STATS_INC_NODEFREES(cachep);
> +	spin_lock(&n->list_lock);
>  	if (n->alien && n->alien[page_node]) {
>  		alien = n->alien[page_node];
> +		spin_unlock(&n->list_lock);
>  		ac = &alien->ac;
>  		spin_lock(&alien->lock);
>  		if (unlikely(ac->avail == ac->limit)) {
> @@ -769,14 +771,15 @@ static int __cache_free_alien(struct kmem_cache *cachep, void *objp,
>  		}
>  		ac->entry[ac->avail++] = objp;
>  		spin_unlock(&alien->lock);
> -		slabs_destroy(cachep, &list);
>  	} else {
> +		spin_unlock(&n->list_lock);
>  		n = get_node(cachep, page_node);
>  		spin_lock(&n->list_lock);
>  		free_block(cachep, &objp, 1, page_node, &list);
>  		spin_unlock(&n->list_lock);
> -		slabs_destroy(cachep, &list);
>  	}
> +
> +	slabs_destroy(cachep, &list);
>  	return 1;
>  }
>  
> -- 
> 2.26.2
> 
> 
