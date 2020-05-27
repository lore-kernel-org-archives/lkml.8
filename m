Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64431C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216D92078B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="LwcCTZMK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgE0IZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729369AbgE0IZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:25:01 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E49FC061A0F
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:25:01 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id v128so21038635oia.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 01:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NvZ+VNZUdF3oAojZ1PZr4mNWf4dM3O3q9fsgOwa/9ss=;
        b=LwcCTZMKke6SmUSvjoAQWp49xJIXC42XUG2YRNxABwIZ2HcZDjvjspmyeSd3WSUCD2
         PC2iKD0nZJxZgYiLcknYI7RGHxo3YOoe0wYnP60VCxaVXW7S3g6wG5C3VMI98YloRlst
         8rlhWpMMm3T6ggdypnzd9AgKJPFVaMvkaQB6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NvZ+VNZUdF3oAojZ1PZr4mNWf4dM3O3q9fsgOwa/9ss=;
        b=XFMngr/Q/2qUPtAjN5whKR+f55jmaDehng7yq/CY87POOJeHGiXVfrwpNEnD4nBYZP
         qIwyXUh+pVBuNoOf5d0bzW4WJqd3meuQJi2EoAjpX5uIA2BEILkoHSJVeCtBm8Uqhv8I
         jQ+gLDGVcw+osUzQppqIg0TuRGPCgWryQAs114JyQ+cS6ogCKL18hJRZ/HteHvyrcgyZ
         YvbxJ2uQf3zjufdI9kxeIsma6hgZ+el6sGawrlYAcsomiB7R40fogWfJKgQI5hZmWguW
         JSgKuNsE1mDB+tOtSybm1ILINgbpt2fyunTEAmyUyVyAG7q9v6AINK107gHIkEwBL1ff
         kO8w==
X-Gm-Message-State: AOAM532KMHedTTuHsN9BCQNGEdAEIpbiBAv6kwLJSVU6JnWTD3vG+zCD
        q5rfGWE+wMmg6hRGefpTsGAydV+nehyQdnk3B2SGb5Z0
X-Google-Smtp-Source: ABdhPJyZsO5fBudpTQpNiH7EPqgepXtaLO1q+iAvrZBXZDwvDEkX6XuS1SZGDOgKBhsKE1C3zysVUNsyqUk7diDfcpY=
X-Received: by 2002:aca:4b91:: with SMTP id y139mr1908453oia.128.1590567900813;
 Wed, 27 May 2020 01:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <202005271520.RMhDeLDg%lkp@intel.com>
In-Reply-To: <202005271520.RMhDeLDg%lkp@intel.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Wed, 27 May 2020 10:24:49 +0200
Message-ID: <CAKMK7uE3ROsQVP8Pyo7Owa=D0bbPgOocbMXu3PPhVVb7ZDgyKQ@mail.gmail.com>
Subject: Re: drivers/gpu/drm/r128/ati_pcigart.c:188:52: sparse: sparse:
 incorrect type in assignment (different base types)
To:     kbuild test robot <lkp@intel.com>
Cc:     Jani Nikula <jani.nikula@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 9:18 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Jani,
>
> First bad commit (maybe != root cause):

This patch just moves a file, I guess that's a case the kbuild warning
tracking code doesn't (yet) handle?
-Daniel

