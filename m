Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA65C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5764B20788
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:33:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="k34A8qiX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgCRSdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:33:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34631 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCRSdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:33:22 -0400
Received: by mail-qk1-f195.google.com with SMTP id f3so40528908qkh.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 11:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ip23Q/fmH9GkZLli1PvyNY1tJYowB5KnpO5h7I2g+T8=;
        b=k34A8qiXPlwViOmgLKOUThMMETnc0hJLj8etiqMsluruL0R6jNrkbNsCeGRjctAXkP
         8oTIRM/OspYFKGtQmtiNJhkH7LuJG84hQ+YpG8iEZ1T49eOycdy7gwweDP8iSdy47rXT
         lzPRSzFh6dlljvS7JefASvHrBwuxxif86KRYq1CYP0SXYHB2yB5L2BDosVffNoqa42od
         osT67blOOEwHzhNefYIMwYd4mUhkqyMwiOk8irb2Icx99Z4WhvblIWOc5zCOrurl0L0H
         SJAGyOLo+NWGyyBzMDjLGUMeJM08pNVBQtUi9VpPgg8WK1VrpJDfay77ln7BBpimFq/7
         hCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ip23Q/fmH9GkZLli1PvyNY1tJYowB5KnpO5h7I2g+T8=;
        b=r/4oaSgkXdEAhq6qrp+tzRkaoqZE6oOGVrpCademVg34GY8vtVqbJTl0F8ieTLAsQz
         Fhp7qKmwjQGIONMR5kL0TFyLJoahk1Ewyg1BV+KjtiS20S+EffJ7nbm2BRU59T5AxVNI
         gkwxYx8iA3Mg8rKMHUieHsTy5XC3dVDVCIQJ99eJKBFZnAmsF6sWGRyGT6fyEyY4Muav
         DYo/wU+giBjPUpHhTT6/GQiK6Ahlj98yvy7UGMLBQmSSULf2OgClM95RrNBL+Qw/uk68
         LMJ7tMCXL4RWD+9SPwcKHNfUCkONhgVtJn3n6HRchVqo9TG39ji93ErOp3sT+X83hX3x
         acGA==
X-Gm-Message-State: ANhLgQ1mSGdJ9f1DmDQ4KSzt3f3Ptfvscfme0ec5SRzpWGxE8bKZVtGf
        SHsy73EU4qVy+yZYzw7lz4nNzw==
X-Google-Smtp-Source: ADFU+vu7GryYNKb43tvvadTPFd4tNQYK1tv0MLcVZ+z57z+2qPdzTSPqxt8vCt8xmtB5WFAiLQ5tnw==
X-Received: by 2002:a37:47d3:: with SMTP id u202mr5383770qka.264.1584556400310;
        Wed, 18 Mar 2020 11:33:20 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a9a9])
        by smtp.gmail.com with ESMTPSA id l16sm5318954qtc.73.2020.03.18.11.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 11:33:19 -0700 (PDT)
Date:   Wed, 18 Mar 2020 14:33:18 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v3 4/9] mm/swapcache: support to handle the value in
 swapcache
Message-ID: <20200318183318.GD154135@cmpxchg.org>
References: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584423717-3440-5-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584423717-3440-5-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 02:41:52PM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Swapcache doesn't handle the value since there is no case using the value.
> In the following patch, workingset detection for anonymous page will be
> implemented and it stores the value into the swapcache. So, we need to
> handle it and this patch implement handling.

"value" is too generic, it's not quite clear what this refers to
here. "Exceptional entries" or "shadow entries" would be better.

> @@ -155,24 +163,33 @@ int add_to_swap_cache(struct page *page, swp_entry_t entry, gfp_t gfp)
>   * This must be called only on pages that have
>   * been verified to be in the swap cache.
>   */
> -void __delete_from_swap_cache(struct page *page, swp_entry_t entry)
> +void __delete_from_swap_cache(struct page *page,
> +			swp_entry_t entry, void *shadow)
>  {
>  	struct address_space *address_space = swap_address_space(entry);
>  	int i, nr = hpage_nr_pages(page);
>  	pgoff_t idx = swp_offset(entry);
>  	XA_STATE(xas, &address_space->i_pages, idx);
>  
> +	/* Do not apply workingset detection for the hugh page */
> +	if (nr > 1)
> +		shadow = NULL;

Hm, why is that? Should that be an XXX/TODO item? The comment should
explain the reason, not necessarily what the code is doing.

Also, s/hugh/huge/

The rest of the patch looks straight-forward to me.
