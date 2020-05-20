Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912CAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55434206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0+brP9d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgETPGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgETPGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:06:50 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA21C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 08:06:50 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id a37so1385395uad.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 08:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+gDCGjMZWEdVRUtQZYVp+UsS6eran4MdaLZDqVTRgpg=;
        b=G0+brP9dlZpegWEIl+cnjiVVn5DswkuPLM+7RKlGLuvwQ7VXzZwOVqSjLeLkymu8K3
         tfV/Kao2rLHgzpU+kGExrnVNJPZGH06uyjiJH9y6H7/aSp1gDdqSLfAvmlC6G/qTZoxX
         ZSkWO9v3aq0UpE1hbsxaNaKRNopKOBX7u/Ik2oTzjQh8E3CutJ/LBKG/xvz2rrbpd2Fy
         FAg6A8sbESNl0Tu3Y68cN1WOB0Mq0yF44znLqivgb7q759oGOB7aZ5HP5Lynzfc5oACP
         nQRYXLnAGy9aa0waFP0AvnwPPKaKPl4+gybhMVBgvsFpODjx6bsku1f8kJMpDUxtvWpd
         xMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+gDCGjMZWEdVRUtQZYVp+UsS6eran4MdaLZDqVTRgpg=;
        b=sbIMlGUBoRYqkPVHDbk75AyFqdNHdWhnPYkGaCjmv+Mg6RqhEO5cmDb3sOyB4RZdzd
         F7STXtNRL8QCc3TGrJuvcw9ZJEWJ2HWWJg3+0+rwV0Wysous7OI91AQp4W/bOdwW5FfD
         3PuJ/nEXUGqIJ+qyNK/pEFXlzkGg6yOPpU+wdTZBotSFDDgc7GQss2W8r6Rxhi2MyRLA
         6eQJi9wCSBgul0AH6VKo6O5RHlGmbR++svUSihlAu5NdT3I1zrk4bXXK3EzmFZFo5VDa
         mCMsTg7WhME6zpgrUoH9sGjeL4dOyISoK1CBYQD7oY0CrIrfTNHLqkWVo5aReWDX9oAt
         0jAQ==
X-Gm-Message-State: AOAM531uk7/qIPZgkRiezj7nt0ZCogIM3XBwIny73UaMOrBh3GbpbNWn
        kr2iIfSu7DtKZ8JgQb8RTxVAc6Qii6Mgk5FW7fI4Fw==
X-Google-Smtp-Source: ABdhPJxnSeb02kPxObDs2fmjf476jjjMKwRYDCatBC3QMeFvNrUaWLWHMkqRN59R82Lzhtmwp5HY1nR/ZzasLnprsqY=
X-Received: by 2002:a9f:37c3:: with SMTP id q61mr4034114uaq.100.1589987209658;
 Wed, 20 May 2020 08:06:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200520131558.23009-1-tomi.valkeinen@ti.com>
In-Reply-To: <20200520131558.23009-1-tomi.valkeinen@ti.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 20 May 2020 17:06:12 +0200
Message-ID: <CAPDyKFpxSYE9G=Hy61cWmj1fGdfnzqg5DLraD7_o462bZg_oCw@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2-dma-contig: fix bad kfree in vb2_dma_contig_clear_max_seg_size
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 at 15:16, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
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

Not entirely true I believe, see more below.

>
> For v5.8 we should remove the two functions and move the
> dma_set_max_seg_size() calls into the drivers.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>
> Note: I have only fully tested this on linux-next, as the capture driver
> I use doesn't support unloading modules in v5.7.
>
>  drivers/media/common/videobuf2/videobuf2-dma-contig.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-contig.c b/drivers/media/common/videobuf2/videobuf2-dma-contig.c
> index d3a3ee5b597b..24f80b62ef94 100644
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
> @@ -747,8 +746,6 @@ EXPORT_SYMBOL_GPL(vb2_dma_contig_set_max_seg_size);
>   */
>  void vb2_dma_contig_clear_max_seg_size(struct device *dev)
>  {
> -       kfree(dev->dma_parms);
> -       dev->dma_parms = NULL;
>  }
>  EXPORT_SYMBOL_GPL(vb2_dma_contig_clear_max_seg_size);

I think you need something along the lines of this as well:

diff --git a/drivers/media/platform/s5p-mfc/s5p_mfc.c
b/drivers/media/platform/s5p-mfc/s5p_mfc.c
index 5c2a23b953a4..7acf2a03812d 100644
--- a/drivers/media/platform/s5p-mfc/s5p_mfc.c
+++ b/drivers/media/platform/s5p-mfc/s5p_mfc.c
@@ -1070,6 +1070,7 @@ static const struct v4l2_file_operations s5p_mfc_fops = {
 /* DMA memory related helper functions */
 static void s5p_mfc_memdev_release(struct device *dev)
 {
+       kfree(dev->dma_parms);
        of_reserved_mem_device_release(dev);
 }

@@ -1090,6 +1091,10 @@ static struct device
*s5p_mfc_alloc_memdev(struct device *dev,
        child->dma_mask = dev->dma_mask;
        child->release = s5p_mfc_memdev_release;

+       child->dma_parms = kzalloc(sizeof(*child->dma_parms), GFP_KERNEL);
+       if (!child->dma_parms)
+               goto err;
+
        /*
         * The memdevs are not proper OF platform devices, so in order for them
         * to be treated as valid DMA masters we need a bit of a hack to force
@@ -1105,6 +1110,7 @@ static struct device
*s5p_mfc_alloc_memdev(struct device *dev,
                device_del(child);
        }

+err:
        put_device(child);
        return NULL;
 }

Also, please tag the patch for stable.

Kind regards
Uffe
