Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2F7C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5AC20678
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arbsatfE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389421AbgDBUdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:33:21 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39826 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728225AbgDBUdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:33:21 -0400
Received: by mail-ot1-f68.google.com with SMTP id x11so4939574otp.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 13:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xjz9VfQ/qcp06gPRmgOFCZkqy7YVuSQylRbKQQtnWwA=;
        b=arbsatfEDTGt5U1xGl1CrxJPFSO78TybUI+NQpBL+jjl2EMsFYDL89UkVs/WXkBHrA
         KaHAIknSWiIVcHoBKDAvBvfo90xG0BmjvfRRErO1bxPMU9FJ8uDQQ29+lGkExI4jPa2S
         4XKf8c+5I/aLSFQXA5Xwb8VS2PnbURA0WjmtOKGtcrkrjhDsSjAeUreWU+22fxF5EWkI
         lZNFR924dx+r0nqejtDkW/dBsmHLNA/ktPOmx0yP9lAZN7cg7c5JrGRN6gGAlPTOl/Eh
         Zii1TrO3UdNaq64GPZIHLtjyBLmVJbKGvPReW0EocjHQmys+wnrKj8AMaZkMQXgBFvsb
         Fdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xjz9VfQ/qcp06gPRmgOFCZkqy7YVuSQylRbKQQtnWwA=;
        b=LDR2AY4xST74XCQdtuVxBydx15yZtJVEUzRxHOlucGogUPvgXTAOl7S8B2bFoVQ7UQ
         NyV71YXHjmMiA+XQPKD3rBm5+MBCtY6rD5JlA5wVBy/j0bnbcJckeJJo59fWR3xz7OwT
         3vXWX2quxqZ7rw0ydCvR5ZGdWwse2wBp4n5YfJQx8xIv5LdmZGSu3pTmiirNduggpHHe
         XbgvPX0HenR/KCe2wnNv2PjFr3yWaS+j4P+gVD/zzHg1jGMvnelZRUnp9QylI34cC4u0
         e4i31Pl/I5KaLR8E7hdO52rf1M/8ARYY+BlKBBUYPAr7WUY8WvXELHX0jk6LqzZBiUZp
         Z0OA==
X-Gm-Message-State: AGi0PuZ15p874RTY2ilPtg77VDjsHsOcgZp9d/STBoQzVqqZecV/ckat
        kxcVXx7W+yd0IbMZlz2R5j8=
X-Google-Smtp-Source: APiQypIsr688F5pjBSs+9imenGbLkv72CD+nePG2AykbQLefKqbZynMew4T7z2ON+yf5A3hVd3gRZg==
X-Received: by 2002:a9d:7a9:: with SMTP id 38mr3858373oto.60.1585859600152;
        Thu, 02 Apr 2020 13:33:20 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id 68sm1568699oon.14.2020.04.02.13.33.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Apr 2020 13:33:19 -0700 (PDT)
Date:   Thu, 2 Apr 2020 13:33:17 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, chris@chris-wilson.co.uk
Subject: Re: [git pull] drm for 5.7-rc1
Message-ID: <20200402203317.GA34560@ubuntu-m2-xlarge-x86>
References: <CAPM=9twza_DeycOEhT+u6Erh0yFTAUe447J6bxWCLq5+QW8ZaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9twza_DeycOEhT+u6Erh0yFTAUe447J6bxWCLq5+QW8ZaA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 03:50:42PM +1000, Dave Airlie wrote:
> Hey Linus,
> 
> This is the main drm pull request for 5.7-rc1.
> 
> Writing the changelog seemed a bit quieter, but it looks about average.
> 
> I've got a separate merge for some VM interactions for TTM huge pages, but I'll
> send that once this is landed.
> 
> It didn't seem to have many major conflicts, but my git trees have a bad habit
> of finding the shared rerere cache and lulling me into thinking it merged fine.
> 
> Highlights:
> i915 enables Tigerlake by default
> i915 and amdgpu have initial OLED backlight support
> vmwgfx add support to enable OpenGL 4 userspace
> zero length arrays are mostly removed.
> 
> Regards,
> Dave.

<snip>

>       drm: Remove the dma_alloc_coherent wrapper for internal usage

This patch causes a build regression on arm32 in certain configurations
(I found it with Debian's armmp config).

$ printf 'CONFIG_XEN=y\nCONFIG_DRM_LEGACY=y\n' >> arch/arm/configs/multi_v7_defconfig

$ make -j$(nproc) -s ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- defconfig drivers/gpu/drm/drm_bufs.o
drivers/gpu/drm/drm_bufs.c: In function 'drm_addmap_core':
drivers/gpu/drm/drm_bufs.c:328:8: error: passing argument 3 of 'dma_alloc_coherent' from incompatible pointer type [-Werror=incompatible-pointer-types]
  328 |        &map->offset,
      |        ^~~~~~~~~~~~
      |        |
      |        resource_size_t * {aka unsigned int *}
In file included from ./include/linux/pci-dma-compat.h:8,
                 from ./include/linux/pci.h:2392,
                 from ./include/drm/drm_pci.h:35,
                 from drivers/gpu/drm/drm_bufs.c:46:
./include/linux/dma-mapping.h:642:15: note: expected 'dma_addr_t *' {aka 'long long unsigned int *'} but argument is of type 'resource_size_t *' {aka 'unsigned int *'}
  642 |   dma_addr_t *dma_handle, gfp_t gfp)
      |   ~~~~~~~~~~~~^~~~~~~~~~
cc1: some warnings being treated as errors
make[4]: *** [scripts/Makefile.build:268: drivers/gpu/drm/drm_bufs.o] Error 1
make[3]: *** [scripts/Makefile.build:505: drivers/gpu/drm] Error 2
make[2]: *** [scripts/Makefile.build:505: drivers/gpu] Error 2
make[1]: *** [Makefile:1703: drivers] Error 2
make: *** [Makefile:328: __build_one_by_one] Error 2

This fixes it but I am not sure if it is proper or not (could be
problematic if CONFIG_PHYS_ADDR_T_64BIT is set but
CONFIG_ARCH_DMA_ADDR_T_64BIT is not, not sure if that is possible) so I
figured I'd report it and let you guys deal with it.

Cheers,
Nathan

diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
index dcabf5698333..9282fd075424 100644
--- a/drivers/gpu/drm/drm_bufs.c
+++ b/drivers/gpu/drm/drm_bufs.c
@@ -325,7 +325,7 @@ static int drm_addmap_core(struct drm_device *dev, resource_size_t offset,
 		 * need to point to a 64bit variable first. */
 		map->handle = dma_alloc_coherent(&dev->pdev->dev,
 						 map->size,
-						 &map->offset,
+						 (dma_addr_t *)&map->offset,
 						 GFP_KERNEL);
 		if (!map->handle) {
 			kfree(map);
