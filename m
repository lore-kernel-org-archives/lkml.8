Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C42FC3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 240F820873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 07:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581580134;
	bh=rW6SLpuBqssj1SNYDQZlum6yep+K+QRkEjq3MzfZSL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p9uN8Ooq5XGj5CTGST8spZjCN9lLop6ObsGQrwOzpmTTzRXqjBHl1PlJ+foBKFaG4
	 jWAvviDTRBfcUbXC2MZUC9+GZgMrs9b5D81JB/PcHEgDTCSOIzOUkoG0pIp35fkE0n
	 GPAu7Mli6HDOqSbqKmqkkltti+Yp5ZcPw6FUisiI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729875AbgBMHsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 02:48:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53632 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729706AbgBMHsw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 02:48:52 -0500
Received: by mail-wm1-f65.google.com with SMTP id s10so5050056wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 23:48:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HBD1ZB0zWqswLTDRQo7TRqSq+Yo01aL64QJ9zoMi6fY=;
        b=RTj6Nki0s3R/n1mvL8vEMjn6sThqmZgoQG2CZjxVP7bN+Xpfxs9cV1ue3YvXw3hrHA
         grDk4EoMnxYlsuMk1uf8Gx8TKfk1O+Ti6qjk6N8/C8W1qelEno7/NMwqJ9XjkOoNkGY/
         zhWVXu0dmYd81IEe2WC14sC6e5ldd2aqd2qFfu6jevvOsK3L5USX1UpzrP9ZSUiL26zV
         g6wE6o4IYCqnk2QRRv3Em/h3mjqaRTgjXDjSCRAhhost4+DTskHpKdLzdIrE4o3TFuFV
         Jphmzb2d6ZUf3VpjjVMDYXmAPmoc3kPz6KrXJoZQdjiFdYJrKj0660lgdCtXB9aT7BaU
         gbYw==
X-Gm-Message-State: APjAAAVF8Dh/cSguuItfoWkmOyRyTjUZBcTaStQUNkr7wqEyRe3YtzTG
        B5fQX+8U5lVAuRJAHj3njaY=
X-Google-Smtp-Source: APXvYqzdgn+czh+92nzqAyeowfjf8/VqsClD6Ydsest9INQfDJ80i8wriM68Q3W8L+ANJ7a3yZrDKQ==
X-Received: by 2002:a7b:c14e:: with SMTP id z14mr4146049wmi.58.1581580129310;
        Wed, 12 Feb 2020 23:48:49 -0800 (PST)
Received: from localhost (ip-37-188-133-87.eurotel.cz. [37.188.133.87])
        by smtp.gmail.com with ESMTPSA id c77sm1877694wmd.12.2020.02.12.23.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 23:48:48 -0800 (PST)
Date:   Thu, 13 Feb 2020 08:48:47 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
Message-ID: <20200213074847.GB31689@dhcp22.suse.cz>
References: <20200121090048.GG29276@dhcp22.suse.cz>
 <CAM_iQpU0p7JLyQ4mQ==Kd7+0ugmricsEAp1ST2ShAZar2BLAWg@mail.gmail.com>
 <20200126233935.GA11536@bombadil.infradead.org>
 <20200127150024.GN1183@dhcp22.suse.cz>
 <20200127190653.GA8708@bombadil.infradead.org>
 <20200128081712.GA18145@dhcp22.suse.cz>
 <20200128083044.GB6615@bombadil.infradead.org>
 <20200128091352.GC18145@dhcp22.suse.cz>
 <20200128104857.GC6615@bombadil.infradead.org>
 <20200128113953.GA24244@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128113953.GA24244@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-01-20 12:39:55, Michal Hocko wrote:
