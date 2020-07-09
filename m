Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672F3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43D272077D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594309492;
	bh=aGxVb1DpozV7hPF11M4DsBqQ/F4gMscLyOHG8dL9j04=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1Qp9kpU8P1b4e+ysSv9mwAI1D+NP+oOzvwYQXovPvWxYyGymygSDS6AZex8O4rCug
	 ssM3OP5Hedz2VLaRzlUf1OClfkriGcmyVZIio5VVlqnaH4nAF/+024pd1asPkm7J/o
	 BK+HjViESHBs3SeImvSc4UnPY58+vJEpA03Dk1Fc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgGIPov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:44:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgGIPou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:44:50 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5720207DA
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 15:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594309490;
        bh=aGxVb1DpozV7hPF11M4DsBqQ/F4gMscLyOHG8dL9j04=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0k7684PoUgEkh6vKt/lEAefEnXoyZuetBeD96YkehKeEcFfnG5FYX2cJeuDYTvxBU
         0UBwgrAxPCBHFrUeYigmgahHtSPX7eYVfI/gFc90zIDh3ysx3itLamOGDB18wZAOZJ
         EL2u8W+FVfqRRAvGV/P/gpYxQFxiMxitMzaCBIjQ=
Received: by mail-oi1-f178.google.com with SMTP id j11so2202903oiw.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 08:44:49 -0700 (PDT)
X-Gm-Message-State: AOAM533UyP2eNzIB2A4jFY9kAfwi/ztGx7mWLAcsQpFdtWr+gq4dv8Q1
        oRZdyh7beO1Mi37wYEMDsshwjSGvdIkJZWl1sA==
X-Google-Smtp-Source: ABdhPJzl0mWTn/pDt1A80BbL1boJ6ERwIXyk6Ru4V8uvWhGSAzZj8kyuTd/RKd9//s92FUEqZO+4e/a//gzXkCx19Ik=
X-Received: by 2002:aca:4844:: with SMTP id v65mr614541oia.152.1594309489279;
 Thu, 09 Jul 2020 08:44:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200614062730.46489-1-navid.emamdoost@gmail.com>
In-Reply-To: <20200614062730.46489-1-navid.emamdoost@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 9 Jul 2020 09:44:36 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL=+ToP1w3m8GdK0K0o8ER2eYSiM5ffuFVxyMsZns4gqA@mail.gmail.com>
Message-ID: <CAL_JsqL=+ToP1w3m8GdK0K0o8ER2eYSiM5ffuFVxyMsZns4gqA@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: fix ref count leak in panfrost_job_hw_submit
To:     Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Navid Emamdoost <emamd001@umn.edu>, wu000273@umn.edu,
        kjlu@umn.edu, Stephen McCamant <smccaman@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 12:27 AM Navid Emamdoost
<navid.emamdoost@gmail.com> wrote:
>
> in panfrost_job_hw_submit, pm_runtime_get_sync is called which
> increments the counter even in case of failure, leading to incorrect
> ref count. In case of failure, decrement the ref count before returning.
>
> Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_job.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/panfrost/panfrost_job.c b/drivers/gpu/drm/panfrost/panfrost_job.c
> index 7914b1570841..89ac84667eb1 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_job.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_job.c
> @@ -147,11 +147,10 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
>
>         ret = pm_runtime_get_sync(pfdev->dev);
>         if (ret < 0)
> -               return;
> +               goto out;

If the get failed, I don't think we want to do a put.

>
>         if (WARN_ON(job_read(pfdev, JS_COMMAND_NEXT(js)))) {
> -               pm_runtime_put_sync_autosuspend(pfdev->dev);
> -               return;
> +               goto out;
>         }
>
>         cfg = panfrost_mmu_as_get(pfdev, &job->file_priv->mmu);
> @@ -184,6 +183,9 @@ static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
>                                 job, js, jc_head);
>
>         job_write(pfdev, JS_COMMAND_NEXT(js), JS_COMMAND_START);

So we start the job here and then...

> +out:
> +       pm_runtime_put_sync_autosuspend(pfdev->dev);

...turn off clocks/power here. Typically, you'd be fine as autosuspend
has a delay by default, but userspace is free to change the delay to
0.

> +       return;
>  }
>
>  static void panfrost_acquire_object_fences(struct drm_gem_object **bos,
> --
> 2.17.1
>
