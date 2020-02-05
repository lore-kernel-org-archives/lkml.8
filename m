Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71CCC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 20:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03C020720
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 20:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oxenJqq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgBEUUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 15:20:25 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35207 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBEUUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 15:20:24 -0500
Received: by mail-il1-f195.google.com with SMTP id g12so3038003ild.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 12:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JlLlxcQrpMkFUoU3hq5dL+E4UdUH5CDEd0YwvUejnVU=;
        b=oxenJqq82hLbOY7iPrO4DykFZo5N5e0MnyDP4aMCZ4rNnPVzW7PVckpP2qD7MWebBl
         Al2LFHbYZUmY6P3jBNPQTFTJATaNYQgghy5BquPjuhetKLPYg9SYNadMl/MB5nl7p4qg
         fP4YnhAj3q8n1AbMRpiGqJzn+4OeEEOrK6Re9bVBJ1d/IuaQkN3rb6jYEWcjVskRYLp5
         vWHG9YVnk4VtWVbENO1Fy3klZ4pRRQAwj+tfauQTnQrm5eYUVWtjg7IuVHH6cFLXArQ9
         PWBduhU9ZJSz1uDA/+UGLI7zagtMps7gLmNwuAHjyETzuhbO2L6Wzt2/DjinPhcQ6ge4
         Q1gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JlLlxcQrpMkFUoU3hq5dL+E4UdUH5CDEd0YwvUejnVU=;
        b=fjClK4UAnOyR054PeQY6OsnfO+xsirM1Yn2ZbKLmO1goc9mQGsacUhZ2svtwzIetOo
         90O1pewahVIwgmvWSC8shiThrm2YHMZASB+mqRqu2Qk8THl3FAtYWZhF1Bfuy6dCvTgd
         DZRkd032QPl4+wOH2u16UoGvnc9v2/h3ZbpdXWeFrquXn3SV6AODT9/iQ/n0BUz+YEsS
         NFF/nxlHF/sKxSjmESvrgJ+YULMjLzxGx48gy5rSb+1AKaKckbt/wsKPqp1bAzGeDB91
         llK5fy9e3FQYQ3nkeRCfoE91feQJ0Bg4GnlvelXGlhnOTE8/AbthwAD408ZgJ5avP66r
         Q/1g==
X-Gm-Message-State: APjAAAXUHUUPE4izEGc0xCD4VznMml21a7rY9X31+YmsCKBRpPXezNct
        75M1kCBe55xVafDNCn/wgViw1DRMF5gem0gN/M0=
X-Google-Smtp-Source: APXvYqxFqY4hqvCjpu5bLrtVB9HF9X+Oiknt2AoIL2F6QzIYDbfIIZTO59osj5M/WRh4O2BVdm/STxVTgQlIrA90kSA=
X-Received: by 2002:a92:9e97:: with SMTP id s23mr29405150ilk.139.1580934023820;
 Wed, 05 Feb 2020 12:20:23 -0800 (PST)
MIME-Version: 1.0
References: <20200205102552.21409-1-kraxel@redhat.com>
In-Reply-To: <20200205102552.21409-1-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Wed, 5 Feb 2020 12:20:12 -0800
Message-ID: <CAPaKu7SyqZU=ov4Atbedie6AGC52he0QQJZnGqr545mG-U7vvg@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: ratelimit error logging
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 5, 2020 at 2:26 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Avoid flooding the log in case we screw up badly.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_vq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 5914e79d3429..83f22933c3bb 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -212,9 +212,9 @@ void virtio_gpu_dequeue_ctrl_func(struct work_struct *work)
>                         if (resp->type >= cpu_to_le32(VIRTIO_GPU_RESP_ERR_UNSPEC)) {
>                                 struct virtio_gpu_ctrl_hdr *cmd;
>                                 cmd = (struct virtio_gpu_ctrl_hdr *)entry->buf;
> -                               DRM_ERROR("response 0x%x (command 0x%x)\n",
> -                                         le32_to_cpu(resp->type),
> -                                         le32_to_cpu(cmd->type));
> +                               DRM_ERROR_RATELIMITED("response 0x%x (command 0x%x)\n",
> +                                                     le32_to_cpu(resp->type),
> +                                                     le32_to_cpu(cmd->type));
>                         } else
>                                 DRM_DEBUG("response 0x%x\n", le32_to_cpu(resp->type));
>                 }
> --
> 2.18.1
>
