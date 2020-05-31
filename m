Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB7BC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 21:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E002C207DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 21:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ovfRk/Nl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgEaV1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 17:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgEaV1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 17:27:09 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44404C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 14:27:05 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id u17so4202323ybi.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 14:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9R6dVyOeXrAbjNA/B3IIGOCdujTvIeVldj32RQubxr8=;
        b=ovfRk/NleZHoHT7Yd3jtetDN/3l3N1H730cVxdzCsFWsLWEQXtrult0KjWGOQOHVQz
         Lgb7zZkAZboDsF5+4OKjfPqsgQybBM/BQ0s4/DFQ3uba3eLnFN0AnzhHTUWAuMLvuu6x
         MyWn31djYZAPKNIuhCAStLK5v43z3VeLLAH47kzAFKnXbM5GSm2oOLEvsMmDLuAbARJm
         5w8igNNBinNE0akPd37aaVIQ1TZtItiaYfc/2U2EV2OjgG8PqgRxpXeA18oZoVF6AJ88
         3hqs6R5CV9EDWasOqPUwi3cCw9mEnXlVcdc9CR6GIpYfdULtm1MWXBlvmnGJyYs09GFa
         uAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9R6dVyOeXrAbjNA/B3IIGOCdujTvIeVldj32RQubxr8=;
        b=U5WZE0QItVdnJJ6SCn4+YgiqMiFe0GwKChV9cA7QLoaqfKFmCfglkN6ZqrsKHd6upS
         xQsABDnuY0qojfndFexzeP8XdYZ5f2mid3VtDKwTJ71cb2rFJWIWqJFIxnopeSnJkDG0
         oymia8R6VEqdoIHHmK1Ljc6hKwiO6RXM1mAsfhw45kdDrXKgdpbW7xvbwsxhpKouDn+A
         JQ6BsEAXkmFnQkQCC7CKigUAc8XbLaQbrMVjo3PKvMQ3JzWgqi8Fc2/biuMx8OpebCvZ
         uZgJdZ9xk7Mgnj3cwYzIU0Gr4vgFUAFDDOYzEpLNqR1WVl6eoomAGZwLXNzuv2ICyoHK
         tgpA==
X-Gm-Message-State: AOAM530vB3cOk+b3PJ112oU2uE0b5VCz4yRfMHtsEj4b5pKBZYD1NSez
        eLcEsNSSPZF4ZgwR2IEU5GrE16w3fskAz4I0Gfc=
X-Google-Smtp-Source: ABdhPJwRLxg7L3fKQd+F9YCNmDDUNHYElr7ybkypr5S2lY45mveAfg0flKbDgvApEAG1lSwZLNs8XPodr58A0Eg9u6Y=
X-Received: by 2002:a25:9d82:: with SMTP id v2mr28689573ybp.268.1590960424282;
 Sun, 31 May 2020 14:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200529080042.6082-1-dinghao.liu@zju.edu.cn>
In-Reply-To: <20200529080042.6082-1-dinghao.liu@zju.edu.cn>
From:   Ben Skeggs <skeggsb@gmail.com>
Date:   Mon, 1 Jun 2020 07:26:53 +1000
Message-ID: <CACAvsv73wZK_pKk4TDHaTeBUqxYHvK0KhLQBgPC8Be_VviY2jg@mail.gmail.com>
Subject: Re: [PATCH] drm/nouveau/clk/gm20b: Fix memory leak in gm20b_clk_new
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, David Airlie <airlied@linux.ie>,
        ML nouveau <nouveau@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Ben Skeggs <bskeggs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 May 2020 at 19:42, Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
>
> When gk20a_clk_ctor() returns an error code, pointer "clk"
> should be released. It's the same when gm20b_clk_new()
> returns from elsewhere following this call.
This shouldn't be necessary.  If a subdev constructor fails, and
returns a pointer, the core will call the destructor to clean things
up.

Ben.

>
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c
> index b284e949f732..a5aeba74d3b7 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/gm20b.c
> @@ -1039,7 +1039,7 @@ gm20b_clk_new(struct nvkm_device *device, int index, struct nvkm_clk **pclk)
>         ret = gk20a_clk_ctor(device, index, &gm20b_clk, clk_params,
>                              &clk->base);
>         if (ret)
> -               return ret;
> +               goto out_free;
>
>         /*
>          * NAPLL can only work with max_u, clamp the m range so
> @@ -1067,8 +1067,8 @@ gm20b_clk_new(struct nvkm_device *device, int index, struct nvkm_clk **pclk)
>                 nvkm_warn(subdev, "no fused calibration parameters\n");
>
>         ret = gm20b_clk_init_safe_fmax(clk);
> -       if (ret)
> -               return ret;
>
> -       return 0;
> +out_free:
> +       kfree(clk);
> +       return ret;
>  }
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
