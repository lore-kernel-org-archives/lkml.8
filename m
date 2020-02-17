Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BDDC761A3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 11:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8C2E2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 11:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbgBQLSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 06:18:12 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39070 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbgBQLSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 06:18:12 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id F0F8E293121;
        Mon, 17 Feb 2020 11:18:10 +0000 (GMT)
Date:   Mon, 17 Feb 2020 12:18:07 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Jeff Kletsky <git-commits@allycomm.com>,
        liaoweixiong <liaoweixiong@allwinnertech.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Peter Pan <peterpandong@micron.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "Richard Weinberger" <richard@nod.at>
Subject: Re: [PATCH 2/3] mtd: spinand: Explicitly use MTD_OPS_RAW to write
 the bad block marker to OOB
Message-ID: <20200217121807.3ac0de4c@collabora.com>
In-Reply-To: <20200211163452.25442-3-frieder.schrempf@kontron.de>
References: <20200211163452.25442-1-frieder.schrempf@kontron.de>
        <20200211163452.25442-3-frieder.schrempf@kontron.de>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Feb 2020 16:35:43 +0000
Schrempf Frieder <frieder.schrempf@kontron.de> wrote:

> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> When writing the bad block marker to the OOB area the access mode
> should be set to MTD_OPS_RAW as it is done for reading the marker.
> Currently this only works because req.mode is initialized to
> MTD_OPS_PLACE_OOB (0) and spinand_write_to_cache_op() checks for
> req.mode != MTD_OPS_AUTO_OOB.
> 
> Fix this by explicitly setting req.mode to MTD_OPS_RAW.
> 
> Fixes: 7529df465248 ("mtd: nand: Add core infrastructure to support SPI NANDs")
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/nand/spi/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index 5d267a67a5f7..925db6269861 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -609,6 +609,7 @@ static int spinand_markbad(struct nand_device *nand, const struct nand_pos *pos)
>  		.ooboffs = 0,
>  		.ooblen = 2,
>  		.oobbuf.out = marker,
> +		.mode = MTD_OPS_RAW,
>  	};
>  	int ret;
>  

