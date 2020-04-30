Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D2AC83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EE252073E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV5kIo0T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgD3D6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 23:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726596AbgD3D6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 23:58:42 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09615C035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 20:58:42 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id e16so248556ybn.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 20:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIwWvB1bcjrgfWAykQ5flP8M3l3Y++aqvhNqkjaW3S0=;
        b=UV5kIo0TX3CL2ps98HTMoWP2CHG35rrpWPzCa2GHvD4ZHX0OROJ+ZjBaoaQ03y2wfE
         ICe259ObbpcaEUu36lI9FuwzwFuVVkbL+AuQVVaeCubRw0OGxf6acQJ2+nD0TjKLr2n7
         Y+T10Oyh7V7GrEG5fKI7fGvHkI+eJrcmjpUg4xGXlbTN9CDCOw3/Jw6mKQiagFzCaBN8
         Rpk3VMXlOK4uZuj4N6d1RQSsHjaUt/Imi3vC3hSBMlojJJgjQQCSBcKXeFPfcvNSxIva
         P0FklL5JIkB6IhEZNE+XfaA8yiyATrbEqZzPhqp/vIy2u2PGTq8JJTNn9yay5+aL3ksm
         9JLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIwWvB1bcjrgfWAykQ5flP8M3l3Y++aqvhNqkjaW3S0=;
        b=gTP3tBiYlWE6M+9qaTxV/VBE2kGIM7RG2erEJ+GbPgDVoh1tti44xLWSXo6cU9W6js
         zzxIo0J763G+1HUvTPZ6dXvg6lhDb8VA81mgaK+wxPFCM2uq6QRiIT5oiL6aykagOe5T
         mt5kFe8a2XACy+GUxw/oWcPC+UCuRPT517bz04xhF9B0Dm+QW5cIg/gIRNzUJXFXD6RN
         K3LqxJ1IB9hIp7XW6Pl8L+aX4ntQoetlOq0XuIGgtQ2t7N/IZHR/eaf4sr5x/nXLlZLW
         l4xT5ioxJHpYQJuihyPXrtJvlPFReZF03gCO5JcsgdgBTsNCI7maqzP4+PJ57XgRcZyc
         9+jA==
X-Gm-Message-State: AGi0PuYlp9FFs/VbGYQ5xzvCinpUFpM3cxbBPyyM5y/ckldud6y1UADP
        gGmPWz9wWILErLKxN0LVvRw+S8xZjMStw7gi8515TFsc
X-Google-Smtp-Source: APiQypIAwfcTkBjD11IKPHp/L8eLblpfs6T06DURXindp+KMXfmopDU1wbJDpZp657G9gL+SloE/f2+ROCQSt7U6bVU=
X-Received: by 2002:a25:12c1:: with SMTP id 184mr2644186ybs.162.1588219121198;
 Wed, 29 Apr 2020 20:58:41 -0700 (PDT)
MIME-Version: 1.0
References: <1587472651-105308-1-git-send-email-zou_wei@huawei.com>
In-Reply-To: <1587472651-105308-1-git-send-email-zou_wei@huawei.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Thu, 30 Apr 2020 13:58:30 +1000
Message-ID: <CACAvsv5qXhLkspF0==z36xY1R1Uv=-XUHEwnH52GDurivbF5Tw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/nouveau/acr: Use kmemdup instead of kmalloc and memcpy
To:     Zou Wei <zou_wei@huawei.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

On Wed, 22 Apr 2020 at 16:56, Zou Wei <zou_wei@huawei.com> wrote:
>
> Fixes coccicheck warning:
>
> drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c:103:23-30: WARNING opportunity for kmemdup
> drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c:113:22-29: WARNING opportunity for kmemdup
>
> Fixes: 22dcda45a3d1 ("drm/nouveau/acr: implement new subdev to replace "secure boot"")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> index aecce2d..667fa01 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/acr/hsfw.c
> @@ -100,25 +100,21 @@ nvkm_acr_hsfw_load_image(struct nvkm_acr *acr, const char *name, int ver,
>         hsfw->data_size = lhdr->data_size;
>
>         hsfw->sig.prod.size = fwhdr->sig_prod_size;
> -       hsfw->sig.prod.data = kmalloc(hsfw->sig.prod.size, GFP_KERNEL);
> +       hsfw->sig.prod.data = kmemdup(fw->data + fwhdr->sig_prod_offset + sig,
> +                                     hsfw->sig.prod.size, GFP_KERNEL);
>         if (!hsfw->sig.prod.data) {
>                 ret = -ENOMEM;
>                 goto done;
>         }
>
> -       memcpy(hsfw->sig.prod.data, fw->data + fwhdr->sig_prod_offset + sig,
> -              hsfw->sig.prod.size);
> -
>         hsfw->sig.dbg.size = fwhdr->sig_dbg_size;
> -       hsfw->sig.dbg.data = kmalloc(hsfw->sig.dbg.size, GFP_KERNEL);
> +       hsfw->sig.dbg.data = kmemdup(fw->data + fwhdr->sig_dbg_offset + sig,
> +                                    hsfw->sig.dbg.size, GFP_KERNEL);
>         if (!hsfw->sig.dbg.data) {
>                 ret = -ENOMEM;
>                 goto done;
>         }
>
> -       memcpy(hsfw->sig.dbg.data, fw->data + fwhdr->sig_dbg_offset + sig,
> -              hsfw->sig.dbg.size);
> -
>         hsfw->sig.patch_loc = loc;
>  done:
>         nvkm_firmware_put(fw);
> --
> 2.6.2
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
