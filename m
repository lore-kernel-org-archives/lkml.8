Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0AEC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 08:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0068207DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 08:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBab6S5Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgGSIKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 04:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSIKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 04:10:50 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B998C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 01:10:50 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e90so9961125ote.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 01:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dxLIBAwVj8+/giMfYZPC4rfs2i8NDawqE2SJi2nPnyU=;
        b=NBab6S5Yoowvf8J+udtX0MvQlc7IPVDWK4cWLY837W6jvBqijehPttZWY7sJp2TizG
         1sVBSM3I22tuvAkjZSZ7az5kjErjbSGYPayk9KjYb4oCB7RqLSwqjJ6ss88kXdrE8MYj
         ZyUPuS3cOdvTh9VycIvZMlYmwPOFaW07N4knjWPQ5s4x4qeaAEezDPeWwKIObPAYGIa6
         UM7ZHy5aTth7uoMpR3u6tUTvPuTsEPsZ/sni5+yt3YVMTr40UeD5frtYGHHzocqGIJk/
         zqrsqmCCq356ABeBmVaaRAB1evLf3D2HFjrDNfPR5TbSankzEfEJcvoWqBrPsuaq40+R
         xEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dxLIBAwVj8+/giMfYZPC4rfs2i8NDawqE2SJi2nPnyU=;
        b=VBMENNVuqbrfHRCBqqfqhGwQM3aSLIfLP9Ioz6BfsVIahFzIV0Rx6EF+gXiahH5eZv
         v58tT/TcvXERy8iscDSt5s4P1iLuxfC5gbCloQHj0jWuwlrSD3up6Od5MG+tzlLfBytJ
         m0//5sATe/sLQF0hbaRnnOyoTrUvvzra063lkDfu7EextKNg+9ydgPy2HPiwqqb9amqk
         8FXz6I6CjeuR1Q/d0suZedXyXyrmmTEPDC1877PZagL8nZ5u3L33htzg3rWlNoeMe3Sm
         M+xiZ/wURwBTwvADF3sWzuY6S3OVkWLQFhqajTi8YAURwY5yJRnFMBQ3abcQTTz2fwMt
         gX2A==
X-Gm-Message-State: AOAM532OTpALe/lX4j8VvyFPiYeh0JokFVSAOIVrnGnSi3b07KdCs9r2
        nvHQ41AMn+444I9vHqMP/K2ZOs5zymQ8gflsUyLDDtdb
X-Google-Smtp-Source: ABdhPJyhNcfrqLXq6VhvoAKxAYVq0HVwSgz1wyqOzdF0RTBO8/TT35IDtUTAvjqwuOD5kAuz9HB9qgmc1fPKVIY265Q=
X-Received: by 2002:a05:6830:3151:: with SMTP id c17mr16085413ots.143.1595146249154;
 Sun, 19 Jul 2020 01:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200719080003.19692-1-ttayar@habana.ai>
In-Reply-To: <20200719080003.19692-1-ttayar@habana.ai>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sun, 19 Jul 2020 11:10:21 +0300
Message-ID: <CAFCwf12d7ozZM_38Y3ZUoZ0WyFstHazGcbwiVmdM561Yw-FKZA@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: use no flags on MMU cache invalidation
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        SW_Drivers@habana.ai
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 11:00 AM Tomer Tayar <ttayar@habana.ai> wrote:
>
> gaudi_mmu_invalidate_cache() doesn't use the flags parameter, and thus
> it can be set to 0 when the function is called in the gaudi only files.
>
> Signed-off-by: Tomer Tayar <ttayar@habana.ai>
> ---
>  drivers/misc/habanalabs/gaudi/gaudi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
> index 86cfaf73ad74..4a1a52608fc0 100644
> --- a/drivers/misc/habanalabs/gaudi/gaudi.c
> +++ b/drivers/misc/habanalabs/gaudi/gaudi.c
> @@ -2646,8 +2646,7 @@ static int gaudi_mmu_init(struct hl_device *hdev)
>         WREG32(mmSTLB_CACHE_INV_BASE_39_8, MMU_CACHE_MNG_ADDR >> 8);
>         WREG32(mmSTLB_CACHE_INV_BASE_49_40, MMU_CACHE_MNG_ADDR >> 40);
>
> -       hdev->asic_funcs->mmu_invalidate_cache(hdev, true,
> -                                       VM_TYPE_USERPTR | VM_TYPE_PHYS_PACK);
> +       hdev->asic_funcs->mmu_invalidate_cache(hdev, true, 0);
>
>         WREG32(mmMMU_UP_MMU_ENABLE, 1);
>         WREG32(mmMMU_UP_SPI_MASK, 0xF);
> --
> 2.17.1
>

This patch is:
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
