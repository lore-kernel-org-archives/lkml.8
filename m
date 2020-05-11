Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797E3C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53571206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730545AbgEKQOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726687AbgEKQOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:14:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9281DC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:14:36 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 2494F2A0E1A;
        Mon, 11 May 2020 17:14:35 +0100 (BST)
Date:   Mon, 11 May 2020 18:14:31 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>,
        <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>
Subject: Re: [PATCH v7 3/7] i3c: master: add i3c_secondary_master_register
Message-ID: <20200511181431.442cdf0b@collabora.com>
In-Reply-To: <1589202833-6908-1-git-send-email-pthombar@cadence.com>
References: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
        <1589202833-6908-1-git-send-email-pthombar@cadence.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 15:13:53 +0200
Parshuram Thombare <pthombar@cadence.com> wrote:

> add i3c_secondary_master_register which is used
> to register secondary masters.
> 
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  drivers/i3c/master.c       | 154 ++++++++++++++++++++++++++++++++++++-
>  include/linux/i3c/master.h |   3 +
>  2 files changed, 156 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index ba07a7d49633..669bd7e45810 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -1768,6 +1768,90 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
>  	return ret;
>  }
>  
> +/**
> + * i3c_secondary_master_bus_init() - initialize an I3C bus for secondary
> + * master
> + * @master: secondary master initializing the bus
> + *
> + * This function does
> + *
> + * 1. Attach I2C devs to the master
> + *
> + * 2. Call &i3c_master_controller_ops->bus_init() method to initialize
> + *    the master controller. That's usually where the bus mode is selected
> + *    (pure bus or mixed fast/slow bus)

Can you really select the bus mode without knowing the I3C devices you
have on the bus? Or maybe that's a preliminary initialization which is
then updated when you receive DEFSLVS events.

> + *
> + * Once this is done, I2C devices should be usable.

I suspect you'll have to request bus ownership first, which means
they're not really usable, just registered to the I2C subsystem. This
might lead to a whole bunch of problems when drivers will try to send
messages to the I2C devices and receive ETIMEDOUT/EBUSY errors. We'll
probably need some updates to the I2C framework if we want I2C to play
nicely with bus handover, but I think we can keep that for later. I'd
suggest to forget about I2C for now and mark that as a limitation (no
I2C devs on secondary masters).

> + *
> + * Return: a 0 in case of success, an negative error code otherwise.
> + */
> +static int i3c_secondary_master_bus_init(struct i3c_master_controller *master)
> +{
> +	enum i3c_addr_slot_status status;
> +	struct i2c_dev_boardinfo *i2cboardinfo;
> +	struct i2c_dev_desc *i2cdev;
> +	int ret;
> +
> +	/*
> +	 * First attach all devices with static definitions provided by the
> +	 * FW.
> +	 */
> +	list_for_each_entry(i2cboardinfo, &master->boardinfo.i2c, node) {
> +		status = i3c_bus_get_addr_slot_status(&master->bus,
> +						      i2cboardinfo->base.addr);
> +		if (status != I3C_ADDR_SLOT_FREE) {
> +			ret = -EBUSY;
> +			goto err_detach_devs;
> +		}
> +
> +		i3c_bus_set_addr_slot_status(&master->bus,
> +					     i2cboardinfo->base.addr,
> +					     I3C_ADDR_SLOT_I2C_DEV);
> +
> +		i2cdev = i3c_master_alloc_i2c_dev(master, i2cboardinfo);
> +		if (IS_ERR(i2cdev)) {
> +			ret = PTR_ERR(i2cdev);
> +			goto err_detach_devs;
> +		}
> +
> +		ret = i3c_master_attach_i2c_dev(master, i2cdev);
> +		if (ret) {
> +			i3c_master_free_i2c_dev(i2cdev);
> +			goto err_detach_devs;
> +		}
> +	}
> +
> +	/*
> +	 * Now execute the controller specific ->bus_init() routine, which
> +	 * might configure its internal logic to match the bus limitations.
> +	 */
> +	ret = master->ops->bus_init(master);
> +	if (ret)
> +		goto err_detach_devs;
> +
> +	/*
> +	 * The master device should have been instantiated in ->bus_init(),
> +	 * complain if this was not the case.
> +	 */
> +	if (!master->this) {
> +		dev_err(&master->dev,
> +			"master_set_info() was not called in ->bus_init()\n");
> +		ret = -EINVAL;
> +		goto err_bus_cleanup;
> +	}
> +
> +	return 0;
> +
> +err_bus_cleanup:
> +	if (master->ops->bus_cleanup)
> +		master->ops->bus_cleanup(master);
> +
> +err_detach_devs:
> +	i3c_master_detach_free_devs(master);
> +
> +	return ret;
> +}
> +
>  static void i3c_master_bus_cleanup(struct i3c_master_controller *master)
>  {
>  	if (master->ops->bus_cleanup)
> @@ -2457,7 +2541,10 @@ static int i3c_master_init(struct i3c_master_controller *master,
>  		goto err_put_dev;
>  	}
>  
> -	ret = i3c_master_bus_init(master);
> +	if (secondary)
> +		ret = i3c_secondary_master_bus_init(master);
> +	else
> +		ret = i3c_master_bus_init(master);
>  	if (ret)
>  		goto err_put_dev;
>  
> @@ -2535,6 +2622,71 @@ int i3c_master_register(struct i3c_master_controller *master,
>  }
>  EXPORT_SYMBOL_GPL(i3c_master_register);
>  
> +/**
> + * i3c_secondary_master_register() - register an I3C secondary master
> + * @master: master used to send frames on the bus
> + * @parent: the parent device (the one that provides this I3C master
> + *	    controller)
> + * @ops: the master controller operations
> + *
> + * This function does minimal required initialization for secondary
> + * master, rest functionality like creating and registering I2C
> + * and I3C devices is done in defslvs processing.
> + *
> + *  i3c_secondary_master_register() does following things -
> + * - creates and initializes the I3C bus
> + * - populates the bus with static I2C devs if @parent->of_node is not
> + *   NULL
> + *   initialization
> + * - allocate memory for defslvs_data.devs, which is used to receive
> + *   defslvs list
> + * - create I3C device representing this master
> + * - registers the I2C adapter and all I2C devices
> + *
> + * Return: 0 in case of success, a negative error code otherwise.
> + */
> +int i3c_secondary_master_register(struct i3c_master_controller *master,
> +				  struct device *parent,
> +				  const struct i3c_master_controller_ops *ops)
> +{
> +	int ret;
> +
> +	ret = i3c_master_init(master, parent, ops, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = device_add(&master->dev);
> +	if (ret)
> +		goto err_cleanup_bus;
> +
> +	/*
> +	 * Expose our I3C bus as an I2C adapter so that I2C devices are exposed
> +	 * through the I2C subsystem.
> +	 */
> +	ret = i3c_master_i2c_adapter_init(master);
> +	if (ret)
> +		goto err_del_dev;
> +
> +	/*
> +	 * We're done initializing the bus and the controller, we can now
> +	 * register I3C devices from defslvs list.
> +	 */
> +	master->init_done = true;
> +
> +	return 0;
> +
> +err_del_dev:
> +	device_del(&master->dev);
> +
> +err_cleanup_bus:
> +	i3c_master_bus_cleanup(master);
> +
> +	put_device(&master->dev);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(i3c_secondary_master_register);
> +
>  /**
>   * i3c_master_unregister() - unregister an I3C master
>   * @master: master used to send frames on the bus
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> index f5ba82c390bc..5124ff4831eb 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -534,6 +534,9 @@ int i3c_master_set_info(struct i3c_master_controller *master,
>  int i3c_master_register(struct i3c_master_controller *master,
>  			struct device *parent,
>  			const struct i3c_master_controller_ops *ops);
> +int i3c_secondary_master_register(struct i3c_master_controller *master,
> +				  struct device *parent,
> +				  const struct i3c_master_controller_ops *ops);
>  int i3c_master_unregister(struct i3c_master_controller *master);
>  
>  /**

