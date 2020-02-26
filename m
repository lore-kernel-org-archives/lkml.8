Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE03C4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:30:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A4A24687
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWRHua45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgBZMao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 07:30:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44530 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726277AbgBZMan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582720242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=USc4GZx7VeByANQXh3m8ONczXPb4tD0GznPgTK+y2dM=;
        b=RWRHua45/+GMj/Gcv7raJZzg9N2ToVdDtjmTfU2DTMn6bMaLYBO53UXHWZvM6bsiFtmYXr
        TkZzutg2lTjZnMj+BB0EGDslGRPi55oVQMizn36K2Bgc1PtS1tk5i5kuqObJVRWA53BVR6
        qJwRZZs0PSQMy7t/KrDKscIdzJgbZ5Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-SqhY_Z7XMm61uUtse-5Haw-1; Wed, 26 Feb 2020 07:30:38 -0500
X-MC-Unique: SqhY_Z7XMm61uUtse-5Haw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD166107ACC7;
        Wed, 26 Feb 2020 12:30:36 +0000 (UTC)
Received: from localhost (ovpn-12-39.pek2.redhat.com [10.72.12.39])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BAA8F5DA60;
        Wed, 26 Feb 2020 12:30:32 +0000 (UTC)
Date:   Wed, 26 Feb 2020 20:30:30 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        richardw.yang@linux.intel.com, osalvador@suse.de,
        dan.j.williams@intel.com, rppt@linux.ibm.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 0/7] mm/hotplug: Only use subsection map in VMEMMAP
 case
Message-ID: <20200226123030.GG24216@MiWiFi-R3L-srv>
References: <20200220043316.19668-1-bhe@redhat.com>
 <20200220103849.GG20509@dhcp22.suse.cz>
 <20200221142847.GG4937@MiWiFi-R3L-srv>
 <75b4f840-7454-d6d0-5453-f0a045c852fa@redhat.com>
 <20200225100226.GM22443@dhcp22.suse.cz>
 <20200226034236.GD24216@MiWiFi-R3L-srv>
 <20200226091421.GE3771@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226091421.GE3771@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/26/20 at 10:14am, Michal Hocko wrote:
> On Wed 26-02-20 11:42:36, Baoquan He wrote:
> > On 02/25/20 at 11:02am, Michal Hocko wrote:
> > > On Tue 25-02-20 10:10:45, David Hildenbrand wrote:
> > > > >>>  include/linux/mmzone.h |   2 +
> > > > >>>  mm/sparse.c            | 178 +++++++++++++++++++++++++++++------------
> > > > >>>  2 files changed, 127 insertions(+), 53 deletions(-)
> > > > >>
> > > > >> Why do we need to add so much code to remove a functionality from one
> > > > >> memory model?
> > > > > 
> > > > > Hmm, Dan also asked this before.
> > > > > 
> > > > > The adding mainly happens in patch 2, 3, 4, including the two newly
> > > > > added function defitions, the code comments above them, and those added
> > > > > dummy functions for !VMEMMAP.
> > > > 
> > > > AFAIKS, it's mostly a bunch of newly added comments on top of functions.
> > > > E.g., the comment for fill_subsection_map() alone spans 12 LOC in total.
> > > > I do wonder if we have to be that verbose. We are barely that verbose on
> > > > MM code (and usually I don't see much benefit unless it's a function
> > > > with many users from many different places).
> > > 
> > > I would tend to agree here. Not that I am against kernel doc
> > > documentation but these are internal functions and the comment doesn't
> > > really give any better insight IMHO. I would be much more inclined if
> > > this was the general pattern in the respective file but it just stands
> > > out.
> > 
> > I saw there are internal functions which have code comments, e.g
> > shrink_slab() in mm/vmscan.c, not only this one place, there are several
> > places. I personally prefer to see code comment for function if
> > possible, this can save time, e.g people can skip the bitmap operation
> > when read code if not necessary. And here I mainly want to tell there
> > are different returned value to note different behaviour when call them.
> 
> ... yet nobody really cares about different return code. It is an error
> that is propagated up the call chain and that's all.
> 
> I also like when there is a kernel doc comment that helps to understand
> the intented usage, context the function can be called from, potential
> side effects, locking requirements and other details people need to know

Fair enough. As I have said, I didn't intend to stick to add kernel doc
comments for these two functions. Will remove them. Thanks for
reviewing.

> when calling functions. But have a look at 
> /**
>  * clear_subsection_map - Clear subsection map of one memory region
>  *
>  * @pfn - start pfn of the memory range
>  * @nr_pages - number of pfns to add in the region
>  *
>  * This is only intended for hotplug, and clear the related subsection
>  * map inside one section.
>  *
>  * Return:
>  * * -EINVAL	- Section already deactived.
>  * * 0		- Subsection map is emptied.
>  * * 1		- Subsection map is not empty.
>  */
> 
> the only useful information in here is that this is a hotplug stuff but
> I would be completely lost about the intention without already knowing
> what is this whole subsection about.
> 
> -- 
> Michal Hocko
> SUSE Labs
> 

