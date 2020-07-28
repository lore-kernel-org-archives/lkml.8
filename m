Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CF0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25F5D20672
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 17:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="c68YZvbK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbgG1Rmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 13:42:50 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:57691 "EHLO
        esa3.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732035AbgG1Rmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 13:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1595958171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bm6xpS3UPlSHgrr/AwBHxbllr8iQgva7zYaEqmfywQE=;
  b=c68YZvbKM6yvoUYtaO8IeJCtT59yKXQfAbftBGBAgv5t8N64G6o8mzin
   lVSp8DnDsNOj/zhB9GuaLMIwhXuAx28UsPzTr1QyEhGfXWgOTEHvPytbb
   +ai8cfgaATyb/S1REt4RFvd7Enw9aFAL8gRMWzQFChhpu4bU8WEL+ZGih
   Q=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: tqfc4/1PrubWMv5ewSP0LHdTujHFP8U+m86/9kdKUf1uh2GxSqdRLKvvIjL7M7hl/BUVdvDraQ
 7xWgR+boyI9h5kdqmKdL4Un2zB12iUpSymGIbUEEQ7O8Hw5Bf2EayFOnHW8bDGV9iixxNVgLOC
 ohHW/uZUKSlMasSdB5PVjkQ2CjgPz8+aAB4j7j0KQdWkgHS/AF8C2gxIr9YIlD7LejhmX4/3f6
 NuNWHo6AupAExmeZCKgns9LBWBBDJcckRANyYzThzC0R8PZACty0nlqgJXI7DofDVY/yjkEeEd
 sT0=
X-SBRS: 2.7
X-MesageID: 23367204
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,406,1589256000"; 
   d="scan'208";a="23367204"
Date:   Tue, 28 Jul 2020 19:42:42 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
CC:     Julien Grall <julien@xen.org>, Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        Wei Liu <wl@xen.org>,
        "Oleksandr Andrushchenko" <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>,
        Yan Yankovskyi <yyankovskyi@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 4/4] xen: add helpers to allocate unpopulated memory
Message-ID: <20200728174242.GB7191@Air-de-Roger>
References: <20200727091342.52325-1-roger.pau@citrix.com>
 <20200727091342.52325-5-roger.pau@citrix.com>
 <b5460659-88a5-c2aa-c339-815d5618bcb5@xen.org>
 <20200728165919.GA7191@Air-de-Roger>
 <cb1790b3-2ad0-2c1b-a632-e4fea4b6bcfa@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cb1790b3-2ad0-2c1b-a632-e4fea4b6bcfa@citrix.com>
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 06:06:25PM +0100, Andrew Cooper wrote:
> On 28/07/2020 17:59, Roger Pau Monné wrote:
> > On Tue, Jul 28, 2020 at 05:48:23PM +0100, Julien Grall wrote:
> >> Hi,
> >>
> >> On 27/07/2020 10:13, Roger Pau Monne wrote:
> >>> To be used in order to create foreign mappings. This is based on the
> >>> ZONE_DEVICE facility which is used by persistent memory devices in
> >>> order to create struct pages and kernel virtual mappings for the IOMEM
> >>> areas of such devices. Note that on kernels without support for
> >>> ZONE_DEVICE Xen will fallback to use ballooned pages in order to
> >>> create foreign mappings.
> >>>
> >>> The newly added helpers use the same parameters as the existing
> >>> {alloc/free}_xenballooned_pages functions, which allows for in-place
> >>> replacement of the callers. Once a memory region has been added to be
> >>> used as scratch mapping space it will no longer be released, and pages
> >>> returned are kept in a linked list. This allows to have a buffer of
> >>> pages and prevents resorting to frequent additions and removals of
> >>> regions.
> >>>
> >>> If enabled (because ZONE_DEVICE is supported) the usage of the new
> >>> functionality untangles Xen balloon and RAM hotplug from the usage of
> >>> unpopulated physical memory ranges to map foreign pages, which is the
> >>> correct thing to do in order to avoid mappings of foreign pages depend
> >>> on memory hotplug.
> >> I think this is going to break Dom0 on Arm if the kernel has been built with
> >> hotplug. This is because you may end up to re-use region that will be used
> >> for the 1:1 mapping of a foreign map.
> >>
> >> Note that I don't know whether hotplug has been tested on Xen on Arm yet. So
> >> it might be possible to be already broken.
> >>
> >> Meanwhile, my suggestion would be to make the use of hotplug in the balloon
> >> code conditional (maybe using CONFIG_ARM64 and CONFIG_ARM)?
> > Right, this feature (allocation of unpopulated memory separated from
> > the balloon driver) is currently gated on CONFIG_ZONE_DEVICE, which I
> > think could be used on Arm.
> >
> > IMO the right solution seems to be to subtract the physical memory
> > regions that can be used for the identity mappings of foreign pages
> > (all RAM on the system AFAICT) from iomem_resource, as that would make
> > this and the memory hotplug done in the balloon driver safe?
> 
> The right solution is a mechanism for translated guests to query Xen to
> find regions of guest physical address space which are unused, and can
> be safely be used for foreign/grant/other  mappings.
> 
> Please don't waste any more time applying more duct tape to a broken
> system, and instead spend the time organising some proper foundations.

The piece added here (using ZONE_DEVICE) will be relevant when Xen can
provide the space to map foreign pages, it's just that right now it
relies on iomem_resource instead of a Xen specific resource map that
should be provided by the hypervisor. It should indeed be fixed, but
right now this patch should allow a PVH dom0 to work slightly better.
When Xen provides such areas Linux just needs to populate a custom Xen
resource with them and use it instead of iomem_resurce.

The Arm stuff I'm certainly not familiar with, and can't provide much
insight on that. If it's best to just disable it and continue to rely
on ballooned out pages that's fine.

Roger.
