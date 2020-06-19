Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4502AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 02:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DB5120776
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 02:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3itQqvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgFSCDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 22:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgFSCDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 22:03:18 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3BEC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 19:03:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l11so8125279wru.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 19:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RODJZYn4iFbMvRSnqNgS+uD53dBjoKERg29X6MlC140=;
        b=s3itQqvOv37ouSFDWwtHgxc+PavKGYTvFT8wNWbcTjv2Chl+4PCfUoJSHCRvgILzmF
         aurtvht8u9WNnw9YPQh41vKtG3ahKgLQ6hmBjvJ9FVqqXt5OmFRm/ajwlf8WRdg+rWRo
         02RZf9LUbdLi27wOmRjWVtpKk7uPhdptduczocA/H7k0qcYkEyq7bSFwVNmuTfjW1DcK
         0Nx8cuF7wTTYhh7cThkwc+T206FBcFLiCH9HjMYzl9saks+kuMgbPY1YLfN9eV6yY7VW
         DoIPOAWkl71uJKyopDxbek3UweL21NXqzOmxUQ9VJWor9LyRVRDkf/sB2gkBne6NCN1v
         c8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RODJZYn4iFbMvRSnqNgS+uD53dBjoKERg29X6MlC140=;
        b=EuUCblsrq7oxyrrAqab4MlQgSjUn2Vd9VSCc588SqeFrkG2NAMeStl9vWV5hiFKKhj
         p0g5so2AxbzzhkwrTlpMrFNILuTVZTJJsb3XGjzyanohaoGWfR7QEC/vIIIcik278MNe
         7PSVwPDemo/+KyHw+XwWc7iKoeCVIk7gEiTRFPnA4A+s0gzb3t8dmYab70YJh+HaxF7u
         ckO081gxYRp6PsAIDNHUgzfSXHNAML9Xzwrwa0bdx0BPOiV4o9RcnwVGXE+54/iiTqHw
         bEAyf9SR0BYo2FmXFQMRk+X7Lg35NUXYTu7L1mnorqR32X8EPQUUbQ5bFC0kRU8uesz5
         gb+g==
X-Gm-Message-State: AOAM532N8hwcUx2vFE5yJm1QKQ0JM6xW9nn2aArjGu/fMVFVCw0nH2Km
        VGlTaTB05jc6AG+5UhWS8HX9LmvmT1Dotzvju3sfJnVY
X-Google-Smtp-Source: ABdhPJzn5PrCq5NL5cXS+bqcFGUOPR0i9ys88AV1yxcZr8JHsO7R4rcKc5Q6oB/imNxQ71nysuXJYLNFTr35c5+C61g=
X-Received: by 2002:a5d:60c3:: with SMTP id x3mr1365729wrt.48.1592532196588;
 Thu, 18 Jun 2020 19:03:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAKGbVbuV8meZji9PqFUwt4CpFEy6efpX63hJBgMY7fzAnZS4Rg@mail.gmail.com>
 <20200618145838.2956591-1-andrey.lebedev@gmail.com>
In-Reply-To: <20200618145838.2956591-1-andrey.lebedev@gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Fri, 19 Jun 2020 10:03:05 +0800
Message-ID: <CAKGbVbtYusvURFcUyQtgUycNJPAQyDGDaLXW8qw-x49DqfKmQA@mail.gmail.com>
Subject: Re: [PATCH] drm/lima: Expose job_hang_limit module parameter
To:     Andrey Lebedev <andrey.lebedev@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Lebedev <andrey@lebedev.lt>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 10:58 PM Andrey Lebedev
<andrey.lebedev@gmail.com> wrote:
>
> From: Andrey Lebedev <andrey@lebedev.lt>
>
> Some pp or gp jobs can be successfully repeated even after they time outs.
> Introduce lima module parameter to specify number of times a job can hang
> before being dropped.
>
> Signed-off-by: Andrey Lebedev <andrey@lebedev.lt>
> ---
>
> Fixes for the embarrassing build error
> Reported-by: kernel test robot <lkp@intel.com>
>
>  drivers/gpu/drm/lima/lima_drv.c   | 4 ++++
>  drivers/gpu/drm/lima/lima_drv.h   | 1 +
>  drivers/gpu/drm/lima/lima_sched.c | 5 +++--
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
> index a831565af813..2400b8d52d92 100644
> --- a/drivers/gpu/drm/lima/lima_drv.c
> +++ b/drivers/gpu/drm/lima/lima_drv.c
> @@ -19,6 +19,7 @@
>  int lima_sched_timeout_ms;
>  uint lima_heap_init_nr_pages = 8;
>  uint lima_max_error_tasks;
> +uint lima_job_hang_limit;
>
>  MODULE_PARM_DESC(sched_timeout_ms, "task run timeout in ms");
>  module_param_named(sched_timeout_ms, lima_sched_timeout_ms, int, 0444);
> @@ -29,6 +30,9 @@ module_param_named(heap_init_nr_pages, lima_heap_init_nr_pages, uint, 0444);
>  MODULE_PARM_DESC(max_error_tasks, "max number of error tasks to save");
>  module_param_named(max_error_tasks, lima_max_error_tasks, uint, 0644);
>
> +MODULE_PARM_DESC(job_hang_limit, "number of times to allow a job to hang before dropping it (default 0)");
> +module_param_named(job_hang_limit, lima_job_hang_limit, int, 0444);
> +
Still miss this "int" to "uint".

Regards,
Qiang

>  static int lima_ioctl_get_param(struct drm_device *dev, void *data, struct drm_file *file)
>  {
>         struct drm_lima_get_param *args = data;
> diff --git a/drivers/gpu/drm/lima/lima_drv.h b/drivers/gpu/drm/lima/lima_drv.h
> index fdbd4077c768..c738d288547b 100644
> --- a/drivers/gpu/drm/lima/lima_drv.h
> +++ b/drivers/gpu/drm/lima/lima_drv.h
> @@ -11,6 +11,7 @@
>  extern int lima_sched_timeout_ms;
>  extern uint lima_heap_init_nr_pages;
>  extern uint lima_max_error_tasks;
> +extern uint lima_job_hang_limit;
>
>  struct lima_vm;
>  struct lima_bo;
> diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
> index e6cefda00279..1602985dfa04 100644
> --- a/drivers/gpu/drm/lima/lima_sched.c
> +++ b/drivers/gpu/drm/lima/lima_sched.c
> @@ -503,8 +503,9 @@ int lima_sched_pipe_init(struct lima_sched_pipe *pipe, const char *name)
>
>         INIT_WORK(&pipe->recover_work, lima_sched_recover_work);
>
> -       return drm_sched_init(&pipe->base, &lima_sched_ops, 1, 0,
> -                             msecs_to_jiffies(timeout), name);
> +       return drm_sched_init(&pipe->base, &lima_sched_ops, 1,
> +                             lima_job_hang_limit, msecs_to_jiffies(timeout),
> +                             name);
>  }
>
>  void lima_sched_pipe_fini(struct lima_sched_pipe *pipe)
> --
> 2.25.1
>
