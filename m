Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9016CC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A0D20409
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 10:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgCIKdI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 06:33:08 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:60075 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgCIKdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 06:33:08 -0400
X-Originating-IP: 90.89.41.158
Received: from xps13 (lfbn-tou-1-1473-158.w90-89.abo.wanadoo.fr [90.89.41.158])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 708D81C001A;
        Mon,  9 Mar 2020 10:32:57 +0000 (UTC)
Date:   Mon, 9 Mar 2020 11:32:56 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     shiva.linuxworks@gmail.com
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: Re: [PATCH v5 0/6] Add new series Micron SPI NAND devices
Message-ID: <20200309113256.6c6751f8@xps13>
In-Reply-To: <20200228150311.12184-1-sshivamurthy@micron.com>
References: <20200228150311.12184-1-sshivamurthy@micron.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shiva,

shiva.linuxworks@gmail.com wrote on Fri, 28 Feb 2020 16:03:05 +0100:

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
> Changes since v4:
> -----------------
> 
> 1. Patch 2 is separated into two as per the comment by Boris.
> 2. Renamed MICRON_CFG_CONTI_READ into MICRON_CFG_CR.
> 3. Reworked die selection function as per the comment by Boris.

I was about to apply this series but unfortunately it is not based on
v5.6-rc1 so no patch applies correctly. Can you please rebase and send
a v6 soon?

Thanks,
Miquèl