>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   444fc5cde64330661bf59944c43844e7d4c2ccd8
> commit: be14312472e93d0c9c8c3ea8ef7d4eb59ed73f8f drm/r128: make ATI PCI GART part of its only user, r128
> date:   6 months ago
> config: ia64-randconfig-s031-20200527 (attached as .config)
> compiler: ia64-linux-gcc (GCC) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-240-gf0fe1cd9-dirty
>         git checkout be14312472e93d0c9c8c3ea8ef7d4eb59ed73f8f
>         # save the attached .config to linux build tree
>         make W=1 C=1 ARCH=ia64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
>
> sparse warnings: (new ones prefixed by >>)
>
> >> drivers/gpu/drm/r128/ati_pcigart.c:188:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
>    drivers/gpu/drm/r128/ati_pcigart.c:188:52: sparse:     expected unsigned int [usertype]
>    drivers/gpu/drm/r128/ati_pcigart.c:188:52: sparse:     got restricted __le32 [usertype]
>    drivers/gpu/drm/r128/ati_pcigart.c:200:9: sparse: sparse: undefined identifier 'wbinvd'
>
> vim +188 drivers/gpu/drm/r128/ati_pcigart.c
>
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16   99
> 55910517af381eb drivers/char/drm/ati_pcigart.c Dave Airlie            2007-07-11  100  int drm_ati_pcigart_init(struct drm_device *dev, struct drm_ati_pcigart_info *gart_info)
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  101  {
> 5a7aad9a559a548 drivers/gpu/drm/ati_pcigart.c  David Miller           2009-02-12  102   struct drm_local_map *map = &gart_info->mapping;
> 55910517af381eb drivers/char/drm/ati_pcigart.c Dave Airlie            2007-07-11  103   struct drm_sg_mem *entry = dev->sg;
> f26c473cdf557ea drivers/char/drm/ati_pcigart.c Dave Airlie            2006-01-02  104   void *address = NULL;
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  105   unsigned long pages;
> 6abf66018f7fe23 drivers/gpu/drm/ati_pcigart.c  Dave Airlie            2009-02-26  106   u32 *pci_gart = NULL, page_base, gart_idx;
> b05c23851ab820b drivers/char/drm/ati_pcigart.c Dave Airlie            2008-03-17  107   dma_addr_t bus_address = 0;
> c27889ca3bb8bdc drivers/gpu/drm/ati_pcigart.c  Dan Carpenter          2018-12-17  108   int i, j, ret = -ENOMEM;
> d30333bbabb4a2c drivers/gpu/drm/ati_pcigart.c  David Miller           2009-02-15  109   int max_ati_pages, max_real_pages;
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  110
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  111   if (!entry) {
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  112           DRM_ERROR("no scatter/gather memory!\n");
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  113           goto done;
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  114   }
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  115
> b5e89ed53ed8d24 drivers/char/drm/ati_pcigart.c Dave Airlie            2005-09-25  116   if (gart_info->gart_table_location == DRM_ATI_GART_MAIN) {
> ea98a92ff18c03b drivers/char/drm/ati_pcigart.c Dave Airlie            2005-09-11  117           DRM_DEBUG("PCI: no table in VRAM: using normal RAM\n");
> ea98a92ff18c03b drivers/char/drm/ati_pcigart.c Dave Airlie            2005-09-11  118
> e6be8d9d17bd440 drivers/gpu/drm/ati_pcigart.c  Zhenyu Wang            2010-01-05  119           if (pci_set_dma_mask(dev->pdev, gart_info->table_mask)) {
> e6be8d9d17bd440 drivers/gpu/drm/ati_pcigart.c  Zhenyu Wang            2010-01-05  120                   DRM_ERROR("fail to set dma mask to 0x%Lx\n",
> d7748bacbbee80b drivers/gpu/drm/ati_pcigart.c  Randy Dunlap           2010-02-02  121                             (unsigned long long)gart_info->table_mask);
> c27889ca3bb8bdc drivers/gpu/drm/ati_pcigart.c  Dan Carpenter          2018-12-17  122                   ret = -EFAULT;
> e6be8d9d17bd440 drivers/gpu/drm/ati_pcigart.c  Zhenyu Wang            2010-01-05  123                   goto done;
> e6be8d9d17bd440 drivers/gpu/drm/ati_pcigart.c  Zhenyu Wang            2010-01-05  124           }
> e6be8d9d17bd440 drivers/gpu/drm/ati_pcigart.c  Zhenyu Wang            2010-01-05  125
> b05c23851ab820b drivers/char/drm/ati_pcigart.c Dave Airlie            2008-03-17  126           ret = drm_ati_alloc_pcigart_table(dev, gart_info);
> b05c23851ab820b drivers/char/drm/ati_pcigart.c Dave Airlie            2008-03-17  127           if (ret) {
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  128                   DRM_ERROR("cannot allocate PCI GART page!\n");
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  129                   goto done;
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  130           }
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  131
> 6abf66018f7fe23 drivers/gpu/drm/ati_pcigart.c  Dave Airlie            2009-02-26  132           pci_gart = gart_info->table_handle->vaddr;
> b05c23851ab820b drivers/char/drm/ati_pcigart.c Dave Airlie            2008-03-17  133           address = gart_info->table_handle->vaddr;
> b05c23851ab820b drivers/char/drm/ati_pcigart.c Dave Airlie            2008-03-17  134           bus_address = gart_info->table_handle->busaddr;
> b5e89ed53ed8d24 drivers/char/drm/ati_pcigart.c Dave Airlie            2005-09-25  135   } else {
> ea98a92ff18c03b drivers/char/drm/ati_pcigart.c Dave Airlie            2005-09-11  136           address = gart_info->addr;
> ea98a92ff18c03b drivers/char/drm/ati_pcigart.c Dave Airlie            2005-09-11  137           bus_address = gart_info->bus_addr;
> f67e74ca690d9f1 drivers/char/drm/ati_pcigart.c Andrew Morton          2008-03-28  138           DRM_DEBUG("PCI: Gart Table: VRAM %08LX mapped at %08lX\n",
> f67e74ca690d9f1 drivers/char/drm/ati_pcigart.c Andrew Morton          2008-03-28  139                     (unsigned long long)bus_address,
> f67e74ca690d9f1 drivers/char/drm/ati_pcigart.c Andrew Morton          2008-03-28  140                     (unsigned long)address);
> ea98a92ff18c03b drivers/char/drm/ati_pcigart.c Dave Airlie            2005-09-11  141   }
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  142
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  143
> d30333bbabb4a2c drivers/gpu/drm/ati_pcigart.c  David Miller           2009-02-15  144   max_ati_pages = (gart_info->table_size / sizeof(u32));
> d30333bbabb4a2c drivers/gpu/drm/ati_pcigart.c  David Miller           2009-02-15  145   max_real_pages = max_ati_pages / (PAGE_SIZE / ATI_PCIGART_PAGE_SIZE);
> d30333bbabb4a2c drivers/gpu/drm/ati_pcigart.c  David Miller           2009-02-15  146   pages = (entry->pages <= max_real_pages)
> d30333bbabb4a2c drivers/gpu/drm/ati_pcigart.c  David Miller           2009-02-15  147       ? entry->pages : max_real_pages;
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  148
> 5a7aad9a559a548 drivers/gpu/drm/ati_pcigart.c  David Miller           2009-02-12  149   if (gart_info->gart_table_location == DRM_ATI_GART_MAIN) {
> d30333bbabb4a2c drivers/gpu/drm/ati_pcigart.c  David Miller           2009-02-15  150           memset(pci_gart, 0, max_ati_pages * sizeof(u32));
> 5a7aad9a559a548 drivers/gpu/drm/ati_pcigart.c  David Miller           2009-02-12  151   } else {
> 6abf66018f7fe23 drivers/gpu/drm/ati_pcigart.c  Dave Airlie            2009-02-26  152           memset_io((void __iomem *)map->handle, 0, max_ati_pages * sizeof(u32));
> 5a7aad9a559a548 drivers/gpu/drm/ati_pcigart.c  David Miller           2009-02-12  153   }
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  154
> 5a7aad9a559a548 drivers/gpu/drm/ati_pcigart.c  David Miller           2009-02-12  155   gart_idx = 0;
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  156   for (i = 0; i < pages; i++) {
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  157           /* we need to support large memory configurations */
> 7ec700fcaf4f01a drivers/char/drm/ati_pcigart.c Dave Airlie            2008-06-19  158           entry->busaddr[i] = pci_map_page(dev->pdev, entry->pagelist[i],
> 296c6ae0e9b5ced drivers/gpu/drm/ati_pcigart.c  David Miller           2009-02-12  159                                            0, PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
> a30f6fb7ce86275 drivers/gpu/drm/ati_pcigart.c  Benjamin Herrenschmidt 2010-08-10  160           if (pci_dma_mapping_error(dev->pdev, entry->busaddr[i])) {
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  161                   DRM_ERROR("unable to map PCIGART pages!\n");
> ea98a92ff18c03b drivers/char/drm/ati_pcigart.c Dave Airlie            2005-09-11  162                   drm_ati_pcigart_cleanup(dev, gart_info);
> f26c473cdf557ea drivers/char/drm/ati_pcigart.c Dave Airlie            2006-01-02  163                   address = NULL;
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  164                   bus_address = 0;
> c27889ca3bb8bdc drivers/gpu/drm/ati_pcigart.c  Dan Carpenter          2018-12-17  165                   ret = -ENOMEM;
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  166                   goto done;
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  167           }
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  168           page_base = (u32) entry->busaddr[i];
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  169
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  170           for (j = 0; j < (PAGE_SIZE / ATI_PCIGART_PAGE_SIZE); j++) {
> 03fda35d109b0a1 drivers/gpu/drm/ati_pcigart.c  Sam Ravnborg           2019-07-18  171                   u32 offset;
> 5a7aad9a559a548 drivers/gpu/drm/ati_pcigart.c  David Miller           2009-02-12  172                   u32 val;
> 5a7aad9a559a548 drivers/gpu/drm/ati_pcigart.c  David Miller           2009-02-12  173
> f2b04cd219e5c0f drivers/char/drm/ati_pcigart.c Dave Airlie            2007-05-08  174                   switch(gart_info->gart_reg_if) {
> f2b04cd219e5c0f drivers/char/drm/ati_pcigart.c Dave Airlie            2007-05-08  175                   case DRM_ATI_GART_IGP:
> 5a7aad9a559a548 drivers/gpu/drm/ati_pcigart.c  David Miller           2009-02-12  176                           val = page_base | 0xc;
> f2b04cd219e5c0f drivers/char/drm/ati_pcigart.c Dave Airlie            2007-05-08  177                           break;
> f2b04cd219e5c0f drivers/char/drm/ati_pcigart.c Dave Airlie            2007-05-08  178                   case DRM_ATI_GART_PCIE:
> 5a7aad9a559a548 drivers/gpu/drm/ati_pcigart.c  David Miller           2009-02-12  179                           val = (page_base >> 8) | 0xc;
> f2b04cd219e5c0f drivers/char/drm/ati_pcigart.c Dave Airlie            2007-05-08  180                           break;
> f2b04cd219e5c0f drivers/char/drm/ati_pcigart.c Dave Airlie            2007-05-08  181                   default:
> f2b04cd219e5c0f drivers/char/drm/ati_pcigart.c Dave Airlie            2007-05-08  182                   case DRM_ATI_GART_PCI:
> 5a7aad9a559a548 drivers/gpu/drm/ati_pcigart.c  David Miller           2009-02-12  183                           val = page_base;
> f2b04cd219e5c0f drivers/char/drm/ati_pcigart.c Dave Airlie            2007-05-08  184                           break;
> f2b04cd219e5c0f drivers/char/drm/ati_pcigart.c Dave Airlie            2007-05-08  185                   }
> 5a7aad9a559a548 drivers/gpu/drm/ati_pcigart.c  David Miller           2009-02-12  186                   if (gart_info->gart_table_location ==
> 03fda35d109b0a1 drivers/gpu/drm/ati_pcigart.c  Sam Ravnborg           2019-07-18  187                       DRM_ATI_GART_MAIN) {
> 5a7aad9a559a548 drivers/gpu/drm/ati_pcigart.c  David Miller           2009-02-12 @188                           pci_gart[gart_idx] = cpu_to_le32(val);
> 03fda35d109b0a1 drivers/gpu/drm/ati_pcigart.c  Sam Ravnborg           2019-07-18  189                   } else {
> 03fda35d109b0a1 drivers/gpu/drm/ati_pcigart.c  Sam Ravnborg           2019-07-18  190                           offset = gart_idx * sizeof(u32);
> 03fda35d109b0a1 drivers/gpu/drm/ati_pcigart.c  Sam Ravnborg           2019-07-18  191                           writel(val, (void __iomem *)map->handle + offset);
> 03fda35d109b0a1 drivers/gpu/drm/ati_pcigart.c  Sam Ravnborg           2019-07-18  192                   }
> 5a7aad9a559a548 drivers/gpu/drm/ati_pcigart.c  David Miller           2009-02-12  193                   gart_idx++;
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  194                   page_base += ATI_PCIGART_PAGE_SIZE;
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  195           }
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  196   }
> c27889ca3bb8bdc drivers/gpu/drm/ati_pcigart.c  Dan Carpenter          2018-12-17  197   ret = 0;
> ^1da177e4c3f415 drivers/char/drm/ati_pcigart.c Linus Torvalds         2005-04-16  198
>
> :::::: The code at line 188 was first introduced by commit
> :::::: 5a7aad9a559a5488cbef7aa3d4d96fc28220b8ae drm: ati_pcigart: Do not access I/O MEM space using pointer derefs.
>
> :::::: TO: David Miller <davem@davemloft.net>
> :::::: CC: Dave Airlie <airlied@redhat.com>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
