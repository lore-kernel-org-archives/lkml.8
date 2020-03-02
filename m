Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34413C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07DFC24695
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 09:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgCBJ0p convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 04:26:45 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:33871 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgCBJ0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:26:45 -0500
Received: from xps13 (lfbn-tou-1-1473-158.w90-89.abo.wanadoo.fr [90.89.41.158])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 0E16D10000F;
        Mon,  2 Mar 2020 09:26:42 +0000 (UTC)
Date:   Mon, 2 Mar 2020 10:26:42 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Harvey Hunt <harveyhuntnexus@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, od@zcrc.me,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: ingenic: Fix unmet dependency if
 COMPILE_TEST
Message-ID: <20200302102642.1191e8b1@xps13>
In-Reply-To: <20200229160443.11208-1-paul@crapouillou.net>
References: <20200229160443.11208-1-paul@crapouillou.net>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Paul Cercueil <paul@crapouillou.net> wrote on Sat, 29 Feb 2020 13:04:43
-0300:

> Commit 7c779cf7c1f7 ("mtd: rawnand: ingenic: Allow to compile test the
> new Ingenic driver") dropped the dependency on JZ4780_NEMC when
> COMPILE_TEST was set, which is wrong, as the driver requires symbols
> provided by the jz4780-nemc driver.
> 
> Change the dependency to (MIPS || COMPILE_TEST) && JZ4780_NEMC to
> address the issue.

That was simple actually, thanks for finding the solution. Actually I
don't think I mergeg my own patch as it was creating this build issue
(unless I messed with something :) ) so can you please send a patch
just adding COMPILE_TEST support without any Fixes mention?

> 
> Fixes: 7c779cf7c1f7 ("mtd: rawnand: ingenic: Allow to compile test the new Ingenic driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/mtd/nand/raw/ingenic/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/ingenic/Kconfig b/drivers/mtd/nand/raw/ingenic/Kconfig
> index 485abfa3f80b..96c5ae8b1bbc 100644
> --- a/drivers/mtd/nand/raw/ingenic/Kconfig
> +++ b/drivers/mtd/nand/raw/ingenic/Kconfig
> @@ -1,7 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config MTD_NAND_JZ4780
>  	tristate "JZ4780 NAND controller"
> -	depends on JZ4780_NEMC || COMPILE_TEST
> +	depends on MIPS || COMPILE_TEST
> +	depends on JZ4780_NEMC
>  	help
>  	  Enables support for NAND Flash connected to the NEMC on JZ4780 SoC
>  	  based boards, using the BCH controller for hardware error correction.

Thanks,
Miquèl
