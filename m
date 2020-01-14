Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE038C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A52B724670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgANRGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:06:42 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57021 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgANRGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:06:42 -0500
X-Originating-IP: 91.224.148.103
Received: from localhost.localdomain (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A2A17E0004;
        Tue, 14 Jan 2020 17:06:39 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marex@denx.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>
Subject: Re: [PATCH v3 2/5] mtd: rawnand: denali_dt: Add support for configuring SPARE_AREA_SKIP_BYTES
Date:   Tue, 14 Jan 2020 18:06:25 +0100
Message-Id: <20200114170625.1826-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191220113155.28177-3-yamada.masahiro@socionext.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: ca9829e5bc5a7dcf40fb7b7f0c46ef694b78c82b
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-12-20 at 11:31:52 UTC, Masahiro Yamada wrote:
> From: Marek Vasut <marex@denx.de>
> 
> The SPARE_AREA_SKIP_BYTES register is reset when the controller reset
> signal is toggled. Yet, this register must be configured to match the
> content of the NAND OOB area. The current default value is always set
> to 8 and is programmed into the hardware in case the hardware was not
> programmed before (e.g. in a bootloader) with a different value. This
> however does not work when the block is reset properly by Linux.
> 
> On Altera SoCFPGA CycloneV, ArriaV and Arria10, which are the SoCFPGA
> platforms which support booting from NAND, the SPARE_AREA_SKIP_BYTES
> value must be set to 2. On Socionext Uniphier, the value is 8. This
> patch adds support for preconfiguring the default value and handles
> the special SoCFPGA case by setting the default to 2 on all SoCFPGA
> platforms, while retaining the original behavior and default value of
> 8 on all the other platforms.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> To: linux-mtd@lists.infradead.org
> Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
