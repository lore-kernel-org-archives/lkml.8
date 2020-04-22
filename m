Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F13C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 452242077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587549672;
	bh=anuWbPfqgDfo6p2fsmQWGGLxhgYgytS189Hd33TfqRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MWhm0EhB+jS4czycvEXKJ6J9EZh7Etm+0nalB+uh7yBFCFP9qSVpimOxAMZRPu8SC
	 MoC/WmDcPi1Hf9XLqNotLb1cqC47vVOTEqQXh5/9GSspLpyNNt2N1KPKPhegkxLvSh
	 ezvNKJDVfRxAODFKKlc3DOiVezNzurofXZ5Q3m1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgDVKBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:01:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39389 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbgDVKBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:01:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id b11so1650262wrs.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 03:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hv49bv5UUTZ3NDUvU3H6y8LABTtvq3abK5gLpfIazmY=;
        b=DZT65FdFVfLmnjdh9+jur5HmgX7lcvrMWPTtr3dYYKLvTtWiWYBIO+jsJ9QqNfNUT3
         FmFNFb9KFnnoh4OacSoc4DZjUNBhfPT4pFwj9xIZUCKM27XVBa+s10ReVgjyLqsQCel/
         +On8uxECOh08q3vpX1CnniNsC99q/N6MxgkawrC3blLYMDu1ErTudKP89actNpVYG+Kk
         7UbaX//Yu9b1JqBn5Qyp6BIICRE7g0g8dDaBFlUnf/Kp/mlnzptAwPRgv6duqXdnWr0l
         1GNqOPdXO+Els5jSFfjBchs4yAmBXXv9JuSF1i3TplFYqkRA4gu86lZPdH9Q+p0E5FCH
         +wyg==
X-Gm-Message-State: AGi0PubUa75XUMSm1eI2AXehzh4cKrJtkD6bDX9rQqK+1m7/5vqZW+xq
        e6BhaFskrUrpibIFepEf5t4=
X-Google-Smtp-Source: APiQypIiuScS/JZozmSeu0q3j07Jq+Yay5SsoEJb1EVPXRrptCpSf5QiTX3hMatiXu1EWNZIs5DVag==
X-Received: by 2002:a5d:4109:: with SMTP id l9mr27977934wrp.300.1587549661685;
        Wed, 22 Apr 2020 03:01:01 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id q143sm7479880wme.31.2020.04.22.03.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 03:01:00 -0700 (PDT)
Date:   Wed, 22 Apr 2020 12:00:59 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH RFC 1/2] mm/memory_hotplug: no need to init new pgdat
 with node_start_pfn
Message-ID: <20200422100059.GD30312@dhcp22.suse.cz>
References: <20200416104707.20219-1-david@redhat.com>
 <20200416104707.20219-2-david@redhat.com>
 <20200421123011.GE27314@dhcp22.suse.cz>
 <ac246ba8-9a61-0e0b-3aff-caf78743e81f@redhat.com>
 <20200421125250.GG27314@dhcp22.suse.cz>
 <c5b693e0-61b7-ca05-68b5-eb19c517759f@redhat.com>
 <20200422082101.GC30312@dhcp22.suse.cz>
 <47046122-ddf7-7a96-28f6-e8d57b356697@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47046122-ddf7-7a96-28f6-e8d57b356697@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-04-20 10:32:32, David Hildenbrand wrote:
> On 22.04.20 10:21, Michal Hocko wrote:
> > On Tue 21-04-20 15:06:20, David Hildenbrand wrote:
> >> On 21.04.20 14:52, Michal Hocko wrote:
> >>> On Tue 21-04-20 14:35:12, David Hildenbrand wrote:
> >>>> On 21.04.20 14:30, Michal Hocko wrote:
> >>>>> Sorry for the late reply
> >>>>>
> >>>>> On Thu 16-04-20 12:47:06, David Hildenbrand wrote:
> >>>>>> A hotadded node/pgdat will span no pages at all, until memory is moved to
> >>>>>> the zone/node via move_pfn_range_to_zone() -> resize_pgdat_range - e.g.,
> >>>>>> when onlining memory blocks. We don't have to initialize the
> >>>>>> node_start_pfn to the memory we are adding.
> >>>>>
> >>>>> You are right that the node is empty at this phase but that is already
> >>>>> reflected by zero present pages (hmm, I do not see spanned pages to be
> >>>>> set 0 though). What I am missing here is why this is an improvement. The
> >>>>> new node is already visible here and I do not see why we hide the
> >>>>> information we already know.
> >>>>
> >>>> "information we already know" - no, not before we online the memory.
> >>>
> >>> Is this really the case? All add_memory_resource users operate on a
> >>> physical memory range.
> >>
> >> Having the first add_memory() to magically set node_start_pfn of a hotplugged
> >> node isn't dangerous, I think we agree on that. It's just completely
> >> unnecessary here and at least left me confused why this is needed at all-
> >> because the node start/end pfn is only really touched when
> >> onlining/offlining memory (when resizing the zone and the pgdat).
> > 
> > I do not see any specific problem. It just feels odd to
> > ignore the start pfn when we have that information. I am little bit
> > worried that this might kick back. E.g. say we start using the memmaps
> > from the hotplugged memory then the initial part of the node will never> get online and we would have memmaps outside of the node span. I do not
> 
> That's a general issue, which I pointed out as response to Oscars last
> series. This needs more thought and reworks, especially how
> node_start_pfn/node_spanned_pages are glued to memory onlining/offlining
> today.
> 
> > see an immediate problem except for the feeling this is odd.
> 
> I think it's inconsistent. E.g., start with memory-less/cpu-less node
> and don't online memory from the kernel immediately.
> 
> Hotplug CPU. PGDAT initialized with node_start_pfn=0. Hotplug memory.
> -> node_start_pfn=0 until memory is actually onlined.
> 
> Hotplug memory. PGDAT initialized with node_start_pfn=$VALUE. Hotplug CPU.
> -> node_start_pfn=$VALUE
> 
> Hotplug memory. PGDAT initialized with node_start_pfn=$VALUE. Hotplug
> CPU. Hotunplug memory.
> -> node_start_pfn=$VALUE, although there is no memory anymore.
> 
> Hotplug memory 1. PGDAT initialized with node_start_pfn=$VALUE. Hotplug
> memory 2. Hotunplug memory 2.
> -> node_start_pfn=$VALUE1 instead of $VALUE2.
> 
> 
> Again, because node_start_pfn has absolutely no meaning until memory is
> actually onlined - today.
> 
> > 
> > That being said I will shut up now and leave it alone.
> 
> Is that a nack?

No it's not. Nor I am going to ack this but I will not stand in the
way. I would just urge to have as many assumptions you are making and as
much information in the changelog as possible.

-- 
Michal Hocko
SUSE Labs
