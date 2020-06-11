Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4224AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 279C72085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgFKHzp convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:55:45 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:51073 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgFKHzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:55:45 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 2A8FEFF808;
        Thu, 11 Jun 2020 07:55:41 +0000 (UTC)
Date:   Thu, 11 Jun 2020 09:55:40 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>
Cc:     tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, richard@nod.at,
        vigneshr@ti.com, jonas.gorski@gmail.com, linus.walleij@linaro.org,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2] mtd: parsers: bcm63xx: simplify CFE detection
Message-ID: <20200611095540.250184d2@xps13>
In-Reply-To: <20200608160649.3717152-1-noltari@gmail.com>
References: <20200608094053.3381512-1-noltari@gmail.com>
        <20200608160649.3717152-1-noltari@gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Álvaro,

Álvaro Fernández Rojas <noltari@gmail.com> wrote on Mon,  8 Jun 2020
18:06:49 +0200:

> Instead of trying to parse CFE version string, which is customized by some
> vendors, let's just check that "CFE1" was passed on argument 3.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
>  v2: use CFE_EPTSEAL definition and avoid using an additional funtion.
> 
>  drivers/mtd/parsers/bcm63xxpart.c | 29 ++++-------------------------
>  1 file changed, 4 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/mtd/parsers/bcm63xxpart.c b/drivers/mtd/parsers/bcm63xxpart.c
> index 78f90c6c18fd..493a75b2f266 100644
> --- a/drivers/mtd/parsers/bcm63xxpart.c
> +++ b/drivers/mtd/parsers/bcm63xxpart.c
> @@ -22,6 +22,9 @@
>  #include <linux/mtd/partitions.h>
>  #include <linux/of.h>
>  
> +#include <asm/bootinfo.h>
> +#include <asm/fw/cfe/cfe_api.h>

Are you sure both includes are needed?

I don't think it is a good habit to include asm/ headers, are you sure
there is not another header doing it just fine?

> +
>  #define BCM963XX_CFE_BLOCK_SIZE		SZ_64K	/* always at least 64KiB */
>  
>  #define BCM963XX_CFE_MAGIC_OFFSET	0x4e0
> @@ -32,30 +35,6 @@
>  #define STR_NULL_TERMINATE(x) \
>  	do { char *_str = (x); _str[sizeof(x) - 1] = 0; } while (0)
>  
> -static int bcm63xx_detect_cfe(struct mtd_info *master)
> -{
> -	char buf[9];
> -	int ret;
> -	size_t retlen;
> -
> -	ret = mtd_read(master, BCM963XX_CFE_VERSION_OFFSET, 5, &retlen,
> -		       (void *)buf);
> -	buf[retlen] = 0;
> -
> -	if (ret)
> -		return ret;
> -
> -	if (strncmp("cfe-v", buf, 5) == 0)
> -		return 0;
> -
> -	/* very old CFE's do not have the cfe-v string, so check for magic */
> -	ret = mtd_read(master, BCM963XX_CFE_MAGIC_OFFSET, 8, &retlen,
> -		       (void *)buf);
> -	buf[retlen] = 0;
> -
> -	return strncmp("CFE1CFE1", buf, 8);
> -}
> -
>  static int bcm63xx_read_nvram(struct mtd_info *master,
>  	struct bcm963xx_nvram *nvram)
>  {
> @@ -138,7 +117,7 @@ static int bcm63xx_parse_cfe_partitions(struct mtd_info *master,
>  	struct bcm963xx_nvram *nvram = NULL;
>  	int ret;
>  
> -	if (bcm63xx_detect_cfe(master))
> +	if (fw_arg3 != CFE_EPTSEAL)
>  		return -EINVAL;
>  
>  	nvram = vzalloc(sizeof(*nvram));
