Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78ADEC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54FB020CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583222990;
	bh=TNa7U/ItCOtHe8fdWbXp9SzpzlayoeF8TIag3zlUzAg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2aypWa+V8akD0DL7/fT3RS512zalM9nqXIQGnhF38xbQXYKYtxvZ4tsO0vZJXYo1h
	 TV/CKbL9E3gIX1XNQxFpb0hELp+FjK1OvzteQCLromxW443xLCBIonCcEe7qmgZz28
	 D8MVAHa019W2sqWzv8llsI6o6Ys5fjhdLnQ89Q30=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgCCIJt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:09:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43992 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgCCIJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:09:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id h9so2144223wrr.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 00:09:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1rZb3JfiJUNf5SBeSXRzrX8hWQKOCLyxoGXM0AHXnvQ=;
        b=HfpAoJwA+5LhBLbEdeGePnKn31zXDDrl99DerIi8DFX/pbVgH0u3lo/9qG9btIphEf
         YNe9IM4222TSKmxmR9p3XzF+F3VZXYe/UYqEzMDEsnUoUJ71FgKFrr9xSYytnJiRrwR6
         CNoHEM2CzsA9WklZE0aITJfpzoxz2D18MpGCto0uMKmU7nL3H2KXFfsL7NJGtwNMMMq1
         7e7qNAEDBJBTP7NVeQxZVWNE+60xUsIYFQ0oTQbxjdOT4lEeWmJ3zibaPgHob/TVPghS
         PSLz2Ra1mhKguSyeoxIFq0sY8AhijQQi2nSepcoCv8ns+E0m4KW/wz7yXqylwpgxwU5B
         zhoQ==
X-Gm-Message-State: ANhLgQ30Q4uBRzwn5GfbHFN2YRADM9d0oebXyMBtfVCWsOL52hDUMFwQ
        dnH1H3Hd7yfVL3HXrnJr8zM=
X-Google-Smtp-Source: ADFU+vteu5G2rX7KcA5JXwBEO5CYyBnhqS00yIwSpMnE1zL4SniK4s+xJ33pjF7gp/5ZjrcT9BuaYw==
X-Received: by 2002:a5d:608e:: with SMTP id w14mr4420860wrt.201.1583222986799;
        Tue, 03 Mar 2020 00:09:46 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id j66sm2752586wmb.21.2020.03.03.00.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 00:09:46 -0800 (PST)
Date:   Tue, 3 Mar 2020 09:09:45 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Mel Gorman <mgorman@suse.de>, David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC 0/3] mm: Discard lazily freed pages when migrating
Message-ID: <20200303080945.GX4380@dhcp22.suse.cz>
References: <20200228033819.3857058-1-ying.huang@intel.com>
 <20200228034248.GE29971@bombadil.infradead.org>
 <87a7538977.fsf@yhuang-dev.intel.com>
 <edae2736-3239-0bdc-499c-560fc234c974@redhat.com>
 <871rqf850z.fsf@yhuang-dev.intel.com>
 <20200228094954.GB3772@suse.de>
 <87h7z76lwf.fsf@yhuang-dev.intel.com>
 <20200302151607.GC3772@suse.de>
 <87zhcy5hoj.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zhcy5hoj.fsf@yhuang-dev.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 03-03-20 09:51:56, Huang, Ying wrote:
> Mel Gorman <mgorman@suse.de> writes:
> > On Mon, Mar 02, 2020 at 07:23:12PM +0800, Huang, Ying wrote:
> >> If some applications cannot tolerate the latency incurred by the memory
> >> allocation and zeroing.  Then we cannot discard instead of migrate
> >> always.  While in some situations, less memory pressure can help.  So
> >> it's better to let the administrator and the application choose the
> >> right behavior in the specific situation?
> >> 
> >
> > Is there an application you have in mind that benefits from discarding
> > MADV_FREE pages instead of migrating them?
> >
> > Allowing the administrator or application to tune this would be very
> > problematic. An application would require an update to the system call
> > to take advantage of it and then detect if the running kernel supports
> > it. An administrator would have to detect that MADV_FREE pages are being
> > prematurely discarded leading to a slowdown and that is hard to detect.
> > It could be inferred from monitoring compaction stats and checking
> > if compaction activity is correlated with higher minor faults in the
> > target application. Proving the correlation would require using the perf
> > software event PERF_COUNT_SW_PAGE_FAULTS_MIN and matching the addresses
> > to MADV_FREE regions that were freed prematurely. That is not an obvious
> > debugging step to take when an application detects latency spikes.
> >
> > Now, you could add a counter specifically for MADV_FREE pages freed for
> > reasons other than memory pressure and hope the administrator knows about
> > the counter and what it means. That type of knowledge could take a long
> > time to spread so it's really very important that there is evidence of
> > an application that suffers due to the current MADV_FREE and migration
> > behaviour.
> 
> OK.  I understand that this patchset isn't a universal win, so we need
> some way to justify it.  I will try to find some application for that.
> 
> Another thought, as proposed by David Hildenbrand, it's may be a
> universal win to discard clean MADV_FREE pages when migrating if there are
> already memory pressure on the target node.  For example, if the free
> memory on the target node is lower than high watermark?

This is already happening because if the target node is short on memory
it will start to reclaim and if MADV_FREE pages are at the tail of
inactive file LRU list then they will be dropped. Please note how that
follows proper aging and doesn't introduce any special casing. Really
MADV_FREE is an inactive cache for anonymous memory and we treat it like
inactive page cache. This is not carved in stone of course but it really
requires very good justification to change.
-- 
Michal Hocko
SUSE Labs
