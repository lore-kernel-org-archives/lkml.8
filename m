Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4457DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228ED20B80
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ne//iH64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgE1JO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 05:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgE1JO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 05:14:56 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAB9C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 02:14:55 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id 14so9397608uaq.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 02:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/bUPBRUsoGA3duyrH2TeZMw5+oOeqgZqPYVv5N0Bp8E=;
        b=Ne//iH640h/EEBEtqoCGfuf9pMzYa08gUSFPet3nUiWCMFf0CC/Gr2oVUm+Mf1G5pW
         7I+c1si80x3o3epEQxzm7aObeVrftr8ivjyXsU0NJLnA6nlvfoZTIVtA94ZOOXhi8eY2
         KaVs/FyPxbO3ByDFxkdYun2tB6/rHrXt7tlFKQzbSED4KznRDQMndxc/5jEe/eS9oibp
         DphU8kmMLxd4jpPNExEYWjWzLiyT4OUBFwHyJj5kvH12rkSlaK7khY7SfOshYCYl61AT
         yiPZjzm1mK5EqW9n3cipObQ28qNzKmCAS+U3Jml+uAqujflKxeH72CxxBdNIKtd0O2Bj
         W7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/bUPBRUsoGA3duyrH2TeZMw5+oOeqgZqPYVv5N0Bp8E=;
        b=RPr4/VdwUFOikd9IiiwLJMIRphn4l/IW6lHVjxav5J3cVG/xEU4qUnuGUnrTkpCsVF
         b+a/73oVEKzKOjdX8WlHRBoo4vYAfilUZrk0KBk3iAuesJo3ibBkBp/cf52Cz3oQRi8x
         HitQTnObY7JafHf0npbE+mHKd2R+08XbFPPUjIDC/wV0c1JzbZS5mX8Q2StR9Zm01CAt
         P/YvuvRh772p7TLoKWllcWksSOQCGuoXMJaHqdQ295zqtSfiySr86WBaJg4foYOGlc0V
         o3O1A2/DsHei2mcUyrn8W1PRYcoqb5KHw/MBKX42fnsv1M2xUv96IgA4tQJzL05ynNGo
         xBaQ==
X-Gm-Message-State: AOAM533BRkfXjIGF8FRR4vG0ZzjzXtJhWlGgBA2AO/FSXCTp8vCaceCi
        /oDzvCd4Y8zUGt++CDfjywKaR5fENxJfEvchwQAFrGySzAg=
X-Google-Smtp-Source: ABdhPJyeBZDK+eRHDc8CWLgi/p/haWLcwq2ltlK4wv91Z0M2J35aG++4G2ilnQYUpjJaJ7F+JSrxGwE2JExC7SMR47U=
X-Received: by 2002:ab0:13f2:: with SMTP id n47mr1188594uae.129.1590657294933;
 Thu, 28 May 2020 02:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200527082334.20774-1-tomi.valkeinen@ti.com>
