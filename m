Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	RDNS_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:39541 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbgCKPtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:49:35 -0400
Date: Wed, 11 Mar 2020 16:49:32 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: shiva.linuxworks@gmail.com
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: Re: [PATCH v6 0/6] Add new series Micron SPI NAND devices
Message-ID: <20200311164932.23cc7a42@xps13>
In-Reply-To: <20200309115230.7207-1-sshivamurthy@micron.com>
References: <20200309115230.7207-1-sshivamurthy@micron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Shiva,

shiva.linuxworks@gmail.com wrote on Mon,  9 Mar 2020 12:52:24 +0100:

> From: Shivamurthy Shastri <sshivamurthy@micron.com>
> 
> This patchset is for the new series of Micron SPI NAND devices, and the
> following links are their datasheets.
> 
> M78A:
> [1] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m78a_1gb_3v_nand_spi.pdf
> [2] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m78a_1gb_1_8v_nand_spi.pdf
> 
> M79A:
> [3] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m79a_2gb_1_8v_nand_spi.pdf
> [4] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m79a_ddp_4gb_3v_nand_spi.pdf
> 
> M70A:
> [5] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m70a_4gb_3v_nand_spi.pdf
> [6] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m70a_4gb_1_8v_nand_spi.pdf
> [7] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m70a_ddp_8gb_3v_nand_spi.pdf
> [8] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m70a_ddp_8gb_1_8v_nand_spi.pdf
> 
> Changes since v5:
> -----------------
> 
> 1. Rebased series to v5.6-rc1.

I am very sorry but actually I had issues applying all your patches not
because they were not based on v5.6-rc1, but because since then I
applied a patch changing the detection that changed the content of a
lot of structures (including in Micron's patches).

Can you please rebase again on top of the current nand/next? I am very
sorry for this extra work, this is my mistake.

Head should be:

	a5d53ad26a8b ("mtd: rawnand: brcmnand: Add support for flash-edu for dma transfers")

And the culprit commit is:

	f1541773af49 ("mtd: spinand: rework detect procedure for different READ_ID operation")

Thanks,
Miquèl

