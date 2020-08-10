Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF11EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8949F207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VFgiYA9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbgHJTgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgHJTgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:36:05 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B463CC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 12:36:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p37so1339001pgl.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 12:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=seOGDcwiAHhEg0sePra6hNJuyqWga65RK4Gqg7FH3XU=;
        b=VFgiYA9zFj+7/S5s6ppg9Qhnm5OJ2NOPyxte8zuNX5vXDP0HEEDOqc95sXg/oFPJKk
         7OB9gTY1pPO2O8dsZQ1D+NsSWaO4/oiEzvdb45e0IrQpXT0QLOyuiEdI5bU28OYKtSbN
         iV+onBvagtaNzCSvlUvOLPYIgRv2JUOGHVOV3rymvUS9NczYsmjtiTUF5JGEPb293vVG
         +i5ov+9VGLgVvU2zQgz55J7yrhq8hnHORlceEpm6v8pv0ygzcyrHybLEIZr5GlvT4Hrs
         TgdkZKvZQ8Et9tA4N3Ni/wWsU5W/Fh4B6FD7aLGc293igwDSLoaB1ECQAjMSxc0MAArI
         aNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=seOGDcwiAHhEg0sePra6hNJuyqWga65RK4Gqg7FH3XU=;
        b=sfKenSxZmJVpBQLrvUE2tONqtJRrVQtGwX10RbWdsF7UVXE7pF0WWPAEf2sPe5vgiM
         NbHvxHxFttfdvDYRdIP/bbjiTP8a31eXgkEkm9XcDPItI8zku0QkFxhgQwCRxcVgN5HW
         ata5JkVEEBQ6rLt4t5JRwdnMPSZuYxbbYWYxuaO4FJ7EiE+11L3XFr9CumMXLFKBw6pX
         BMdToPgEFLGtJurgg0zdlrpQFNDaBzYfyH9peJaEyl0AC/CRMXQ6Z3ZFZaZXMBGfR8ae
         eYWmcEUCtvslspyiPN00PK3VHGK6mSmKbLNkSA1JnlCnw7e4H24waCDIDlMic5ijD+ux
         FciA==
X-Gm-Message-State: AOAM532F7eULlcUc+HpBmt3CN6fM14Ch1Y1g1nMIGfTZBTotNpXq/cPo
        hmdqbNbfvTyzyYJvcaGw9ZCYiw==
X-Google-Smtp-Source: ABdhPJwYva7UpFWysizChcAywgtXGyOCug5HuGNYGgFdfAcZQeH50OHbYZXANqFpi3fIALEvNpmXIQ==
X-Received: by 2002:a63:504a:: with SMTP id q10mr23775588pgl.355.1597088164864;
        Mon, 10 Aug 2020 12:36:04 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id t13sm19027161pgm.32.2020.08.10.12.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 12:36:03 -0700 (PDT)
Date:   Mon, 10 Aug 2020 12:36:03 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Charan Teja Reddy <charante@codeaurora.org>
cc:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org
Subject: Re: [PATCH] mm, page_alloc: fix core hung in free_pcppages_bulk()
In-Reply-To: <1597075833-16736-1-git-send-email-charante@codeaurora.org>
Message-ID: <alpine.DEB.2.23.453.2008101234030.2938695@chino.kir.corp.google.com>
References: <1597075833-16736-1-git-send-email-charante@codeaurora.org>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020, Charan Teja Reddy wrote:

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e4896e6..25e7e12 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3106,6 +3106,7 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
>  	struct zone *zone = page_zone(page);
>  	struct per_cpu_pages *pcp;
>  	int migratetype;
> +	int high;
>  
>  	migratetype = get_pcppage_migratetype(page);
>  	__count_vm_event(PGFREE);
> @@ -3128,8 +3129,19 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
>  	pcp = &this_cpu_ptr(zone->pageset)->pcp;
>  	list_add(&page->lru, &pcp->lists[migratetype]);
>  	pcp->count++;
> -	if (pcp->count >= pcp->high) {
> -		unsigned long batch = READ_ONCE(pcp->batch);
> +	high = READ_ONCE(pcp->high);
> +	if (pcp->count >= high) {
> +		int batch;
> +
> +		batch = READ_ONCE(pcp->batch);
> +		/*
> +		 * For non-default pcp struct values, high is always
> +		 * greater than the batch. If high < batch then pass
> +		 * proper count to free the pcp's list pages.
> +		 */
> +		if (unlikely(high < batch))
> +			batch = min(pcp->count, batch);
> +
>  		free_pcppages_bulk(zone, batch, pcp);
>  	}
>  }

I'm wondering if a fix to free_pcppages_bulk() is more appropriate here 
because the count passed into it seems otherwise fragile if this results 
in a hung core?
