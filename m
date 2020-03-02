Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57202C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29EDF214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583159155;
	bh=TIo+veEs16hslvlH82AiTf1xcl3jofNIs60au7Ay0M0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TbAqulXGBBTvtLoojMUlDE2sHOa4I2aGxDSelLaauCFCLhjj2/PoPw7yOVTFuHH+3
	 b6+AZI7/Ec9oG+lcxbmFdmtgC12j12qHYXRThymbg/K1jdcr5N5Jf8sHUkiJK6Nse4
	 tvg3EPWz29i6iDIbVuv8PokhKOXMXMKxxqU45a7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgCBOZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:25:54 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:46326 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727306AbgCBOZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:25:53 -0500
Received: by mail-wr1-f48.google.com with SMTP id j7so12749099wrp.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 06:25:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=91i00x+r3ObU17/Jn02LmIVt8253x20peMqSjQ89ikI=;
        b=uP9ETzMp5LSht6suRXGaPQBDmuKMfa42FlUlgv2DAi77X5ZjtiQ9/mE3L+YAhpKJx8
         fh+TgBtTR9xv5GVWSZSb04hVxppKC8sa+nwhGRldsO3Wb7piMkfRqC3g1FjBDN6IDezT
         1Q+f4K6/HGKVfZfu+mtWa8U8ZFTVk8QCD6XptNDjNZ8XbAaLuVfsWtlvYWrFDCRS/pcY
         YEN2XQ/Z8YmCQQuWPgtybiFlVB3/M1JQ0r+qEArlT83AU1C3q6BJ2YjVCf1y0FcuCEfc
         hBBxMvHFciJ89p92YvfHqc0KhAqNh3XV7YpxHg4iO5/kfRUqofFqmCpqKrkPgxWXGHss
         RAug==
X-Gm-Message-State: APjAAAXN0Y83Ai6f84GCScSFYsiuMwOslSJeq2eiEkMoiqFOCK5vv70J
        APcyLg/dKid1QBobmhSpTrQ=
X-Google-Smtp-Source: APXvYqwdAQL3VnZNwjPeETAbUL+bLXtL8v4BUHFJcIm/NTpDVwnZDrNB/j65t032OBVc8SsE4bQMYg==
X-Received: by 2002:a5d:5286:: with SMTP id c6mr16208977wrv.418.1583159151203;
        Mon, 02 Mar 2020 06:25:51 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id q12sm30065989wrg.71.2020.03.02.06.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 06:25:50 -0800 (PST)
Date:   Mon, 2 Mar 2020 15:25:49 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC 0/3] mm: Discard lazily freed pages when migrating
Message-ID: <20200302142549.GO4380@dhcp22.suse.cz>
References: <20200228033819.3857058-1-ying.huang@intel.com>
 <20200228034248.GE29971@bombadil.infradead.org>
 <87a7538977.fsf@yhuang-dev.intel.com>
 <edae2736-3239-0bdc-499c-560fc234c974@redhat.com>
 <871rqf850z.fsf@yhuang-dev.intel.com>
 <20200228095048.GK3771@dhcp22.suse.cz>
 <87d09u7sm2.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d09u7sm2.fsf@yhuang-dev.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 02-03-20 22:12:53, Huang, Ying wrote:
> Michal Hocko <mhocko@kernel.org> writes:
[...]
> > And MADV_FREE pages are a kind of cache as well. If the target node is
> > short on memory then those will be reclaimed as a cache so a
> > pro-active freeing sounds counter productive as you do not have any
> > idea whether that cache is going to be used in future. In other words
> > you are not going to free a clean page cache if you want to use that
> > memory as a migration target right? So you should make a clear case
> > about why MADV_FREE cache is less important than the clean page cache
> > and ideally have a good justification backed by real workloads.
> 
> Clean page cache still have valid contents, while clean MADV_FREE pages
> has no valid contents.  So penalty of discarding the clean page cache is
> reading from disk, while the penalty of discarding clean MADV_FREE pages
> is just page allocation and zeroing.

And "just page allocation and zeroing" overhead is the primary
motivation to keep the page in memory. It is a decision of the workload
to use MADV_FREE because chances are that this will speed things up. All
that with a contract that the memory goes away under memory pressure so
with a good workload/memory sizing you do not really lose that
optimization. Now you want to make decision on behalf of the consumer of
the MADV_FREE memory.

> I understand that MADV_FREE is another kind of cache and has its value.
> But in the original implementation, during migration, we have already
> freed the original "cache", then reallocate the cache elsewhere and
> copy.  This appears more like all pages are populated in mmap() always.
> I know there's value to populate all pages in mmap(), but does that need
> to be done always by default?

It is not. You have to explicitly request MAP_POPULATE to initialize
mmap.

-- 
Michal Hocko
SUSE Labs
