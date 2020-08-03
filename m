Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B89C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CBFB20738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 10:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jql41LA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgHCKmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 06:42:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56982 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725933AbgHCKmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 06:42:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596451370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+bnr20DWse3hnxM4IaXhaBpbW0TWRM0m+ZB+3jgFT9M=;
        b=Jql41LA/T+7xRkneNAvrYMDAo9fj0IZRyuGNgCdeqAHroUVXyfatCTiWXHnWZID2VD1KHP
        wodJGdviVl0BcRU2pMzff3jcM6DIy+R2Z051DKZLoyd3PZCr1Qf1cRHPv0zOcydPztesB0
        SsrzocXpBoHQy4Gy+b7zjYLpn6odheY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-gyyWNzJDNl-WDh8r-pHPjQ-1; Mon, 03 Aug 2020 06:42:46 -0400
X-MC-Unique: gyyWNzJDNl-WDh8r-pHPjQ-1
Received: by mail-qv1-f71.google.com with SMTP id q12so18429341qvm.19
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 03:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+bnr20DWse3hnxM4IaXhaBpbW0TWRM0m+ZB+3jgFT9M=;
        b=iGrIsFaZjO8QeME/tq8k9Qj8tuVnBE7IMy3MapVJ0RQFWFYsS4Eg/WUS+WUZoLYbHJ
         x/T2MsBeHJ8LCqK6asY1lOd/WXQxiG9Kj8r1zgF7YijJDkjT8jVRmB2mX9k4XIpEFu2K
         eymqn5KIX/+wh784yDHaF+pa2mejH81Xf7TGPKUAxbgiI3j7y3Fql0UooU8WrGTrUxf8
         v7oh7WglrNoaXc+sIzrQTZv5hCl2eb8PWMVqdleNxwg44Lt6d74K62XWdAkFtxPXhVPx
         sr6eD8dgM542V8b7R5eB09PztMG49FxrXYVocSPWKcgGNdq/Ey3kKWRA+jCIWK8PrwU/
         n78Q==
X-Gm-Message-State: AOAM531Xj/tUDxfGUiu7DtVBloAgcsCxMtM/NLXsNPTlB5D1CVtggjD9
        Q+v+GUteaLYosPemUO2EGO/66M+NJyA+tVhWWbB+xCWgNxyJ05NvVhNqR7+CbvwIH9eElsdUCXg
        3NMW7JQhIFYTrH0FTK0JmpRTZa/dMm0FU1dm9/UPV
X-Received: by 2002:a37:90e:: with SMTP id 14mr15896185qkj.102.1596451365685;
        Mon, 03 Aug 2020 03:42:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhxbdP+GWP4eAMFRYsKdTR78UMQm0cR2+UBqbqAyJHGCbvlFNyBXYetm44K0qZipDzP6iTc6iemkg+iwFYP3s=
X-Received: by 2002:a37:90e:: with SMTP id 14mr15896161qkj.102.1596451365347;
 Mon, 03 Aug 2020 03:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200803034827.100685-1-jingxiangfeng@huawei.com>
In-Reply-To: <20200803034827.100685-1-jingxiangfeng@huawei.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Mon, 3 Aug 2020 12:42:34 +0200
Message-ID: <CACO55tsFuRmHac1_7KdebdrgGk=bAh2_aAUB302PH9rSSxdsjQ@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH] drm/nouveau/acr: fix a coding style in nvkm_acr_lsfw_load_bl_inst_data_sig()
To:     Jing Xiangfeng <jingxiangfeng@huawei.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Karol Herbst <kherbst@redhat.com>

On Mon, Aug 3, 2020 at 5:46 AM Jing Xiangfeng <jingxiangfeng@huawei.com> wrote:
>
> This patch performs the following changes:
> 1. remove a redundant parentheses around the  nvkm_acr_lsfw_add() calls
> 2. do assignment before this if condition, it is more readable
>
> Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
> index 07d1830126ab..5f6006418472 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/lsfw.c
> @@ -191,7 +191,8 @@ nvkm_acr_lsfw_load_bl_inst_data_sig(struct nvkm_subdev *subdev,
>         u32 *bldata;
>         int ret;
>
> -       if (IS_ERR((lsfw = nvkm_acr_lsfw_add(func, acr, falcon, id))))
> +       lsfw = nvkm_acr_lsfw_add(func, acr, falcon, id);
> +       if (IS_ERR(lsfw))
>                 return PTR_ERR(lsfw);
>
>         ret = nvkm_firmware_load_name(subdev, path, "bl", ver, &bl);
> --
> 2.17.1
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
>

