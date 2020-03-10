Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A231C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F1720873
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727391AbgCJT13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:27:29 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49868 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgCJT13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:27:29 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 7DC2828EDD2;
        Tue, 10 Mar 2020 19:27:27 +0000 (GMT)
Date:   Tue, 10 Mar 2020 20:27:23 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        frieder.schrempf@kontron.de, tglx@linutronix.de, stefan@agner.ch,
        juliensu@mxic.com.tw, allison@lohutok.net,
        linux-kernel@vger.kernel.org, bbrezillon@kernel.org,
        rfontana@redhat.com, linux-mtd@lists.infradead.org,
        yuehaibing@huawei.com, s.hauer@pengutronix.de
Subject: Re: [PATCH v3 1/4] mtd: rawnand: Add support manufacturer specific
 lock/unlock operation
Message-ID: <20200310202723.16b48f4b@collabora.com>
In-Reply-To: <1583220084-10890-2-git-send-email-masonccyang@mxic.com.tw>
References: <1583220084-10890-1-git-send-email-masonccyang@mxic.com.tw>
        <1583220084-10890-2-git-send-email-masonccyang@mxic.com.tw>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Mar 2020 15:21:21 +0800
Mason Yang <masonccyang@mxic.com.tw> wrote:

> Add nand_lock() & nand_unlock() for manufacturer specific lock & unlock
> operation while the device supports Block Portection function.
> 
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> Reported-by: kbuild test robot <lkp@intel.com>

Reported-by on something that's not a fix doesn't make sense. I know
the 0day bot asked you to add this tag, but that should only be done if
you submit a separate patch, ideally with a Fixes tag. If the offending
patch has not been merged yet, you should just fix the commit and ignore
the Reported-by tag (you can mention who reported the problem in the
changelog though).

> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  drivers/mtd/nand/raw/nand_base.c | 36 ++++++++++++++++++++++++++++++++++--
>  include/linux/mtd/rawnand.h      |  5 +++++
>  2 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
> index f64e3b6..769be81 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -4360,6 +4360,38 @@ static void nand_shutdown(struct mtd_info *mtd)
>  	nand_suspend(mtd);
>  }
>  
> +/**
> + * nand_lock - [MTD Interface] Lock the NAND flash
> + * @mtd: MTD device structure
> + * @ofs: offset byte address
> + * @len: number of bytes to lock (must be a multiple of block/page size)
> + */
> +static int nand_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (!chip->lock_area)
> +		return -ENOTSUPP;
> +
> +	return chip->lock_area(chip, ofs, len);
> +}
> +
> +/**
> + * nand_unlock - [MTD Interface] Unlock the NAND flash
> + * @mtd: MTD device structure
> + * @ofs: offset byte address
> + * @len: number of bytes to unlock (must be a multiple of block/page size)
> + */
> +static int nand_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +
> +	if (!chip->unlock_area)
> +		return -ENOTSUPP;
> +
> +	return chip->unlock_area(chip, ofs, len);
> +}
> +
>  /* Set default functions */
>  static void nand_set_defaults(struct nand_chip *chip)
>  {
> @@ -5786,8 +5818,8 @@ static int nand_scan_tail(struct nand_chip *chip)
>  	mtd->_read_oob = nand_read_oob;
>  	mtd->_write_oob = nand_write_oob;
>  	mtd->_sync = nand_sync;
> -	mtd->_lock = NULL;
> -	mtd->_unlock = NULL;
> +	mtd->_lock = nand_lock;
> +	mtd->_unlock = nand_unlock;
>  	mtd->_suspend = nand_suspend;
>  	mtd->_resume = nand_resume;
>  	mtd->_reboot = nand_shutdown;
> diff --git a/include/linux/mtd/rawnand.h b/include/linux/mtd/rawnand.h
> index 4ab9bcc..bc2fa3c 100644
> --- a/include/linux/mtd/rawnand.h
> +++ b/include/linux/mtd/rawnand.h
> @@ -1077,6 +1077,8 @@ struct nand_legacy {
>   * @manufacturer:	[INTERN] Contains manufacturer information
>   * @manufacturer.desc:	[INTERN] Contains manufacturer's description
>   * @manufacturer.priv:	[INTERN] Contains manufacturer private information
> + * @lock_area:		[REPLACEABLE] specific NAND chip lock operation
> + * @unlock_area:	[REPLACEABLE] specific NAND chip unlock operation
>   */
>  
>  struct nand_chip {
> @@ -1136,6 +1138,9 @@ struct nand_chip {
>  		const struct nand_manufacturer *desc;
>  		void *priv;
>  	} manufacturer;
> +
> +	int (*lock_area)(struct nand_chip *chip, loff_t ofs, uint64_t len);
> +	int (*unlock_area)(struct nand_chip *chip, loff_t ofs, uint64_t len);
>  };
>  
>  extern const struct mtd_ooblayout_ops nand_ooblayout_sp_ops;

