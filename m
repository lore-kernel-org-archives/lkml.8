Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589EAC33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EDB3207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mv+nXZxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgAMQZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:25:34 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:44315 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbgAMQZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:25:33 -0500
Received: by mail-io1-f65.google.com with SMTP id b10so10394586iof.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 08:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3UKPRjuLVC7RO4AknJBGHEyZav1jTqAsHZbWbB3QaM8=;
        b=Mv+nXZxf2F7xE+wuPTov+5KoY4ixZ6no2YUOcBoz/RDoP7uuU4g041P+xKxpcK2T2b
         mqWwneKicqkxX2VDYaNE1lawqVrL8YFzifprEFFHEhlJnUWQI+5VPqx+BFPRF/IALbS7
         AmcNEYJwh05KKFtlPP8r1AHvUcD7O0fld9+4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3UKPRjuLVC7RO4AknJBGHEyZav1jTqAsHZbWbB3QaM8=;
        b=IKzVLcQxiSi9fMNeVMlyB9tSE9LBNwrarL7S5EEManQYTff/Mx1rdzTjPN9emKVQBJ
         Hi592r3RXQnd7/S1z0lqmQuQCjPQAXnhcT3cpIrY+jFUBH5Lsg5aznwZT7yJhCFdVVK+
         eIrH2WPUCPqvd1c6Sn/hXZzH2t+A06VVhHRBD0cQ2r/9mHu1W91I6riV3NoA8RuMwgpB
         b54zwloGWPNd+49Tb5oOnck9eHmBsXL2eg+Feb2L9jA2QnYnrLzp6uCf06sOTAKnlxSd
         pOOhT/af3pH0nkcBhQkXxvq1Xm2xnHalQ0TTY/ecu9HsSgwRlfw4OMdz/KYHwGhYoaIg
         1K0Q==
X-Gm-Message-State: APjAAAWpAvNzh3Kg0nx9rZdHnXxHm2aPXzYiK3Gk7+gtU5ALTCQRAZG2
        zK+C1WAWoT96Umb1rygvVkUAAMTOKSS2h+HNxC9uNg==
X-Google-Smtp-Source: APXvYqyLDLAoShN0kNLQeelFvPXh19MZYXF+kvpTMezYlJSyzsMMSzCxmmBx48UJ+c45QjVTifzbEDrRErpdc9L7aRA=
X-Received: by 2002:a05:6638:5b6:: with SMTP id b22mr15275153jar.6.1578932732634;
 Mon, 13 Jan 2020 08:25:32 -0800 (PST)
MIME-Version: 1.0
References: <20200113153605.52350-1-brian@brkho.com> <20200113153605.52350-3-brian@brkho.com>
In-Reply-To: <20200113153605.52350-3-brian@brkho.com>
From:   Rob Clark <robdclark@chromium.org>
Date:   Mon, 13 Jan 2020 08:25:21 -0800
Message-ID: <CAJs_Fx48B-C8GEeAmPaqGAqAOTR2dT0csg8W=TRyULOfy=1=VQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/msm: Add MSM_WAIT_IOVA ioctl
To:     Brian Ho <brian@brkho.com>
Cc:     freedreno <freedreno@lists.freedesktop.org>,
        hoegsberg@chromium.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 7:37 AM Brian Ho <brian@brkho.com> wrote:
