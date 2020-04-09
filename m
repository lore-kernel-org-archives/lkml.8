Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D3CC2D0EA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29642072F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 07:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="Pn8bmpR4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgDIHJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 03:09:59 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46794 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgDIHJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 03:09:59 -0400
Received: by mail-ot1-f67.google.com with SMTP id 88so250698otx.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 00:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GlUPB+6q2mjcNuVTriGgW97+CB0wWd7mr5tulU4n63s=;
        b=Pn8bmpR4HLo/rUfUOGF+R/fNynlNfCPYfvRTLnCYr+qLDJPMm88Z2CpKpGDMNfapS7
         s0l0npj891/g/EmW1JvQX9+vAsgNUMj/enzIWNRWJOs+MNdzeIpA4n8hiREhGUgacS9M
         0Owqo+5Rkn0ftDPJf32XCZj6MPEyxe7VXaaM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlUPB+6q2mjcNuVTriGgW97+CB0wWd7mr5tulU4n63s=;
        b=AHq91VAbztmw4bUONs4CQzqGeQWmE7TWgFacoPtvFoa2OXZnAbXHFZu/rt6dsLC30F
         WcGTsGWRDprWWXlPg38RhAdPkXCfFK65HJpN7kYhZ2yTOFwoaJoJQ2rs2O+2PVdRnlC4
         598TwBbDuUuDbZ0GBIzdgASdajLYvO26B6US7bBTsgd4vjanXBGqneZvb8WWnZ/hrO1F
         rCFKRNGBoQbxTtIpwRu3XBfTO1mUssxQEH3dzkzBiknilZX25YEooMw9CU4pLishOorl
         rKclYPrYanxPHNCSivk9YDBc+0kvdVJCcxhxDDGAkny7wwenKFQEkGmVRSz9ryPviLA2
         wJHQ==
X-Gm-Message-State: AGi0PuZFoIxcrqW7QvS50lcWBxdw22LTFj0dsG0KhW8K4kyzskyx95GA
        2RL50ED2h5kT42Tg88ldYbREWg854xXqKE52Ct1gtw==
X-Google-Smtp-Source: APiQypJTmXZ1C/k1LBwOpOzzXyn5auKKSntAs/wF2Or17hXByhXcRvRBCe+phy7aZ0bHhP6DYvYfauLei8ndvS539C4=
X-Received: by 2002:a4a:4190:: with SMTP id x138mr8844225ooa.35.1586416198200;
 Thu, 09 Apr 2020 00:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200408191224.947302-1-arnd@arndb.de>
In-Reply-To: <20200408191224.947302-1-arnd@arndb.de>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 9 Apr 2020 09:09:46 +0200
Message-ID: <CAKMK7uGsF-C7AXjLESDYb6=09qp0j+OXS9OgLEVCFd9-GAo-kg@mail.gmail.com>
Subject: Re: [PATCH] drm: work around dma_addr_t/resource_size_t mixup warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sean Paul <seanpaul@chromium.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dave Airlie <airlied@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fix got stuck a bit, I just pushed it out, should make it to the
next linux-next:

commit b2ecb89c27a4fd110187e0afeca70557215f55a1 (drm-misc-next-fixes)
Author: Chris Wilson <chris@chris-wilson.co.uk>
Date:   Thu Apr 2 22:59:26 2020 +0100

    drm/legacy: Fix type for drm_local_map.offset

Cheers, Daniel

On Wed, Apr 8, 2020 at 9:12 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On configurations with 64-bit dma_addr_t but 32-bit resource_size_t,
> there is now a warning:
>
> drivers/gpu/drm/drm_bufs.c: In function 'drm_addmap_core':
> drivers/gpu/drm/drm_bufs.c:328:8: error: passing argument 3 of 'dma_alloc_coherent' from incompatible pointer type [-Werror=incompatible-pointer-types]
>   328 |        &map->offset,
>       |        ^~~~~~~~~~~~
>       |        |
>       |        resource_size_t * {aka unsigned int *}
> In file included from include/linux/pci-dma-compat.h:8,
>                  from include/linux/pci.h:2392,
>                  from include/drm/drm_pci.h:35,
>                  from drivers/gpu/drm/drm_bufs.c:46:
> include/linux/dma-mapping.h:642:15: note: expected 'dma_addr_t *' {aka 'long long unsigned int *'} but argument is of type 'resource_size_t *' {aka 'unsigned int *'}
>   642 |   dma_addr_t *dma_handle, gfp_t gfp)
>       |   ~~~~~~~~~~~~^~~~~~~~~~
>
> I have no idea if this is safe on targets that may need a high DMA address,
> or why we store a DMA address token in a resource_size_t in the first place,
> but using a temporary variable avoids the warning.
>
> Fixes: 8e4ff9b56957 ("drm: Remove the dma_alloc_coherent wrapper for internal usage")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/drm_bufs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/drm_bufs.c b/drivers/gpu/drm/drm_bufs.c
> index dcabf5698333..0fbe65c62f1e 100644
> --- a/drivers/gpu/drm/drm_bufs.c
> +++ b/drivers/gpu/drm/drm_bufs.c
> @@ -149,6 +149,7 @@ static int drm_addmap_core(struct drm_device *dev, resource_size_t offset,
>  {
>         struct drm_local_map *map;
>         struct drm_map_list *list;
> +       dma_addr_t dma_addr;
>         unsigned long user_token;
>         int ret;
>
> @@ -325,8 +326,9 @@ static int drm_addmap_core(struct drm_device *dev, resource_size_t offset,
>                  * need to point to a 64bit variable first. */
>                 map->handle = dma_alloc_coherent(&dev->pdev->dev,
>                                                  map->size,
> -                                                &map->offset,
> +                                                &dma_addr,
>                                                  GFP_KERNEL);
> +               map->offset = (resource_size_t)dma_addr;
>                 if (!map->handle) {
>                         kfree(map);
>                         return -ENOMEM;
> --
> 2.26.0
>


-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
