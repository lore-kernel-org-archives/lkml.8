Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAA1C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F9E32051A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="epYBeI9h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCQTbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 15:31:37 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39834 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgCQTbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:31:36 -0400
Received: from MININT-65B7IF6 (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6640920B9C02;
        Tue, 17 Mar 2020 12:31:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6640920B9C02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1584473495;
        bh=Zngd3GbJO0PyrflA0R74CEKTaOHgEt8n6lY6urAh09A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=epYBeI9hS3JGSAwsYzrm3tl9J/YnvWRXzM1UQSXPvKkbfkPVlRjCb/s9HFd0dEKBP
         +xVTINXqYrEur86KfyUpOBHHl5T6h4Zogt55rnPEGPxW9XAJm6TVa1lsNzr4Dr1PRp
         s9KYbsytM1wCPzez3wu7Zjcw6Dls4ubuJy6orZnc=
Date:   Tue, 17 Mar 2020 14:31:25 -0500
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH v1 1/1] maillbox: bcm-flexrm-mailbox: handle cmpl_pool
 dma allocation failure
Message-ID: <20200317192916.GA708@MININT-65B7IF6>
References: <20200317042216.20623-1-rayagonda.kokatanur@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317042216.20623-1-rayagonda.kokatanur@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-17 09:52:16, Rayagonda Kokatanur wrote:
> Handle 'cmpl_pool' dma memory allocation failure.
> 
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

This looks correct to me.

Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>

It would be ideal if we could include this tag when applying the fix (or
sending a v2):

Fixes: a9a9da47f8e6 ("mailbox: no need to check return value of debugfs_create functions")

Thanks!

Tyler

> ---
>  drivers/mailbox/bcm-flexrm-mailbox.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
> index 8ee9db274802..bee33abb5308 100644
> --- a/drivers/mailbox/bcm-flexrm-mailbox.c
> +++ b/drivers/mailbox/bcm-flexrm-mailbox.c
> @@ -1599,6 +1599,7 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
>  					  1 << RING_CMPL_ALIGN_ORDER, 0);
>  	if (!mbox->cmpl_pool) {
>  		ret = -ENOMEM;
> +		goto fail_destroy_bd_pool;
>  	}
>  
>  	/* Allocate platform MSIs for each ring */
> @@ -1661,6 +1662,7 @@ static int flexrm_mbox_probe(struct platform_device *pdev)
>  	platform_msi_domain_free_irqs(dev);
>  fail_destroy_cmpl_pool:
>  	dma_pool_destroy(mbox->cmpl_pool);
> +fail_destroy_bd_pool:
>  	dma_pool_destroy(mbox->bd_pool);
>  fail:
>  	return ret;
> -- 
> 2.17.1
> 
