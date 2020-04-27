Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10626C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E888720663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgD0N3S convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:29:18 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:54609 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgD0N3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:29:18 -0400
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 25CD520000A;
        Mon, 27 Apr 2020 13:29:14 +0000 (UTC)
Date:   Mon, 27 Apr 2020 15:29:13 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Joe Perches <joe@perches.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mtd: lpddr: Fix bad logic in print_drs_error
Message-ID: <20200427152913.47a48b46@xps13>
In-Reply-To: <2e19547dcec386b47923211896f43053b60ebc60.camel@perches.com>
References: <2e19547dcec386b47923211896f43053b60ebc60.camel@perches.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

Joe Perches <joe@perches.com> wrote on Mon, 30 Mar 2020 12:56:59 -0700:

> Update logic for broken test.
> Use a more common logging style.
> 
> Miscellanea:
> 
> o Coalesce formats
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> Found by inspection of include files using printk.
> 
> It appears the logic in this function is broken for the
> consecutive tests of
> 
> 	if (prog_status & 0x3)
> 		...
> 	else if (prog_status & 0x2)
> 		...
> 	else (prog_status & 0x1)
> 		...
> 
> Likely the first test should be
> 
> 	if ((prog_status & 0x3) == 0x3)

I had a hard time understanding the patch just with the commit log, I
think the above text is as important.

In fact, would you mind doing the printk->pr_notice in a first patch,
and fix the wrong condition in a separate change?

> 
> And this function is only used in drivers/mtd/lpddr/lpddr_cmds.c
> perhaps it should be moved there.

Agreed, do not hesitate to move the function as suggested in a third
patch.

> 
>  include/linux/mtd/pfow.h | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/mtd/pfow.h b/include/linux/mtd/pfow.h
> index 122f343..1c08e75 100644
> --- a/include/linux/mtd/pfow.h
> +++ b/include/linux/mtd/pfow.h
> @@ -127,31 +127,28 @@ static inline void print_drs_error(unsigned dsr)
>  	int prog_status = (dsr & DSR_RPS) >> 8;
>  
>  	if (!(dsr & DSR_AVAILABLE))
> -		printk(KERN_NOTICE"DSR.15: (0) Device not Available\n");
> -	if (prog_status & 0x03)
> -		printk(KERN_NOTICE"DSR.9,8: (11) Attempt to program invalid "
> -						"half with 41h command\n");
> +		pr_notice("DSR.15: (0) Device not Available\n");
> +
> +	if ((prog_status & 0x03) == 0x03)
> +		pr_notice("DSR.9,8: (11) Attempt to program invalid half with 41h command\n");
>  	else if (prog_status & 0x02)
> -		printk(KERN_NOTICE"DSR.9,8: (10) Object Mode Program attempt "
> -					"in region with Control Mode data\n");
> +		pr_notice("DSR.9,8: (10) Object Mode Program attempt in region with Control Mode data\n");
>  	else if (prog_status &  0x01)
> -		printk(KERN_NOTICE"DSR.9,8: (01) Program attempt in region "
> -						"with Object Mode data\n");
> +		pr_notice("DSR.9,8: (01) Program attempt in region with Object Mode data\n");
> +
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
> 
> 

Thanks,
Miquèl
