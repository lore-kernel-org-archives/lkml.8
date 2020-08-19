Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE17EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C322E204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qp4+Gar0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgHSNhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbgHSNhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:37:23 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3CD1C061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:37:22 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id s189so24749789iod.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CU9Zr4LI/GfTl7S1ltjLtLw+xp0kyM6bHpT8zYvnkMs=;
        b=Qp4+Gar0fMdYytsOSyLZpqrBgkqBGvWD+9KS4ZseGwKtZ3UNmsfFLNqHnKKNBmCoZV
         VARg7fHPutGJvnweVdaTrqVHR3DUOOkFWStxpx3Y63I+tBqS6YS6Whn5p44SkING9Xey
         jMsdKlHmr+gt1sww85jiljC8v/OQ6dIgR1gB5BtoxUWWqd6D7hYjfSH2OsfemNl330Gh
         FTCdcIJnFsbkaUiBTIYu+tdSoyGJYWao8pll33WUuAV+LiPLKPNim1p4Ogdx0H667C6s
         n+R0e1LADuy/Sbwfo2l5FUqtxfn4As7rZ22hCCEHGhA5yza/Ksn0i4BcGwSq+8rXJZBH
         Q2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CU9Zr4LI/GfTl7S1ltjLtLw+xp0kyM6bHpT8zYvnkMs=;
        b=maAxK/CWZSkP/B9aBDO3esnynWKV+dJVvFFfuFygjyi2dLMz18YQO6kOpkrY/oA2Y+
         N1ekD12ZkkBH2RGl58zsh8+x370bRvIPlNBbzyztojKcMnvaSDbyZzAk3ys1usdleJS0
         4IXx+oV+UqJ4OHA9Hyn3V7djVS3tMxMHqdMdxpzyORSWcSfrrZYPwuBH4Rnw966JKtu4
         Z6nCKFTW7b0AIBXcL7joB2YXVmIkwEZc2b+Zf/X1pjSTQO2cQKu7nnUCEOoW8lzPAqO9
         niOeLMp1pPNA5EHipVYDZu3DyAcAmL0MeLwRqv4BV6paCYtfEWVWnUZxqOoasVQH2pIu
         AAlA==
X-Gm-Message-State: AOAM533YUhCxUV5zmnEy9KXOfIc5RDK7HbJ9TJ+kKG+Ng8aaR/8Kh3Zc
        e+TurtlpFXJQnbVWlg7mS1NGZEHdNKI3y5uePps=
X-Google-Smtp-Source: ABdhPJwRz5ptWi9jU0zOEyttOJM97RGMZUNDEZDD+TTNv3kZGB1W0K4Y0G6nj8hodta9E7UzclSOD+POhpFtBVP+fjc=
X-Received: by 2002:a02:6066:: with SMTP id d38mr24198724jaf.105.1597844241987;
 Wed, 19 Aug 2020 06:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200819020503.3079-1-thunder.leizhen@huawei.com> <20200819020503.3079-2-thunder.leizhen@huawei.com>
In-Reply-To: <20200819020503.3079-2-thunder.leizhen@huawei.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Wed, 19 Aug 2020 23:37:11 +1000
Message-ID: <CAOSf1CGvtX6FjYXy-mGxoEx4B6ZQ-LUZDMi-503JtECLu93faw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] libnvdimm: fix memmory leaks in of_pmem.c
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 12:05 PM Zhen Lei <thunder.leizhen@huawei.com> wrote:
>
> The memory priv->bus_desc.provider_name allocated by kstrdup() is not
> freed correctly.
>
> Fixes: 49bddc73d15c ("libnvdimm/of_pmem: Provide a unique name for bus provider")
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Yep, that's a bug.

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>

> ---
>  drivers/nvdimm/of_pmem.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/nvdimm/of_pmem.c b/drivers/nvdimm/of_pmem.c
> index 10dbdcdfb9ce913..1292ffca7b2ecc0 100644
> --- a/drivers/nvdimm/of_pmem.c
> +++ b/drivers/nvdimm/of_pmem.c
> @@ -36,6 +36,7 @@ static int of_pmem_region_probe(struct platform_device *pdev)
>
>         priv->bus = bus = nvdimm_bus_register(&pdev->dev, &priv->bus_desc);
>         if (!bus) {
> +               kfree(priv->bus_desc.provider_name);
>                 kfree(priv);
>                 return -ENODEV;
>         }
> @@ -83,6 +84,7 @@ static int of_pmem_region_remove(struct platform_device *pdev)
>         struct of_pmem_private *priv = platform_get_drvdata(pdev);
>
>         nvdimm_bus_unregister(priv->bus);
> +       kfree(priv->bus_desc.provider_name);
>         kfree(priv);
>
>         return 0;
> --
> 1.8.3
>
>
