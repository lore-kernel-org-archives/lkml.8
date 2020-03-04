Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD0BC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F1521744
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 11:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583321217;
	bh=409yaTcC9oU8TRO48hXYZTs0haDvqMegb+qn1O+sDaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p7kGGutsD3eNH6QMU5EbcC2EbmwVO1CzfPFr633XkTwHkrK+MxUNpKpxObc5Xzgmf
	 sSy5LUyBzBZU2rl+eX55y6lwk2gRvRfR9/LfvBJ6JjXPKhzCYJoN+2DTa0O+ZVjWpQ
	 AanXbuGKVaSlTD2k7NV8HVPJWKEplBIVdEp1Ro+4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729283AbgCDL04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 06:26:56 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41187 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbgCDL04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 06:26:56 -0500
Received: by mail-wr1-f51.google.com with SMTP id v4so1926883wrs.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 03:26:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bH3fISo8TLwz0Zch/JAF6ezBy0LKas5gSdqAMX74AuQ=;
        b=G/b/+R4wHEdOVX5WgbULi2JZJjbHCFFvveJgmWUGvgKzePUuaC/OD/aNxQfxRMiGjv
         VVky5HkRCwVv/YB5VGXoegLhp4y5bn4mnwDSlzEzRQXcvHLqwPx5BD+/Q9mf+xnweE3q
         yNVmDeJyJrbUmeYAqyp574JchxLyhE8WseyNbf84io9uQVv/i1mM8qrGS9TzpZHRlZ9U
         osm4BoRxq7fICqrlowXGzPOgNAsirDoM9v/kaZdcfYSX0z9nCg2DVws14NCZpyUhGEar
         hH/flawuKremyg4CJw3qX/4836OQ/GTKlDP6bIQRjbYRV24LgAqkQm0fyAWFtdcDwRgn
         CvCQ==
X-Gm-Message-State: ANhLgQ0+johhGNKSENLkYL+0tqsVNMNfSbZPUgCQ9jpvHc2p+Rjsx/+R
        Gxudb2i7ZH/iqotNGDA4kjk=
X-Google-Smtp-Source: ADFU+vtivAUEm4FokWwu4Bokvv9b1dtgYKE4mT5/AUo0fk+wRLC+rDkVCCGO8bokCPMlXeezzk9cgA==
X-Received: by 2002:adf:e98f:: with SMTP id h15mr3788899wrm.263.1583321214487;
        Wed, 04 Mar 2020 03:26:54 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id i1sm17963622wrs.18.2020.03.04.03.26.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 03:26:53 -0800 (PST)
Date:   Wed, 4 Mar 2020 12:26:53 +0100
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
Message-ID: <20200304112653.GH16139@dhcp22.suse.cz>
References: <20200228094954.GB3772@suse.de>
 <87h7z76lwf.fsf@yhuang-dev.intel.com>
 <20200302151607.GC3772@suse.de>
 <87zhcy5hoj.fsf@yhuang-dev.intel.com>
 <20200303080945.GX4380@dhcp22.suse.cz>
 <87o8td4yf9.fsf@yhuang-dev.intel.com>
 <20200303085805.GB4380@dhcp22.suse.cz>
 <87ftep4pzy.fsf@yhuang-dev.intel.com>
 <20200304095802.GE16139@dhcp22.suse.cz>
 <87blpc2wxj.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blpc2wxj.fsf@yhuang-dev.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-03-20 19:15:20, Huang, Ying wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
> > On Tue 03-03-20 19:49:53, Huang, Ying wrote:
[...]
> >> Because the penalty difference is so large, I
> >> think it may be a good idea to always put clean MADV_FREE pages at the
> >> tail of the inactive file LRU list?
> >
> > You are again making assumptions without giving any actual real
> > examples. Reconstructing MADV_FREE pages cost can differ a lot.
> 
> In which situation the cost to reconstruct MADV_FREE pages can be higher
> than the cost to allocate file cache page and read from disk?  Heavy
> contention on mmap_sem?

Allocating a page might be really costly but even without that.
Reconstructnig the content of the page can be really high and actually
much larger than an IO to get a page from the storage. Consider
decompression or some other transformations to get the content.
Userspace has means to detect that the content is still up-to-date as
already has been mentioned so all those steps can be avoided.

-- 
Michal Hocko
SUSE Labs
