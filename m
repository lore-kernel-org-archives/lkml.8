Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB83BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0CB22084C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 03:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ETKtEfdX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgE1DGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 23:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgE1DGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 23:06:19 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED6AC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 20:06:18 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id k3so1941662vsg.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 20:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c0zRf9WTF0mM6R4rLoCl6Co+fSR9upGJzK30+eXsCrQ=;
        b=ETKtEfdX4f87hvL+eN5+pIdyNmq0wY+7xdaPLxVaTXZ42GBITJENo0kA+8TlcsZaF5
         Xluh6N64Pf46mJHA+DCu9/ektSbdItOS8crhEaj6B6a0AfsFuYS1/YNRAKXPhihGWVOh
         lFgctf5UcsAxRAKLBTOmKAe9xcj+pQoznprDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c0zRf9WTF0mM6R4rLoCl6Co+fSR9upGJzK30+eXsCrQ=;
        b=U96e3YdszoLjkF2SyU4icko2gw0X8njBzxxqcQNEBojpTVr8t6yJkAvbKIvbqHxCvS
         5/QbGEKANHyBMz+YywbMn4HDWTRUWLN8hbOo8Ee2piDVxnMMvBUWb6ybvPXwDHtY2Gjt
         49XZfqjB2feLCg7iiq6/hbL0ReCf0kkXULghKKw7givg5pCK4VD/dcAKxIJbU0N3Fi+w
         hW1rAQBr0b/lZQTHGSTgyJZzyJH2AychI51gQ1zEhSHFrTYdqdmgaoI/dhvZ2orVMuEB
         Zwhx0AYg/aVE7Kd2R91hQW1b5BcQQMo/CTC1ozdbkWjbAW3YkxFbrvB5Y4iR+zuENWeF
         fZwQ==
X-Gm-Message-State: AOAM532UIv9KU5Pw3dbWga1wGJruD9Eq9mSWSBzueOMlH9xOMELQ7zea
        7ZfRSonrY86Ht4olvo28/MIkHMmFZyPMoxH1r09XxQ==
X-Google-Smtp-Source: ABdhPJyRv5KIG7uAo2gx9DLqYFdLVEioWfhg8W/XAXDq9+AhgpxLCUHCVP+7cfxwa0TCIQBIbicDDN+po4i6IYEWEZI=
X-Received: by 2002:a67:71c2:: with SMTP id m185mr581124vsc.186.1590635177072;
 Wed, 27 May 2020 20:06:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200528025503.24003-1-wuxy@bitland.com.cn>
In-Reply-To: <20200528025503.24003-1-wuxy@bitland.com.cn>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 28 May 2020 11:06:04 +0800
Message-ID: <CANMq1KDWp7ztviO+ZoXeEqek3uCzPDKjteahO32C3b-=OxerUQ@mail.gmail.com>
Subject: Re: [PATCH] [v3]mtd: spi-nor: winbond: add 1.8v SPI NOR Flash IDs
To:     wuxy@bitland.com.cn
Cc:     lkml <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org,
        stlin2@winbond.com, wuxy <wuxy@bitland.corp-partner.google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 10:55 AM <wuxy@bitland.com.cn> wrote:
>
> From: wuxy <wuxy@bitland.corp-partner.google.com>
>
> Winbond has new 1.8V SPI NOR Flash IDs,we need to use the SPI
> flash IDs in kukui series,this patch can support the new flash IDs.
>
> TEST=boot to shell,get the spi information from 'dmesg'.

TEST= is Chromium OS specific, you can drop this line.

>
> Signed-off-by: Xingyu Wu <wuxy@bitland.corp-partner.google.com>
> Signed-off-by: ST Lin <stlin2@winbond.com>

Tested-by: Nicolas Boichat <drinkcat@chromium.org>

>
> This patch copied from:https://patchwork.ozlabs.org/patch/1150756/,
> The original patch is invalid,so re-submit a new patch for this.

This belongs below the ---, but I guess the maintainer can help you with that.

> ---
>  drivers/mtd/spi-nor/winbond.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index 17deabad57e1..cda4f8847bd6 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -61,6 +61,15 @@ static const struct flash_info winbond_parts[] = {
>                              SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>         { "w25m512jv", INFO(0xef7119, 0, 64 * 1024, 1024,
>                             SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
> +       { "w25q64jwxxIM", INFO(0xef8017, 0, 64 * 1024, 128,
> +                           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +                           SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
> +       { "w25q128jwxxIM", INFO(0xef8018, 0, 64 * 1024, 256,
> +                           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +                           SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
> +       { "w25q256jwxxIM", INFO(0xef8019, 0, 64 * 1024, 512,
> +                           SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
> +                           SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
>  };
>
>  /**
> --
> 2.20.1
>
>
>
