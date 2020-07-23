Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5935C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6C720792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 12:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Gryz+W9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgGWMXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 08:23:10 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:21524 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgGWMXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 08:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1595506987;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j6qul/NVIhOo7e+TLhNG7ehnkX4T5gKRyU+jhvsVBOU=;
  b=Gryz+W9CwsOe3o1rsuphzIi9TWKuXXwnykYNQXn7Xg/Ofw53Tr32aF8y
   3is8rq9mnVXtpCIDveKhgkRzkKw/JxzTbmkhfWeseEyJidpoZf+417dpS
   n2DhPZr7mGVUGksHvL08CkIKDqS733r64sGQjbsK+/UHdzGJTolEnWQWB
   0=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: ky2qICr6DqkiBG7KlBXtd8Nsu9X16KtCcJpdaQl2eTun6se982M36cWHvyEBpZRpb7rH+JG/KC
 m6C22yVSuSt1y3f7cVBJ/RCRwq062uamwwz6G27s1MRDsXFja6WtxfdFAr6thhDLxt1I3WpQIc
 eRrGfyDqy2MQ5l0ZSzYYNTtUfJUZ9TIanmdgQ9JBuerBzX2SHfUIg4YXga4CA3F4eViEcIUa4a
 s2Oj410dcO+gDBI1Oz2vpjMxYehXG2ooG1W38YV5EjT9bxPSEr0U2K5GMu8tZYVE6dvhkgBanA
 3fc=
X-SBRS: 2.7
X-MesageID: 23358347
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,386,1589256000"; 
   d="scan'208";a="23358347"
Date:   Thu, 23 Jul 2020 14:23:00 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     David Hildenbrand <david@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <xen-devel@lists.xenproject.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 3/3] memory: introduce an option to force onlining of
 hotplug memory
Message-ID: <20200723122300.GD7191@Air-de-Roger>
References: <20200723084523.42109-1-roger.pau@citrix.com>
 <20200723084523.42109-4-roger.pau@citrix.com>
 <21490d49-b2cf-a398-0609-8010bdb0b004@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <21490d49-b2cf-a398-0609-8010bdb0b004@redhat.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 01:37:03PM +0200, David Hildenbrand wrote:
> On 23.07.20 10:45, Roger Pau Monne wrote:
> > Add an extra option to add_memory_resource that overrides the memory
> > hotplug online behavior in order to force onlining of memory from
> > add_memory_resource unconditionally.
> > 
> > This is required for the Xen balloon driver, that must run the
> > online page callback in order to correctly process the newly added
> > memory region, note this is an unpopulated region that is used by Linux
> > to either hotplug RAM or to map foreign pages from other domains, and
> > hence memory hotplug when running on Xen can be used even without the
> > user explicitly requesting it, as part of the normal operations of the
> > OS when attempting to map memory from a different domain.
> > 
> > Setting a different default value of memhp_default_online_type when
> > attaching the balloon driver is not a robust solution, as the user (or
> > distro init scripts) could still change it and thus break the Xen
> > balloon driver.
> 
> I think we discussed this a couple of times before (even triggered by my
> request), and this is responsibility of user space to configure. Usually
> distros have udev rules to online memory automatically. Especially, user
> space should eb able to configure *how* to online memory.

Note (as per the commit message) that in the specific case I'm
referring to the memory hotplugged by the Xen balloon driver will be
an unpopulated range to be used internally by certain Xen subsystems,
like the xen-blkback or the privcmd drivers. The addition of such
blocks of (unpopulated) memory can happen without the user explicitly
requesting it, and hence not even aware such hotplug process is taking
place. To be clear: no actual RAM will be added to the system.

Failure to online such blocks using the Xen specific online handler
(which does not handle back the memory to the allocator in any way)
will result in the system getting stuck and malfunctioning.

> It's the admin/distro responsibility to configure this properly. In case
> this doesn't happen (or as you say, users change it), bad luck.
> 
> E.g., virtio-mem takes care to not add more memory in case it is not
> getting onlined. I remember hyper-v has similar code to at least wait a
> bit for memory to get onlined.

I don't think VirtIO or Hyper-V use the hotplug system in the same way
as Xen, as said this is done to add unpopulated memory regions that
will be used to map foreign memory (from other domains) by Xen drivers
on the system.

Maybe this should somehow use a different mechanism to hotplug such
empty memory blocks? I don't mind doing this differently, but I would
need some pointers. Allowing user-space to change a (seemingly
unrelated) parameter and as a result produce failures on Xen drivers
is not an acceptable solution IMO.

Thanks, Roger.
