Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3030DC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A7912065D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:25:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Onrf+/q5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgGWNZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:25:10 -0400
Received: from esa6.hc3370-68.iphmx.com ([216.71.155.175]:24773 "EHLO
        esa6.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgGWNZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1595510708;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=dzkYPQkWuIKszRErK34RX+I5IJu4n5MB+23a1TyFK1Y=;
  b=Onrf+/q5zTnntN63mSbfYdZnPqrHs9ILyVOrctgAUM9m5tGW9dL7TfkX
   XOFoRmDmYHtjsDBanIDBn2U4GAnQp6yVdPMvdCdo/jSwWnnl/q9gK9ffq
   cd+s4g41hLWlgG2RDjuoukYtM6rAN2Nd6sPgKlWEjL3NHmHgM0gMJP8fQ
   c=;
Authentication-Results: esa6.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: hOa7QLdLG4sGCBb98EKi9ESS5BawhFC2ZRJ0t8z3qRtPr7/JcAaRwVCUiMx00yVY9q0BWMMc2y
 EJEFrR8DRLeTbZ9tUl45BDZ1uoYV5ZPgB8LRI6IwwELn49a3nlLty4Rp24orrUEL3/2aJm7k5Q
 WYibHeAaC5zq9npx9jp5FYOwEgVlCDgV+u7runjA/wYjj4USyiKg8nf5WGLr2jIWGQtUnHdwsw
 97ItFod9fnwcAPjpR5w6SWIxIUTOqf/nAHW+7RRkAzap0rBugUku0pYuG/dyjD1E13qenKgqKQ
 HFs=
X-SBRS: 2.7
X-MesageID: 23366682
X-Ironport-Server: esa6.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,386,1589256000"; 
   d="scan'208";a="23366682"
Date:   Thu, 23 Jul 2020 15:25:00 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     David Hildenbrand <david@redhat.com>
CC:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <xen-devel@lists.xenproject.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH 3/3] memory: introduce an option to force onlining of
 hotplug memory
Message-ID: <20200723132500.GF7191@Air-de-Roger>
References: <20200723084523.42109-1-roger.pau@citrix.com>
 <20200723084523.42109-4-roger.pau@citrix.com>
 <21490d49-b2cf-a398-0609-8010bdb0b004@redhat.com>
 <20200723122300.GD7191@Air-de-Roger>
 <404ea76f-c3d8-dbc5-432d-08d84a17f2d7@suse.com>
 <20200723130831.GE7191@Air-de-Roger>
 <0e04b526-924d-aa51-cc2e-2c7561ce3df2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e04b526-924d-aa51-cc2e-2c7561ce3df2@redhat.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 03:14:31PM +0200, David Hildenbrand wrote:
> On 23.07.20 15:08, Roger Pau Monné wrote:
> > On Thu, Jul 23, 2020 at 02:28:13PM +0200, Jürgen Groß wrote:
> >> On 23.07.20 14:23, Roger Pau Monné wrote:
> >>> On Thu, Jul 23, 2020 at 01:37:03PM +0200, David Hildenbrand wrote:
> >>>> On 23.07.20 10:45, Roger Pau Monne wrote:
> >>>>> Add an extra option to add_memory_resource that overrides the memory
> >>>>> hotplug online behavior in order to force onlining of memory from
> >>>>> add_memory_resource unconditionally.
> >>>>>
> >>>>> This is required for the Xen balloon driver, that must run the
> >>>>> online page callback in order to correctly process the newly added
> >>>>> memory region, note this is an unpopulated region that is used by Linux
> >>>>> to either hotplug RAM or to map foreign pages from other domains, and
> >>>>> hence memory hotplug when running on Xen can be used even without the
> >>>>> user explicitly requesting it, as part of the normal operations of the
> >>>>> OS when attempting to map memory from a different domain.
> >>>>>
> >>>>> Setting a different default value of memhp_default_online_type when
> >>>>> attaching the balloon driver is not a robust solution, as the user (or
> >>>>> distro init scripts) could still change it and thus break the Xen
> >>>>> balloon driver.
> >>>>
> >>>> I think we discussed this a couple of times before (even triggered by my
> >>>> request), and this is responsibility of user space to configure. Usually
> >>>> distros have udev rules to online memory automatically. Especially, user
> >>>> space should eb able to configure *how* to online memory.
> >>>
> >>> Note (as per the commit message) that in the specific case I'm
> >>> referring to the memory hotplugged by the Xen balloon driver will be
> >>> an unpopulated range to be used internally by certain Xen subsystems,
> >>> like the xen-blkback or the privcmd drivers. The addition of such
> >>> blocks of (unpopulated) memory can happen without the user explicitly
> >>> requesting it, and hence not even aware such hotplug process is taking
> >>> place. To be clear: no actual RAM will be added to the system.
> >>>
> >>> Failure to online such blocks using the Xen specific online handler
> >>> (which does not handle back the memory to the allocator in any way)
> >>> will result in the system getting stuck and malfunctioning.
> >>>
> >>>> It's the admin/distro responsibility to configure this properly. In case
> >>>> this doesn't happen (or as you say, users change it), bad luck.
> >>>>
> >>>> E.g., virtio-mem takes care to not add more memory in case it is not
> >>>> getting onlined. I remember hyper-v has similar code to at least wait a
> >>>> bit for memory to get onlined.
> >>>
> >>> I don't think VirtIO or Hyper-V use the hotplug system in the same way
> >>> as Xen, as said this is done to add unpopulated memory regions that
> >>> will be used to map foreign memory (from other domains) by Xen drivers
> >>> on the system.
> >>>
> >>> Maybe this should somehow use a different mechanism to hotplug such
> >>> empty memory blocks? I don't mind doing this differently, but I would
> >>> need some pointers. Allowing user-space to change a (seemingly
> >>> unrelated) parameter and as a result produce failures on Xen drivers
> >>> is not an acceptable solution IMO.
> >>
> >> Maybe we can use the same approach as Xen PV-domains: pre-allocate a
> >> region in the memory map to be used for mapping foreign pages. For the
> >> kernel it will look like pre-ballooned memory, so it will create struct
> >> page for the region (which is what we are after), but it won't give the
> >> memory to the allocator.
> > 
> > IMO using something similar to memory hotplug would give us more
> > flexibility, and TBH the logic is already there in the balloon driver.
> > It seems quite wasteful to allocate such region(s) beforehand for all
> > domains, even when most of them won't end up using foreign mappings at
> > all.
> 
> I do wonder why these issues you describe start to pop up now, literally
> years after this stuff has been implemented - or am I missing something
> important?

We are (very slowly) implementing support to switch to a PVH dom0
(something similar to a fully emulated guest as dom0), and that kind
of guest no longer has a pre-allocated memory region for mappings,
likely because we mostly use the native path when dealing with
memory, and such reservation was done by the PV specific setup path
that deals with the memory map.

> > 
> > Anyway, I'm going to take a look at how to do that, I guess it's going
> > to involve playing with the memory map and reserving some space.
> > 
> > I suggest we should remove the Xen balloon hotplug logic, as it's not
> > working properly and we don't have a plan to fix it.
> 
> Which exact hotplug logic are you referring to?

There are some sections in the Xen balloon driver protected with
CONFIG_XEN_BALLOON_MEMORY_HOTPLUG.

When xen_hotplug_unpopulated is enabled but the default policy for
memory hotplug is to not online the added blocks certain operations
like alloc_xenballooned_pages would block forever waiting for the
hotplugged memory to be onlined in order to be usable.

Thanks, Roger.
