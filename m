Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BCCC54E4A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51925208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jx3QPFNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgEGLeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:34:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57298 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725900AbgEGLeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588851240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XwlnVfeL8zwiME3AXkx3OodZgfIVpDR8QDqNxlTyOzM=;
        b=Jx3QPFNgWKbQ/rmIJB+a9R34S8bBkHO0mSWXHM7WF1mihNFfrNe3ccvBxYKZXVeL8j3aZR
        dQXeW6qysBV+VYK3GzVvQlog6MVekSzZZQjEW1dPNmIkvaFC3V+sTj83Vf3Nrog8jL4yma
        pQ8OSRzuSBaAarto/xhmaorgHV4H1+I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-Gtfy91w1PdWHh56DKT6UhA-1; Thu, 07 May 2020 07:33:57 -0400
X-MC-Unique: Gtfy91w1PdWHh56DKT6UhA-1
Received: by mail-wm1-f70.google.com with SMTP id n17so2371043wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 04:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XwlnVfeL8zwiME3AXkx3OodZgfIVpDR8QDqNxlTyOzM=;
        b=lkQAQUPFd5Y4kkK3PEBSdVp76+q1uziwN9y1oAclft0Uad8QJdxQJnx2ZDwhyxvwEd
         BNhHTehIZnK1FSDm2jYQtA9V5St88T3QC8oCft/9YbdL/GG0u1lYnpZ09fTTjggL56Ou
         XkB6t0aikNol2vijNYAVX4VJscKdshmXwcyrV6+U+VCUJhvNirrempXcr41S0y2VFXQo
         29liBIF5M7N3hkOUF+YZZKYU/JGwAsKkdD5xgnhyKhsqbg99KlN0W5tAY1TuRBpuMLf2
         703Kp4iOFYNObpo9T6QEA60nPmTa6EzcgBrnw99mnlT3ubI65COdA0D5+s6R6rAS9xRU
         ZnxA==
X-Gm-Message-State: AGi0PuZv3VAFGPX9i64xyqUDob4Qd/HlIX5w/7K5687CaGi0erk2jrN3
        NyuyrEv1zIxqpr24c2GwsAZKgBDz2WV7LaJkVpQ+7R4vJYYW0cCbmFm6QCrl0a+PLkZrFlnOq3G
        /ylrWOmrozGw9vDETjnFkErcC
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr10636343wmc.83.1588851236209;
        Thu, 07 May 2020 04:33:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypKGIkZb1OCioKL4MfDtVCIXay4HVUxjU1z1uE6butvfdGNej6NGsQ5cSCDAt+neZC4D4zgsoQ==
X-Received: by 2002:a1c:f20c:: with SMTP id s12mr10636305wmc.83.1588851235952;
        Thu, 07 May 2020 04:33:55 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id t4sm2834162wmf.33.2020.05.07.04.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 04:33:55 -0700 (PDT)
Date:   Thu, 7 May 2020 07:33:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH v3 07/15] mm/memory_hotplug: Introduce
 offline_and_remove_memory()
Message-ID: <20200507073302-mutt-send-email-mst@kernel.org>
References: <20200507103119.11219-1-david@redhat.com>
 <20200507103119.11219-8-david@redhat.com>
 <20200507064558-mutt-send-email-mst@kernel.org>
 <a915653f-232e-aa13-68f7-f988704fa84c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a915653f-232e-aa13-68f7-f988704fa84c@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 01:24:38PM +0200, David Hildenbrand wrote:
> On 07.05.20 12:46, Michael S. Tsirkin wrote:
> > On Thu, May 07, 2020 at 12:31:11PM +0200, David Hildenbrand wrote:
> >> virtio-mem wants to offline and remove a memory block once it unplugged
> >> all subblocks (e.g., using alloc_contig_range()). Let's provide
> >> an interface to do that from a driver. virtio-mem already supports to
> >> offline partially unplugged memory blocks. Offlining a fully unplugged
> >> memory block will not require to migrate any pages. All unplugged
> >> subblocks are PageOffline() and have a reference count of 0 - so
> >> offlining code will simply skip them.
> >>
> >> All we need is an interface to offline and remove the memory from kernel
> >> module context, where we don't have access to the memory block devices
> >> (esp. find_memory_block() and device_offline()) and the device hotplug
> >> lock.
> >>
> >> To keep things simple, allow to only work on a single memory block.
> >>
> >> Acked-by: Michal Hocko <mhocko@suse.com>
> >> Tested-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: David Hildenbrand <david@redhat.com>
> >> Cc: Oscar Salvador <osalvador@suse.com>
> >> Cc: Michal Hocko <mhocko@suse.com>
> >> Cc: Pavel Tatashin <pasha.tatashin@soleen.com>
> >> Cc: Wei Yang <richard.weiyang@gmail.com>
> >> Cc: Dan Williams <dan.j.williams@intel.com>
> >> Cc: Qian Cai <cai@lca.pw>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> > 
> > 
> > didn't you lose Andrew Morton's ack here?
> 
> Yeah, thanks for noticing.
> 
> > 
> >> ---
> >>  include/linux/memory_hotplug.h |  1 +
> >>  mm/memory_hotplug.c            | 37 ++++++++++++++++++++++++++++++++++
> >>  2 files changed, 38 insertions(+)
> > 
> > I get:
> > 
> > error: sha1 information is lacking or useless (mm/memory_hotplug.c).
> > error: could not build fake ancestor
> > 
> > which version is this against? Pls post patches on top of some tag
> > in Linus' tree if possible.
> 
> As the cover states, latest linux-next. To be precise
> 
> commit 6b43f715b6379433e8eb30aa9bcc99bd6a585f77 (tag: next-20200507,
> next/master)
> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> Date:   Thu May 7 18:11:31 2020 +1000
> 
>     Add linux-next specific files for 20200507
> 

Don't base on linux-next please. Generally base on the tree you are
targeting, or Linus' tree.


> -- 
> Thanks,
> 
> David / dhildenb

