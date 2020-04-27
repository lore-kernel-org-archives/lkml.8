Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9364FC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 03:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685B4206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 03:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sSo3NCPa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgD0DNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 23:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725788AbgD0DNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 23:13:00 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62141C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 20:13:00 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id z1so6594403pfn.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 20:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=SCfzkhntNmlfJ3/9dHC8fKSHMv9iuHlVHfaxqt9T00M=;
        b=sSo3NCPasVs8bFbG8XtjnczfxwgVESVeNKxhsYIBuPwtdsiMv7YfL2BQHWfEMfp1Ax
         sd8qe1g1Nt1ioonKuXplQOQ/k08Nfk3eJpfzIySYDJ2Lh/QMDXvKWIpgX/6aBDvlui1l
         cprAws5jDVv6FV6uXxFHejSZtW/dLK7CmrRcczzAuIT2FFyAaeD9a/jUav2oZmGeeJJ8
         I/FdzfIYUUy4yy0gy+Xdv24R5P82FR+GsWXZYdvaLORvLLRLsiAJouQ9X1tCMZSywuEa
         p8C0DXzt0aFLuK6ii8VC/K4gnM+UnP/KyDgEwVb2rWOgZT+Cv6XpeCpXpZBkUBnODd67
         NAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=SCfzkhntNmlfJ3/9dHC8fKSHMv9iuHlVHfaxqt9T00M=;
        b=ZBKHw649wJ2hQCszS4rvGOvHSgFMrGgamIhPmVqkL8JvpRL8IwqsPFErVvgmoh86jC
         RSSwWlBCsjCU4k75p5/iFOVkJvvO3xgJXbePKdS2uwCU8TD6YCzo93tAo+Td6WwOgjFh
         iJUjSXmBVvNXLTtlBsDEd3QfF2d9/E50DBtAFPzki5I4ruVZBmFQXE9aPNudtXGOq7ZP
         mtBW7E7WsJ8p8GXa1Bpk3tD4Vpl3GS/js1+gzXY1uT37iqjx0hGE0/oupTIo0pvQeCmj
         cP7fRxjuCkwCrnBzohnViE3/tXuz+KkcdQgHA6/r6XQwquoQhf99xtGICrIDvZ7VREEG
         ZuuA==
X-Gm-Message-State: AGi0Pubv4JTiXnjmiaDM9T3MaUaKXWNxe4/+vGhiOrqgM6Xd12DREQU8
        N/1DposD4G1DO/AYZlgqRN4PNzWuIfo=
X-Google-Smtp-Source: APiQypLO38pS2eEFBwtoKL/D4fMIEtX/1v4RbA1SHFjGz9L9KoMTro5mg74TE5qeFPns3QGoD04euw==
X-Received: by 2002:aa7:9218:: with SMTP id 24mr21685803pfo.312.1587957179430;
        Sun, 26 Apr 2020 20:12:59 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id s44sm10049417pjc.28.2020.04.26.20.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 20:12:58 -0700 (PDT)
Date:   Sun, 26 Apr 2020 20:12:58 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mm, oom: stop reclaiming if GFP_ATOMIC will start failing
 soon
In-Reply-To: <20200425172706.26b5011293e8dc77b1dccaf3@linux-foundation.org>
Message-ID: <alpine.DEB.2.22.394.2004261959310.80211@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com> <20200425172706.26b5011293e8dc77b1dccaf3@linux-foundation.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020, Andrew Morton wrote:

> > If GFP_ATOMIC allocations will start failing soon because the amount of
> > free memory is substantially under per-zone min watermarks, it is better
> > to oom kill a process rather than continue to reclaim.
> > 
> > This intends to significantly reduce the number of page allocation
> > failures that are encountered when the demands of user and atomic
> > allocations overwhelm the ability of reclaim to keep up.  We can see this
> > with a high ingress of networking traffic where memory allocated in irq
> > context can overwhelm the ability to reclaim fast enough such that user
> > memory consistently loops.  In that case, we have reclaimable memory, and
> 
> "user memory allocation", I assume?  Or maybe "blockable memory
> allocatoins".
> 

"user memory allocations consistently loop", yeah.  Thanks.

