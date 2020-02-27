Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80983C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 10:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1D52469A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 10:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="bR8Qr1Dr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgB0K74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 05:59:56 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:29999 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728680AbgB0K7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 05:59:55 -0500
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 01RAxiqg001015
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 19:59:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 01RAxiqg001015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582801185;
        bh=kOw0sBdvSt7sUjD/0HddbtyeQxtSwGi/7erPa7p/9dc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bR8Qr1DrTlqgaP93XedueBODBAy2XnRRnYItjD4pySB01/bjAICgD+3tvf+lImMd3
         o2+WgmttU6bk0WT9pDau+usqOctVdRUZ681KPNGRnBtwvGNpj1pI0HlPmr1MmpmknT
         J/2py+HydW1LbXppqRFlTQXMfBd8uUBjTuf/415YtECG4MLZZ6X+fg5z3E1dVPwzZn
         OZnFB4Rq8QfoY2KrEfwORiqvLhrUnQ0Y0BsGGN+3TQrE3ZyeL5zMwPkhABj6VS3Ktz
         WgOSCofuTMBD1vUspg/3HTUMRg+PS5LVlLSZs6NVtzkBcW+I4MzMDZiD0EGd1n9DMS
         Djy2gHzX0lAMA==
X-Nifty-SrcIP: [209.85.222.45]
Received: by mail-ua1-f45.google.com with SMTP id k24so772938uaq.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 02:59:45 -0800 (PST)
X-Gm-Message-State: APjAAAXLOFqgqFY8ViB3GMoRnfwouSUOTyGz5nev1Hhze3Jtkcz4+neK
        1YNRJoC95oot1myi1ZFyseiggZWhzZCTYF//cmo=
X-Google-Smtp-Source: APXvYqzHVjhb5MLGMVwROtpWRonvewg9SUUG1QW9qCu9nmcL7dmHBBzmi3dUeyhriGPnm4yTXMoldh0YBTjfPTXjx24=
X-Received: by 2002:ab0:2414:: with SMTP id f20mr854899uan.121.1582801184098;
 Thu, 27 Feb 2020 02:59:44 -0800 (PST)
MIME-Version: 1.0
References: <20200226222722.GA18020@embeddedor>
In-Reply-To: <20200226222722.GA18020@embeddedor>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 27 Feb 2020 19:59:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNARPK=AgshKO1k0BtdYg5wLUp7e9s3zA2-jGLGO26a+A3A@mail.gmail.com>
Message-ID: <CAK7LNARPK=AgshKO1k0BtdYg5wLUp7e9s3zA2-jGLGO26a+A3A@mail.gmail.com>
Subject: Re: [PATCH] mtd: rawnand: Replace zero-length array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Xiaolei Li <xiaolei.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 7:25 AM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
>
> struct foo {
>         int stuff;
>         struct boo array[];
> };
>
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
>
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
>
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
>
> This issue was found with the help of Coccinelle.
>
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/mtd/nand/raw/denali.h       | 2 +-


Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


>  drivers/mtd/nand/raw/marvell_nand.c | 2 +-
>  drivers/mtd/nand/raw/meson_nand.c   | 2 +-
>  drivers/mtd/nand/raw/mtk_nand.c     | 2 +-
>  drivers/mtd/nand/raw/nand_hynix.c   | 2 +-
>  drivers/mtd/nand/raw/sunxi_nand.c   | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>

-- 
Best Regards
Masahiro Yamada
