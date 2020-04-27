Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F59EC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED0DD206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgD0UJJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:09:09 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:58663 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbgD0UJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:09:08 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 94DB5240002;
        Mon, 27 Apr 2020 20:09:04 +0000 (UTC)
Date:   Mon, 27 Apr 2020 22:09:03 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 2/3] mtd: lpddr: Replace printk with pr_notice
Message-ID: <20200427220903.5ad059d5@xps13>
In-Reply-To: <ff48ce07ef208ba65b858f09279a3b36031d64d2.1588016644.git.gustavo@embeddedor.com>
References: <cover.1588016644.git.gustavo@embeddedor.com>
        <ff48ce07ef208ba65b858f09279a3b36031d64d2.1588016644.git.gustavo@embeddedor.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote on Mon, 27 Apr
2020 14:54:13 -0500:

> pr_notice is preferred over printk.
> 
> Also, coalesce formats as coalescing is part of coding-style:
> "never break user-visible strings such as printk messages"
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - Coalesce formats and update changelog text, accordingly.
> 
>  include/linux/mtd/pfow.h | 27 +++++++++++----------------
>  1 file changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/mtd/pfow.h b/include/linux/mtd/pfow.h
> index c65d7a3be3c6..cd21c6768065 100644
> --- a/include/linux/mtd/pfow.h
> +++ b/include/linux/mtd/pfow.h
> @@ -127,31 +127,26 @@ static inline void print_drs_error(unsigned dsr)
>  	int prog_status = (dsr & DSR_RPS) >> 8;
>  
>  	if (!(dsr & DSR_AVAILABLE))
> -		printk(KERN_NOTICE"DSR.15: (0) Device not Available\n");
> +		pr_notice("DSR.15: (0) Device not Available\n");
>  	if ((prog_status & 0x03) == 0x03)
> -		printk(KERN_NOTICE"DSR.9,8: (11) Attempt to program invalid "
> -						"half with 41h command\n");
> +		pr_notice("DSR.9,8: (11) Attempt to program invalid half with 41h command\n");
>  	else if (prog_status & 0x02)
> -		printk(KERN_NOTICE"DSR.9,8: (10) Object Mode Program attempt "
> -					"in region with Control Mode data\n");
> +		pr_notice("DSR.9,8: (10) Object Mode Program attempt in region with Control Mode data\n");
>  	else if (prog_status &  0x01)
> -		printk(KERN_NOTICE"DSR.9,8: (01) Program attempt in region "
> -						"with Object Mode data\n");
> +		pr_notice("DSR.9,8: (01) Program attempt in region with Object Mode data\n");
>  	if (!(dsr & DSR_READY_STATUS))
> -		printk(KERN_NOTICE"DSR.7: (0) Device is Busy\n");
> +		pr_notice("DSR.7: (0) Device is Busy\n");
>  	if (dsr & DSR_ESS)
> -		printk(KERN_NOTICE"DSR.6: (1) Erase Suspended\n");
> +		pr_notice("DSR.6: (1) Erase Suspended\n");
>  	if (dsr & DSR_ERASE_STATUS)
> -		printk(KERN_NOTICE"DSR.5: (1) Erase/Blank check error\n");
> +		pr_notice("DSR.5: (1) Erase/Blank check error\n");
>  	if (dsr & DSR_PROGRAM_STATUS)
> -		printk(KERN_NOTICE"DSR.4: (1) Program Error\n");
> +		pr_notice("DSR.4: (1) Program Error\n");
>  	if (dsr & DSR_VPPS)
> -		printk(KERN_NOTICE"DSR.3: (1) Vpp low detect, operation "
> -					"aborted\n");
> +		pr_notice("DSR.3: (1) Vpp low detect, operation aborted\n");
>  	if (dsr & DSR_PSS)
> -		printk(KERN_NOTICE"DSR.2: (1) Program suspended\n");
> +		pr_notice("DSR.2: (1) Program suspended\n");
>  	if (dsr & DSR_DPS)
> -		printk(KERN_NOTICE"DSR.1: (1) Aborted Erase/Program attempt "
> -					"on locked block\n");
> +		pr_notice("DSR.1: (1) Aborted Erase/Program attempt on locked block\n");
>  }
>  #endif /* __LINUX_MTD_PFOW_H */


Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
