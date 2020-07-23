Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187FAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD69B206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="GwwRckPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbgGWQXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:23:05 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:55996 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgGWQXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:23:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1595521385;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pnROkcEpzt5hqqMgmqaKRrmNaTL4b1rnk61ZyREWxOE=;
  b=GwwRckPuN9CZXV0JIapMxBsl4NokNF+orfmrVvOSUgMU5CQXygZKXV3y
   nBSHGlc/G6T7lvGffPF8/Gzduey/TSkZzcOjrEI3PzeVXUUGatUycgDx5
   rtj17PZbSaZ0psZLvYwKZsuCctMwGUuThe8mhvIXcRKN5rRixKeu7/QoG
   U=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: SWN1Qv9Vg9UuCVerUDK4H3bgKeOadVxeZGsvJXl6PnccOSKOYBTcvN9I6wjT6IwJFkPdhXIRw0
 kFcKo29eMjnJoS2WsGGcaZyca03MQjcyw9U9320DxG5Asn9dsHmVHne9Bb6/eAg5+tv33V2pMR
 vEJbAaT3x6DNSYYJ7UfUjgvb+4YbrSOkcFVfMSfCiq8087EDxZOi+vssGJbntjDi+9FJZH7Mfe
 PdndOJ+pY4J7QtauKXpYcPYITi03og2YKjxGzu/uKM3rK82oV5/A3wPsVz9EOMq3DVQzMSI2KP
 Ebg=
X-SBRS: 2.7
X-MesageID: 23391925
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,387,1589256000"; 
   d="scan'208";a="23391925"
Date:   Thu, 23 Jul 2020 18:22:56 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        David Hildenbrand <david@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <xen-devel@lists.xenproject.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 3/3] memory: introduce an option to force onlining of
 hotplug memory
