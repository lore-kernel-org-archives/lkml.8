Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49784C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E03E24686
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580211598;
	bh=kmf5D6RKZUxlp3g7H60rO0uBNfp2fqdARa08eJtYZqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MLUCael8Ocqi5yHpQoVGXwMBq+2LpCt6WluCvZTGBJlBOkZvrzwlCIQoXmiyWj2FZ
	 Akbt+frMk1G68BYJZnK9UBZf+EOKwABRs7XXvLvrYcnhJTlrvbPvjspe4yRgXNMGUv
	 sg3rGAg0zbTYjzbyrn90cyHk0jJl+LAh5kvkkeZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726108AbgA1Lj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 06:39:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40325 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgA1Lj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 06:39:57 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so15632728wrn.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 03:39:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T3Wbgf30Ii+VOg2FGlTD1Ulg3uZcieH89u7q/gSMF7Q=;
        b=b2ke8Tb8inNAk094ut1CQvIywQNw2arDJ9gFUncf6F3JZf6IDiUawbauNAij/hqy0F
         T7yzXhmayuXVjjBA5+6os1ewu8qYnm8cYdIA36XepvwARk/DnyWlAigAAtFZi+Fxo+fO
         hC7vgirRV58aeG7NhDEzKzXIW3bUq//I7lg222gvvzlsB3f65T12+5vMht0p/BxbsiTV
         HVHKKK1a50tewrlq7dprwOMNxZxssAulsGxXpIIQpDqCK6rsMqw+lm849gpnf8THbdqq
         PC1aAHfTRMEvw19XOHBH2mNOy3WJEuDqphiTusZGzdw6VleMkVRWjQcPMMO0CLnQEk3R
         eMOA==
X-Gm-Message-State: APjAAAVevgZ6/WZ/tFVxWa1dsSwfx3CTRvRffv7BsGqcmU8muF7juDUK
        R91UBohO1EfAdNR5W5EXdcA=
X-Google-Smtp-Source: APXvYqzgecilxTYzirylIKzVzYuY4fsPh3O0daKMkdvqtSLa+z+JrNZ6MnR+WnRBbY9ZDtMGNtZvHw==
X-Received: by 2002:a5d:56ca:: with SMTP id m10mr29266505wrw.313.1580211595104;
        Tue, 28 Jan 2020 03:39:55 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id r6sm25656024wrq.92.2020.01.28.03.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 03:39:54 -0800 (PST)
Date:   Tue, 28 Jan 2020 12:39:53 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
Message-ID: <20200128113953.GA24244@dhcp22.suse.cz>
References: <CAM_iQpVN4MNhcK0TXvhmxsCdkVOqQ4gZBzkDHykLocPC6Va7LQ@mail.gmail.com>
 <20200121090048.GG29276@dhcp22.suse.cz>
 <CAM_iQpU0p7JLyQ4mQ==Kd7+0ugmricsEAp1ST2ShAZar2BLAWg@mail.gmail.com>
 <20200126233935.GA11536@bombadil.infradead.org>
 <20200127150024.GN1183@dhcp22.suse.cz>
 <20200127190653.GA8708@bombadil.infradead.org>
 <20200128081712.GA18145@dhcp22.suse.cz>
 <20200128083044.GB6615@bombadil.infradead.org>
 <20200128091352.GC18145@dhcp22.suse.cz>
 <20200128104857.GC6615@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128104857.GC6615@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-01-20 02:48:57, Matthew Wilcox wrote:
> On Tue, Jan 28, 2020 at 10:13:52AM +0100, Michal Hocko wrote:
> > On Tue 28-01-20 00:30:44, Matthew Wilcox wrote:
> > > On Tue, Jan 28, 2020 at 09:17:12AM +0100, Michal Hocko wrote:
> > > > On Mon 27-01-20 11:06:53, Matthew Wilcox wrote:
> > > > > On Mon, Jan 27, 2020 at 04:00:24PM +0100, Michal Hocko wrote:
> > > > > > On Sun 26-01-20 15:39:35, Matthew Wilcox wrote:
> > > > > > > On Sun, Jan 26, 2020 at 11:53:55AM -0800, Cong Wang wrote:
> > > > > > > > I suspect the process gets stuck in the retry loop in try_charge(), as
> > > > > > > > the _shortest_ stacktrace of the perf samples indicated:
> > > > > > > > 
> > > > > > > > cycles:ppp:
> > > > > > > >         ffffffffa72963db mem_cgroup_iter
> > > > > > > >         ffffffffa72980ca mem_cgroup_oom_unlock
> > > > > > > >         ffffffffa7298c15 try_charge
> > > > > > > >         ffffffffa729a886 mem_cgroup_try_charge
> > > > > > > >         ffffffffa720ec03 __add_to_page_cache_locked
> > > > > > > >         ffffffffa720ee3a add_to_page_cache_lru
> > > > > > > >         ffffffffa7312ddb iomap_readpages_actor
> > > > > > > >         ffffffffa73133f7 iomap_apply
> > > > > > > >         ffffffffa73135da iomap_readpages
> > > > > > > >         ffffffffa722062e read_pages
> > > > > > > >         ffffffffa7220b3f __do_page_cache_readahead
> > > > > > > >         ffffffffa7210554 filemap_fault
> > > > > > > >         ffffffffc039e41f __xfs_filemap_fault
> > > > > > > >         ffffffffa724f5e7 __do_fault
> > > > > > > >         ffffffffa724c5f2 __handle_mm_fault
> > > > > > > >         ffffffffa724cbc6 handle_mm_fault
> > > > > > > >         ffffffffa70a313e __do_page_fault
> > > > > > > >         ffffffffa7a00dfe page_fault
> > > > 
> > > > I am not deeply familiar with the readahead code. But is there really a
> > > > high oerder allocation (order > 1) that would trigger compaction in the
> > > > phase when pages are locked?
> > > 
> > > Thanks to sl*b, yes:
> > > 
> > > radix_tree_node    80890 102536    584   28    4 : tunables    0    0    0 : slabdata   3662   3662      0
> > > 
> > > so it's allocating 4 pages for an allocation of a 576 byte node.
> > 
> > I am not really sure that we do sync migration for costly orders.
> 
> Doesn't the stack trace above indicate that we're doing migration as
> the result of an allocation in add_to_page_cache_lru()?

Which stack trace do you refer to? Because the one above doesn't show
much more beyond mem_cgroup_iter and likewise others in this email
thread. I do not really remember any stack with lock_page on the trace.
> 
> > > > Btw. the compaction rejects to consider file backed pages when __GFP_FS
> > > > is not present AFAIR.
> > > 
> > > Ah, that would save us.
> > 
> > So the NOFS comes from the mapping GFP mask, right? That is something I
> > was hoping to get rid of eventually :/ Anyway it would be better to have
> > an explicit NOFS with a comment explaining why we need that. If for
> > nothing else then for documentation.
> 
> I'd also like to see the mapping GFP mask go away, but rather than seeing
> an explicit GFP_NOFS here, I'd rather see the memalloc_nofs API used.

Completely agreed agree here. The proper place for the scope would be
the place where pages are locked with an explanation that there are
other allocations down the line which might invoke sync migration and
that would be dangerous. Having that explicitly documented is clearly an
improvement.

-- 
Michal Hocko
SUSE Labs
