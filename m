Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518ADC3F2D3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26B752469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582883454;
	bh=binvWHwgA+8zOc0S3udXLEX2Y/nNftwqmkdTAmgChpc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NNCTCZk/zafXlVstJHnpe9fTnL8ywWW1XJutTRtmHvW4YIcZjR/Wlf4WY/R+Bb0ma
	 Oxbxz809r8Vi1mEwMKj8WP2SbVRUzTYJZ89LbK8F27Q7BuiaeMVYlBM3cdmauGp2Mw
	 iPp0mR+NGCfrMKJZwuWCZjFmExOg4A7I5Y/vmpag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgB1Jux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:50:53 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41371 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgB1Juw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:50:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id v4so2191820wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 01:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JuWbxYpwiWaTODBjAB7HmLfrXVb5I46eoTle9ZgxHYU=;
        b=PjfxvfY1R/bL7jhYVATEvjfvB77T/nYX57HvT15yAwMaL/22djlUwO38kvqJgA+3zv
         YgujuKR17dalgC4cq/zYLbt0Jr2pp7zmgw5u5zksRGmDvOQ6N6vqhhzJuFQgGG0B4Zd7
         HaY+rLTg5m/qpHzxsqs55cIDCdlUbotatzDdthT3icFMVCyYpHifcF/u3vPYp2Tzr7yV
         VTgTJlWRp8C9+snJ93YB937SA/DyldVyzBB05mKiF7RFQBgdGcmkywLTOrgw9EzPrE/J
         MKFAyFcPMvrvHmEPfejPIgGmKz0wOlKwNzxW5946YzCeaSsfczde9uf7pdNX3+QYEayk
         Qixg==
X-Gm-Message-State: APjAAAU5IxUuoPtz4tuMSauq6ExTt6PvzTpLW44lPpn9vIfEWk2RZk2C
        wRLnmlgnbogcf8cXVlca7lA=
X-Google-Smtp-Source: APXvYqwIQUNCJ2BsMMUuQyrovPwiMQUHrokSk8CJl0+LzcZb3GFLEfNaUKpUp7ylfhAcD4Ws2EnKEQ==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr4042600wru.294.1582883450512;
        Fri, 28 Feb 2020 01:50:50 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id d4sm1332086wmb.48.2020.02.28.01.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 01:50:49 -0800 (PST)
Date:   Fri, 28 Feb 2020 10:50:48 +0100
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
Message-ID: <20200228095048.GK3771@dhcp22.suse.cz>
References: <20200228033819.3857058-1-ying.huang@intel.com>
 <20200228034248.GE29971@bombadil.infradead.org>
 <87a7538977.fsf@yhuang-dev.intel.com>
 <edae2736-3239-0bdc-499c-560fc234c974@redhat.com>
 <871rqf850z.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rqf850z.fsf@yhuang-dev.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 28-02-20 16:55:40, Huang, Ying wrote:
> David Hildenbrand <david@redhat.com> writes:
[...]
> > E.g., free page reporting in QEMU wants to use MADV_FREE. The guest will
> > report currently free pages to the hypervisor, which will MADV_FREE the
> > reported memory. As long as there is no memory pressure, there is no
> > need to actually free the pages. Once the guest reuses such a page, it
> > could happen that there is still the old page and pulling in in a fresh
> > (zeroed) page can be avoided.
> >
> > AFAIKs, after your change, we would get more pages discarded from our
> > guest, resulting in more fresh (zeroed) pages having to be pulled in
> > when a guest touches a reported free page again. But OTOH, page
> > migration is speed up (avoiding to migrate these pages).
> 
> Let's look at this problem in another perspective.  To migrate the
> MADV_FREE pages of the QEMU process from the node A to the node B, we
> need to free the original pages in the node A, and (maybe) allocate the
> same number of pages in the node B.  So the question becomes
> 
> - we may need to allocate some pages in the node B
> - these pages may be accessed by the application or not
> - we should allocate all these pages in advance or allocate them lazily
>   when they are accessed.
> 
> We thought the common philosophy in Linux kernel is to allocate lazily.

The common philosophy is to cache as much as possible. And MADV_FREE
pages are a kind of cache as well. If the target node is short on memory
then those will be reclaimed as a cache so a pro-active freeing sounds
counter productive as you do not have any idea whether that cache is
going to be used in future. In other words you are not going to free a
clean page cache if you want to use that memory as a migration target
right? So you should make a clear case about why MADV_FREE cache is less
important than the clean page cache and ideally have a good
justification backed by real workloads.

-- 
Michal Hocko
SUSE Labs