In-Reply-To: <20200527082334.20774-1-tomi.valkeinen@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 May 2020 11:14:18 +0200
Message-ID: <CAPDyKFqRa81q9EYFKB52kr6+EPJBK5u+4_hC0+ZnxU_axbxAZQ@mail.gmail.com>
Subject: Re: [PATCHv2] media: videobuf2-dma-contig: fix bad kfree in vb2_dma_contig_clear_max_seg_size
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 at 10:23, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>
> Commit 9495b7e92f716ab2bd6814fab5e97ab4a39adfdd ("driver core: platform:
> Initialize dma_parms for platform devices") in v5.7-rc5 causes
> vb2_dma_contig_clear_max_seg_size() to kfree memory that was not
> allocated by vb2_dma_contig_set_max_seg_size().
>
> The assumption in vb2_dma_contig_set_max_seg_size() seems to be that
> dev->dma_parms is always NULL when the driver is probed, and the case
> where dev->dma_parms has bee initialized by someone else than the driver
> (by calling vb2_dma_contig_set_max_seg_size) will cause a failure.
>
> All the current users of these functions are platform devices, which now
> always have dma_parms set by the driver core. To fix the issue for v5.7,
> make vb2_dma_contig_set_max_seg_size() return an error if dma_parms is
> NULL to be on the safe side, and remove the kfree code from
> vb2_dma_contig_clear_max_seg_size().
>
> For v5.8 we should remove the two functions and move the
> dma_set_max_seg_size() calls into the drivers.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Fixes: 9495b7e92f71 ("driver core: platform: Initialize dma_parms for platform devices")
> Cc: stable@vger.kernel.org

Thanks for fixing this!

However, as I tried to point out in v1, don't you need to care about
drivers/media/platform/s5p-mfc/s5p_mfc.c, which allocates its own type
of struct device (non-platform). No?

Kind regards
Uffe


> ---
>
> Changes in v2:
> * vb2_dma_contig_clear_max_seg_size to empty static inline
> * Added cc: stable and fixes tag
>
>  .../common/videobuf2/videobuf2-dma-contig.c   | 20 ++-----------------
>  include/media/videobuf2-dma-contig.h          |  2 +-
>  2 files changed, 3 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> index d3a3ee5b597b..f4b4a7c135eb 100644
> --- a/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> +++ b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> @@ -726,9 +726,8 @@ EXPORT_SYMBOL_GPL(vb2_dma_contig_memops);
>  int vb2_dma_contig_set_max_seg_size(struct device *dev, unsigned int size)
>  {
>         if (!dev->dma_parms) {
> -               dev->dma_parms = kzalloc(sizeof(*dev->dma_parms), GFP_KERNEL);
> -               if (!dev->dma_parms)
> -                       return -ENOMEM;
> +               dev_err(dev, "Failed to set max_seg_size: dma_parms is NULL\n");
> +               return -ENODEV;
>         }
>         if (dma_get_max_seg_size(dev) < size)
>                 return dma_set_max_seg_size(dev, size);
> @@ -737,21 +736,6 @@ int vb2_dma_contig_set_max_seg_size(struct device *dev, unsigned int size)
>  }
>  EXPORT_SYMBOL_GPL(vb2_dma_contig_set_max_seg_size);
>
> -/*
> - * vb2_dma_contig_clear_max_seg_size() - release resources for DMA parameters
> - * @dev:       device for configuring DMA parameters
> - *
> - * This function releases resources allocated to configure DMA parameters
> - * (see vb2_dma_contig_set_max_seg_size() function). It should be called from
> - * device drivers on driver remove.
> - */
> -void vb2_dma_contig_clear_max_seg_size(struct device *dev)
> -{
> -       kfree(dev->dma_parms);
> -       dev->dma_parms = NULL;
> -}
> -EXPORT_SYMBOL_GPL(vb2_dma_contig_clear_max_seg_size);
> -
>  MODULE_DESCRIPTION("DMA-contig memory handling routines for videobuf2");
>  MODULE_AUTHOR("Pawel Osciak <pawel@osciak.com>");
>  MODULE_LICENSE("GPL");
> diff --git a/include/media/videobuf2-dma-contig.h b/include/media/videobuf2-dma-contig.h
> index 5604818d137e..5be313cbf7d7 100644
> --- a/include/media/videobuf2-dma-contig.h
> +++ b/include/media/videobuf2-dma-contig.h
> @@ -25,7 +25,7 @@ vb2_dma_contig_plane_dma_addr(struct vb2_buffer *vb, unsigned int plane_no)
>  }
>
>  int vb2_dma_contig_set_max_seg_size(struct device *dev, unsigned int size);
> -void vb2_dma_contig_clear_max_seg_size(struct device *dev);
> +static inline void vb2_dma_contig_clear_max_seg_size(struct device *dev) { }
>
>  extern const struct vb2_mem_ops vb2_dma_contig_memops;
>
> --
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>
