Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11307C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E36452078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390488AbgEYLyb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:54:31 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:18725 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390281AbgEYLya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:54:30 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 24CCF240008;
        Mon, 25 May 2020 11:54:26 +0000 (UTC)
Date:   Mon, 25 May 2020 13:54:24 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the nand tree
Message-ID: <20200525135424.1fbc33bf@xps13>
In-Reply-To: <20200525204535.18e243d7@canb.auug.org.au>
References: <20200525204535.18e243d7@canb.auug.org.au>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

Stephen Rothwell <sfr@canb.auug.org.au> wrote on Mon, 25 May 2020
20:45:35 +1000:

> Hi all,
> 
> After merging the nand tree, today's linux-next build (powerpc
> allyesconfig) failed like this:
> 
> drivers/mtd/nand/raw/pasemi_nand.c: In function 'pasemi_nand_probe':
> drivers/mtd/nand/raw/pasemi_nand.c:157:1: warning: label 'out_cleanup' defined but not used [-Wunused-label]
>   157 | out_cleanup:
>       | ^~~~~~~~~~~
> drivers/mtd/nand/raw/pasemi_nand.c:149:3: error: label 'out_cleanup_nand' used but not defined
>   149 |   goto out_cleanup_nand;
>       |   ^~~~
> 
> Caused by commit
> 
>   d6a2207d79e3 ("mtd: rawnand: pasemi: Fix the probe error path")
> 
> I have applied the following patch for today.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 25 May 2020 20:41:22 +1000
> Subject: [PATCH] mtd: rawnand: pasemi: fix up label spelling
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/mtd/nand/raw/pasemi_nand.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/pasemi_nand.c b/drivers/mtd/nand/raw/pasemi_nand.c
> index 37570f0c3a36..d8eca8c3fdcd 100644
> --- a/drivers/mtd/nand/raw/pasemi_nand.c
> +++ b/drivers/mtd/nand/raw/pasemi_nand.c
> @@ -154,7 +154,7 @@ static int pasemi_nand_probe(struct platform_device *ofdev)
>  
>  	return 0;
>  
> -out_cleanup:
> + out_cleanup_nand:
>  	nand_cleanup(chip);
>   out_lpc:
>  	release_region(lpcctl, 4);

Damn it, I always screw up with !COMPILE_TEST drivers...

That's the right fix, I updated nand/next for tomorrow.

Thanks a lot,
Miquèl