> On Tue 28-01-20 02:48:57, Matthew Wilcox wrote:
> > On Tue, Jan 28, 2020 at 10:13:52AM +0100, Michal Hocko wrote:
> > > On Tue 28-01-20 00:30:44, Matthew Wilcox wrote:
> > > > On Tue, Jan 28, 2020 at 09:17:12AM +0100, Michal Hocko wrote:
> > > > > On Mon 27-01-20 11:06:53, Matthew Wilcox wrote:
> > > > > > On Mon, Jan 27, 2020 at 04:00:24PM +0100, Michal Hocko wrote:
> > > > > > > On Sun 26-01-20 15:39:35, Matthew Wilcox wrote:
> > > > > > > > On Sun, Jan 26, 2020 at 11:53:55AM -0800, Cong Wang wrote:
> > > > > > > > > I suspect the process gets stuck in the retry loop in try_charge(), as
> > > > > > > > > the _shortest_ stacktrace of the perf samples indicated:
> > > > > > > > > 
> > > > > > > > > cycles:ppp:
> > > > > > > > >         ffffffffa72963db mem_cgroup_iter
> > > > > > > > >         ffffffffa72980ca mem_cgroup_oom_unlock
> > > > > > > > >         ffffffffa7298c15 try_charge
> > > > > > > > >         ffffffffa729a886 mem_cgroup_try_charge
> > > > > > > > >         ffffffffa720ec03 __add_to_page_cache_locked
> > > > > > > > >         ffffffffa720ee3a add_to_page_cache_lru
> > > > > > > > >         ffffffffa7312ddb iomap_readpages_actor
> > > > > > > > >         ffffffffa73133f7 iomap_apply
> > > > > > > > >         ffffffffa73135da iomap_readpages
> > > > > > > > >         ffffffffa722062e read_pages
> > > > > > > > >         ffffffffa7220b3f __do_page_cache_readahead
> > > > > > > > >         ffffffffa7210554 filemap_fault
> > > > > > > > >         ffffffffc039e41f __xfs_filemap_fault
> > > > > > > > >         ffffffffa724f5e7 __do_fault
> > > > > > > > >         ffffffffa724c5f2 __handle_mm_fault
> > > > > > > > >         ffffffffa724cbc6 handle_mm_fault
> > > > > > > > >         ffffffffa70a313e __do_page_fault
> > > > > > > > >         ffffffffa7a00dfe page_fault
> > > > > 
> > > > > I am not deeply familiar with the readahead code. But is there really a
> > > > > high oerder allocation (order > 1) that would trigger compaction in the
> > > > > phase when pages are locked?
> > > > 
> > > > Thanks to sl*b, yes:
> > > > 
> > > > radix_tree_node    80890 102536    584   28    4 : tunables    0    0    0 : slabdata   3662   3662      0
> > > > 
> > > > so it's allocating 4 pages for an allocation of a 576 byte node.
> > > 
> > > I am not really sure that we do sync migration for costly orders.
> > 
> > Doesn't the stack trace above indicate that we're doing migration as
> > the result of an allocation in add_to_page_cache_lru()?
> 
> Which stack trace do you refer to? Because the one above doesn't show
> much more beyond mem_cgroup_iter and likewise others in this email
> thread. I do not really remember any stack with lock_page on the trace.
> > 
> > > > > Btw. the compaction rejects to consider file backed pages when __GFP_FS
> > > > > is not present AFAIR.
> > > > 
> > > > Ah, that would save us.
> > > 
> > > So the NOFS comes from the mapping GFP mask, right? That is something I
> > > was hoping to get rid of eventually :/ Anyway it would be better to have
> > > an explicit NOFS with a comment explaining why we need that. If for
> > > nothing else then for documentation.
> > 
> > I'd also like to see the mapping GFP mask go away, but rather than seeing
> > an explicit GFP_NOFS here, I'd rather see the memalloc_nofs API used.
> 
> Completely agreed agree here. The proper place for the scope would be
> the place where pages are locked with an explanation that there are
> other allocations down the line which might invoke sync migration and
> that would be dangerous. Having that explicitly documented is clearly an
> improvement.

Can we pursue on this please? An explicit NOFS scope annotation with a
reference to compaction potentially locking up on pages in the readahead
would be a great start.
-- 
Michal Hocko
SUSE Labs
