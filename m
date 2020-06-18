Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAD5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C975720FC3
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 06:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j8ggOw7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgFRGoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 02:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727779AbgFRGoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 02:44:06 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CB3C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 23:44:05 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r7so4799644wro.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 23:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5he0LX9AkSF3dLJiFJLP7+SSZu9EadmKeCoEaXRlto=;
        b=j8ggOw7MNFWei7kz45vHodyTQzqUmaHKVX/Raj4Tnd5xdvxTGLhUu1oG5GfqZ3nviz
         il75HFEtqNN180CM/2x/uK62oT3uf+a+G4e9JL0EFkyZLR7SbY4G/m/oDF4ulEJPtK5O
         8NxY1VRptQZybaiBG1XKQTDKzXj3N2XAIrDstCgWa6pKu7g8n91eL2smuRuVGWPWULnN
         4fHzESZPFKIq5hXZVWRo/zA11a+OZFKCCfU43NKr6zCY/rbh6DMSpxH8Ab9VUi1jWpIF
         xMsb4GOJ9fUFchT1tmkCYsPH/4LZ87rS/5LhKMTZxKyk39I/w2VboyEl4IEHZ0Kjoxmm
         mqlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5he0LX9AkSF3dLJiFJLP7+SSZu9EadmKeCoEaXRlto=;
        b=p+MZwkcqrTeqQ65fUtBTOch3rmkbUM3XKPAB6/mqrfIRQ2hwUJJ5geWWBWqa+VL7gn
         776jK1F8yqbTy+N/rwyQG0uIz1AHnfp34N6ZWxC8BXTRnDfRG9HFyca37F6L5T+O6X5f
         FLFaklu8xZPytGa9JUob7eET6SAeanmTpCGuNCDLvvkYpLF+ZxTBZMABJ8DPiXo/42hu
         iRCDaR51vyX1h/Mdsrb6TXYr09/6v/5uJ5pzo9dhoOiZ3+P4MSOYzRNf6xHiE7W8jZvv
         bO9l0+l2SGZRJbELWORFTOdvyy5vwB8fvZYoUQuyJVgmPqc3ZqzX76hGsqYpeyTnA8HJ
         vyjw==
X-Gm-Message-State: AOAM531ShXeWUT0dgVNemycnMo84r9G7oKlofjZkTaZ1ZxmrIjLQbuLI
        PPNn63xqQJ5QdZd6xU4j0psHe6dA7HpvzTSa0zacokFw
X-Google-Smtp-Source: ABdhPJxqxOCbKY2b3RyKbmPC9Y4yvEuh2t9F+Ipw012eO0XCOCOaKkMXZBLhuPa40MM9LxD5BB8yXANspaH1O4LM2ow=
X-Received: by 2002:a5d:60c3:: with SMTP id x3mr2856502wrt.48.1592462644689;
 Wed, 17 Jun 2020 23:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200617175447.2681047-1-andrey.lebedev@gmail.com>
In-Reply-To: <20200617175447.2681047-1-andrey.lebedev@gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Thu, 18 Jun 2020 14:43:53 +0800
Message-ID: <CAKGbVbuV8meZji9PqFUwt4CpFEy6efpX63hJBgMY7fzAnZS4Rg@mail.gmail.com>
Subject: Re: [PATCH] drm/lima: Expose job_hang_limit module parameter
To:     Andrey Lebedev <andrey.lebedev@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        andrey@lebedev.lt
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 1:57 AM Andrey Lebedev <andrey.lebedev@gmail.com> wrote:
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
> Hello,
>
> This patch allows to work around a freezing problem as discussed in
> https://gitlab.freedesktop.org/lima/linux/-/issues/33
>
>  drivers/gpu/drm/lima/lima_drv.c   | 4 ++++
>  drivers/gpu/drm/lima/lima_drv.h   | 1 +
>  drivers/gpu/drm/lima/lima_sched.c | 5 +++--
>  3 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
> index a831565af813..2807eba26c55 100644
> --- a/drivers/gpu/drm/lima/lima_drv.c
> +++ b/drivers/gpu/drm/lima/lima_drv.c
> @@ -19,6 +19,7 @@
>  int lima_sched_timeout_ms;
>  uint lima_heap_init_nr_pages = 8;
>  uint lima_max_error_tasks;
> +int lima_job_hang_limit;

Better be an "uint" to avoid negative check. With this fixed, patch is:
Reviewed-by: Qiang Yu <yuq825@gmail.com>

Regards,
Qiang

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
>  static int lima_ioctl_get_param(struct drm_device *dev, void *data, struct drm_file *file)
>  {
>         struct drm_lima_get_param *args = data;
> diff --git a/drivers/gpu/drm/lima/lima_drv.h b/drivers/gpu/drm/lima/lima_drv.h
> index fdbd4077c768..39fd98e3b14d 100644
> --- a/drivers/gpu/drm/lima/lima_drv.h
> +++ b/drivers/gpu/drm/lima/lima_drv.h
> @@ -11,6 +11,7 @@
>  extern int lima_sched_timeout_ms;
>  extern uint lima_heap_init_nr_pages;
>  extern uint lima_max_error_tasks;
> +extern int lima_job_hang_limit;
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
