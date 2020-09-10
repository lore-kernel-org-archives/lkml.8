Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43478C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFEFA21D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599749061;
	bh=X1oz6LSaNNagHRh+ADTx8a6iFsrP03AhWhXXDzITLVo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=McUGFI8/QOlpoaVWheFDDNae0Pgod3cYGGm4ziN54Nh87PVxPcdaEmUQdqsBJ5CHs
	 kideNIjvalqDoHauuPkop5+pSpB796xTi9KbB9yC0F/7v1Ugjf1acq7SHlTG6ZQ4Jc
	 iyeJEB63fGemKLf9n6OVyuD+Nd3LlIdHj87/Ru2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbgIJOlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 10:41:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731198AbgIJOi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:38:59 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AC112076D;
        Thu, 10 Sep 2020 14:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599748739;
        bh=X1oz6LSaNNagHRh+ADTx8a6iFsrP03AhWhXXDzITLVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZ7rFkO96+mbI3Z/iZVF8jynxmbTyOlnthuYOo/WRibTwUg/4y0Kdbi6IJydO/+Gs
         9FMajZDz8TUNsPeiGt1eMuq25u6LEbdIp/VBuHr/QxnidNzohZGaDzEE4l5VfH/Ohj
         5GNeRXyt48/zUXHJPclCht+lC7ZZUK3lRqbFWJQs=
Date:   Thu, 10 Sep 2020 09:44:19 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     linux@dominikbrodowski.net, linux-kernel@vger.kernel.org,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] pcmcia: db1xxx_ss: remove unneeded semicolon
Message-ID: <20200910144419.GB4162@embeddedor>
References: <20200910140524.1191003-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910140524.1191003-1-yanaijie@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 10:05:24PM +0800, Jason Yan wrote:
> Eliminate the following coccicheck warning:
> 
> drivers/pcmcia/db1xxx_ss.c:455:2-3: Unneeded semicolon
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
--
Gustavo

> ---
>  drivers/pcmcia/db1xxx_ss.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
> index a7c7c7cd2326..a6fbc709913e 100644
> --- a/drivers/pcmcia/db1xxx_ss.c
> +++ b/drivers/pcmcia/db1xxx_ss.c
> @@ -452,7 +452,7 @@ static int db1x_pcmcia_socket_probe(struct platform_device *pdev)
>  		printk(KERN_INFO "db1xxx-ss: unknown board %d!\n", bid);
>  		ret = -ENODEV;
>  		goto out0;
> -	};
> +	}
>  
>  	/*
>  	 * gather resources necessary and optional nice-to-haves to
> -- 
> 2.25.4
> 
