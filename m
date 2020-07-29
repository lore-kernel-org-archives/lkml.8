Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2AFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4463F2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="b/qQahM8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgG2MYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgG2MYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:24:38 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB23C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 05:24:38 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r12so21398110wrj.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 05:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=68xCg6pXAouXrwVrUHPkLuNqXQU/Y65Yetyo+oMQQNw=;
        b=b/qQahM800QMRiH+9NizG5codtnPio/oswvWkqp2JmDxdIHjL+hpE/YOLt7T+JG+EI
         oHe9zhLXLmOOQo7hh6Wp0pohER1pSAkj00B12t5aK4YFqLLXA9lnn/dC2S4oGy97Nlx9
         tI5KKXbp4YcFKoQqfrGbNV79ep5BgaxJxz45k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=68xCg6pXAouXrwVrUHPkLuNqXQU/Y65Yetyo+oMQQNw=;
        b=uC7FJQjNVXr8WA7YNMquWRaRM7WuDXhVDRINg1KUyOhm/qmli+Wew0w869YUHl6CwO
         sJ6+JtlKgeOzRZaIoRjzScBuY5ix/+B+ft8Ytsha5Xp0VjCWUm0kzmk9cAkoGz0k7sR/
         Tbi7kfgYM8BncUD/8O4p8IW9So3b1G+qc3ALufx+DxsYtK4IfbrZB+LDPKKPXB2/Z/JX
         HPAS4feUqXqPFZOyNwH7Yvu/fubeMpNGFsyzlWLHng35ET5OUtE/qR9/FvycRtoicYAF
         Y+NAbCwlV6gnVh0+8bKEuDzFkw88ERCgxcqs+w5cxoreyJTCqUJRixZ3/PJ9ERYVGgdf
         +RtA==
X-Gm-Message-State: AOAM530250rQPTHAtzYGht8Ek1crqS7kFz0Mp3lg7kBhSeqDyv2Jz+KP
        bBgc+PYLpyEYXVaya/Gkfn+VVw==
X-Google-Smtp-Source: ABdhPJxK4vkbf33VbCIGnnM9rck6aBrCCi/BSADl8DrkI+ZRQWrB11FcRI931Xm+ZzwwrwUDk96qnQ==
X-Received: by 2002:a5d:5647:: with SMTP id j7mr28662396wrw.242.1596025476669;
        Wed, 29 Jul 2020 05:24:36 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f9sm4970222wrm.62.2020.07.29.05.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 05:24:35 -0700 (PDT)
Date:   Wed, 29 Jul 2020 14:24:33 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>
Subject: Re: [Intel-gfx] [PATCH v12 2/3] drm/i915: add syncobj timeline
 support
Message-ID: <CAKMK7uFkMKiwyTFMRASk5L=1NdFqeuKfCh_FHRLg4FxzHpXpfw@mail.gmail.com>
Mail-Followup-To: Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>
References: <20200708131751.334457-1-lionel.g.landwerlin@intel.com>
 <20200708131751.334457-3-lionel.g.landwerlin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708131751.334457-3-lionel.g.landwerlin@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees&Linus,

Not sure you're the right person, but figured I start with you with an
idea I had while looking at this patch. Cut out everything except the
relevant part:

On Wed, Jul 8, 2020 at 3:18 PM Lionel Landwerlin <lionel.g.landwerlin@intel.com> wrote:
> +       /* Check multiplication overflow for access_ok() and kvmalloc_array() */
> +       BUILD_BUG_ON(sizeof(size_t) > sizeof(unsigned long));
> +       if (num_user_fences > min_t(unsigned long,
> +                                   ULONG_MAX / sizeof(*user_fences),
> +                                   SIZE_MAX / sizeof(*fences)))
> +               return -EINVAL;
> +
> +       user_fences = u64_to_user_ptr(timeline_fences->handles_ptr);
> +       if (!access_ok(user_fences, num_user_fences * sizeof(*user_fences)))
> +               return -EFAULT;
> +
> +       user_values = u64_to_user_ptr(timeline_fences->values_ptr);
> +       if (!access_ok(user_values, num_user_fences * sizeof(*user_values)))
> +               return -EFAULT;

