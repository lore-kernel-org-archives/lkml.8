Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD8EC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 653B2206A3
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730227AbgEKPop (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726687AbgEKPop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:44:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A81C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:44:44 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id B36BB2A0A4B;
        Mon, 11 May 2020 16:44:40 +0100 (BST)
Date:   Mon, 11 May 2020 17:44:37 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>,
        <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>
Subject: Re: [PATCH v7 2/7] i3c: master: use i3c_master_register only for
 main master
Message-ID: <20200511174437.1a886231@collabora.com>
In-Reply-To: <1589202785-6174-1-git-send-email-pthombar@cadence.com>
References: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
        <1589202785-6174-1-git-send-email-pthombar@cadence.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 15:13:05 +0200
Parshuram Thombare <pthombar@cadence.com> wrote:

> Removed last argument 'secondary' and refactored
> i3c_master_register to move code that can be common
> to i3c_secondary_master_register to separate function
> i3c_master_init.
> 
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  drivers/i3c/master.c                 | 69 +++++++++++++++++-----------
>  drivers/i3c/master/dw-i3c-master.c   |  2 +-
>  drivers/i3c/master/i3c-master-cdns.c |  2 +-
>  include/linux/i3c/master.h           |  3 +-
>  4 files changed, 46 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 5f4bd52121fe..ba07a7d49633 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -2391,31 +2391,10 @@ static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
>  	return 0;
>  }
>  
> -/**
> - * i3c_master_register() - register an I3C master
> - * @master: master used to send frames on the bus
> - * @parent: the parent device (the one that provides this I3C master
> - *	    controller)
> - * @ops: the master controller operations
> - * @secondary: true if you are registering a secondary master. Will return
> - *	       -ENOTSUPP if set to true since secondary masters are not yet
> - *	       supported
> - *
> - * This function takes care of everything for you:
> - *
> - * - creates and initializes the I3C bus
> - * - populates the bus with static I2C devs if @parent->of_node is not
> - *   NULL
> - * - registers all I3C devices added by the controller during bus
> - *   initialization
> - * - registers the I2C adapter and all I2C devices
> - *
> - * Return: 0 in case of success, a negative error code otherwise.
> - */
> -int i3c_master_register(struct i3c_master_controller *master,
> -			struct device *parent,
> -			const struct i3c_master_controller_ops *ops,
> -			bool secondary)
> +static int i3c_master_init(struct i3c_master_controller *master,
> +			   struct device *parent,
> +			   const struct i3c_master_controller_ops *ops,
> +			   bool secondary)
>  {
>  	struct i3c_bus *i3cbus = i3c_master_get_bus(master);
>  	enum i3c_bus_mode mode = I3C_BUS_MODE_PURE;
> @@ -2482,6 +2461,45 @@ int i3c_master_register(struct i3c_master_controller *master,
>  	if (ret)
>  		goto err_put_dev;
>  
> +	return 0;
> +
> +err_put_dev:
> +	put_device(&master->dev);
> +
> +	return ret;
> +}
> +
> +/**
> + * i3c_master_register() - register an I3C master

The function should be renamed and the doc updated to reflect the fact
that it only works for primary masters:

i3c_primary_master_register() - register a primary I3C master

> + * @master: master used to send frames on the bus
> + * @parent: the parent device (the one that provides this I3C master
> + *	    controller)
> + * @ops: the master controller operations
> + * @secondary: true if you are registering a secondary master. Will return
> + *	       -ENOTSUPP if set to true since secondary masters are not yet
> + *	       supported

This argument no longer exists.

> + *
> + * This function takes care of everything for you:
> + *
> + * - creates and initializes the I3C bus
> + * - populates the bus with static I2C devs if @parent->of_node is not
> + *   NULL
> + * - registers all I3C devices added by the controller during bus
> + *   initialization
> + * - registers the I2C adapter and all I2C devices
> + *
> + * Return: 0 in case of success, a negative error code otherwise.
> + */
> +int i3c_master_register(struct i3c_master_controller *master,
> +			struct device *parent,
> +			const struct i3c_master_controller_ops *ops)
> +{
> +	int ret;
> +
> +	ret = i3c_master_init(master, parent, ops, false);
> +	if (ret)
> +		return ret;
> +
>  	ret = device_add(&master->dev);
>  	if (ret)
>  		goto err_cleanup_bus;
> @@ -2511,7 +2529,6 @@ int i3c_master_register(struct i3c_master_controller *master,
>  err_cleanup_bus:
>  	i3c_master_bus_cleanup(master);
>  
> -err_put_dev:
>  	put_device(&master->dev);
>  
>  	return ret;
> diff --git a/drivers/i3c/master/dw-i3c-master.c b/drivers/i3c/master/dw-i3c-master.c
> index 1d83c97431c7..5d5a8a90ec06 100644
> --- a/drivers/i3c/master/dw-i3c-master.c
> +++ b/drivers/i3c/master/dw-i3c-master.c
> @@ -1158,7 +1158,7 @@ static int dw_i3c_probe(struct platform_device *pdev)
>  	master->free_pos = GENMASK(master->maxdevs - 1, 0);
>  
>  	ret = i3c_master_register(&master->base, &pdev->dev,
> -				  &dw_mipi_i3c_ops, false);
> +				  &dw_mipi_i3c_ops);
>  	if (ret)
>  		goto err_assert_rst;
>  
> diff --git a/drivers/i3c/master/i3c-master-cdns.c b/drivers/i3c/master/i3c-master-cdns.c
> index 8889a4fdb454..ed4f43807f9e 100644
> --- a/drivers/i3c/master/i3c-master-cdns.c
> +++ b/drivers/i3c/master/i3c-master-cdns.c
> @@ -1615,7 +1615,7 @@ static int cdns_i3c_master_probe(struct platform_device *pdev)
>  	writel(DEVS_CTRL_DEV_CLR_ALL, master->regs + DEVS_CTRL);
>  
>  	ret = i3c_master_register(&master->base, &pdev->dev,
> -				  &cdns_i3c_master_ops, false);
> +				  &cdns_i3c_master_ops);
>  	if (ret)
>  		goto err_disable_sysclk;
>  
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> index f13fd8b1dd79..f5ba82c390bc 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -533,8 +533,7 @@ int i3c_master_set_info(struct i3c_master_controller *master,
>  
>  int i3c_master_register(struct i3c_master_controller *master,
>  			struct device *parent,
> -			const struct i3c_master_controller_ops *ops,
> -			bool secondary);
> +			const struct i3c_master_controller_ops *ops);
>  int i3c_master_unregister(struct i3c_master_controller *master);
>  
>  /**

