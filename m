Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEEBFC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C99E222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581663309;
	bh=hGkCZMCddMn1wby+kg4hJmt8w5x/ui0xLxHmz7IP5g8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ihqVbo5dUzWDfRwFqxCXIHioo+OMMLMiWSmka6idL8mF8NulR2wgxzDBdaOilb4fK
	 ryksAPAlsOzM5TV25u5+LK3aqGv8FVXtML4Zsr36WrHluSkw0ab4yeGMYeigyUonES
	 V3bMBXtlNSbxwfbbVYJyqXdz9J41E+jtPkUfb3VY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgBNGzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:55:08 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39846 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgBNGzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:55:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id y11so9600713wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 22:55:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eI86x/JvrHy/AVCnRwQ8huawbMtougjhcECL9y/T5ag=;
        b=TSER4SJ3Y+W1s5SImY4MjN2muMiHcYTlnNCIacF8LUfwwub6A/C2m7GBBtMvQ9cvaL
         PEj8aCYyUC03pmEGCtSopfRrKi2ZhVBZcHJZe1BmFQUtQaS10m9MR0J2tdygCPXaIiSX
         L776COudj3tLjxGNEhH36SI6lxJ73rpxbNWqJX/OceH6oHS0WQ7wUSi9tIdfqe+YrXIA
         ALnQXrd20bir0xuTxgY/CbI+bjGa0wwFRwDkAWoWEqUZZQx0qIdh6U5PrBt4pQh+nPb0
         CqK6YN9ssSI71iIJQqIlNabF8G93WYtZR0qKLD67AhMKMakRNnX9DhCa/FVI+oD2pJVN
         /CXA==
X-Gm-Message-State: APjAAAW72hqgIoLCI3FLostpK+nmu7GIUy/NGpJp0HclS9aY72HD4r3I
        vikJdBQb3PiFPdMiF5ar5Xc=
X-Google-Smtp-Source: APXvYqxa99Wwo6T/pCkhaObjWkD992aRkrtEM3E65/y3wBf3rEiCXeJZgNEGE0MLmnuAhlfpzODBHQ==
X-Received: by 2002:a05:6000:1187:: with SMTP id g7mr2171193wrx.109.1581663306520;
        Thu, 13 Feb 2020 22:55:06 -0800 (PST)
Received: from localhost (ip-37-188-133-87.eurotel.cz. [37.188.133.87])
        by smtp.gmail.com with ESMTPSA id m9sm5915978wrx.55.2020.02.13.22.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 22:55:05 -0800 (PST)
Date:   Fri, 14 Feb 2020 07:55:04 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
Message-ID: <20200214065504.GK31689@dhcp22.suse.cz>
References: <20200127190653.GA8708@bombadil.infradead.org>
 <20200128081712.GA18145@dhcp22.suse.cz>
 <20200128083044.GB6615@bombadil.infradead.org>
 <20200128091352.GC18145@dhcp22.suse.cz>
 <20200128104857.GC6615@bombadil.infradead.org>
 <20200128113953.GA24244@dhcp22.suse.cz>
 <20200213074847.GB31689@dhcp22.suse.cz>
 <20200213164607.GR7778@bombadil.infradead.org>
 <20200213170824.GJ31689@dhcp22.suse.cz>
 <20200214042724.GY7778@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214042724.GY7778@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 13-02-20 20:27:24, Matthew Wilcox wrote:
> On Thu, Feb 13, 2020 at 06:08:24PM +0100, Michal Hocko wrote:
> > On Thu 13-02-20 08:46:07, Matthew Wilcox wrote:
> > > On Thu, Feb 13, 2020 at 08:48:47AM +0100, Michal Hocko wrote:
> > > > Can we pursue on this please? An explicit NOFS scope annotation with a
> > > > reference to compaction potentially locking up on pages in the readahead
> > > > would be a great start.
> > > 
> > > How about this (on top of the current readahead series):
> > > 
> > > diff --git a/mm/readahead.c b/mm/readahead.c
> > > index 29ca25c8f01e..32fd32b913da 100644
> > > --- a/mm/readahead.c
> > > +++ b/mm/readahead.c
> > > @@ -160,6 +160,16 @@ unsigned long page_cache_readahead_limit(struct address_space *mapping,
> > >  		.nr_pages = 0,
> > >  	};
> > >  
> > > +	/*
> > > +	 * Partway through the readahead operation, we will have added
> > > +	 * locked pages to the page cache, but will not yet have submitted
> > > +	 * them for I/O.  Adding another page may need to allocate
> > > +	 * memory, which can trigger memory migration.	Telling the VM
> > 
> > I would go with s@migration@compaction@ because it would make it more
> > obvious that this is about high order allocations.
> 
> Perhaps even just 'reclaim' -- it's about compaction today, but tomorrow's
> VM might try to reclaim these pages too.  They are on the LRU, after all.
> 
> So I currently have:
> 
>         /*
>          * Partway through the readahead operation, we will have added
>          * locked pages to the page cache, but will not yet have submitted
>          * them for I/O.  Adding another page may need to allocate memory,
>          * which can trigger memory reclaim.  Telling the VM we're in
>          * the middle of a filesystem operation will cause it to not
>          * touch file-backed pages, preventing a deadlock.  Most (all?)
>          * filesystems already specify __GFP_NOFS in their mapping's
>          * gfp_mask, but let's be explicit here.
>          */

OK, Thanks!
-- 
Michal Hocko
SUSE Labs