Message-ID: <20200723162256.GI7191@Air-de-Roger>
References: <20200723084523.42109-1-roger.pau@citrix.com>
 <20200723084523.42109-4-roger.pau@citrix.com>
 <21490d49-b2cf-a398-0609-8010bdb0b004@redhat.com>
 <20200723122300.GD7191@Air-de-Roger>
 <e94d9556-f615-bbe2-07d2-08958969ee5f@redhat.com>
 <20200723135930.GH7191@Air-de-Roger>
 <82b131f4-8f50-cd49-65cf-9a87d51b5555@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82b131f4-8f50-cd49-65cf-9a87d51b5555@suse.com>
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 05:10:03PM +0200, Jürgen Groß wrote:
> On 23.07.20 15:59, Roger Pau Monné wrote:
> > On Thu, Jul 23, 2020 at 03:22:49PM +0200, David Hildenbrand wrote:
> > > On 23.07.20 14:23, Roger Pau Monné wrote:
> > > > On Thu, Jul 23, 2020 at 01:37:03PM +0200, David Hildenbrand wrote:
> > > > > On 23.07.20 10:45, Roger Pau Monne wrote:
> > > > > > Add an extra option to add_memory_resource that overrides the memory
> > > > > > hotplug online behavior in order to force onlining of memory from
> > > > > > add_memory_resource unconditionally.
> > > > > > 
> > > > > > This is required for the Xen balloon driver, that must run the
> > > > > > online page callback in order to correctly process the newly added
> > > > > > memory region, note this is an unpopulated region that is used by Linux
> > > > > > to either hotplug RAM or to map foreign pages from other domains, and
> > > > > > hence memory hotplug when running on Xen can be used even without the
> > > > > > user explicitly requesting it, as part of the normal operations of the
> > > > > > OS when attempting to map memory from a different domain.
> > > > > > 
> > > > > > Setting a different default value of memhp_default_online_type when
> > > > > > attaching the balloon driver is not a robust solution, as the user (or
> > > > > > distro init scripts) could still change it and thus break the Xen
> > > > > > balloon driver.
> > > > > 
> > > > > I think we discussed this a couple of times before (even triggered by my
> > > > > request), and this is responsibility of user space to configure. Usually
> > > > > distros have udev rules to online memory automatically. Especially, user
> > > > > space should eb able to configure *how* to online memory.
> > > > 
> > > > Note (as per the commit message) that in the specific case I'm
> > > > referring to the memory hotplugged by the Xen balloon driver will be
> > > > an unpopulated range to be used internally by certain Xen subsystems,
> > > > like the xen-blkback or the privcmd drivers. The addition of such
> > > > blocks of (unpopulated) memory can happen without the user explicitly
> > > > requesting it, and hence not even aware such hotplug process is taking
> > > > place. To be clear: no actual RAM will be added to the system.
> > > 
> > > Okay, but there is also the case where XEN will actually hotplug memory
> > > using this same handler IIRC (at least I've read papers about it). Both
> > > are using the same handler, correct?
> > 
> > Yes, it's used by this dual purpose, which I have to admit I don't
> > like that much either.
> > 
> > One set of pages should be clearly used for RAM memory hotplug, and
> > the other to map foreign pages that are not related to memory hotplug,
> > it's just that we happen to need a physical region with backing struct
> > pages.
> > 
> > > > 
> > > > > It's the admin/distro responsibility to configure this properly. In case
> > > > > this doesn't happen (or as you say, users change it), bad luck.
> > > > > 
> > > > > E.g., virtio-mem takes care to not add more memory in case it is not
> > > > > getting onlined. I remember hyper-v has similar code to at least wait a
> > > > > bit for memory to get onlined.
> > > > 
> > > > I don't think VirtIO or Hyper-V use the hotplug system in the same way
> > > > as Xen, as said this is done to add unpopulated memory regions that
> > > > will be used to map foreign memory (from other domains) by Xen drivers
> > > > on the system.
> > > 
> > > Indeed, if the memory is never exposed to the buddy (and all you need is
> > > struct pages +  a kernel virtual mapping), I wonder if
> > > memremap/ZONE_DEVICE is what you want?
> > 
> > I'm certainly not familiar with the Linux memory subsystem, but if
> > that gets us a backing struct page and a kernel mapping then I would
> > say yes.
> > 
> > > Then you won't have user-visible
> > > memory blocks created with unclear online semantics, partially involving
> > > the buddy.
> > 
> > Seems like a fine solution.
> > 
> > Juergen: would you be OK to use a separate page-list for
> > alloc_xenballooned_pages on HVM/PVH using the logic described by
> > David?
> > 
> > I guess I would leave PV as-is, since it already has this reserved
> > region to map foreign pages.
> 
> I would really like a common solution, especially as it would enable
> pv driver domains to use that feature, too.

I think PV is much more easy on that regard, as it doesn't have MMIO
holes except when using PCI passthrough, and in that case it's
trivial to identify those.

However on HVM/PVH this is not so trivial. I'm certainly not opposing
to a solution that covers both, but ATM I would really like to get
something working for PVH dom0, or else it's not usable on Linux IMO.

> And finding a region for this memory zone in PVH dom0 should be common
> with PV dom0 after all. We don't want to collide with either PCI space
> or hotplug memory.

Right, we could use the native memory map for that on dom0, and maybe
create a custom resource for the Xen balloon driver instead of
allocating from iomem_resource?

DomUs are more tricky as a guest has no idea where mappings can be
safely placed, maybe we will have to resort to iomem_resource in that
case, as I don't see much other option due to the lack of information
from Xen.

I also think that ZONE_DEVICE will need some adjustments, for once the
types in memory_type don't seem to be suitable for Xen, as they are
either specific to DAX or PCI. I gave a try at using allocate_resource
plus memremap_pages but that didn't seem to fly, I will need to
investigate further.

Maybe we can resort to something even simpler than memremap_pages? I
certainly have very little idea of how this is supposed to be used,
but dev_pagemap seems overly complex for what we are trying to
achieve.

Thanks, Roger.
