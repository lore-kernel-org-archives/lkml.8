Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B216C433EC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46AC82053B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 16:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Z+RemIi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbgG1Q7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:59:33 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:49540 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731578AbgG1Q71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1595955568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tRrG2kIPRmHZl5KYjBZDnpKOe+a1KAifCS6TcraQCvw=;
  b=Z+RemIi/6pAEEYTQzK56hTBK9EUNPk1nEZ75Jlzp2fDrA1Uh9N6rix76
   9q4w1goHGh99cAAC3+5P4ZSwb+XcIq6IiUaiG0//qC5CnDpxXIqQ2Va66
   Ii6yg6GtaZFEkI8bjVfKyb9oKi/r0vDjEAXo2XuS5VJJ+KmKI5t4lUoYW
   Q=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: ek+XUNwRJ4Q5p4iyKzYjQH2lwOuZGVQ6Lx+zstg9NwpzzjRk2zB+v1/h9r6kuVVwRRNSCQGoXa
 D8++MW18YDeKCEmXhrvpH1ZyV0JbQvvIgpmIJERE5rrUKGp9cmDKMmPTr4piKhlvofOfDIfJYe
 2rK+680bc67sJoyZee3FTviqXiwfbr0qq0/CqTZ5Z0mVPLSMrngigHlxQVYUtTkhCySNVkupEs
 zSdbmNe7SgW5IpviGcOeDar3EuhU7jdXOS/8qypW3eFImgTAyx5Vym8iTQCHVMYS3dHYj3I2H8
 GeI=
X-SBRS: 2.7
X-MesageID: 23705708
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,406,1589256000"; 
   d="scan'208";a="23705708"
Date:   Tue, 28 Jul 2020 18:59:19 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     Julien Grall <julien@xen.org>
CC:     <linux-kernel@vger.kernel.org>, Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        Wei Liu <wl@xen.org>,
        "Oleksandr Andrushchenko" <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>,
        Yan Yankovskyi <yyankovskyi@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        <dri-devel@lists.freedesktop.org>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 4/4] xen: add helpers to allocate unpopulated memory
Message-ID: <20200728165919.GA7191@Air-de-Roger>
References: <20200727091342.52325-1-roger.pau@citrix.com>
 <20200727091342.52325-5-roger.pau@citrix.com>
 <b5460659-88a5-c2aa-c339-815d5618bcb5@xen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <b5460659-88a5-c2aa-c339-815d5618bcb5@xen.org>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 05:48:23PM +0100, Julien Grall wrote:
> Hi,
> 
> On 27/07/2020 10:13, Roger Pau Monne wrote:
> > To be used in order to create foreign mappings. This is based on the
> > ZONE_DEVICE facility which is used by persistent memory devices in
> > order to create struct pages and kernel virtual mappings for the IOMEM
> > areas of such devices. Note that on kernels without support for
> > ZONE_DEVICE Xen will fallback to use ballooned pages in order to
> > create foreign mappings.
> > 
> > The newly added helpers use the same parameters as the existing
> > {alloc/free}_xenballooned_pages functions, which allows for in-place
> > replacement of the callers. Once a memory region has been added to be
> > used as scratch mapping space it will no longer be released, and pages
> > returned are kept in a linked list. This allows to have a buffer of
> > pages and prevents resorting to frequent additions and removals of
> > regions.
> > 
> > If enabled (because ZONE_DEVICE is supported) the usage of the new
> > functionality untangles Xen balloon and RAM hotplug from the usage of
> > unpopulated physical memory ranges to map foreign pages, which is the
> > correct thing to do in order to avoid mappings of foreign pages depend
> > on memory hotplug.
> I think this is going to break Dom0 on Arm if the kernel has been built with
> hotplug. This is because you may end up to re-use region that will be used
> for the 1:1 mapping of a foreign map.
> 
> Note that I don't know whether hotplug has been tested on Xen on Arm yet. So
> it might be possible to be already broken.
> 
> Meanwhile, my suggestion would be to make the use of hotplug in the balloon
> code conditional (maybe using CONFIG_ARM64 and CONFIG_ARM)?

Right, this feature (allocation of unpopulated memory separated from
the balloon driver) is currently gated on CONFIG_ZONE_DEVICE, which I
think could be used on Arm.

IMO the right solution seems to be to subtract the physical memory
regions that can be used for the identity mappings of foreign pages
(all RAM on the system AFAICT) from iomem_resource, as that would make
this and the memory hotplug done in the balloon driver safe?

Thanks, Roger.
