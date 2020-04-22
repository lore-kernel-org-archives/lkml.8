Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4D5C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CABD2074F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 08:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587543667;
	bh=z5I7+01A+jX9k3Cg5XJ6Yj4ad1l/c2Y9f2scsGOFlX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zg+qeh3HYcUUQI+/uTdhE9L6byuh1Q2CUc2U7dc1bHyhOLSnImDP43KdxDxJJwFBH
	 REMqnoFBHlfhQxoaulBmpe3RZCcM9VdL9oJ4MD9QoElyoeAvBwsy86n9V0Cb8+QHyY
	 uWvsqT3eqkh48eyhmpq/8p9VoIAvhBF9L5xyq0aY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgDVIVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:21:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40301 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgDVIVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 04:21:05 -0400
Received: by mail-wm1-f68.google.com with SMTP id u16so1254378wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 01:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5NU5ZhAJHq6ciQrPGIfc8KggoL6wwkS48uukTc3+gvE=;
        b=pBtTMX6urHD3zMpTlI7A33CIycrah7Sp0vaZWZsjV8IcX3CoV2ImfbFtP3YJeHQfS4
         t4PEc+HE9xRbgfOZvhfx8Hv71vOSsesmdvSS9ZXAumQca/tob1QjqNVdnKVp/HqMtATW
         AiFP3naqJBItvtdYLwhl6fpFBxxRvATIouHqOz1UmyqxtULPYcVBy6oEpsnuJ6wiZq2H
         h4gyGQskghYTpkufjx0w0BXyo2HcBsdM2JCpoY6aQNhQ+oeIbrz2r9aAmrPlmxTqk0lF
         hw5TkNX1D80oB4/imsMbC/AqAac4su75EMbBOVbsxLGuy1MU3ie+47nfE6w8O8V8DM3E
         04/g==
X-Gm-Message-State: AGi0Pubtg07Oedn81wbuIurVNjjynPQaLG/388F6nDa2noAzZZ3XzXf0
        rnApplpG1v1oudBTK4z2Img=
X-Google-Smtp-Source: APiQypIahp8XtYzcQptvFeNTn34PdqiiYT9KTGBHLyPfNL1QcREQrptbYD4Ao0S0wxPn6ghGhgl8KQ==
X-Received: by 2002:a1c:4346:: with SMTP id q67mr9023354wma.162.1587543663505;
        Wed, 22 Apr 2020 01:21:03 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id f7sm7011365wrt.10.2020.04.22.01.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 01:21:02 -0700 (PDT)
Date:   Wed, 22 Apr 2020 10:21:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH RFC 1/2] mm/memory_hotplug: no need to init new pgdat
 with node_start_pfn
Message-ID: <20200422082101.GC30312@dhcp22.suse.cz>
References: <20200416104707.20219-1-david@redhat.com>
 <20200416104707.20219-2-david@redhat.com>
 <20200421123011.GE27314@dhcp22.suse.cz>
 <ac246ba8-9a61-0e0b-3aff-caf78743e81f@redhat.com>
 <20200421125250.GG27314@dhcp22.suse.cz>
 <c5b693e0-61b7-ca05-68b5-eb19c517759f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5b693e0-61b7-ca05-68b5-eb19c517759f@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-04-20 15:06:20, David Hildenbrand wrote:
> On 21.04.20 14:52, Michal Hocko wrote:
> > On Tue 21-04-20 14:35:12, David Hildenbrand wrote:
> >> On 21.04.20 14:30, Michal Hocko wrote:
> >>> Sorry for the late reply
> >>>
> >>> On Thu 16-04-20 12:47:06, David Hildenbrand wrote:
> >>>> A hotadded node/pgdat will span no pages at all, until memory is moved to
> >>>> the zone/node via move_pfn_range_to_zone() -> resize_pgdat_range - e.g.,
> >>>> when onlining memory blocks. We don't have to initialize the
> >>>> node_start_pfn to the memory we are adding.
> >>>
> >>> You are right that the node is empty at this phase but that is already
> >>> reflected by zero present pages (hmm, I do not see spanned pages to be
> >>> set 0 though). What I am missing here is why this is an improvement. The
> >>> new node is already visible here and I do not see why we hide the
> >>> information we already know.
> >>
> >> "information we already know" - no, not before we online the memory.
> > 
> > Is this really the case? All add_memory_resource users operate on a
> > physical memory range.
> 
> Having the first add_memory() to magically set node_start_pfn of a hotplugged
> node isn't dangerous, I think we agree on that. It's just completely
> unnecessary here and at least left me confused why this is needed at all-
> because the node start/end pfn is only really touched when
> onlining/offlining memory (when resizing the zone and the pgdat).

I do not see any specific problem. It just feels odd to
ignore the start pfn when we have that information. I am little bit
worried that this might kick back. E.g. say we start using the memmaps
from the hotplugged memory then the initial part of the node will never
get online and we would have memmaps outside of the node span. I do not
see an immediate problem except for the feeling this is odd.

That being said I will shut up now and leave it alone.

[...]
> > Btw. one thing that I have in my notes, I was never able to actually
> > test the no numa node case. Because I have always been testing with node
> > being allocated during the boot. Do you have any way to trigger this
> > path?
> 
> Sure, here is my test case
> 
> #! /bin/bash
> sudo qemu-system-x86_64 \
>     --enable-kvm \
>     -m 4G,maxmem=20G,slots=2 \
>     -smp sockets=2,cores=2 \
>     -numa node,nodeid=0,cpus=0-1,mem=4G -numa node,nodeid=1,mem=0G \

I have been using a similar command line
NUMA_ONE_MEMORY_LESS_NODE="-numa node,mem=2G -numa node,mem=0G"
which gets appended to the qemu cmdline. I have always thought that this
would allocate pgdat for node 1 though. I have checked that again now
and dmesg doesn't point to node 1 anywhere.

Thanks!

-- 
Michal Hocko
SUSE Labs
