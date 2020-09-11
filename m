Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4E4C2D0E1
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1300722204
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgIKP7M convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:59:12 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:45647 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgIKPzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:55:22 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 13E07E000F;
        Fri, 11 Sep 2020 15:55:15 +0000 (UTC)
Date:   Fri, 11 Sep 2020 17:55:14 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: remove redundant assignment to pointer eb
Message-ID: <20200911175514.766eeaf1@xps13>
In-Reply-To: <20200911102321.22515-1-colin.king@canonical.com>
References: <20200911102321.22515-1-colin.king@canonical.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

Colin King <colin.king@canonical.com> wrote on Fri, 11 Sep 2020
11:23:21 +0100:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer eb is being assigned a value that is never read, the assignment
> is redundant and can be removed.
> 
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/mtd/mtdswap.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mtd/mtdswap.c b/drivers/mtd/mtdswap.c
> index 58eefa43af14..795dec4483c2 100644
> --- a/drivers/mtd/mtdswap.c
> +++ b/drivers/mtd/mtdswap.c
> @@ -1053,7 +1053,6 @@ static int mtdswap_writesect(struct mtd_blktrans_dev *dev,
>  	if (ret < 0)
>  		return ret;
>  
> -	eb = d->eb_data + (newblock / d->pages_per_eblk);
>  	d->page_data[page] = newblock;
>  
>  	return 0;

Yes it looks unused but perhaps it helps to catch the logic here. This
is not a strong disagreement but I'd keep it this way. Let's see what
other maintainers think.

Thanks,
Miquèl
