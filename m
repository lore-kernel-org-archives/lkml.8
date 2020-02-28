Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70278C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FF5246AF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 13:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="XCmbk+bF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgB1NpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 08:45:17 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:34910 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgB1NpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 08:45:13 -0500
Received: by mail-qv1-f65.google.com with SMTP id u10so1343341qvi.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 05:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ydjq0Koyntqo52xeAXVHWKMN25S8+wwGUlWGgrhmkBA=;
        b=XCmbk+bFS3IbRMVKI/DATWBXdwFkchlG2otk4H7BV9o2orwGtCPM5bbwViBo8R2/0C
         4a5n7SAnutnE/wyAWfpmXWaDJUx6ax+HKCoYVQiLibgxiyQIej7DY12bIKygDSz7Z9Gs
         iTd5RT7yY6awOnVofYncgyCuI/02tqhLFJugL6o/xKkBjc61efeBtuMyf23QWqVH+17G
         5L/zdKZvUbKyNnK+ntGzggKtXVpXndYniPYkqeYxYztfY9m4a5GTWOaAIXGPPzSclVQI
         zjb5MPJJg+T4s4Kn4Av28+MQDDjB53p8qaNkvAS2+2BS4LTgy1L1yYsQruLryX8yywyz
         BaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ydjq0Koyntqo52xeAXVHWKMN25S8+wwGUlWGgrhmkBA=;
        b=XiOQ+JebsMXSN/emwI0qz81NEDRh/QuBCtI+hCBZp2+xcGLK8ftubTjuJ+vFa+vSEM
         ourtMeITjxUkV/GPOMunSpvtI+p7qodYVWgoi3JraAGL5kA2rjNsC2mDyPkMrD5BtFgT
         e+de2mCDJAPDbG0P1RMMYu4jQcuYRu/hnKdOCWg9Hi4Beg6s6F155fgMppHat7EMrnGL
         mfhFRdis4fkFacXhq98dJHEjoToB7pZTjxOahQef1gtqNhNQkR20P9Ov/g5kYz9AY177
         0l3qmxZIHmLOhMTMJhQCUpOh79slKwwk3uK0BejUIcrQSecqiM+fwMnojvBx3Fheyp49
         xTUw==
X-Gm-Message-State: APjAAAXoq1pABoKQlu3zYep2zR/tu87H4FRhVDikCPNR+QAAme8PWxdn
        +qR0WlWtDP9vwt8tVjXWERVCSQ==
X-Google-Smtp-Source: APXvYqy6fbwDdwdZT15xjTyr/jtAKIp4iS/ZqDTyDs9Xx11Pzgu0lNsILkJDk1dW5b5CiD0scTq61w==
X-Received: by 2002:a0c:e4cc:: with SMTP id g12mr3747707qvm.237.1582897511845;
        Fri, 28 Feb 2020 05:45:11 -0800 (PST)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id m11sm2010361qkh.31.2020.02.28.05.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 05:45:11 -0800 (PST)
Date:   Fri, 28 Feb 2020 08:45:10 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [RFC 0/3] mm: Discard lazily freed pages when migrating
Message-ID: <20200228134510.GA50843@cmpxchg.org>
References: <20200228033819.3857058-1-ying.huang@intel.com>
 <20200228034248.GE29971@bombadil.infradead.org>
 <87a7538977.fsf@yhuang-dev.intel.com>
 <edae2736-3239-0bdc-499c-560fc234c974@redhat.com>
 <871rqf850z.fsf@yhuang-dev.intel.com>
 <20200228095048.GK3771@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228095048.GK3771@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 10:50:48AM +0100, Michal Hocko wrote:
> On Fri 28-02-20 16:55:40, Huang, Ying wrote:
> > David Hildenbrand <david@redhat.com> writes:
> [...]
> > > E.g., free page reporting in QEMU wants to use MADV_FREE. The guest will
> > > report currently free pages to the hypervisor, which will MADV_FREE the
> > > reported memory. As long as there is no memory pressure, there is no
> > > need to actually free the pages. Once the guest reuses such a page, it
> > > could happen that there is still the old page and pulling in in a fresh
> > > (zeroed) page can be avoided.
> > >
> > > AFAIKs, after your change, we would get more pages discarded from our
> > > guest, resulting in more fresh (zeroed) pages having to be pulled in
> > > when a guest touches a reported free page again. But OTOH, page
> > > migration is speed up (avoiding to migrate these pages).
> > 
> > Let's look at this problem in another perspective.  To migrate the
> > MADV_FREE pages of the QEMU process from the node A to the node B, we
> > need to free the original pages in the node A, and (maybe) allocate the
> > same number of pages in the node B.  So the question becomes
> > 
> > - we may need to allocate some pages in the node B
> > - these pages may be accessed by the application or not
> > - we should allocate all these pages in advance or allocate them lazily
> >   when they are accessed.
> > 
> > We thought the common philosophy in Linux kernel is to allocate lazily.
> 
> The common philosophy is to cache as much as possible. And MADV_FREE
> pages are a kind of cache as well. If the target node is short on memory
> then those will be reclaimed as a cache so a pro-active freeing sounds
> counter productive as you do not have any idea whether that cache is
> going to be used in future. In other words you are not going to free a
> clean page cache if you want to use that memory as a migration target
> right? So you should make a clear case about why MADV_FREE cache is less
> important than the clean page cache and ideally have a good
> justification backed by real workloads.

Agreed.

MADV_FREE says that the *data* in the pages is no longer needed, and
so the pages are cheaper to reclaim than regular anon pages (swap).

But people use MADV_FREE in the hope that they can reuse the pages at
a later point - otherwise, they'd unmap them. We should retain them
until the memory is actively needed for other allocations.