>
> Implements an ioctl to wait until a value at a given iova is greater
> than or equal to a supplied value.
>
> This will initially be used by turnip (open-source Vulkan driver for
> QC in mesa) for occlusion queries where the userspace driver can
> block on a query becoming available before continuing via
> vkGetQueryPoolResults.
>
> Signed-off-by: Brian Ho <brian@brkho.com>
> ---
>  drivers/gpu/drm/msm/msm_drv.c | 63 +++++++++++++++++++++++++++++++++--
>  include/uapi/drm/msm_drm.h    | 13 ++++++++
>  2 files changed, 74 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index c84f0a8b3f2c..dcc46874a5a2 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -36,10 +36,11 @@
>   *           MSM_GEM_INFO ioctl.
>   * - 1.4.0 - softpin, MSM_RELOC_BO_DUMP, and GEM_INFO support to set/get
>   *           GEM object's debug name
> - * - 1.5.0 - Add SUBMITQUERY_QUERY ioctl
> + * - 1.5.0 - Add SUBMITQUEUE_QUERY ioctl
> + * - 1.6.0 - Add WAIT_IOVA ioctl
>   */
>  #define MSM_VERSION_MAJOR      1
> -#define MSM_VERSION_MINOR      5
> +#define MSM_VERSION_MINOR      6
>  #define MSM_VERSION_PATCHLEVEL 0
>
>  static const struct drm_mode_config_funcs mode_config_funcs = {
> @@ -952,6 +953,63 @@ static int msm_ioctl_submitqueue_close(struct drm_device *dev, void *data,
>         return msm_submitqueue_remove(file->driver_priv, id);
>  }
>
> +static int msm_ioctl_wait_iova(struct drm_device *dev, void *data,
> +               struct drm_file *file)
> +{
> +       struct msm_drm_private *priv = dev->dev_private;
> +       struct drm_gem_object *obj;
> +       struct drm_msm_wait_iova *args = data;
> +       ktime_t timeout = to_ktime(args->timeout);
> +       unsigned long remaining_jiffies = timeout_to_jiffies(&timeout);
> +       struct msm_gpu *gpu = priv->gpu;
> +       void *base_vaddr;
> +       uint64_t *vaddr;
> +       int ret;
> +
> +       if (args->pad)
> +               return -EINVAL;
> +
> +       if (!gpu)
> +               return 0;

hmm, I'm not sure we should return zero in this case.. maybe -ENODEV?

> +
> +       obj = drm_gem_object_lookup(file, args->handle);
> +       if (!obj)
> +               return -ENOENT;
> +
> +       base_vaddr = msm_gem_get_vaddr(obj);
> +       if (IS_ERR(base_vaddr)) {
> +               ret = PTR_ERR(base_vaddr);
> +               goto err_put_gem_object;
> +       }
> +       if (args->offset + sizeof(*vaddr) > obj->size) {
> +               ret = -EINVAL;
> +               goto err_put_vaddr;
> +       }
> +
> +       vaddr = base_vaddr + args->offset;
> +
> +       /* Assumes WC mapping */
> +       ret = wait_event_interruptible_timeout(
> +                       gpu->event, *vaddr >= args->value, remaining_jiffies);
> +
> +       if (ret == 0) {
> +               ret = -ETIMEDOUT;
> +               goto err_put_vaddr;
> +       } else if (ret == -ERESTARTSYS) {
> +               goto err_put_vaddr;
> +       }

maybe:

 } else {
   ret = 0;
 }

and then drop the next three lines?

> +
> +       msm_gem_put_vaddr(obj);
> +       drm_gem_object_put_unlocked(obj);
> +       return 0;
> +
> +err_put_vaddr:
> +       msm_gem_put_vaddr(obj);
> +err_put_gem_object:
> +       drm_gem_object_put_unlocked(obj);
> +       return ret;
> +}
> +
>  static const struct drm_ioctl_desc msm_ioctls[] = {
>         DRM_IOCTL_DEF_DRV(MSM_GET_PARAM,    msm_ioctl_get_param,    DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(MSM_GEM_NEW,      msm_ioctl_gem_new,      DRM_RENDER_ALLOW),
> @@ -964,6 +1022,7 @@ static const struct drm_ioctl_desc msm_ioctls[] = {
>         DRM_IOCTL_DEF_DRV(MSM_SUBMITQUEUE_NEW,   msm_ioctl_submitqueue_new,   DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(MSM_SUBMITQUEUE_CLOSE, msm_ioctl_submitqueue_close, DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(MSM_SUBMITQUEUE_QUERY, msm_ioctl_submitqueue_query, DRM_RENDER_ALLOW),
> +       DRM_IOCTL_DEF_DRV(MSM_WAIT_IOVA, msm_ioctl_wait_iova, DRM_RENDER_ALLOW),
>  };
>
>  static const struct vm_operations_struct vm_ops = {
> diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
> index 0b85ed6a3710..8477f28a4ee1 100644
> --- a/include/uapi/drm/msm_drm.h
> +++ b/include/uapi/drm/msm_drm.h
> @@ -298,6 +298,17 @@ struct drm_msm_submitqueue_query {
>         __u32 pad;
>  };
>
> +/* This ioctl blocks until the u64 value at bo + offset is greater than or
> + * equal to the reference value.
> + */
> +struct drm_msm_wait_iova {
> +       __u32 handle;          /* in, GEM handle */
> +       __u32 pad;
> +       struct drm_msm_timespec timeout;   /* in */
> +       __u64 offset;          /* offset into bo */
> +       __u64 value;           /* reference value */

Maybe we should go ahead and add a __u64 mask;

that would let us wait for 32b values as well, and wait for bits in a bitmask

Other than those minor comments, it looks pretty good to me

BR,
-R

> +};
> +
>  #define DRM_MSM_GET_PARAM              0x00
>  /* placeholder:
>  #define DRM_MSM_SET_PARAM              0x01
> @@ -315,6 +326,7 @@ struct drm_msm_submitqueue_query {
>  #define DRM_MSM_SUBMITQUEUE_NEW        0x0A
>  #define DRM_MSM_SUBMITQUEUE_CLOSE      0x0B
>  #define DRM_MSM_SUBMITQUEUE_QUERY      0x0C
> +#define DRM_MSM_WAIT_IOVA      0x0D
>
>  #define DRM_IOCTL_MSM_GET_PARAM        DRM_IOWR(DRM_COMMAND_BASE + DRM_MSM_GET_PARAM, struct drm_msm_param)
>  #define DRM_IOCTL_MSM_GEM_NEW          DRM_IOWR(DRM_COMMAND_BASE + DRM_MSM_GEM_NEW, struct drm_msm_gem_new)
> @@ -327,6 +339,7 @@ struct drm_msm_submitqueue_query {
>  #define DRM_IOCTL_MSM_SUBMITQUEUE_NEW    DRM_IOWR(DRM_COMMAND_BASE + DRM_MSM_SUBMITQUEUE_NEW, struct drm_msm_submitqueue)
>  #define DRM_IOCTL_MSM_SUBMITQUEUE_CLOSE  DRM_IOW (DRM_COMMAND_BASE + DRM_MSM_SUBMITQUEUE_CLOSE, __u32)
>  #define DRM_IOCTL_MSM_SUBMITQUEUE_QUERY  DRM_IOW (DRM_COMMAND_BASE + DRM_MSM_SUBMITQUEUE_QUERY, struct drm_msm_submitqueue_query)
> +#define DRM_IOCTL_MSM_WAIT_IOVA        DRM_IOW (DRM_COMMAND_BASE + DRM_MSM_WAIT_IOVA, struct drm_msm_wait_iova)
>
>  #if defined(__cplusplus)
>  }
> --
> 2.25.0.rc1.283.g88dfdc4193-goog
>
