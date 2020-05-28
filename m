Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC20C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C6CF20776
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E0SfhFNx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387762AbgE1KTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387717AbgE1KTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:19:37 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F9FC08C5C5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:19:37 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id g7so9460189uap.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f5eLdtnXoyYrMReynJ8g23vP6dcjH2deBArK9MBPsOA=;
        b=E0SfhFNxQyV6Kh+9tWKDRG4U5sfqRQI5rDSruFXsJJLQLir/rQrwWI5QcOYlJwuQCk
         Ruo3Kc+DPz+HBMfcM6GbV1XHVkZe0rw+E3qMRvnSVOqNyTHAsbH4p/KTS1HBOOyY9OJ7
         gwSQCv7QRvOw0nYZID/1WqcBILuTP0HvtDQukSUUyNfedVG/STJ3rno6I2hz2ReBDWHw
         TQbImKFmrPZG+EeG4rcQ/ueL0EJitzGg+WJkdcT92NegsshP3LkwQE2Tr6QoLqS0dwdB
         CnyZcA32OQkkzto7OzjPl15fgpmq/ebuhyHafa6nfguLRUeHUbwTA0LatnSm5j1cLqbG
         BPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f5eLdtnXoyYrMReynJ8g23vP6dcjH2deBArK9MBPsOA=;
        b=iXXfcSyBSOs+drzt22BDwqJF0crGC3Ez0gW1QLLFpguM/f4B5t9ncAQhGzo+dEZiWW
         WbNCK3Iv+YuXimrVzGZ0gHXgEw9uaqGGV5SU+LGv/KikE7OIeljU7wro/UhOrGoXFpTb
         5XN+QAgev0FyQCqr8H1MEUFCOAnP96WXn+amiAgpnYnYU3zQ+gl9miNK5aZxCbl5Ro9E
         DtkB8VNaokazmBrP8+1VnADJxbwDmzJizIcuKbTsBpwHQvSR2DmjUFXIsM7IHovh3Qp0
         vVjkDKfXQvtQSeJeGAypTfAWyJ2VNp++lXHLZ0hUOy0b7cCDqnfSJBhCk7f94a0jAWnW
         Q4ZQ==
X-Gm-Message-State: AOAM530/bS47KNLa63LM+Rz2MO7xlQhLZPWYB1KsWta7qLjwqmhxYhHp
        jh9qLFmwkmdZQ4gN96V2BP7F62ob483Wto2yw1kNwg==
X-Google-Smtp-Source: ABdhPJwU4FQfKxI8zbZS6DJQ0er77d6//XOhOdE8ysvkLwNHc++5I8kqqLBnsndpoGGUHLv4GXHsMapzXESGeGZ950s=
X-Received: by 2002:ab0:70c9:: with SMTP id r9mr1364877ual.15.1590661175270;
 Thu, 28 May 2020 03:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200527082334.20774-1-tomi.valkeinen@ti.com> <CGME20200528091458eucas1p13645743b402f161dfa2fcd2b1e0e3b60@eucas1p1.samsung.com>
 <CAPDyKFqRa81q9EYFKB52kr6+EPJBK5u+4_hC0+ZnxU_axbxAZQ@mail.gmail.com> <53acbff5-ccb2-1f26-c1e3-54a540ac537f@samsung.com>
In-Reply-To: <53acbff5-ccb2-1f26-c1e3-54a540ac537f@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 28 May 2020 12:18:59 +0200
Message-ID: <CAPDyKFqgf=G3U3wRkiZaskVGYVzM=HBfuZwfsQA7N48Su7-NPg@mail.gmail.com>
Subject: Re: [PATCHv2] media: videobuf2-dma-contig: fix bad kfree in vb2_dma_contig_clear_max_seg_size
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "# 4.0+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 at 11:24, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> Hi Ulf,
>
> On 28.05.2020 11:14, Ulf Hansson wrote:
> > On Wed, 27 May 2020 at 10:23, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> >> Commit 9495b7e92f716ab2bd6814fab5e97ab4a39adfdd ("driver core: platform:
> >> Initialize dma_parms for platform devices") in v5.7-rc5 causes
> >> vb2_dma_contig_clear_max_seg_size() to kfree memory that was not
> >> allocated by vb2_dma_contig_set_max_seg_size().
> >>
> >> The assumption in vb2_dma_contig_set_max_seg_size() seems to be that
> >> dev->dma_parms is always NULL when the driver is probed, and the case
> >> where dev->dma_parms has bee initialized by someone else than the driver
> >> (by calling vb2_dma_contig_set_max_seg_size) will cause a failure.
> >>
> >> All the current users of these functions are platform devices, which now
> >> always have dma_parms set by the driver core. To fix the issue for v5.7,
> >> make vb2_dma_contig_set_max_seg_size() return an error if dma_parms is
> >> NULL to be on the safe side, and remove the kfree code from
> >> vb2_dma_contig_clear_max_seg_size().
> >>
> >> For v5.8 we should remove the two functions and move the
> >> dma_set_max_seg_size() calls into the drivers.
> >>
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> >> Fixes: 9495b7e92f71 ("driver core: platform: Initialize dma_parms for platform devices")
> >> Cc: stable@vger.kernel.org
> > Thanks for fixing this!
> >
> > However, as I tried to point out in v1, don't you need to care about
> > drivers/media/platform/s5p-mfc/s5p_mfc.c, which allocates its own type
> > of struct device (non-platform). No?
>
> I will send a patch for the S5P MFC driver separately. It is not so
> critical, because the mentioned 2port memory case is not used on any
> board with the default exynos_defconfig from mainline. On Exynos4-based
> boards it is only used when IOMMU is disabled. It is mainly for
> S5PV210/S5PC110 boards, which are still not fully functional after
> conversion to device-tree.

Okay, makes sense to me. Feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

For the s5p_mfc issue, here's how I would have done it (just pick the
code if you want).

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

Kind regards
Uffe