> > reclaiming is successful, but we've fully depleted memory reserves that
> > are allowed for non-blockable allocations.
> > 
> > Commit 400e22499dd9 ("mm: don't warn about allocations which stall for
> > too long") removed evidence of user allocations stalling because of this,
> > but the situation can apply anytime we get "page allocation failures"
> > where reclaim is happening but per-zone min watermarks are starved:
> > 
> > Node 0 Normal free:87356kB min:221984kB low:416984kB high:611984kB active_anon:123009936kB inactive_anon:67647652kB active_file:429612kB inactive_file:209980kB unevictable:112348kB writepending:260kB present:198180864kB managed:195027624kB mlocked:81756kB kernel_stack:24040kB pagetables:11460kB bounce:0kB free_pcp:940kB local_pcp:96kB free_cma:0kB
> > lowmem_reserve[]: 0 0 0 0
> > Node 1 Normal free:105616kB min:225568kB low:423716kB high:621864kB active_anon:122124196kB inactive_anon:74112696kB active_file:39172kB inactive_file:103696kB unevictable:204480kB writepending:180kB present:201326592kB managed:198174372kB mlocked:204480kB kernel_stack:11328kB pagetables:3680kB bounce:0kB free_pcp:1140kB local_pcp:0kB free_cma:0kB
> > lowmem_reserve[]: 0 0 0 0
> > 
> > Without this patch, there is no guarantee that user memory allocations
> > will ever be successful when non-blockable allocations overwhelm the
> > ability to get above per-zone min watermarks.
> > 
> > This doesn't solve page allocation failures entirely since it's a
> > preemptive measure based on watermarks that requires concurrent blockable
> > allocations to trigger the oom kill.  To complete solve page allocation
> > failures, it would be possible to do the same watermark check for non-
> > blockable allocations and then queue a worker to asynchronously oom kill
> > if it finds watermarks to be sufficiently low as well.
> > 
> 
> Well, what's really going on here?
> 
> Is networking potentially consuming an unbounded amount of memory?  If
> so, then killing a process will just cause networking to consume more
> memory then hit against the same thing.  So presumably the answer is
> "no, the watermarks are inappropriately set for this workload".
> 
> So would it not be sensible to dynamically adjust the watermarks in
> response to this condition?  Maintain a larger pool of memory for these
> allocations?  Or possibly push back on networking and tell it to reduce
> its queue sizes?  So that stuff doesn't keep on getting oom-killed?
> 

No - that would actually make the problem worse.

Today, per-zone min watermarks dictate when user allocations will loop or 
oom kill.  should_reclaim_retry() currently loops if reclaim has succeeded 
in the past few tries and we should be able to allocate if we are able to 
reclaim the amount of memory that we think we can.

The issue is that this supposes that looping to reclaim more will result 
in more free memory.  That doesn't always happen if there are concurrent 
memory allocators.

GFP_ATOMIC allocators can access below these per-zone watermarks.  So the 
issue is that per-zone free pages stays between ALLOC_HIGH watermarks 
(the watermark that GFP_ATOMIC allocators can allocate to) and min 
watermarks.  We never reclaim enough memory to get back to min watermarks 
because reclaim cannot keep up with the amount of GFP_ATOMIC allocations.

In production scnearios, this results in userspace processes going out to 
lunch because they are constantly looping in the page allocator reclaiming 
only for the benefit of GFP_ATOMIC allocations.

In fact, when we hit ALLOC_HIGH watermarks and we start getting "page 
allocation failures" in the kernel log, there is also no guarantee that 
kswapd's reclaim will outpace GFP_ATOMIC allocations.  Thus, an oom kill 
is really the best policy at this point to provide an actual guarantee of 
net positive memory freeing.

This isn't a matter of any specific networking stack; the scope of 
allocations that can trigger this is the set of all GFP_ATOMIC (or 
GFP_MEMALLOC) allocations in the kernel.

Tetsuo: the specific allocation that triggers a page allocation failure is 
not interesting; we have tens of thousands of examples.  Each example is 
simply the unlucky last GFP_ATOMIC allocation that fails; the interesting 
point is the amount of free memory.  In other words, when free memory is 
below ALLOC_HIGH watermarks, we assume that we have depleted memory 
reserves *faster* than when user allocations started to fail.  In the 
interest of userspace being responsive, we should oom kill here.
