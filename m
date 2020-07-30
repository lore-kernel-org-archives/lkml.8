Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFC7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 285522083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:45:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ffhiqppk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730804AbgG3XpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgG3XpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 19:45:04 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6488BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 16:45:04 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u10so6190864plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 16:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=LIOKBGZfRASo2D/3orERxe57iSzMy6S6QL+EcVsSq84=;
        b=ffhiqppkEpp60lNBK9wc8DYAkm/vTkDoboYGbBo2xqlSHEeCPYzHqhVscdsH6Umn+Z
         fa990Z+7cFxq9gC/X46ceQhRibZBKHXyKFcYDpMzaOoFyw8hb7tlyAhSIXMnuxVIF60Z
         mIAmKxwy4DD2gc0XiQ2FjJLc/4xT07hC2ePonK1uDEItCRJGu7J372g3q0edaCmupZ0l
         wK/qCZquibp5Y4CXoN9huGgdpNDUfLyfn2zJ1PhaWYAlx0ZeGJt1+G81BhrTXDPcin8U
         1aNKJcw0j1vpp7+Nj6rAjuelaSD6/Wuckn0SKdfzLDblrI6c3NSrMLY12HXCu/YxJUFB
         CJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=LIOKBGZfRASo2D/3orERxe57iSzMy6S6QL+EcVsSq84=;
        b=r8s7ns6ypU2OXYVI8KIVWUdykTRqL8HhhpGdXnhPg+mht9N6wjWKIX2LyN+GebzAWg
         BQhvVXzjwDGT0+EDYLKQGrTSt0pOmmIiddbiZETL5JgSu35c0Ni/8qQsqET6WGO4ZQ6f
         XMbLvT5IJro0AjRpLCKCQ0ogks4AbOXV47O2Be8sC8l8dlVyROG2kg2KTEo1BW5heEPl
         Z2Q4VwygnykWWMduwoU0kyAXk+i3DPVOywjBjzc43qnP0GkGWg0SDwCPiSviGq+YUqUm
         bLCKhCZ+95SJnoZUHKvyP9C8dD6s7DkyePI14+dSroerVzcCsNeBeBiBXVUBRTFMX6+Y
         4E6g==
X-Gm-Message-State: AOAM530dDxPRHjFqo7u+wBa20Y4iHQX+xisyKEl70nnwLNYxXDnRkPGb
        radNvIgsF86p7Sypdn7dbnsrtg==
X-Google-Smtp-Source: ABdhPJzBQrVG0e+xksdvtOwS39qqIGOWzEYbeY31MeCaw2IDBTEWMsJNOsh3jnfTQQha1dboiH4RzQ==
X-Received: by 2002:a17:902:6bc2:: with SMTP id m2mr1463515plt.158.1596152703771;
        Thu, 30 Jul 2020 16:45:03 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id j11sm7475771pfn.38.2020.07.30.16.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 16:45:03 -0700 (PDT)
Date:   Thu, 30 Jul 2020 16:45:02 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     qiang.zhang@windriver.com
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm/slab.c: add node spinlock protect in
 __cache_free_alien
In-Reply-To: <20200730101934.38343-1-qiang.zhang@windriver.com>
Message-ID: <alpine.DEB.2.23.453.2007301644400.3634587@chino.kir.corp.google.com>
References: <20200730101934.38343-1-qiang.zhang@windriver.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020, qiang.zhang@windriver.com wrote:

> From: Zhang Qiang <qiang.zhang@windriver.com>
> 
> for example:
> 			        node0
> 	cpu0				                cpu1
> slab_dead_cpu
>    >mutex_lock(&slab_mutex)
>      >cpuup_canceled                            slab_dead_cpu
>        >mask = cpumask_of_node(node)               >mutex_lock(&slab_mutex)
>        >n = get_node(cachep0, node0)
>        >spin_lock_irq(n&->list_lock)
>        >if (!cpumask_empty(mask)) == true
>        	>spin_unlock_irq(&n->list_lock)
> 	>goto free_slab
>        ....
>    >mutex_unlock(&slab_mutex)
> 
> ....						   >cpuup_canceled
> 						     >mask = cpumask_of_node(node)
> kmem_cache_free(cachep0 )			     >n = get_node(cachep0, node0)
>  >__cache_free_alien(cachep0 )			     >spin_lock_irq(n&->list_lock)
>    >n = get_node(cachep0, node0)		     >if (!cpumask_empty(mask)) == false
>    >if (n->alien && n->alien[page_node])	     >alien = n->alien
>      >alien = n->alien[page_node]	             >n->alien = NULL
>      >....					     >spin_unlock_irq(&n->list_lock)
> 						     >....
> 

As mentioned in the review of v1 of this patch, we likely want to do a fix 
for cpuup_canceled() instead.
