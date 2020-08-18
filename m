Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA62C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4E5420786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 17:07:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgHRRHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 13:07:08 -0400
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:36830 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728468AbgHRRG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 13:06:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 319721E19;
        Tue, 18 Aug 2020 17:06:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: stew13_3e08fcc27021
X-Filterd-Recvd-Size: 3473
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 18 Aug 2020 17:06:53 +0000 (UTC)
Message-ID: <516b2816dddbc9427e4f0a5a6a57e77292014e7a.camel@perches.com>
Subject: Re: [PATCH] staging: kpc2000: kpc_dma: fix spelling mistake "for
 for" -> "for"
From:   Joe Perches <joe@perches.com>
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matt Sickler <Matt.Sickler@daktronics.com>
Date:   Tue, 18 Aug 2020 10:06:52 -0700
In-Reply-To: <20200818164654.381588-1-colin.king@canonical.com>
References: <20200818164654.381588-1-colin.king@canonical.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-18 at 17:46 +0100, Colin King wrote:
> There are a couple of duplicated "for" spelling mistakes in dev_err
> error messages. Fix these.

Might as well remove the messages instead.

> diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
[]
> @@ -53,7 +53,7 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
>  
>  	acd = kzalloc(sizeof(*acd), GFP_KERNEL);
>  	if (!acd) {
> -		dev_err(&priv->ldev->pldev->dev, "Couldn't kmalloc space for for the aio data\n");
> +		dev_err(&priv->ldev->pldev->dev, "Couldn't kmalloc space for the aio data\n");
>  		return -ENOMEM;
>  	}
>  	memset(acd, 0x66, sizeof(struct aio_cb_data));

Also there's no reason to use kzalloc then a memset over
the alloc'ed memory or a different sizeof style for the
alloc then memset.

Setting the struct content to 0x66 does seem odd.

> @@ -69,7 +69,7 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
>  	acd->user_pages = kcalloc(acd->page_count, sizeof(struct page *),
>  				  GFP_KERNEL);
>  	if (!acd->user_pages) {
> -		dev_err(&priv->ldev->pldev->dev, "Couldn't kmalloc space for for the page pointers\n");
> +		dev_err(&priv->ldev->pldev->dev, "Couldn't kmalloc space for the page pointers\n");
>  		rv = -ENOMEM;
>  		goto err_alloc_userpages;
>  	}

Maybe:
---
 drivers/staging/kpc2000/kpc_dma/fileops.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc_dma/fileops.c b/drivers/staging/kpc2000/kpc_dma/fileops.c
index dd716edd9b1b..c5330ad6b175 100644
--- a/drivers/staging/kpc2000/kpc_dma/fileops.c
+++ b/drivers/staging/kpc2000/kpc_dma/fileops.c
@@ -51,12 +51,11 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 
 	ldev = priv->ldev;
 
-	acd = kzalloc(sizeof(*acd), GFP_KERNEL);
-	if (!acd) {
-		dev_err(&priv->ldev->pldev->dev, "Couldn't kmalloc space for for the aio data\n");
+	acd = kmalloc(sizeof(*acd), GFP_KERNEL);
+	if (!acd)
 		return -ENOMEM;
-	}
-	memset(acd, 0x66, sizeof(struct aio_cb_data));
+
+	memset(acd, 0x66, sizeof(*acd));
 
 	acd->priv = priv;
 	acd->ldev = priv->ldev;
@@ -69,7 +68,6 @@ static int kpc_dma_transfer(struct dev_private_data *priv,
 	acd->user_pages = kcalloc(acd->page_count, sizeof(struct page *),
 				  GFP_KERNEL);
 	if (!acd->user_pages) {
-		dev_err(&priv->ldev->pldev->dev, "Couldn't kmalloc space for for the page pointers\n");
 		rv = -ENOMEM;
 		goto err_alloc_userpages;
 	}


