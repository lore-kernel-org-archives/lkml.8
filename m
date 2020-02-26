Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B14CC4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284FC21556
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgBZJGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:06:06 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49558 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgBZJGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:06:05 -0500
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 385BD294931;
        Wed, 26 Feb 2020 09:06:04 +0000 (GMT)
Date:   Wed, 26 Feb 2020 10:06:01 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH] i3c: master: use 'dev' variable in dev_err
Message-ID: <20200226100601.2fc86032@collabora.com>
In-Reply-To: <20200224083439.3487-1-luca@lucaceresoli.net>
References: <20200224083439.3487-1-luca@lucaceresoli.net>
Organization: Collabora
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Lucas,

On Mon, 24 Feb 2020 09:34:39 +0100
Luca Ceresoli <luca@lucaceresoli.net> wrote:

> of_i3c_master_add_i2c_boardinfo() already has a handy 'dev' variable, use
> it and simplify code.

I already applied a similar patch from Wolfram, but thanks for your
contribution.

Regards,

Boris

> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  drivers/i3c/master.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 7f8f896fa0c3..b56207bbed2b 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -1953,7 +1953,7 @@ of_i3c_master_add_i2c_boardinfo(struct i3c_master_controller *master,
>  	 * DEFSLVS command.
>  	 */
>  	if (boardinfo->base.flags & I2C_CLIENT_TEN) {
> -		dev_err(&master->dev, "I2C device with 10 bit address not supported.");
> +		dev_err(dev, "I2C device with 10 bit address not supported.");
>  		return -ENOTSUPP;
>  	}
>  

