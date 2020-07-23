Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC62BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99E15207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOuWGFzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgGWNw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGWNw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:52:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9AAC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:52:55 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a15so5237650wrh.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p3pTNZMs0Co8HSRLuxgx+ra6lY54Ifu742adT9Ty5xY=;
        b=YOuWGFzGLdaS8sm/4P693z/q9JjhWvmhyhFplKGUqSRHHyBRTgEA59O7Z47QFiQvpU
         UzStdAD1j6xaxcTfNTvyBXxChNNnPcM6jJUG8HVtyTzyBq4ELzoQzMdZxy34SlfLEzHW
         dHohAAM0reRYYgZQmFS1bNrCNr3wNah2/OqE7fO9rjNbJkbmwWGHoDKjvz4Ujn/gzgVh
         qjpIxoNbckBJ5iPIJyP4ABG5NK/Dc5/8u9AZxdlzl4rP2pSl3q8Y9fTH4l2cyb9Vf/Bf
         SOWeR7V/+N5dXtEJidhNYOjw3geeykDGZRwPxeFxaHPvKDLk5/QL14t41L7KbMa2W5Kc
         PD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p3pTNZMs0Co8HSRLuxgx+ra6lY54Ifu742adT9Ty5xY=;
        b=f2Bc1EzYzfp1FgMhJLxkzQlLvh54rNZSJkUqy1MDijLwfiFhvLy0cGE3j7AoljY1dW
         zQFfYRBd490S5gaErEsgLwo/I90VkodDT+H+oo62y8ZtxgsgnPf3jiL0h0mv3Z16Y6L7
         dXbofS9eCDMQslGJ+wtdEbNnxBwybWasHOjx+UeOmuosYyp51AvbKSeza+58n5Nem7Fp
         hzk22lq5oe1g+e/jBvhBRVn8w/g0FLi6J2KfJmoVjR0F+h51EGxteKJbQitPvlFuCFt9
         djhCwh7koodxFBTuikbbl5G0guWxm83nZL8bak1DsLqszv1lqGd7Wmx6bZAnrDiO3wGK
         Z39A==
X-Gm-Message-State: AOAM530vAqqor8Rl4TSSfCg3k5IcVa209qqsyHVHngTq4cvSpBNgsbdR
        5LdvHjImvJbqdCggnqoh0vqLABKMMNE0NJxOppKLRw==
X-Google-Smtp-Source: ABdhPJw7F4eKclGD+IAsLEwgabBkwXiJmgMEVwJzwCYsa73+YKGp6CGgLTDL/65UmlqOrvOFwmGjZAY84PaJ4RKlgTI=
X-Received: by 2002:adf:a351:: with SMTP id d17mr4116950wrb.111.1595512374316;
 Thu, 23 Jul 2020 06:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <1595474863-33112-1-git-send-email-liheng40@huawei.com> <1595474863-33112-2-git-send-email-liheng40@huawei.com>
In-Reply-To: <1595474863-33112-2-git-send-email-liheng40@huawei.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 23 Jul 2020 09:52:43 -0400
Message-ID: <CADnq5_PgjxWHxzemDPh1kmfT7twPrend5a5uewMTqVdvf_wkjg@mail.gmail.com>
Subject: Re: [PATCH -next 2/2] drm: Remove redundant NULL check
To:     Li Heng <liheng40@huawei.com>
Cc:     Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 12:11 AM Li Heng <liheng40@huawei.com> wrote:
>
> Fix below warnings reported by coccicheck:
> ./drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c:557:2-7: WARNING: NULL check before some freeing functions is not needed.
>
> Fixes: 4d55b0dd1cdd ("drm/amd/display: Add DCN3 CLK_MGR")
> Signed-off-by: Li Heng <liheng40@huawei.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
> index d94fdc5..d8af56a 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
> @@ -553,8 +553,7 @@ void dcn3_clk_mgr_construct(
>
>  void dcn3_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr)
>  {
> -       if (clk_mgr->base.bw_params)
> -               kfree(clk_mgr->base.bw_params);
> +       kfree(clk_mgr->base.bw_params);
>
>         if (clk_mgr->wm_range_table)
>                 dm_helpers_free_gpu_mem(clk_mgr->base.ctx, DC_MEM_ALLOC_TYPE_GART,
> --
> 2.7.4
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
