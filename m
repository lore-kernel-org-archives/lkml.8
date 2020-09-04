Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659D1C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3926B2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 08:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="VJH4hc0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbgIDImq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 04:42:46 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:41414 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgIDImn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1599208963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=xLTKJpKu0Qb9zvtBCrFuNtN0uryK+Cr91K+kobkwuTU=;
  b=VJH4hc0FPhmjgut4SqbjI7CokB2tWO7ccaoYtbQZPeKo8AETmu6DDSfU
   uWYiCukAb9/QxH/zjCH7IM1NY4yc0cSjqalXiTWZtLKDIuq1sktwsuruY
   5IQfNXZ3C6lgKNwHAwXcVM0nkJ4971tSTcYWex88WkjAiPBi2OCjDiGg7
   s=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: h5tULVCP7TU027wl9AXL6ZQ6VRDTloWxNR1nakHosYYzU8awVMN14syMLQayv9uBc8sCFQrpo9
 MPsKynxlrUeIV2fLzkBXNB2LUVlnfaK5CMhGyHMRLQdBCX/4b+icfvHWVHnKE5oWjtKeDrh1Vt
 bxXRH4/LS58XLNlEMXW3QOoEhr480K9hH8A115xIrprTnfo3A9FB8sMcgG1DSn17YgpLbZzhqS
 8hNixQHRV8a/451xr8mSb/Ts/liLTz0NYAxGPT2Wdtw9MukJ2GIKcdJVYScDS0jHAxjENA9Gp1
 +EE=
X-SBRS: 2.7
X-MesageID: 26001821
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.76,389,1592884800"; 
   d="scan'208";a="26001821"
Date:   Fri, 4 Sep 2020 10:42:29 +0200
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
CC:     <linux-kernel@vger.kernel.org>,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
        David Airlie <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>, Wei Liu <wl@xen.org>,
        Yan Yankovskyi <yyankovskyi@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <xen-devel@lists.xenproject.org>, <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 3/3] xen: add helpers to allocate unpopulated memory
Message-ID: <20200904084229.GN753@Air-de-Roger>
References: <20200901083326.21264-1-roger.pau@citrix.com>
 <20200901083326.21264-4-roger.pau@citrix.com>
 <b1713f26-8202-ac1e-c18a-4989312219b9@suse.com>
 <20200903163837.GM753@Air-de-Roger>
 <6fd73d30-5525-7f00-1e9c-d7bb96ea34a6@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fd73d30-5525-7f00-1e9c-d7bb96ea34a6@suse.com>
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 FTLPEX02CL06.citrite.net (10.13.108.179)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 09:00:18AM +0200, Jürgen Groß wrote:
> On 03.09.20 18:38, Roger Pau Monné wrote:
> > On Thu, Sep 03, 2020 at 05:30:07PM +0200, Jürgen Groß wrote:
> > > On 01.09.20 10:33, Roger Pau Monne wrote:
> > > > To be used in order to create foreign mappings. This is based on the
> > > > ZONE_DEVICE facility which is used by persistent memory devices in
> > > > order to create struct pages and kernel virtual mappings for the IOMEM
> > > > areas of such devices. Note that on kernels without support for
> > > > ZONE_DEVICE Xen will fallback to use ballooned pages in order to
> > > > create foreign mappings.
> > > > 
> > > > The newly added helpers use the same parameters as the existing
> > > > {alloc/free}_xenballooned_pages functions, which allows for in-place
> > > > replacement of the callers. Once a memory region has been added to be
> > > > used as scratch mapping space it will no longer be released, and pages
> > > > returned are kept in a linked list. This allows to have a buffer of
> > > > pages and prevents resorting to frequent additions and removals of
> > > > regions.
> > > > 
> > > > If enabled (because ZONE_DEVICE is supported) the usage of the new
> > > > functionality untangles Xen balloon and RAM hotplug from the usage of
> > > > unpopulated physical memory ranges to map foreign pages, which is the
> > > > correct thing to do in order to avoid mappings of foreign pages depend
> > > > on memory hotplug.
> > > > 
> > > > Note the driver is currently not enabled on Arm platforms because it
> > > > would interfere with the identity mapping required on some platforms.
> > > > 
> > > > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> > > 
> > > Sorry, I just got a build error for x86 32-bit build:
> > > 
> > > WARNING: unmet direct dependencies detected for ZONE_DEVICE
> > >    Depends on [n]: MEMORY_HOTPLUG [=n] && MEMORY_HOTREMOVE [=n] &&
> > > SPARSEMEM_VMEMMAP [=n] && ARCH_HAS_PTE_DEVMAP [=n]
> > >    Selected by [y]:
> > >    - XEN_UNPOPULATED_ALLOC [=y] && XEN [=y] && X86 [=y]
> > >    GEN     Makefile
> > >    CC      kernel/bounds.s
> > >    CALL    /home/gross/korg/src/scripts/atomic/check-atomics.sh
> > >    UPD     include/generated/bounds.h
> > >    CC      arch/x86/kernel/asm-offsets.s
> > > In file included from /home/gross/korg/src/include/linux/mmzone.h:19:0,
> > >                   from /home/gross/korg/src/include/linux/gfp.h:6,
> > >                   from /home/gross/korg/src/include/linux/slab.h:15,
> > >                   from /home/gross/korg/src/include/linux/crypto.h:19,
> > >                   from /home/gross/korg/src/arch/x86/kernel/asm-offsets.c:9:
> > > /home/gross/korg/src/include/linux/page-flags-layout.h:95:2: error: #error
> > > "Not enough bits in page flags"
> > >   #error "Not enough bits in page flags"
> > >    ^~~~~
> > > make[2]: *** [/home/gross/korg/src/scripts/Makefile.build:114:
> > > arch/x86/kernel/asm-offsets.s] Error 1
> > > make[1]: *** [/home/gross/korg/src/Makefile:1175: prepare0] Error 2
> > > make[1]: Leaving directory '/home/gross/korg/x8632'
> > > make: *** [Makefile:185: __sub-make] Error 2
> > 
> > Sorry for this. I've tested a 32bit build but I think it was before
> > the last Kconfig changes. I'm a little unsure how to solve this, as
> > ZONE_DEVICE doesn't select the required options for it to run, but
> > rather depends on them to be available.
> > 
> > You can trigger something similar on x86-64 by doing:
> > 
> > $ make ARCH=x86_64 xen.config
> > Using .config as base
> > Merging ./kernel/configs/xen.config
> > Merging ./arch/x86/configs/xen.config
> > #
> > # merged configuration written to .config (needs make)
> > #
> > scripts/kconfig/conf  --olddefconfig Kconfig
> > 
> > WARNING: unmet direct dependencies detected for ZONE_DEVICE
> >    Depends on [n]: MEMORY_HOTPLUG [=y] && MEMORY_HOTREMOVE [=n] && SPARSEMEM_VMEMMAP [=y] && ARCH_HAS_PTE_DEVMAP [=y]
> >    Selected by [y]:
> >    - XEN_UNPOPULATED_ALLOC [=y] && XEN [=y] && X86_64 [=y]
> > #
> > # configuration written to .config
> > #
> > 
> > I think the only solution is to have XEN_UNPOPULATED_ALLOC depend on
> > ZONE_DEVICE rather than select it?
> 
> Yes, I think so.
> 
> I've folded that in and now build is fine.

Thanks, I assume no further action is needed on my side.

Roger.
