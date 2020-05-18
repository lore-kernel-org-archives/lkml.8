Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24E3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4AA5207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 15:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgERPW7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 11:22:59 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:40489 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgERPW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 11:22:59 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 2AAEDFF809;
        Mon, 18 May 2020 15:22:55 +0000 (UTC)
Date:   Mon, 18 May 2020 17:22:53 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Bean Huo <huobean@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, s.hauer@pengutronix.de,
        boris.brezillon@collabora.com, derosier@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: Re: [PATCH v4 0/5] Micron SLC NAND filling block
Message-ID: <20200518172253.1c3b9d32@xps13>
In-Reply-To: <20200518135943.11749-1-huobean@gmail.com>
References: <20200518135943.11749-1-huobean@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bean,

Bean Huo <huobean@gmail.com> wrote on Mon, 18 May 2020 15:59:38 +0200:

> From: Bean Huo <beanhuo@micron.com>
> 
> Hi,
> 
> on some legacy planar 2D Micron NAND devices when a block erase command is
> issued, occasionally even though a block erase operation completes and returns
> a pass status, the flash block may not be completely erased. Subsequent
> operations to this block on very rare cases can result in subtle failures or
> corruption. These extremely rare cases should nevertheless be considered. This
> patchset is to address this potential issue.
> 
> After submission of patch V1 [1] and V2 [2], we stopped its update since we get
> stuck in the solution on how to avoid the power-loss issue in case power-cut
> hits the block filling. In the v1 and v2, to avoid this issue, we always damaged
> page0, page1, this's based on the hypothesis that NAND FS is UBIFS. This
> FS-specifical code is unacceptable in the MTD layer. Also, it cannot cover all
> NAND based file system. Based on the current discussion, seems that re-write all
> first 15 page from page0 is a satisfactory solution.

We have a layering problem now. Maybe we should just have an MTD
internal variable like min_written_pages_before_erase that the Micron
driver could set to a !0 value.

Then, the handling could be done by the user (UBI/UBIFS, JFFS2, MTD
user if exported).

> 
> Meanwhile, I borrowed one idea from Miquel Raynal patchset [3], in which keeps
> a recode of programmed pages, base on it, for most of the cases, we don't need
> to read every page to see if current erasing block is a partially programmed
> block.
> 
> Changelog:
> 
> v3 - v4:
>     1. In the patch 4/5, change to directly use ecc.strength to judge the page
>        is a empty page or not, rather than max_bitflips < mtd->bitflip_threshold
>     2. In the patch 5/5, for the powerloss case, from the next time boot up,
>        lots of page will be programmed from >page15 address, if still using
>        first_p as GENMASK() bitmask starting position, writtenp will be always 0,
>        fix it by changing its bitmask starting at bit position 0.
> 
> v2 - v3:
>     1. Rebase patch to the latest MTD git tree
>     2. Add a record that keeps tracking the programmed pages in the first 16
>        pages
>     3. Change from program odd pages, damage page 0 and page 1, to program all
>        first 15 pages
>     4. Address issues which exist in the V2.
> 
> v1 - v2:
>     1. Rebased V1 to latest Linux kernel.
>     2. Add erase preparation function pointer in nand_manufacturer_ops.
> 
> 
> [1] https://www.spinics.net/lists/linux-mtd/msg04112.html
> [2] https://www.spinics.net/lists/linux-mtd/msg04450.html
> [3] https://www.spinics.net/lists/linux-mtd/msg13083.html
> 
> 
> Bean Huo (5):
>   mtd: rawnand: group all NAND specific ops into new nand_chip_ops
>   mtd: rawnand: Add {pre,post}_erase hooks in nand_chip_ops
>   mtd: rawnand: Add write_oob hook in nand_chip_ops
>   mtd: rawnand: Introduce a new function nand_check_is_erased_page()
>   mtd: rawnand: micron: Micron SLC NAND filling block

When you take my patches in your series, especially when not touching
them at all, you should keep my Authorship and SoB first, then add your
SoB.


Thanks,
Miquèl
