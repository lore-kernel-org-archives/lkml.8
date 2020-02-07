Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89289C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64DEB214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgBGIch convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 03:32:37 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:39605 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgBGIch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 03:32:37 -0500
X-Originating-IP: 90.76.211.102
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 26B381C0002;
        Fri,  7 Feb 2020 08:32:35 +0000 (UTC)
Date:   Fri, 7 Feb 2020 09:32:34 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
Cc:     vigneshr@ti.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3] mtd: spinand: toshiba: Add comment about Kioxia ID
Message-ID: <20200207093234.56bd8cae@xps13>
In-Reply-To: <1581051561-7302-1-git-send-email-ytc-mb-yfuruyama7@kioxia.com>
References: <1581051561-7302-1-git-send-email-ytc-mb-yfuruyama7@kioxia.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yoshio,

Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com> wrote on Fri,  7 Feb
2020 13:59:21 +0900:

> Add a comment above NAND_MFR_TOSHIBA and SPINAND_MFR_TOSHIBA definitions
> that Toshiba and Kioxia ID are the same.
> Since its independence from Toshiba Group, Toshiba memory Co has become
> Kioxia Co.
> 
> Signed-off-by: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>

Just as an FYI for your next submission, below the three dashes you
should add a changelog, a small paragraph describing what changed
between the versions.

No need to resend just for this, I have it in mind.

I'm fine with the patch and will apply it soon.

> ---
>  drivers/mtd/nand/raw/internals.h | 1 +
>  drivers/mtd/nand/spi/toshiba.c   | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
> index cba6fe7..9d0caad 100644
> --- a/drivers/mtd/nand/raw/internals.h
> +++ b/drivers/mtd/nand/raw/internals.h
> @@ -30,6 +30,7 @@
>  #define NAND_MFR_SAMSUNG	0xec
>  #define NAND_MFR_SANDISK	0x45
>  #define NAND_MFR_STMICRO	0x20
> +/* Kioxia is new name of Toshiba memory. */
>  #define NAND_MFR_TOSHIBA	0x98
>  #define NAND_MFR_WINBOND	0xef
>  
> diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
> index 0db5ee4..833e8f6 100644
> --- a/drivers/mtd/nand/spi/toshiba.c
> +++ b/drivers/mtd/nand/spi/toshiba.c
> @@ -10,6 +10,7 @@
>  #include <linux/kernel.h>
>  #include <linux/mtd/spinand.h>
>  
> +/* Kioxia is new name of Toshiba memory. */
>  #define SPINAND_MFR_TOSHIBA		0x98
>  #define TOSH_STATUS_ECC_HAS_BITFLIPS_T	(3 << 4)
>  

Thanks,
Miquèl
