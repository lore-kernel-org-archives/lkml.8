Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F4F4C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 00:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AAF020748
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 00:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgDYAc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 20:32:26 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49886 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgDYAc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 20:32:26 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03P0WAqF060160;
        Sat, 25 Apr 2020 09:32:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp);
 Sat, 25 Apr 2020 09:32:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03P0W4sI060047
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 25 Apr 2020 09:32:10 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Subject: Re: [patch] mm, oom: stop reclaiming if GFP_ATOMIC will start failing
 soon
To:     David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <6ed3e585-394a-42ff-03c4-a9bb8b5fcbc4@I-love.SAKURA.ne.jp>
Date:   Sat, 25 Apr 2020 09:32:02 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/04/25 5:48, David Rientjes wrote:
> @@ -4372,11 +4372,21 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
>  					ac->nodemask) {
>  		unsigned long available;
>  		unsigned long reclaimable;
> +		unsigned long free;
>  		unsigned long min_wmark = min_wmark_pages(zone);
>  		bool wmark;
>  
> +		free = zone_page_state_snapshot(zone, NR_FREE_PAGES);
> +		/*
> +		 * If this zone is approaching the point where even order-0
> +		 * GFP_ATOMIC allocations will fail, stop considering reclaim.
> +		 */
> +		if (!__zone_watermark_ok(zone, 0, min_wmark, ac_classzone_idx(ac),
> +					 alloc_flags | ALLOC_HIGH, free))
> +			continue;

This is to trigger the OOM killer more aggressively, isn't it? But where is the
guarantee that this is an allocation request which can trigger the OOM killer?
If this is an allocation request which cannot trigger the OOM killer, wouldn't
this cause premature allocation failures?

> +
>  		available = reclaimable = zone_reclaimable_pages(zone);
> -		available += zone_page_state_snapshot(zone, NR_FREE_PAGES);
> +		available += free;
>  
>  		/*
>  		 * Would the allocation succeed if we reclaimed all
> 

