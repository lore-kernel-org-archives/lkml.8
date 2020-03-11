Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D186AC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B150021655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 10:50:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgCKKut (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 06:50:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:56482 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgCKKut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 06:50:49 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 58288295F37;
        Wed, 11 Mar 2020 10:50:47 +0000 (GMT)
Date:   Wed, 11 Mar 2020 11:50:44 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     shiva.linuxworks@gmail.com
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: Re: [PATCH v6 2/6] mtd: spinand: micron: Describe the SPI NAND
 device MT29F2G01ABAGD
Message-ID: <20200311115044.694eab39@collabora.com>
In-Reply-To: <20200309115230.7207-3-sshivamurthy@micron.com>
References: <20200309115230.7207-1-sshivamurthy@micron.com>
        <20200309115230.7207-3-sshivamurthy@micron.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Mar 2020 12:52:26 +0100
shiva.linuxworks@gmail.com wrote:

> From: Shivamurthy Shastri <sshivamurthy@micron.com>
> 
> Add the SPI NAND device MT29F2G01ABAGD series number, size and voltage
> details as a comment.
> 
> Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/mtd/nand/spi/micron.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mtd/nand/spi/micron.c b/drivers/mtd/nand/spi/micron.c
> index c028d0d7e236..e4aeafc56f4e 100644
> --- a/drivers/mtd/nand/spi/micron.c
> +++ b/drivers/mtd/nand/spi/micron.c
> @@ -91,6 +91,7 @@ static int micron_8_ecc_get_status(struct spinand_device *spinand,
>  }
>  
>  static const struct spinand_info micron_spinand_table[] = {
> +	/* M79A 2Gb 3.3V */
>  	SPINAND_INFO("MT29F2G01ABAGD", 0x24,
>  		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 2, 1, 1),
>  		     NAND_ECCREQ(8, 512),

