Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A19C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04D4520759
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="H8C2nuNu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGQN7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbgGQN7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:59:44 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09565C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:59:44 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id e11so8800535qkm.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 06:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZD6pIPqGBsKJeMez/CHitdzBvjnLslWeJDCJg3q41cA=;
        b=H8C2nuNu+fhYO+A4K5s1D/iEGVIKweceHCtMuvmqcBkq05dtoxz2N4nzH73COlYnoM
         r7lJSyA3zQcY2WjTUeeVPXUlS2ptEov54lQAAw+C5qtp918AY/4Notio80aPWY1ow6sv
         vwJ64KrHuPZ3yetcl9dMklp6MRIMAH9quuheMvSI4fFvsC0/dRckj4nV33j4HET75nTo
         uAg/mvqHj6WzFmUo+InhoweVz6Le6wlehnVCxFHb2hoIV/QBkKXJoqOwW2Zg1T4E7ZDg
         dPLaOd5fuFEyoIWWZi4TnOzlaqn3TQM20i0HR5b+iH8uaHdMUj2xpMeFeiXV95GPD6KG
         Tq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZD6pIPqGBsKJeMez/CHitdzBvjnLslWeJDCJg3q41cA=;
        b=OPRdWXqSwbdxX39vAKexfZqxM1/1+nepZ3essFG5uTZwqBB6GwLY7eXeUri16Cjsmw
         Xfo399MJFBr63WMDyR/UkKmOTHkmNyg/nN3rDDucR/6WhUeSJ0R85fel8JMoFzWY46RD
         yy6AI42JtZQ36tPLCVV4LoIHRvVi3JPqUBWDw1MJvqFw4OqPZ153offIZ1Fa2Os+HDsJ
         So9toKEQSdWWNWBTJNsqFp+ATKDzn5IABroT1xzRHKKVkX7I7L3BMOHjkV8heQFIbik2
         gcCEBYMUbXlX1174KrLPnl8n3U/JBGWVDAaMgVvOutX4O6HTut/GF1lK1FZGlUQvmB6y
         AEMw==
X-Gm-Message-State: AOAM533QB3l8s9WIBXc9SPDi/k9mG0GFagbzuOZT6slPBJUFg4rNFKXn
        lVjmirU6ZSIidnSTCqkMHlGsGw==
X-Google-Smtp-Source: ABdhPJz0V9eHHUMY5YFbDJfGvmKvNCK1ZNR4mKHH5fdHumFTh8NJf1VmxqvMFJRxZC9nkgI0n+IHGg==
X-Received: by 2002:a37:d02:: with SMTP id 2mr8648055qkn.382.1594994383213;
        Fri, 17 Jul 2020 06:59:43 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:be7d])
        by smtp.gmail.com with ESMTPSA id z187sm9788095qkb.102.2020.07.17.06.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 06:59:42 -0700 (PDT)
Date:   Fri, 17 Jul 2020 09:58:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v6 2/6] mm/vmscan: protect the workingset on anonymous LRU
Message-ID: <20200717135849.GA265107@cmpxchg.org>
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592371583-30672-3-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592371583-30672-3-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 02:26:19PM +0900, js1304@gmail.com wrote:
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
> v6: Before this patch, all anon pages (inactive + active) are considered
> as workingset. However, with this patch, only active pages are considered
> as workingset. So, file refault formula which uses the number of all
> anon pages is changed to use only the number of active anon pages.

I can see that also from the code, but it doesn't explain why.

And I'm not sure this is correct. I can see two problems with it.

After your patch series, there is still one difference between anon
and file: cache trim mode. If the "use-once" anon dominate most of
memory and you have a small set of heavily thrashing files, it would
not get recognized. File refaults *have* to compare their distance to
the *entire* anon set, or we could get trapped in cache trimming mode
even as file pages with access frequencies <= RAM are thrashing.

On the anon side, there is no cache trimming mode. But even if we're
not in cache trimming mode and active file is already being reclaimed,
we have to recognize thrashing on the anon side when reuse frequencies
are within available RAM. Otherwise we treat an inactive file that is
not being reused as having the same value as an anon page that is
being reused. And then we may reclaim file and anon at the same rate
even as anon is thrashing and file is not. That's not right.

We need to activate everything with a reuse frequency <= RAM. Reuse
frequency is refault distance plus size of the inactive list the page
was on. This means anon distances should be compared to active anon +
inactive file + active file, and file distances should be compared to
active file + inactive_anon + active anon.

workingset_size should basically always be everything except the
inactive list the page is refaulting from as that represents the delta
between total RAM and the amount of space this page had available.
