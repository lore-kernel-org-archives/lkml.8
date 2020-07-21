Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1393EC433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:54:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAB7820720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595321674;
	bh=7ZKypSwJ/TtKAkBF9OlVUVTJtOKIc8YaONrJQO64MCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lfU4fWdy6NQ4a5zwJMwkrcU89ZrF1L92+FKd3YPDDTuFnpZj8my1b9PRkXoBOZVId
	 Gr/rGqx8bFTo9ncPziUXizEeeW90sffeY/tlPAp0S/9Nk72J88EVrZlgRl+y4hL1FT
	 plluiUnYEZWoMQnRdlt5YFyk1jQHZAE8LE9fup50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgGUIyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:33198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgGUIyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:54:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8239920717;
        Tue, 21 Jul 2020 08:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595321673;
        bh=7ZKypSwJ/TtKAkBF9OlVUVTJtOKIc8YaONrJQO64MCM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JeD9u3nUzqhB6Y2tHOufy1aIPlPB3vURxvqzG4wqSzHSTZff1uYjctW7S8Fpdcvnp
         MeEHbx8MecApmkYvkIFzZnUdRBmZmcNYyvFQa+P+oO7HD4+TZktgxX/LfF/TM9B17c
         zFoI5m52zhb8rf1YJSZ5jYl2qLf9Tasyxz2BBWxE=
Date:   Tue, 21 Jul 2020 10:54:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: applicom: remove set but not used variable
 'byte_reset_it'
Message-ID: <20200721085441.GB1664942@kroah.com>
References: <20200721084107.13472-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721084107.13472-1-zhengyongjun3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 04:41:07PM +0800, Zheng Yongjun wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/char/applicom.c: In function 'ac_register_board':
> drivers/char/applicom.c:543: warning:
> variable 'byte_reset_it' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/char/applicom.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/char/applicom.c b/drivers/char/applicom.c
> index 14b2d8034c51..fd0b21607a7f 100644
> --- a/drivers/char/applicom.c
> +++ b/drivers/char/applicom.c
> @@ -131,8 +131,6 @@ static int dummy;	/* dev_id for request_irq() */
>  static int ac_register_board(unsigned long physloc, void __iomem *loc, 
>  		      unsigned char boardno)
>  {
> -	volatile unsigned char byte_reset_it;
> -
>  	if((readb(loc + CONF_END_TEST)     != 0x00) ||
>  	   (readb(loc + CONF_END_TEST + 1) != 0x55) ||
>  	   (readb(loc + CONF_END_TEST + 2) != 0xAA) ||
> @@ -160,7 +158,6 @@ static int ac_register_board(unsigned long physloc, void __iomem *loc,
>  	apbs[boardno].RamIO = loc;
>  	init_waitqueue_head(&apbs[boardno].FlagSleepSend);
>  	spin_lock_init(&apbs[boardno].mutex);
> -	byte_reset_it = readb(loc + RAM_IT_TO_PC);

Are you sure you didn't just break the driver?  Lots of times reading
from hardware is required in order to have previous things work, or even
have other affects.

thanks,

greg k-h
