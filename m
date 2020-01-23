Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8660AC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 04:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D35124673
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 04:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579752432;
	bh=Ljk4aNTIh5qaY+LhyrDRlPXS83l3MsxY6wI4fyIxdgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VQ0WW3Oq7t4MDLXa4TpC/0olCHPwfcOZ98QoSI7tihEv7lZfzecWJ+yh54nyJfeQV
	 hjPkyImyw/Wlh6sd3I0YPsDANJrOVDOz45mjqphZHMGR/vtMeoioMwnRO86jKb9i8F
	 YWMDs1K91yOMFeFFK4JB1eDcorC8P3etucuniVnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgAWEHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 23:07:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbgAWEHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 23:07:10 -0500
Received: from localhost (unknown [106.200.244.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFCAF2465A;
        Thu, 23 Jan 2020 04:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579752429;
        bh=Ljk4aNTIh5qaY+LhyrDRlPXS83l3MsxY6wI4fyIxdgs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gM30JBU2phcjbEoMCePoUQn2rPt1Ihug1K8uZwpGvusdGIx57rgswEklYC9QRH7YE
         UBiWP7DuubGSSHNBvCqfhX2VwQbAKPZMoFWwV26JoB1mk4Yn/DQd7KdwfqiHkhNTfu
         4Xz7wn+Yf7zMXBk6HSkObzgWO75i3AOtFxCO6hik=
Date:   Thu, 23 Jan 2020 09:37:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/rose: fix spelling mistake "to" -> "too"
Message-ID: <20200123040705.GT2841@vkoul-mobl>
References: <20200123010133.2834467-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123010133.2834467-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On 23-01-20, 01:01, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a printk message. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/dma/s3c24xx-dma.c | 2 +-
>  net/rose/af_rose.c        | 2 +-

Care to split the two..?

Thanks
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
> index 8e14c72d03f0..63f1453ca250 100644
> --- a/drivers/dma/s3c24xx-dma.c
> +++ b/drivers/dma/s3c24xx-dma.c
> @@ -826,7 +826,7 @@ static struct dma_async_tx_descriptor *s3c24xx_dma_prep_memcpy(
>  			len, s3cchan->name);
>  
>  	if ((len & S3C24XX_DCON_TC_MASK) != len) {
> -		dev_err(&s3cdma->pdev->dev, "memcpy size %zu to large\n", len);
> +		dev_err(&s3cdma->pdev->dev, "memcpy size %zu too large\n", len);
>  		return NULL;
>  	}
>  
> diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
> index 46b8ff24020d..1e8eeb044b07 100644
> --- a/net/rose/af_rose.c
> +++ b/net/rose/af_rose.c
> @@ -1475,7 +1475,7 @@ static int __init rose_proto_init(void)
>  	int rc;
>  
>  	if (rose_ndevs > 0x7FFFFFFF/sizeof(struct net_device *)) {
> -		printk(KERN_ERR "ROSE: rose_proto_init - rose_ndevs parameter to large\n");
> +		printk(KERN_ERR "ROSE: rose_proto_init - rose_ndevs parameter too large\n");
>  		rc = -EINVAL;
>  		goto out;
>  	}
> -- 
> 2.24.0

-- 
~Vinod
