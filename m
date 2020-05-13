Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659A1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C771A205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tl5Rbiyn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389860AbgEMRIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 13:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgEMRIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:08:09 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9B8C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 10:08:08 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id o14so415357ljp.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 10:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ct92GoQxmjkrJFsjfbiJncWVHhbFDJqrFKHkKPJTo14=;
        b=Tl5Rbiyng5LgHx5Gg6sJfh0nYM5fQaO5R9FbQ+FxIU77QOtG1peH+rYIp9YdGC0Ki+
         WMXudb69z9CbqDUAkmJ3uZ+faKYl1Afni3nUwNKCKi/+a1HCy7m0BUJxuCLN/QaJaXC+
         PdNYd1Dh5DYxj84YQrMpUC8Zm0+T5H/JPUxd1oW787D9a/0TLAHR9oDiFXTD7MWyUNo4
         qRy6awADaPbdSVWfF+K7VbVR8QXWfuQEN6/5D1EnO0K1dC14g/EkK/vbB2U5oLD7vdWu
         L4SEzlMjFeNtqCBrEZGIyJkYetgwgmZzYWL5R+Ve1HRbh+gpXwa2AYqY2ccWB6P+Aj9w
         zADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ct92GoQxmjkrJFsjfbiJncWVHhbFDJqrFKHkKPJTo14=;
        b=EmNF68fgH68hEJZ8eAY1gtdqjFE6bAa7Dnv5ks3OOSAo5f0DxdoJQhXgWYLDiOhWId
         DQZOsCOkEThtkQsg8RtyymetmCS1wFXtCbXC+NQSWBxwQR0FQBr4ePOaFSvT33vkrZOy
         jVrRHx3+O/v9orIfeDKNWeMco6/NwktSugiW1UT/nL73w1Beo68mKfsQyafzSC3fq+ba
         RPGBsXPIFlOMIm+DTO6mESxtdq+OZUp7JCXmojTdM84LPf4yywp/+aBip4eTGtyOi4FF
         hlR/rxOWDaM2y+inml3gggQlMlDt169PsyjI6t/Z00ECBiAazT50d/PGf4QCsRLPeqzE
         WggQ==
X-Gm-Message-State: AOAM531iGsbrn62cR+Xxd/hP/Zh0t4Rt6SyyiVHF/FBiOvDNZ493//mg
        TxX73dkhKDk9DouqueLwzrveP7caQ25/7qmciY0=
X-Google-Smtp-Source: ABdhPJztZOzynU5omXWIWITm6a2uO+5uiPsUQ2mpbi7pLnKEITDKvJ/cWebb6gPS7BsFK4UO0pNiyNMAI5b0QypN0sM=
X-Received: by 2002:a2e:9b50:: with SMTP id o16mr75061ljj.164.1589389687029;
 Wed, 13 May 2020 10:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200513150007.1315395-1-lkundrak@v3.sk> <20200513150007.1315395-3-lkundrak@v3.sk>
In-Reply-To: <20200513150007.1315395-3-lkundrak@v3.sk>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 13 May 2020 14:09:21 -0300
Message-ID: <CAOMZO5B582=tZ_YBCyVYFtGh=z5hZKFxP7XoUHEmH3jZsk2uYQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/etnaviv: Don't ignore errors on getting clocks
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        The etnaviv authors <etnaviv@lists.freedesktop.org>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 12:08 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> There might be good reasons why the getting a clock failed. To treat the
> clocks as optional we're specifically only interested in ignoring -ENOENT,
> and devm_clk_get_optional() does just that.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> index c6dacfe3d321..e7dbb924f576 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
> @@ -1786,26 +1786,26 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
>         }
>
>         /* Get Clocks: */
> -       gpu->clk_reg = devm_clk_get(&pdev->dev, "reg");
> +       gpu->clk_reg = devm_clk_get_optional(&pdev->dev, "reg");
>         DBG("clk_reg: %p", gpu->clk_reg);
>         if (IS_ERR(gpu->clk_reg))
> -               gpu->clk_reg = NULL;
> +               return err;
>
> -       gpu->clk_bus = devm_clk_get(&pdev->dev, "bus");
> +       gpu->clk_bus = devm_clk_get_optional(&pdev->dev, "bus");

The binding doc Documentation/devicetree/bindings/gpu/vivante,gc.yaml
says that only the 'reg' clock could be optional, the others are
required.


>         DBG("clk_bus: %p", gpu->clk_bus);
>         if (IS_ERR(gpu->clk_bus))
> -               gpu->clk_bus = NULL;
> +               return err;
>
> -       gpu->clk_core = devm_clk_get(&pdev->dev, "core");
> +       gpu->clk_core = devm_clk_get_optional(&pdev->dev, "core");
>         DBG("clk_core: %p", gpu->clk_core);
>         if (IS_ERR(gpu->clk_core))
> -               gpu->clk_core = NULL;
> +               return err;
>         gpu->base_rate_core = clk_get_rate(gpu->clk_core);
>
> -       gpu->clk_shader = devm_clk_get(&pdev->dev, "shader");
> +       gpu->clk_shader = devm_clk_get_optional(&pdev->dev, "shader");
>         DBG("clk_shader: %p", gpu->clk_shader);
>         if (IS_ERR(gpu->clk_shader))
> -               gpu->clk_shader = NULL;
> +               return err;
>         gpu->base_rate_shader = clk_get_rate(gpu->clk_shader);
>
>         /* TODO: figure out max mapped size */
> --
> 2.26.2
>
> _______________________________________________
> etnaviv mailing list
> etnaviv@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/etnaviv
