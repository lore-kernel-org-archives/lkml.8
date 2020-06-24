Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2776C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC4A420823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SR+CHrdN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405412AbgFXRPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405372AbgFXRPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:15:14 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E214AC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:15:13 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 18so2627171otv.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WJq1E9+4ZIKiH2IMq2/oJWvEWmQE7EtG4I/6aJCrDto=;
        b=SR+CHrdNFIVnKcR5PuzzeRzD/q1oh/SKiAAgMxN3LTOve05sHTsCzluGm2WXe/7okI
         6AAkZlim56rMH5brzjlld/n4iEyYw3+G08opJ6Tvnwhf+sLNA1WdTWzk6Zx/GKcztLZg
         oZx5EokOZT6grCL1UULM3If8PSsNtCkb6oB1yF3mpAv0wDZ7GVp+3rJ4oQF7zEgRx0Wh
         /pBD9SGJQYSSMS0cOYpoIbU4/aLQ5Vbo+GepRjU3aWwDYc8nc2V85CN5hMP0FKGClSUh
         9jFHHnr3dZE/7hMaQ66dC95x4dJbFxvZn+2bHbr6yK76sa4OKGMfZgh5yeoLfsiH8cFg
         5Fqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WJq1E9+4ZIKiH2IMq2/oJWvEWmQE7EtG4I/6aJCrDto=;
        b=n+PjYudUxeDbzLBv+JFLdm/6G62tB1e9dWmdpkR8TZH76vcS3BQBuS0aaisO1cQEqk
         cQIf7cQEOXR0DUBUGZ1dFtSKWR4x0t7EpSKrkycODEF3QAMLWADghO8uRjqYQ8z4ZGmU
         28/SN6L8bqt1ET5X5/SoDyVwmVCGzmBpTMKhC3qljC7iBcKqzUkmhErdt5Hvl7bZGeSh
         LXwgZfdIG3wW+1SRs2WrEhhmmpvJG7id2Yl5Tq2fuKWDa8BwcG+EezXepbwXUwMKW4MM
         vmfwp7nOS/dsa8d0bNoKKZK7aibSW7cUL/ysEwDWxDc0Eju2Ocm+zDr9fWDktWTwHcpu
         BEVw==
X-Gm-Message-State: AOAM532nH/GC5a9fO8VThsgaD/6SDdy+BeZCgJLG0HUuZU4JPfJqH7FS
        wnfsvQvvqDi8jfXgrg2VKJOObwtPDHQH1NCbt1s=
X-Google-Smtp-Source: ABdhPJw0uBvgV2g3AF7veHKvHYWDw9aQO7TojFYpl6P4GiFvNpCq04hG1+J1+Vn/xvwfRTt/0DfkyOeKdIR/q48sUJc=
X-Received: by 2002:a4a:db4b:: with SMTP id 11mr24595586oot.11.1593018913261;
 Wed, 24 Jun 2020 10:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200613235331.24678-1-TheSven73@gmail.com>
In-Reply-To: <20200613235331.24678-1-TheSven73@gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 24 Jun 2020 13:15:02 -0400
Message-ID: <CAGngYiX1Pz3bkvT=17VUapBwZ9=zrW8rXDP4wuVK=-uD67tfqA@mail.gmail.com>
Subject: Re: [PATCH v1] mtd: spi-nor: Add support for Winbond w25q64jv spi flash
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any way I can help to get this patch into mainline?

Thank you,
Sven

On Sat, Jun 13, 2020 at 7:53 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> This chip is (nearly) identical to the Winbond w25q64 which is
> already supported by Linux. Compared to the w25q64, the 'jv'
> does not support Quad SPI mode, and has a different JEDEC ID.
>
> To: Tudor Ambarus <tudor.ambarus@microchip.com>
> To: Miquel Raynal <miquel.raynal@bootlin.com>
> To: Richard Weinberger <richard@nod.at>
> To: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Sven Van Asbroeck <TheSven73@gmail.com>
> ---
>
> Tree: next-20200613
>
>  drivers/mtd/spi-nor/winbond.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
> index 5062af10f138..18bdff02f57f 100644
> --- a/drivers/mtd/spi-nor/winbond.c
> +++ b/drivers/mtd/spi-nor/winbond.c
> @@ -65,6 +65,7 @@ static const struct flash_info winbond_parts[] = {
>                             SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
>         { "w25x64", INFO(0xef3017, 0, 64 * 1024, 128, SECT_4K) },
>         { "w25q64", INFO(0xef4017, 0, 64 * 1024, 128, SECT_4K) },
> +       { "w25q64jv", INFO(0xef7017, 0, 64 * 1024, 128, SECT_4K) },
>         { "w25q64dw", INFO(0xef6017, 0, 64 * 1024, 128,
>                            SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>                            SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB) },
> --
> 2.17.1
>
