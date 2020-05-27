Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4577C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4988207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="SQkna51R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388623AbgE0NoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387581AbgE0Nn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:43:59 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EEEC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 06:43:59 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id dh1so11109785qvb.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 06:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IO5JhFmIPCTYFLrUzI9rZeUIf5+8TuwzK/GlIcJJS98=;
        b=SQkna51R7cwNgROOrm1TMMvR+y+K6+JlvOcSNGkgvqFFTS/q8pcYbviD2+iO5Zhbuq
         5XwtvcvruQ8GBv556BflApV3T8mCgB6Rat4ZU2uqQJ9r/S3bM+VZF8qr/sb4qX3CkPsL
         HgudQQSThhK9w3iyn1NgPzErW7bOz5mFbHc0sg1kv1JBxbEr7T2RmJ0t7GKFxx19Peit
         E8GEjlGS+eAInm90g7ZO3RLKXwedXBBTcZvbt8HLfoaaHmkfIfxrJnEkhy1U2JOAAlm+
         4tyhf5LBv29vAaqjvJC4Ma09l8IZh5qRD/bme174FEwtHgJHoJ7xThl8x6uTHUxILDN/
         B9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IO5JhFmIPCTYFLrUzI9rZeUIf5+8TuwzK/GlIcJJS98=;
        b=Z+O02mFfaLEs5onvFO8qPx3C9N/0CoqMy392ZjZamDKFndvsHdkqVhqZ8uDaBlQFd5
         /PPbQKKr3slnMWIr6NQNq24YK1aEhmgFKfmhY8kCuIB765v8JDF8Y6MBjEpcSSUyAyyv
         l08XxxeBWra6EsFpDOvLs+az0Z1eqaPlU9Ye+wv24QrhVYRhu9VlMA5imMfbwKON0fsx
         t/7bS4eix3qlYjnslfxa3yYz3hLzs2VZeB6eApBJU+rQA6CVot7DQ+hT2bWnXCTfQuaX
         rdpUHh1FvxQkjgUQ4CLrZppolN6raVyxtuIOmXWwrbZHdV8XuuOthPv/A77qXT9lbM/j
         BK4A==
X-Gm-Message-State: AOAM530MdOvQ7wONj+zWhhgeZStPnHOGLNWgGs6TiJd6UvDpYOtuLH66
        E82Pq8FkQW19IzwHYJRsP+Kd0g==
X-Google-Smtp-Source: ABdhPJx6REUHl/zGkCE1Q/7yFh4jvtGaH1lpWxAb8Ty6lkqqea1s81qP1qKnsPDFktJE1n0Mq5zjEA==
X-Received: by 2002:a0c:b492:: with SMTP id c18mr25889059qve.139.1590587038483;
        Wed, 27 May 2020 06:43:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:8a69])
        by smtp.gmail.com with ESMTPSA id g13sm2152129qki.95.2020.05.27.06.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 06:43:57 -0700 (PDT)
Date:   Wed, 27 May 2020 09:43:33 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH 05/14] mm: workingset: let cache workingset challenge anon
Message-ID: <20200527134333.GF6781@cmpxchg.org>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
 <20200520232525.798933-6-hannes@cmpxchg.org>
 <CAAmzW4MMLw=4BHRtt=g8BHpQLTaSmhG03Ct6WMjmDxVnOkNQYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAmzW4MMLw=4BHRtt=g8BHpQLTaSmhG03Ct6WMjmDxVnOkNQYA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 11:06:47AM +0900, Joonsoo Kim wrote:
> 2020년 5월 21일 (목) 오전 8:26, Johannes Weiner <hannes@cmpxchg.org>님이 작성:
> >
> > We activate cache refaults with reuse distances in pages smaller than
> > the size of the total cache. This allows new pages with competitive
> > access frequencies to establish themselves, as well as challenge and
> > potentially displace pages on the active list that have gone cold.
> >
> > However, that assumes that active cache can only replace other active
> > cache in a competition for the hottest memory. This is not a great
> > default assumption. The page cache might be thrashing while there are
> > enough completely cold and unused anonymous pages sitting around that
> > we'd only have to write to swap once to stop all IO from the cache.
> >
> > Activate cache refaults when their reuse distance in pages is smaller
> > than the total userspace workingset, including anonymous pages.
> 
> Hmm... I'm not sure the correctness of this change.
> 
> IIUC, this patch leads to more activations in the file list and more activations
> here will challenge the anon list since rotation ratio for the file
> list will be increased.

Yes.

> However, this change breaks active/inactive concept of the file list.
> active/inactive
> separation is implemented by in-list refault distance. anon list size has
> no direct connection with refault distance of the file list so using
> anon list size
> to detect workingset for file page breaks the concept.

This is intentional, because there IS a connection: they both take up
space in RAM, and they both cost IO to bring back once reclaimed.

When file is refaulting, it means we need to make more space for
cache. That space can come from stale active file pages. But what if
active cache is all hot, and meanwhile there are cold anon pages that
we could swap out once and then serve everything from RAM?

When file is refaulting, we should find the coldest data that is
taking up RAM and kick it out. It doesn't matter whether it's file or
anon: the goal is to free up RAM with the least amount of IO risk.

Remember that the file/anon split, and the inactive/active split, are
there to optimize reclaim. It doesn't mean that these memory pools are
independent from each other.

The file list is split in two because of use-once cache. The anon and
file lists are split because of different IO patterns, because we may
not have swap etc. But once we are out of use-once cache, have swap
space available, and have corrected for the different cost of IO,
there needs to be a relative order between all pages in the system to
find the optimal candidates to reclaim.

> My suspicion is started by this counter example.
> 
> Environment:
> anon: 500 MB (so hot) / 500 MB (so hot)
> file: 50 MB (hot) / 50 MB (cold)
> 
> Think about the situation that there is periodical access to other file (100 MB)
> with low frequency (refault distance is 500 MB)
> 
> Without your change, this periodical access doesn't make thrashing for cached
> active file page since refault distance of periodical access is larger
> than the size of
> the active file list. However, with your change, it causes thrashing
> on the file list.

It doesn't cause thrashing. It causes scanning because that 100M file
IS thrashing: with or without my patch, that refault IO is occuring.

What this patch acknowledges is that the 100M file COULD fit fully
into memory, and not require any IO to serve, IFF 100M of the active
file or anon pages were cold and could be reclaimed or swapped out.

In your example, the anon set is hot. We'll scan it slowly (at the
rate of IO from the other file) and rotate the pages that are in use -
which would be all of them. Likewise for the file - there will be some
deactivations, but mark_page_accessed() or the second chance algorithm
in page_check_references() for mapped will keep the hottest pages active.

In a slightly modified example, 400M of the anon set is hot and 100M
cold. Without my patch, we would never look for them and the second
file would be IO-bound forever. After my patch, we would scan anon,
eventually find the cold pages, swap them out, and then serve the
entire workingset from memory.

Does it cause more scanning than before in your scenario? Yes, but we
don't even know it's your scenario instead of mine until we actually
sample references of all memory. Not scanning is a false stable state.

And your scenario could easily change over time. Even if the amount of
repeatedly accessed pages stays larger than memory, and will always
require IO to serve, the relative access frequencies could change.
Some pages could become hotter, others colder. Without scanning, we
wouldn't adapt the LRU ordering and cause more IO than necessary.
