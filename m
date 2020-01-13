Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC54C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 00:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD5A206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 00:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkTqD2zd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387538AbgAMAHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jan 2020 19:07:18 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:44012 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbgAMAHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jan 2020 19:07:17 -0500
Received: by mail-ua1-f52.google.com with SMTP id o42so2683684uad.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jan 2020 16:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ni1dsk4zQuirgan391D3nIBqR+fxZP8zwkgVrPSLMyE=;
        b=MkTqD2zddrvNJVuacif3IaKo9o4ZcuvBHo8hi3lg+TBK+H8BFbjbTvHR9+EAMNdTYJ
         WjjqL6Unue/SF4hnaz93AJmi4hcLnjoCGXEurbCntUrHtgbd6KLRahlKz5NFS58Vx/C4
         ce//VG0uUvtrEkO34VPYlQWRgbBE0t2+1WG4GIcsVLkBeA0fVKZdTIikIsfBolWw2teo
         wcmcU8IejtRZvDXLBoUPh6gl7TnxuBnA8H45mrv0GnHhmwWHAefhmGpTWi7xCex+SkXi
         1JGGZfD1KoXo3SioS0hKePFE56IK4C+MZAvibGIWdAR0Jibvsj68q1K+NVTt600PlGWe
         IIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ni1dsk4zQuirgan391D3nIBqR+fxZP8zwkgVrPSLMyE=;
        b=c2bDz7PFJcWZDnDkpvJYdSPSV3wYm1zeTxuP9E67EW0gKjRq4zX0d5uJFMfYoSqpZz
         8DrFN3cKuBGdac1jeQyUjtoKX2y4Bo11gl/wmaTtb0e8VqyvZJGWVzsf4b8zAorgHwIf
         02AZJ9K/fIwQSDn2MkHWa+z2MCmcA/aivHKy7dgZE3HJh+WoIIjiuUwXvdpYDT+yTJOw
         bo8ySn2PtFemeRWxVY3zdoxG5T9kTq9QlDhDDNAzMuejlv24P78djXClItyDG2rTo1FG
         QsaUgdsjw2WNN89p4FeLRyrzHY4n/ED6CHZ0dwrDHBzUBIeTVeo0oLBj7Fd7V7AdHV87
         jmNQ==
X-Gm-Message-State: APjAAAWIRAvx1Z3MK5lFyOaQaHJMB0psEOkHOytc8g66ehww1X/vxY4b
        Hzk9CT+/7bUVqUfWTlg1wsldgyX3rSNKKGxZTdg=
X-Google-Smtp-Source: APXvYqyFFBC8dpNMD69+EuEZSci28AmYlHt/twpN4MrbjgbZwGM7Il8XTOOj7wxDtZqsqieKQqHbTh47ZNWd7OBTNy0=
X-Received: by 2002:ab0:14ea:: with SMTP id f39mr5758331uae.40.1578874036638;
 Sun, 12 Jan 2020 16:07:16 -0800 (PST)
MIME-Version: 1.0
References: <20200110072837.48060-1-yuehaibing@huawei.com>
In-Reply-To: <20200110072837.48060-1-yuehaibing@huawei.com>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Mon, 13 Jan 2020 10:07:05 +1000
Message-ID: <CACAvsv4LQAs_GAavgywod1ksxvKe5JE6FNGMnULbnJACJ280KQ@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH -next] drm/ttm: Remove set but not used variable 'mem'
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Ben Skeggs <bskeggs@redhat.com>, Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 at 17:32, YueHaibing <yuehaibing@huawei.com> wrote:
>
> drivers/gpu/drm/nouveau/nouveau_ttm.c: In function nouveau_vram_manager_new:
> drivers/gpu/drm/nouveau/nouveau_ttm.c:66:22: warning: variable mem set but not used [-Wunused-but-set-variable]
> drivers/gpu/drm/nouveau/nouveau_ttm.c: In function nouveau_gart_manager_new:
> drivers/gpu/drm/nouveau/nouveau_ttm.c:106:22: warning: variable mem set but not used [-Wunused-but-set-variable]
>
> They are not used any more, so remove it.
Thanks!

>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_ttm.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouveau/nouveau_ttm.c
> index 77a0c6a..7ca0a24 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
> @@ -63,14 +63,12 @@ nouveau_vram_manager_new(struct ttm_mem_type_manager *man,
>  {
>         struct nouveau_bo *nvbo = nouveau_bo(bo);
>         struct nouveau_drm *drm = nouveau_bdev(bo->bdev);
> -       struct nouveau_mem *mem;
>         int ret;
>
>         if (drm->client.device.info.ram_size == 0)
>                 return -ENOMEM;
>
>         ret = nouveau_mem_new(&drm->master, nvbo->kind, nvbo->comp, reg);
> -       mem = nouveau_mem(reg);
>         if (ret)
>                 return ret;
>
> @@ -103,11 +101,9 @@ nouveau_gart_manager_new(struct ttm_mem_type_manager *man,
>  {
>         struct nouveau_bo *nvbo = nouveau_bo(bo);
>         struct nouveau_drm *drm = nouveau_bdev(bo->bdev);
> -       struct nouveau_mem *mem;
>         int ret;
>
>         ret = nouveau_mem_new(&drm->master, nvbo->kind, nvbo->comp, reg);
> -       mem = nouveau_mem(reg);
>         if (ret)
>                 return ret;
>
> --
> 2.7.4
>
>
> _______________________________________________
> Nouveau mailing list
> Nouveau@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/nouveau
