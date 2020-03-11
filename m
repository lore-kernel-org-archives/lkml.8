Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	RDNS_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:53777 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbgCKPuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:50:13 -0400
Date: Wed, 11 Mar 2020 16:50:11 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
Cc: vigneshr@ti.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v4 0/2] mtd: spinand: toshiba: Support for new Kioxia
 Serial NAND
Message-ID: <20200311165011.63a3d82e@xps13>
In-Reply-To: <cover.1583834323.git.ytc-mb-yfuruyama7@kioxia.com>
References: <cover.1583834323.git.ytc-mb-yfuruyama7@kioxia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Yoshio,

Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com> wrote on Wed, 11 Mar
2020 10:47:04 +0900:

> First patch is to rename function name becase of add new device.
> Second patch is to supprot for new device.
> 
> Yoshio Furuyama (2):
>   mtd: spinand: toshiba: Rename function name to change suffix and
>     prefix (8Gbit)
>   mtd: spinand: toshiba: Support for new Kioxia Serial NAND
> 
>  drivers/mtd/nand/spi/toshiba.c | 173 +++++++++++++++++++++++++++++++----------
>  1 file changed, 130 insertions(+), 43 deletions(-)
> 

I am very sorry but actually I had issues applying all your patches not
because they were not based on v5.6-rc1, but because since then I
applied a patch changing the detection that changed the content of a
lot of structures (including in Toshiba's driver).

Can you please rebase again on top of the current nand/next? I am very
sorry for this extra work, this is my mistake.

Head should be:

	a5d53ad26a8b ("mtd: rawnand: brcmnand: Add support for flash-edu for dma transfers")

And the culprit commit is:

	f1541773af49 ("mtd: spinand: rework detect procedure for different READ_ID operation")

Thanks,
Miquèl

