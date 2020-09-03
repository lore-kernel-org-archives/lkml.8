Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4141C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A85D20578
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Io7Y/6j5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgICQiw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:38:52 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:25354 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgICQit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1599151128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1r9p2+RFoF3u+hOb93ac0ysyr0EJPEppHknwa791fSA=;
  b=Io7Y/6j5GZ3IHmYkbGqKfewzhAvtnLOM8W6dzlShv2LVvKOuAVn6gcc9
   QTKwdywHLXMaAMfxvbE23O2qeRhvwpvYH3C8tfNZCJuODuK2tcMD/vXPv
   iBQd6oUWIa3c5jOv6ro0Atn5Mf/T4FfTdw5hkUYDn11hrIFsNDVSZmn5y
   A=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: n1UBm6NTmzRoEEmp6chXaBm2JeGlv1UPeWW4NcDpE6MmwKaEEug3qgxA4LMjLaJkfVteFGd+aK
 UyQpDEBtpjDgR7UYwd0Jg33GV7o86inlKKFgsaaHyJNUflCzFSfwopxMOWerSgF0XhG9sEzEfL
 4RRD4RotP+qyYV2hpJYsl3r0gsfqUIOsSdH5lSVHXWp122/oY9ooFXECyGx/srx7sfWn8zfJG2
 vY03kGbKprm5mmB9gPqzwmUs7bHHXQflmjbxrqlmteL5zA03CFuteALBCgRnmyTsXmwaj14XY0
 bkc=
X-SBRS: 2.7
X-MesageID: 26904079
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.76,387,1592884800"; 
   d="scan'208";a="26904079"
Date:   Thu, 3 Sep 2020 18:38:37 +0200
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
Message-ID: <20200903163837.GM753@Air-de-Roger>
References: <20200901083326.21264-1-roger.pau@citrix.com>
 <20200901083326.21264-4-roger.pau@citrix.com>
 <b1713f26-8202-ac1e-c18a-4989312219b9@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b1713f26-8202-ac1e-c18a-4989312219b9@suse.com>
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 FTLPEX02CL06.citrite.net (10.13.108.179)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 05:30:07PM +0200, Jürgen Groß wrote:
> On 01.09.20 10:33, Roger Pau Monne wrote:
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
> > 
> > Note the driver is currently not enabled on Arm platforms because it
> > would interfere with the identity mapping required on some platforms.
> > 
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> 
> Sorry, I just got a build error for x86 32-bit build:
> 
> WARNING: unmet direct dependencies detected for ZONE_DEVICE
>   Depends on [n]: MEMORY_HOTPLUG [=n] && MEMORY_HOTREMOVE [=n] &&
> SPARSEMEM_VMEMMAP [=n] && ARCH_HAS_PTE_DEVMAP [=n]
>   Selected by [y]:
>   - XEN_UNPOPULATED_ALLOC [=y] && XEN [=y] && X86 [=y]
>   GEN     Makefile
>   CC      kernel/bounds.s
>   CALL    /home/gross/korg/src/scripts/atomic/check-atomics.sh
>   UPD     include/generated/bounds.h
>   CC      arch/x86/kernel/asm-offsets.s
> In file included from /home/gross/korg/src/include/linux/mmzone.h:19:0,
>                  from /home/gross/korg/src/include/linux/gfp.h:6,
>                  from /home/gross/korg/src/include/linux/slab.h:15,
>                  from /home/gross/korg/src/include/linux/crypto.h:19,
>                  from /home/gross/korg/src/arch/x86/kernel/asm-offsets.c:9:
> /home/gross/korg/src/include/linux/page-flags-layout.h:95:2: error: #error
> "Not enough bits in page flags"
>  #error "Not enough bits in page flags"
>   ^~~~~
> make[2]: *** [/home/gross/korg/src/scripts/Makefile.build:114:
> arch/x86/kernel/asm-offsets.s] Error 1
> make[1]: *** [/home/gross/korg/src/Makefile:1175: prepare0] Error 2
> make[1]: Leaving directory '/home/gross/korg/x8632'
> make: *** [Makefile:185: __sub-make] Error 2

Sorry for this. I've tested a 32bit build but I think it was before
the last Kconfig changes. I'm a little unsure how to solve this, as
ZONE_DEVICE doesn't select the required options for it to run, but
rather depends on them to be available.

You can trigger something similar on x86-64 by doing:

$ make ARCH=x86_64 xen.config
Using .config as base
Merging ./kernel/configs/xen.config
Merging ./arch/x86/configs/xen.config
#
# merged configuration written to .config (needs make)
#
scripts/kconfig/conf  --olddefconfig Kconfig

WARNING: unmet direct dependencies detected for ZONE_DEVICE
  Depends on [n]: MEMORY_HOTPLUG [=y] && MEMORY_HOTREMOVE [=n] && SPARSEMEM_VMEMMAP [=y] && ARCH_HAS_PTE_DEVMAP [=y]
  Selected by [y]:
  - XEN_UNPOPULATED_ALLOC [=y] && XEN [=y] && X86_64 [=y]
#
# configuration written to .config
#

I think the only solution is to have XEN_UNPOPULATED_ALLOC depend on
ZONE_DEVICE rather than select it?

Thanks, Roger.
