Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC052C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 09:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85858207CD
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 09:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgHWJ7Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 05:59:24 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33506 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgHWJ7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 05:59:23 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4C806293B8E;
        Sun, 23 Aug 2020 10:59:21 +0100 (BST)
Date:   Sun, 23 Aug 2020 11:59:18 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>,
        mparab@cadence.com, praneeth@ti.com, linux-kernel@vger.kernel.org,
        pgaj@cadence.com, linux-i3c@lists.infradead.org
Subject: Re: [PATCH v4] i3c: master: fix for SETDASA and DAA process
Message-ID: <20200823115918.7dd868e0@collabora.com>
In-Reply-To: <1598001195-18511-1-git-send-email-pthombar@cadence.com>
References: <1598001195-18511-1-git-send-email-pthombar@cadence.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Aug 2020 11:13:15 +0200
Parshuram Thombare <pthombar@cadence.com> wrote:

> This patch fix following issue.
> Controller slots blocked for devices with static_addr
> but no init_dyn_addr may limit the number of I3C devices
> on the bus which gets dynamic address in DAA. So
> instead of attaching all the devices with static_addr,
> now we only attach the devices which successfully
> complete SETDASA. For remaining devices with init_dyn_addr,
> i3c_master_add_i3c_dev_locked() will try to set requested
> dynamic address after DAA.
> 
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
> Changes between v3 and v4 are:
> 1. Code rectoring and removed Fixes tag
> 
> Changes between v2 and v3 are:
> 1. Keeping init_dyn_addr reserved.
> 2. Code refactoring and changes in comments.
> 
> Changes between v1 and v2 are:
> 1. Added boardinfo attach fix.
> 2. Removed reattach issue related fix.
> 3. Reserve init_dyn_addr initially, so that it will not
>    be used in DAA and  attempt can be made to set those
>    firmware requested dynamic address after DAA.
> ---
>  drivers/i3c/master.c |  116 ++++++++++++++++++++++++++++---------------------
>  1 files changed, 66 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 3d995f2..3ff95e4 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -1367,7 +1367,9 @@ static int i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
>  	enum i3c_addr_slot_status status;
>  	int ret;
>  
> -	if (dev->info.dyn_addr != old_dyn_addr) {
> +	if (dev->info.dyn_addr != old_dyn_addr &&
> +	    (!dev->boardinfo ||
> +	     dev->info.dyn_addr != dev->boardinfo->init_dyn_addr)) {
>  		status = i3c_bus_get_addr_slot_status(&master->bus,
>  						      dev->info.dyn_addr);
>  		if (status != I3C_ADDR_SLOT_FREE)
> @@ -1426,33 +1428,49 @@ static void i3c_master_detach_i2c_dev(struct i2c_dev_desc *dev)
>  		master->ops->detach_i2c_dev(dev);
>  }
>  
> -static void i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
> +static int i3c_master_early_i3c_dev_add(struct i3c_master_controller *master,
> +					  struct i3c_dev_boardinfo *boardinfo)
>  {
> -	struct i3c_master_controller *master = i3c_dev_get_master(dev);
> +	struct i3c_device_info info = {
> +		.static_addr = boardinfo->static_addr,
> +	};
> +	struct i3c_dev_desc *i3cdev;
>  	int ret;
>  
> -	if (!dev->boardinfo || !dev->boardinfo->init_dyn_addr ||
> -	    !dev->boardinfo->static_addr)
> -		return;
> +	i3cdev = i3c_master_alloc_i3c_dev(master, &info);
> +	if (IS_ERR(i3cdev))
> +		return -ENOMEM;
>  
> -	ret = i3c_master_setdasa_locked(master, dev->info.static_addr,
> -					dev->boardinfo->init_dyn_addr);
> +	i3cdev->boardinfo = boardinfo;
> +
> +	ret = i3c_master_attach_i3c_dev(master, i3cdev);
>  	if (ret)
> -		return;
> +		goto err_attach;
> +
> +	ret = i3c_master_setdasa_locked(master, i3cdev->info.static_addr,
> +					i3cdev->boardinfo->init_dyn_addr);
> +	if (ret)
> +		goto err_setdasa;
>  
> -	dev->info.dyn_addr = dev->boardinfo->init_dyn_addr;
> -	ret = i3c_master_reattach_i3c_dev(dev, 0);
> +	i3cdev->info.dyn_addr = i3cdev->boardinfo->init_dyn_addr;
> +	ret = i3c_master_reattach_i3c_dev(i3cdev, 0);
>  	if (ret)
>  		goto err_rstdaa;
>  
> -	ret = i3c_master_retrieve_dev_info(dev);
> +	ret = i3c_master_retrieve_dev_info(i3cdev);
>  	if (ret)
>  		goto err_rstdaa;
>  
> -	return;
> +	return 0;
>  
>  err_rstdaa:
> -	i3c_master_rstdaa_locked(master, dev->boardinfo->init_dyn_addr);
> +	i3c_master_rstdaa_locked(master, i3cdev->boardinfo->init_dyn_addr);
> +err_setdasa:
> +	i3c_master_detach_i3c_dev(i3cdev);
> +err_attach:
> +	i3c_master_free_i3c_dev(i3cdev);
> +
> +	return ret;
>  }
>  
>  static void
> @@ -1619,8 +1637,8 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
>   * This function is following all initialisation steps described in the I3C
>   * specification:
>   *
> - * 1. Attach I2C and statically defined I3C devs to the master so that the
> - *    master can fill its internal device table appropriately
> + * 1. Attach I2C devs to the master so that the master can fill its internal
> + *    device table appropriately
>   *
>   * 2. Call &i3c_master_controller_ops->bus_init() method to initialize
>   *    the master controller. That's usually where the bus mode is selected
> @@ -1633,10 +1651,14 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
>   * 4. Disable all slave events.
>   *
>   * 5. Pre-assign dynamic addresses requested by the FW with SETDASA for I3C
> - *    devices that have a static address
> + *    devices that have a static address and attach corresponding statically
> + *    defined I3C devices to the master. If only init_dyn_addr is available
> + *    or if SETDASA fails, reserve those init_dyn_addr to be used later to set
> + *    address using SETNEWDA after DAA.
>   *
>   * 6. Do a DAA (Dynamic Address Assignment) to assign dynamic addresses to all
> - *    remaining I3C devices
> + *    remaining I3C devices and attach them to the master if the dynamic address
> + *    assignment succeeds
>   *
>   * Once this is done, all I3C and I2C devices should be usable.
>   *
> @@ -1647,7 +1669,6 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
>  	enum i3c_addr_slot_status status;
>  	struct i2c_dev_boardinfo *i2cboardinfo;
>  	struct i3c_dev_boardinfo *i3cboardinfo;
> -	struct i3c_dev_desc *i3cdev;
>  	struct i2c_dev_desc *i2cdev;
>  	int ret;
>  
> @@ -1679,34 +1700,6 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
>  			goto err_detach_devs;
>  		}
>  	}
> -	list_for_each_entry(i3cboardinfo, &master->boardinfo.i3c, node) {
> -		struct i3c_device_info info = {
> -			.static_addr = i3cboardinfo->static_addr,
> -		};
> -
> -		if (i3cboardinfo->init_dyn_addr) {
> -			status = i3c_bus_get_addr_slot_status(&master->bus,
> -						i3cboardinfo->init_dyn_addr);
> -			if (status != I3C_ADDR_SLOT_FREE) {
> -				ret = -EBUSY;
> -				goto err_detach_devs;
> -			}
> -		}
> -
> -		i3cdev = i3c_master_alloc_i3c_dev(master, &info);
> -		if (IS_ERR(i3cdev)) {
> -			ret = PTR_ERR(i3cdev);
> -			goto err_detach_devs;
> -		}
> -
> -		i3cdev->boardinfo = i3cboardinfo;
> -
> -		ret = i3c_master_attach_i3c_dev(master, i3cdev);
> -		if (ret) {
> -			i3c_master_free_i3c_dev(i3cdev);
> -			goto err_detach_devs;
> -		}
> -	}
>  
>  	/*
>  	 * Now execute the controller specific ->bus_init() routine, which
> @@ -1744,10 +1737,33 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
>  
>  	/*
>  	 * Pre-assign dynamic address and retrieve device information if
> -	 * needed.
> +	 * needed. And reserve the init_dyn_addr in case of failure, to retry
> +	 * setting the requested address after DAA is done in
> +	 * i3c_master_add_i3c_dev_locked().
>  	 */
> -	i3c_bus_for_each_i3cdev(&master->bus, i3cdev)
> -		i3c_master_pre_assign_dyn_addr(i3cdev);
> +	list_for_each_entry(i3cboardinfo, &master->boardinfo.i3c, node) {
> +		/*
> +		 * We don't attach devices which are not addressable
> +		 * (no static_addr and dyn_addr) and devices with static_addr
> +		 * but no init_dyn_addr will participate in DAA.
> +		 */

The above comment should be split:

		/*
		 * We don't reserve a dynamic address for devices that
		 * don't explicitly request one.
		 */

> +		if (!i3cboardinfo->init_dyn_addr)
> +			continue;
> +
> +		ret = i3c_bus_get_addr_slot_status(&master->bus,
> +						   i3cboardinfo->init_dyn_addr);
> +		if (ret != I3C_ADDR_SLOT_FREE) {
> +			ret = -EBUSY;
> +			goto err_rstdaa;
> +		}
> +
> +		i3c_bus_set_addr_slot_status(&master->bus,
> +					     i3cboardinfo->init_dyn_addr,
> +					     I3C_ADDR_SLOT_I3C_DEV);
> +
		/*
		 * Only try to create/attach devices that have a static
		 * address. Other devices will be created/attached when
		 * DAA happens, and the requested dynamic address will
		 * be set using SETNEWDA once those devices become
		 * addressable.
		 */
> +		if (i3cboardinfo->static_addr)
> +			i3c_master_early_i3c_dev_add(master, i3cboardinfo);
> +	}
>  
>  	ret = i3c_master_do_daa(master);
>  	if (ret)

