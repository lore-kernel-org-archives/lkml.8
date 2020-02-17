Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4D2C3B1BF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 01:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16203206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 01:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVRAktaI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgBQBUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 20:20:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51575 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgBQBUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 20:20:39 -0500
Received: by mail-wm1-f65.google.com with SMTP id t23so15496536wmi.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 17:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZuOsBWqGR/J6P3qYbyUpxOiY4OTNviM6Oswc2b07mTA=;
        b=gVRAktaILye8n+mbqfmhURirjsVfqG2q4nOtT/GeqUkCOd1kd/Uj34DA2Q1JFf7a57
         73e/yvG9aa7ZbNEryLbR1xaYweLxVAQ9f8XLKOxBndaTaCj01ovebid95IMiJD0iLAV3
         /Va+PEzoe1p1jFSSOa5P/gZcho8td6rHI8jszCmi2YC6eQAC5Cw7KMiDzaaJRb5vazEh
         /c5Z2hGuODsqbR2+gZjfwku567RASslLZJ8id5E/oRX9LnPvwYCSzcBvBXlOXDs9KYw9
         7XtWvCXlDER99H1dJebmqoy08cdDPjgmibojAh5Cwwqt4PR4hLJ5N9OYaSb7T99zlNXJ
         9k5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZuOsBWqGR/J6P3qYbyUpxOiY4OTNviM6Oswc2b07mTA=;
        b=lC7C2Qy0bfrk3NT185BB07C7oIfBcDrvbOwdeUmVBWveB3KD2YUr01O3F3gEUQFe3Y
         xze3zzDMqGXTxg1wA5tv3t6BpQ5swb5btTsywxHl2AIbrwqLMntCu6wMqXvgR0MTakRs
         J76m1YUwrtSnIqasaOJAqZcB90grLcBrQYwNXS2yOSRu4FVs0Nfr/regGm79uYrRGz8k
         NGDM/fTLwsqagV0HZsh5sbrsrrsBybOXd90iBSRDyXTZFw6BxhI8BMnJd6vKnq+gLSCz
         LGQJponhekzUI18VBUjZVMH+2ejO4mOfK5YLfkv+49CTXc2IMY2kc0q8zT2KLcF+/P29
         6gyQ==
X-Gm-Message-State: APjAAAW9xcOL5l6y+lFndVgIC986Af7FRVsUiSzeXkrPWDs9bXiud/4d
        1ngexIhHaH7DXf96p+x6VUjT/bR7/tdJhT3pfCWgrEzf
X-Google-Smtp-Source: APXvYqx6PBWOpIYIYZLMR1Nb2Yc4mw9pfeBqzDwp/d/kSibSFsfc1P+NGYm2h5IY/YBNVroxq/ho+kWtTgAodNjYPi8=
X-Received: by 2002:a7b:cd92:: with SMTP id y18mr14505338wmj.133.1581902437832;
 Sun, 16 Feb 2020 17:20:37 -0800 (PST)
MIME-Version: 1.0
References: <20200215035026.3180698-1-anarsoul@gmail.com>
In-Reply-To: <20200215035026.3180698-1-anarsoul@gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 17 Feb 2020 09:20:26 +0800
Message-ID: <CAKGbVbvEDYJ19KVWXN0k-5niXLjmPYvxGJQ2-3GWTyYyFkH0Gw@mail.gmail.com>
Subject: Re: [PATCH] drm/lima: fix recovering from PLBU out of memory
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good for me, patch is:
Reviewed-by: Qiang Yu <yuq825@gmail.com>

Regards,
Qiang

On Sat, Feb 15, 2020 at 11:50 AM Vasily Khoruzhick <anarsoul@gmail.com> wrote:
>
> It looks like on PLBU_OUT_OF_MEM interrupt we need to resume from where we
> stopped, i.e. new PLBU heap start is old end. Also update end address
> in GP frame to grow heap on 2nd and subsequent out of memory interrupts.
>
> Fixes: 2081e8dcf1ee ("drm/lima: recover task by enlarging heap buffer")
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/gpu/drm/lima/lima_gp.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/lima/lima_gp.c b/drivers/gpu/drm/lima/lima_gp.c
> index d1e7826c2d74..325604262def 100644
> --- a/drivers/gpu/drm/lima/lima_gp.c
> +++ b/drivers/gpu/drm/lima/lima_gp.c
> @@ -224,8 +224,13 @@ static int lima_gp_task_recover(struct lima_sched_pipe *pipe)
>         }
>
>         gp_write(LIMA_GP_INT_MASK, LIMA_GP_IRQ_MASK_USED);
> +       /* Resume from where we stopped, i.e. new start is old end */
> +       gp_write(LIMA_GP_PLBU_ALLOC_START_ADDR,
> +                f[LIMA_GP_PLBU_ALLOC_END_ADDR >> 2]);
> +       f[LIMA_GP_PLBU_ALLOC_END_ADDR >> 2] =
> +               f[LIMA_GP_PLBU_ALLOC_START_ADDR >> 2] + task->heap->heap_size;
>         gp_write(LIMA_GP_PLBU_ALLOC_END_ADDR,
> -                f[LIMA_GP_PLBU_ALLOC_START_ADDR >> 2] + task->heap->heap_size);
> +                f[LIMA_GP_PLBU_ALLOC_END_ADDR >> 2]);
>         gp_write(LIMA_GP_CMD, LIMA_GP_CMD_UPDATE_PLBU_ALLOC);
>         return 0;
>  }
> --
> 2.25.0
>
