Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B9BC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E0F2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="RiLItl+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgCRRv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:51:59 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46251 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCRRv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:51:59 -0400
Received: by mail-qk1-f193.google.com with SMTP id f28so40238347qkk.13
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W0JooyDRbeGuBMVupYbPukHqUszgISMZep91jqIkGUg=;
        b=RiLItl+HDnetbMERCcyRE4Cf16LHcogEpuj7cCaKCEJMbom3dVu9e4Gr3gvq/AKAFP
         LpT6ZDCJcOxBhjgTo+vwbryV9IyK2BrwA7iOSVlxZgj3uJaZ65OizOG8kV6ZPAFyq5X+
         0MrF+eR81QFiDC3UoVrdjeXZy52CQVhbYmaK0KBbMYtGroUNVZFjw12fQFr65YO2FUt4
         tMeF8JdMt6Hna8ZxGesj+2et+M3jmmbIUOrhkbZaKz1pazB0x10KJ7kN69meyMzKaO1B
         ku+yTYyPYMBFbbToOb6Dy7Ld0u0eZLdJ0qICLpayJU0ZvW37f1eusCWefuOzlFu7A3A9
         G38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W0JooyDRbeGuBMVupYbPukHqUszgISMZep91jqIkGUg=;
        b=hVSn61y8jACK8TJt7ARRakqFDN9TN7f5BXKDr2PhHEx7bhIYm+7yg6GOqRIfUhDn5U
         +VjIDmVSQkHKJTv5Cm9Qfx0jcNV7QjK/PJxjYyn+dfi4jcm5f54qzjtBmzHTzrFqvwQ2
         l+yTKip+Sk+Cdm170BQACl7T8M/8OT/dGr87UX+81h7IOYPsPiztXNXGjaja7MxZkLgX
         FhpdPA5v80w/Y823Gg89Q0Mu1QuFrVJgrJC1+ZF2ve5LzZXU5KystVLXn0ke0j0rsqOT
         uhFTDTwkGVU9YN15O6bYffrW0Xp3CoyLT8N/+UqBp1EuFEedXzNJ1dW7ptQ+asQbOpTt
         zU5w==
X-Gm-Message-State: ANhLgQ2fdPQxIBhMWMURoOzCqWkzitDLl9Hml0i2893QYJzgHBtbFKe6
        wd4YdrCeUxUsET2UxBy3c4yBIg==
X-Google-Smtp-Source: ADFU+vuaYpWrKiiQHqsdsWhN2g1kXkYNMhE/rdbZb3HSZq9R1i8+WtDZrQ8gVJFOvNNKhoNRm8hHfQ==
X-Received: by 2002:a05:620a:146f:: with SMTP id j15mr5073420qkl.443.1584553918172;
        Wed, 18 Mar 2020 10:51:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a9a9])
        by smtp.gmail.com with ESMTPSA id c12sm5317604qtb.49.2020.03.18.10.51.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:51:57 -0700 (PDT)
Date:   Wed, 18 Mar 2020 13:51:55 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v3 2/9] mm/vmscan: protect the workingset on anonymous LRU
Message-ID: <20200318175155.GB154135@cmpxchg.org>
References: <1584423717-3440-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584423717-3440-3-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584423717-3440-3-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 02:41:50PM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> In current implementation, newly created or swap-in anonymous page
> is started on active list. Growing active list results in rebalancing
> active/inactive list so old pages on active list are demoted to inactive
> list. Hence, the page on active list isn't protected at all.
> 
> Following is an example of this situation.
> 
> Assume that 50 hot pages on active list. Numbers denote the number of
> pages on active/inactive list (active | inactive).
> 
> 1. 50 hot pages on active list
> 50(h) | 0
> 
> 2. workload: 50 newly created (used-once) pages
> 50(uo) | 50(h)
> 
> 3. workload: another 50 newly created (used-once) pages
> 50(uo) | 50(uo), swap-out 50(h)
> 
> This patch tries to fix this issue.
> Like as file LRU, newly created or swap-in anonymous pages will be
> inserted to the inactive list. They are promoted to active list if
> enough reference happens. This simple modification changes the above
> example as following.
> 
> 1. 50 hot pages on active list
> 50(h) | 0
> 
> 2. workload: 50 newly created (used-once) pages
> 50(h) | 50(uo)
> 
> 3. workload: another 50 newly created (used-once) pages
> 50(h) | 50(uo), swap-out 50(uo)
> 
> As you can see, hot pages on active list would be protected.
> 
> Note that, this implementation has a drawback that the page cannot
> be promoted and will be swapped-out if re-access interval is greater than
> the size of inactive list but less than the size of total(active+inactive).
> To solve this potential issue, following patch will apply workingset
> detection that is applied to file LRU some day before.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> -void lru_cache_add_active_or_unevictable(struct page *page,
> +void lru_cache_add_inactive_or_unevictable(struct page *page,
>  					 struct vm_area_struct *vma)
>  {
> +	bool evictable;
> +
>  	VM_BUG_ON_PAGE(PageLRU(page), page);
>  
> -	if (likely((vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) != VM_LOCKED))
> -		SetPageActive(page);
> -	else if (!TestSetPageMlocked(page)) {
> +	evictable = (vma->vm_flags & (VM_LOCKED | VM_SPECIAL)) != VM_LOCKED;
> +	if (!evictable && !TestSetPageMlocked(page)) {

Minor point, but in case there is a v4: `unevictable` instead of
!evictable would be a bit easier to read, match the function name,
PageUnevictable etc.
