Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09128C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE0D4206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgD0UIi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:08:38 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:53761 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgD0UIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:08:37 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 7DC6220006;
        Mon, 27 Apr 2020 20:08:35 +0000 (UTC)
Date:   Mon, 27 Apr 2020 22:08:34 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 1/3] mtd: lpddr: Fix bad logic in print_drs_error
Message-ID: <20200427220834.17083b3d@xps13>
In-Reply-To: <3fb0e29f5b601db8be2938a01d974b00c8788501.1588016644.git.gustavo@embeddedor.com>
References: <cover.1588016644.git.gustavo@embeddedor.com>
        <3fb0e29f5b601db8be2938a01d974b00c8788501.1588016644.git.gustavo@embeddedor.com>
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
2020 14:50:37 -0500:

> Update logic for broken test. Use a more common logging style.
> 
> It appears the logic in this function is broken for the
> consecutive tests of
> 
>         if (prog_status & 0x3)
>                 ...
>         else if (prog_status & 0x2)
>                 ...
>         else (prog_status & 0x1)
>                 ...
> 
> Likely the first test should be
> 
>         if ((prog_status & 0x3) == 0x3)
> 
> Found by inspection of include files using printk.
> 
> Fixes: eb3db27507f7 ("[MTD] LPDDR PFOW definition")
> Cc: stable@vger.kernel.org
> Reported-by: Joe Perches <joe@perches.com>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - None.
> 
>  include/linux/mtd/pfow.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mtd/pfow.h b/include/linux/mtd/pfow.h
> index 122f3439e1af..c65d7a3be3c6 100644
> --- a/include/linux/mtd/pfow.h
> +++ b/include/linux/mtd/pfow.h
> @@ -128,7 +128,7 @@ static inline void print_drs_error(unsigned dsr)
>  
>  	if (!(dsr & DSR_AVAILABLE))
>  		printk(KERN_NOTICE"DSR.15: (0) Device not Available\n");
> -	if (prog_status & 0x03)
> +	if ((prog_status & 0x03) == 0x03)
>  		printk(KERN_NOTICE"DSR.9,8: (11) Attempt to program invalid "
>  						"half with 41h command\n");
>  	else if (prog_status & 0x02)


Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>


Thanks,
Miquèl
