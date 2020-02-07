Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018BBC2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA178214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 07:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOZQ9nPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgBGHHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 02:07:40 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:41872 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGHHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 02:07:39 -0500
Received: by mail-io1-f67.google.com with SMTP id m25so1074261ioo.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 23:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fi9cuRdVpZSgrmjmcTsmxSYXnkK56wSAD8cgkFXFjqY=;
        b=GOZQ9nPFOSdqbLte2pDbaMgNEktQIGYkllAIVa6/gEXHF4fO2T7owOkENGAxg3H/V9
         JceazaFr86ZPcqZJCbYW/dz5qU6Oy2fbCJqtMIoYXY026tA6+rFXDlWu/nWH+/63mW5F
         77N6jmyap2Kbs9NPxAGGn5J3sj/xdMfV1zUmlRmC/aWu1EhJMlKsRmAPAe4B8/91nKpr
         gyTR/ACgn3VYQr9db2O4iwLgIDLBgCIbRcQxiOSI+IGkpAz3xmjVO5+6Sqc9fI6hBeZA
         Y7XOZMltEmSnLebh7rgWjpEUxSxu5sfPPy9YJ5o/710XH+4C9eGFPPOK7haF2FUkYiyV
         n54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fi9cuRdVpZSgrmjmcTsmxSYXnkK56wSAD8cgkFXFjqY=;
        b=SVlEXsJhqJho9kFuDAbRzvSxWNl2qxPdJKBfWBpCMyKZ0fNlfn+XpfGJL8Zn9fxEnP
         TFe/3ItX8Lq3wS4nGaiuWwWwALrNn2gudLGjLBDBJmBPnV6CN41SaFXLxiOlKtFbFe8g
         YyLN4jTFuWLlA80GJaOUbZhKxniaNomnXooSKLmswkPvORvDicMrbfiIvGGhRud4qwLE
         kG8Bc1ERPHP5YzpegA44OUIMugdP2FFwxAq71VBRPTOzM1U+XRpCDr2d8SkGW5+RgOsN
         I9ayhjv1rDIr9kqSd3hYeDlF0gfqVrsH8EutFMZxevk5zY+qr8bH72nRipaG9gWgabAk
         LxfA==
X-Gm-Message-State: APjAAAXBsWhgnyOb5JZh5/Jat/WzkPNHcbI7B8suEBZRaDR0fcFx/aHg
        oppAXa2CWF3o+94F/543HkC7iSSHF+PzCH4qslc=
X-Google-Smtp-Source: APXvYqyL4U+Y0Qvy1rn26gr/Unt4Zgd8TMPUJc0YmKynNBNEurpRo3qS4nm7f8ue9KuxlLv4Y03l5JOkGB1DGCL+sPU=
X-Received: by 2002:a02:a14f:: with SMTP id m15mr1989018jah.16.1581059258769;
 Thu, 06 Feb 2020 23:07:38 -0800 (PST)
MIME-Version: 1.0
References: <20200207064653.14403-1-kraxel@redhat.com>
In-Reply-To: <20200207064653.14403-1-kraxel@redhat.com>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Thu, 6 Feb 2020 23:07:27 -0800
Message-ID: <CAPaKu7R25+P-wGdEy2PnPuukcRNSO1ai3hQKtOTSZEMOrwCL7g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/virtio: fix ring free check
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

On Thu, Feb 6, 2020 at 10:47 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> If the virtio device supports indirect ring descriptors we need only one
> ring entry for the whole command.  Take that into account when checking
> whenever the virtqueue has enough free entries for our command.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/gpu/drm/virtio/virtgpu_drv.h     | 1 +
>  drivers/gpu/drm/virtio/virtgpu_debugfs.c | 1 +
>  drivers/gpu/drm/virtio/virtgpu_kms.c     | 3 +++
>  drivers/gpu/drm/virtio/virtgpu_vq.c      | 3 +++
>  4 files changed, 8 insertions(+)
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
> index 7e69c06e168e..d278c8c50f39 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_drv.h
> +++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
> @@ -193,6 +193,7 @@ struct virtio_gpu_device {
>
>         bool has_virgl_3d;
>         bool has_edid;
> +       bool has_indirect;
has_indirect_desc?  Either way,

Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
>
>         struct work_struct config_changed_work;
>
> diff --git a/drivers/gpu/drm/virtio/virtgpu_debugfs.c b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
> index 5156e6b279db..e27120d512b0 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_debugfs.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_debugfs.c
> @@ -47,6 +47,7 @@ static int virtio_gpu_features(struct seq_file *m, void *data)
>
>         virtio_add_bool(m, "virgl", vgdev->has_virgl_3d);
>         virtio_add_bool(m, "edid", vgdev->has_edid);
> +       virtio_add_bool(m, "indirect", vgdev->has_indirect);
>         virtio_add_int(m, "cap sets", vgdev->num_capsets);
>         virtio_add_int(m, "scanouts", vgdev->num_scanouts);
>         return 0;
> diff --git a/drivers/gpu/drm/virtio/virtgpu_kms.c b/drivers/gpu/drm/virtio/virtgpu_kms.c
> index 2f5773e43557..c1086df49816 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_kms.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_kms.c
> @@ -159,6 +159,9 @@ int virtio_gpu_init(struct drm_device *dev)
>         if (virtio_has_feature(vgdev->vdev, VIRTIO_GPU_F_EDID)) {
>                 vgdev->has_edid = true;
>         }
> +       if (virtio_has_feature(vgdev->vdev, VIRTIO_RING_F_INDIRECT_DESC)) {
> +               vgdev->has_indirect = true;
> +       }
>
>         DRM_INFO("features: %cvirgl %cedid\n",
>                  vgdev->has_virgl_3d ? '+' : '-',
> diff --git a/drivers/gpu/drm/virtio/virtgpu_vq.c b/drivers/gpu/drm/virtio/virtgpu_vq.c
> index 41e475fbd67b..cc02fc4bab2a 100644
> --- a/drivers/gpu/drm/virtio/virtgpu_vq.c
> +++ b/drivers/gpu/drm/virtio/virtgpu_vq.c
> @@ -330,6 +330,9 @@ static void virtio_gpu_queue_ctrl_sgs(struct virtio_gpu_device *vgdev,
>         bool notify = false;
>         int ret;
>
> +       if (vgdev->has_indirect)
> +               elemcnt = 1;
> +
>  again:
>         spin_lock(&vgdev->ctrlq.qlock);
>
> --
> 2.18.1
>