Do we have a access_ok_array or so? Instead of duplicating overflow checks
everywhere and getting it all wrong ... Similar I guess for
copy_from/to_user_array.

Just random idea that crossed my mind and I figured I'll throw it out
there.

Cheers, Daniel

> +
> +       fences = kvmalloc_array(num_user_fences, sizeof(*fences),
> +                               __GFP_NOWARN | GFP_KERNEL);
> +       if (!fences)
> +               return -ENOMEM;
> +
> +       BUILD_BUG_ON(~(ARCH_KMALLOC_MINALIGN - 1) &
> +                    ~__I915_EXEC_FENCE_UNKNOWN_FLAGS);
> +
> +       for (n = 0, num_fences = 0; n < timeline_fences->fence_count; n++) {
> +               struct drm_i915_gem_exec_fence fence;
> +               struct drm_syncobj *syncobj;
> +               u64 point;
> +
> +               if (__copy_from_user(&fence, user_fences++, sizeof(fence))) {
> +                       err = -EFAULT;
> +                       goto err;
> +               }
> +
> +               if (fence.flags & __I915_EXEC_FENCE_UNKNOWN_FLAGS) {
> +                       err = -EINVAL;
> +                       goto err;
> +               }
> +
> +               if (__get_user(point, user_values++)) {
> +                       err = -EFAULT;
> +                       goto err;
> +               }
> +
> +               syncobj = drm_syncobj_find(eb->file, fence.handle);
> +               if (!syncobj) {
> +                       DRM_DEBUG("Invalid syncobj handle provided\n");
> +                       err = -ENOENT;
> +                       goto err;
> +               }
> +
> +               /*
> +                * For timeline syncobjs we need to preallocate chains for
> +                * later signaling.
> +                */
> +               if (point != 0 && fence.flags & I915_EXEC_FENCE_SIGNAL) {
> +                       /*
> +                        * Waiting and signaling the same point (when point !=
> +                        * 0) would break the timeline.
> +                        */
> +                       if (fence.flags & I915_EXEC_FENCE_WAIT) {
> +                               DRM_DEBUG("Tring to wait & signal the same timeline point.\n");
> +                               err = -EINVAL;
> +                               drm_syncobj_put(syncobj);
> +                               goto err;
> +                       }
> +
> +                       fences[num_fences].chain_fence =
> +                               kmalloc(sizeof(*fences[num_fences].chain_fence),
> +                                       GFP_KERNEL);
> +                       if (!fences[num_fences].chain_fence) {
> +                               drm_syncobj_put(syncobj);
> +                               err = -ENOMEM;
> +                               DRM_DEBUG("Unable to alloc chain_fence\n");
> +                               goto err;
> +                       }
> +               } else {
> +                       fences[num_fences].chain_fence = NULL;
> +               }
> +
> +               fences[num_fences].syncobj = ptr_pack_bits(syncobj, fence.flags, 2);
> +               fences[num_fences].value = point;
> +               num_fences++;
> +       }
> +
> +       eb->fences = fences;
> +       eb->n_fences = num_fences;
> +
> +       return 0;
> +
> +err:
> +       __free_fence_array(fences, num_fences);
> +       return err;
> +}
> +
> +static int
> +get_legacy_fence_array(struct drm_i915_gem_execbuffer2 *args,
> +                      struct i915_execbuffer *eb)
>  {
>         const unsigned long nfences = args->num_cliprects;
>         struct drm_i915_gem_exec_fence __user *user;
> @@ -2235,7 +2344,7 @@ get_fence_array(struct drm_i915_gem_execbuffer2 *args,
>         BUILD_BUG_ON(sizeof(size_t) > sizeof(unsigned long));
>         if (nfences > min_t(unsigned long,
>                             ULONG_MAX / sizeof(*user),
> -                           SIZE_MAX / sizeof(*fences)))
> +                           SIZE_MAX / sizeof(*eb->fences)))
>                 return -EINVAL;
>
>         user = u64_to_user_ptr(args->cliprects_ptr);
> @@ -2272,6 +2381,8 @@ get_fence_array(struct drm_i915_gem_execbuffer2 *args,
>                              ~__I915_EXEC_FENCE_UNKNOWN_FLAGS);
>
>                 fences[n].syncobj = ptr_pack_bits(syncobj, fence.flags, 2);
> +               fences[n].value = 0;
> +               fences[n].chain_fence = NULL;
>         }
>
>         eb->fences = fences;
> @@ -2303,6 +2414,15 @@ await_fence_array(struct i915_execbuffer *eb)
>                 if (!fence)
>                         return -EINVAL;
>
> +               if (eb->fences[n].value) {
> +                       err = dma_fence_chain_find_seqno(&fence, eb->fences[n].value);
> +                       if (err)
> +                               return err;
> +
> +                       if (!fence)
> +                               continue;
> +               }
> +
>                 err = i915_request_await_dma_fence(eb->request, fence);
>                 dma_fence_put(fence);
>                 if (err < 0)
> @@ -2326,7 +2446,17 @@ signal_fence_array(struct i915_execbuffer *eb)
>                 if (!(flags & I915_EXEC_FENCE_SIGNAL))
>                         continue;
>
> -               drm_syncobj_replace_fence(syncobj, fence);
> +               if (eb->fences[n].chain_fence) {
> +                       drm_syncobj_add_point(syncobj, eb->fences[n].chain_fence,
> +                                             fence, eb->fences[n].value);
> +                       /*
> +                        * The chain's ownership is transferred to the
> +                        * timeline.
> +                        */
> +                       eb->fences[n].chain_fence = NULL;
> +               } else {
> +                       drm_syncobj_replace_fence(syncobj, fence);
> +               }
>         }
>  }
>
> @@ -2371,7 +2501,32 @@ static void eb_request_add(struct i915_execbuffer *eb)
>         mutex_unlock(&tl->mutex);
>  }
>
> +static int parse_timeline_fences(struct i915_user_extension __user *ext, void *data)
> +{
> +       struct drm_i915_gem_execbuffer_ext_timeline_fences timeline_fences;
> +       struct i915_execbuffer *eb = data;
> +
> +       /* Timeline fences are incompatible with the fence array flag. */
> +       if (eb->args->flags & I915_EXEC_FENCE_ARRAY)
> +               return -EINVAL;
> +
> +       /*
> +        * Prevent the drm_i915_gem_execbuffer_ext_timeline_fences structure
> +        * to be included multiple times.
> +        */
> +       if (eb->extension_flags & BIT_ULL(DRM_I915_GEM_EXECBUFFER_EXT_TIMELINE_FENCES))
> +               return -EINVAL;
> +
> +       if (copy_from_user(&timeline_fences, ext, sizeof(timeline_fences)))
> +               return -EFAULT;
> +
> +       eb->extension_flags |= BIT_ULL(DRM_I915_GEM_EXECBUFFER_EXT_TIMELINE_FENCES);
> +
> +       return get_timeline_fence_array(&timeline_fences, eb);
> +}
> +
>  static const i915_user_extension_fn execbuf_extensions[] = {
> +       [DRM_I915_GEM_EXECBUFFER_EXT_TIMELINE_FENCES] = parse_timeline_fences,
>  };
>
>  static int
> @@ -2475,7 +2630,7 @@ i915_gem_do_execbuffer(struct drm_device *dev,
>         if (err)
>                 goto err_out_fence;
>
> -       err = get_fence_array(args, &eb);
> +       err = get_legacy_fence_array(args, &eb);
>         if (err)
>                 goto err_arr_fence;
>
> diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
> index 67102dc26fce..f450d8782ac1 100644
> --- a/drivers/gpu/drm/i915/i915_drv.c
> +++ b/drivers/gpu/drm/i915/i915_drv.c
> @@ -1851,7 +1851,8 @@ static struct drm_driver driver = {
>          */
>         .driver_features =
>             DRIVER_GEM |
> -           DRIVER_RENDER | DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_SYNCOBJ,
> +           DRIVER_RENDER | DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_SYNCOBJ |
> +           DRIVER_SYNCOBJ_TIMELINE,
>         .release = i915_driver_release,
>         .open = i915_driver_open,
>         .lastclose = i915_driver_lastclose,
> diff --git a/drivers/gpu/drm/i915/i915_getparam.c b/drivers/gpu/drm/i915/i915_getparam.c
> index 40390b2352b1..e50bdf676955 100644
> --- a/drivers/gpu/drm/i915/i915_getparam.c
> +++ b/drivers/gpu/drm/i915/i915_getparam.c
> @@ -132,6 +132,7 @@ int i915_getparam_ioctl(struct drm_device *dev, void *data,
>         case I915_PARAM_HAS_EXEC_BATCH_FIRST:
>         case I915_PARAM_HAS_EXEC_FENCE_ARRAY:
>         case I915_PARAM_HAS_EXEC_SUBMIT_FENCE:
> +       case I915_PARAM_HAS_EXEC_TIMELINE_FENCES:
>                 /* For the time being all of these are always true;
>                  * if some supported hardware does not have one of these
>                  * features this value needs to be provided from
> diff --git a/include/uapi/drm/i915_drm.h b/include/uapi/drm/i915_drm.h
> index 7ea38aa6502c..85ff36faf15a 100644
> --- a/include/uapi/drm/i915_drm.h
> +++ b/include/uapi/drm/i915_drm.h
> @@ -619,6 +619,13 @@ typedef struct drm_i915_irq_wait {
>   */
>  #define I915_PARAM_PERF_REVISION       54
>
> +/* Query whether DRM_I915_GEM_EXECBUFFER2 supports supplying an array of
> + * timeline syncobj through drm_i915_gem_execbuf_ext_timeline_fences. See
> + * I915_EXEC_USE_EXTENSIONS.
> + */
> +#define I915_PARAM_HAS_EXEC_TIMELINE_FENCES 55
> +
> +
>  /* Must be kept compact -- no holes and well documented */
>
>  typedef struct drm_i915_getparam {
> @@ -1047,9 +1054,41 @@ struct drm_i915_gem_exec_fence {
>  };
>
>  enum drm_i915_gem_execbuffer_ext {
> +       /**
> +        * See drm_i915_gem_execbuf_ext_timeline_fences.
> +        */
> +       DRM_I915_GEM_EXECBUFFER_EXT_TIMELINE_FENCES = 1,
> +
>         DRM_I915_GEM_EXECBUFFER_EXT_MAX /* non-ABI */
>  };
>
> +/**
> + * This structure describes an array of drm_syncobj and associated points for
> + * timeline variants of drm_syncobj. It is invalid to append this structure to
> + * the execbuf if I915_EXEC_FENCE_ARRAY is set.
> + */
> +struct drm_i915_gem_execbuffer_ext_timeline_fences {
> +       struct i915_user_extension base;
> +
> +       /**
> +        * Number of element in the handles_ptr & value_ptr arrays.
> +        */
> +       __u64 fence_count;
> +
> +       /**
> +        * Pointer to an array of struct drm_i915_gem_exec_fence of length
> +        * fence_count.
> +        */
> +       __u64 handles_ptr;
> +
> +       /**
> +        * Pointer to an array of u64 values of length fence_count. Values
> +        * must be 0 for a binary drm_syncobj. A Value of 0 for a timeline
> +        * drm_syncobj is invalid as it turns a drm_syncobj into a binary one.
> +        */
> +       __u64 values_ptr;
> +};
> +
>  struct drm_i915_gem_execbuffer2 {
>         /**
>          * List of gem_exec_object2 structs
> --
> 2.27.0
>
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
