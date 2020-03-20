Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2552FC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0489220709
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbgCTRUH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:20:07 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:37759 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgCTRUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:20:06 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id CD39D20010;
        Fri, 20 Mar 2020 17:20:03 +0000 (UTC)
Date:   Fri, 20 Mar 2020 18:20:02 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
Cc:     vigneshr@ti.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v3] mtd: rawnand: toshiba: Support actual bitflips for
 BENAND (Built-in ECC NAND)
Message-ID: <20200320182002.4573fa61@xps13>
In-Reply-To: <1583907583-5967-1-git-send-email-ytc-mb-yfuruyama7@kioxia.com>
References: <1583907583-5967-1-git-send-email-ytc-mb-yfuruyama7@kioxia.com>
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

Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com> wrote on Wed, 11 Mar
2020 15:19:43 +0900:


The title is misleading, would it be better:

	"Support reading the number of bitflips" 

> Add support vendor specific commands for KIOXIA CORPORATION BENAND.
> The actual bitflips number can be get by this command.

                                    retrieved?

> 
> Signed-off-by: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
> ---
> changelog[v3]:Tested version.
> original patch:"[RFC,v2] mtd: nand: toshiba: Add support for ->exec_op()".
> 
>  drivers/mtd/nand/raw/nand_toshiba.c | 55 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/nand/raw/nand_toshiba.c b/drivers/mtd/nand/raw/nand_toshiba.c
> index 9c03fbb..10fcfbd 100644
> --- a/drivers/mtd/nand/raw/nand_toshiba.c
> +++ b/drivers/mtd/nand/raw/nand_toshiba.c
> @@ -14,14 +14,65 @@
>  /* Recommended to rewrite for BENAND */
>  #define TOSHIBA_NAND_STATUS_REWRITE_RECOMMENDED	BIT(3)
>  
> +/* ECC Status Read Command for BENAND */
> +#define TOSHIBA_NAND_CMD_ECC_STATUS_READ	0x7A
> +
> +/* ECC Status Mask for BENAND */
> +#define TOSHIBA_NAND_ECC_STATUS_MASK		0x0F
> +
> +/* Uncorrectable Error for BENAND */
> +#define TOSHIBA_NAND_ECC_STATUS_UNCORR		0x0F
> +
> +static int toshiba_nand_benand_read_eccstatus_op(struct nand_chip *chip,
> +						 u8 *buf)
> +{
> +	u8 *ecc_status = buf;
> +
> +	if (nand_has_exec_op(chip)) {
> +		const struct nand_sdr_timings *sdr =
> +			nand_get_sdr_timings(&chip->data_interface);
> +		struct nand_op_instr instrs[] = {
> +			NAND_OP_CMD(TOSHIBA_NAND_CMD_ECC_STATUS_READ,
> +				    PSEC_TO_NSEC(sdr->tADL_min)),
> +			NAND_OP_8BIT_DATA_IN(chip->ecc.steps, ecc_status, 0),
> +		};
> +		struct nand_operation op = NAND_OPERATION(chip->cur_cs, instrs);
> +
> +		return nand_exec_op(chip, &op);
> +	}
> +
> +	return -ENOTSUPP;
> +}
> +
>  static int toshiba_nand_benand_eccstatus(struct nand_chip *chip)
>  {
>  	struct mtd_info *mtd = nand_to_mtd(chip);
>  	int ret;
>  	unsigned int max_bitflips = 0;
> -	u8 status;
> +	u8 status, ecc_status[8];

Shall we define this          ^ ?
It is strange to have the number of steps hardcoded this way.

>  
>  	/* Check Status */
> +	ret = toshiba_nand_benand_read_eccstatus_op(chip, ecc_status);
> +	if (!ret) {
> +		unsigned int i, bitflips = 0;
> +
> +		for (i = 0; i < chip->ecc.steps; i++) {
> +			bitflips = ecc_status[i] & TOSHIBA_NAND_ECC_STATUS_MASK;
> +			if (bitflips == TOSHIBA_NAND_ECC_STATUS_UNCORR) {
> +				mtd->ecc_stats.failed++;
> +			} else {
> +				mtd->ecc_stats.corrected += bitflips;
> +				max_bitflips = max(max_bitflips, bitflips);
> +			}
> +		}
> +
> +		return max_bitflips;
> +	}
> +
> +	/*
> +	 * Fallback to regular status check if
> +	 * toshiba_nand_benand_read_eccstatus_op() failed.
> +	 */
>  	ret = nand_status_op(chip, &status);
>  	if (ret)
>  		return ret;
> @@ -108,7 +159,7 @@ static void toshiba_nand_decode_id(struct nand_chip *chip)
>  	 */
>  	if (chip->id.len >= 6 && nand_is_slc(chip) &&
>  	    (chip->id.data[5] & 0x7) == 0x6 /* 24nm */ &&
> -	    !(chip->id.data[4] & 0x80) /* !BENAND */) {
> +	    !(chip->id.data[4] & TOSHIBA_NAND_ID4_IS_BENAND) /* !BENAND */) {
>  		memorg->oobsize = 32 * memorg->pagesize >> 9;
>  		mtd->oobsize = memorg->oobsize;
>  	}

Looks fine otherwise.

Thanks,
Miquèl
