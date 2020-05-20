Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A27BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0DF02075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgETI7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETI7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:59:00 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FCFC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 01:59:00 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:b93f:9fae:b276:a89a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E4E5B2A29CA;
        Wed, 20 May 2020 09:58:58 +0100 (BST)
Date:   Wed, 20 May 2020 10:58:55 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>,
        mparab@cadence.com, praneeth@ti.com, linux-kernel@vger.kernel.org,
        pgaj@cadence.com, linux-i3c@lists.infradead.org
Subject: Re: [PATCH] i3c: master: fix for SETDASA and DAA process
Message-ID: <20200520105855.71db98d1@collabora.com>
In-Reply-To: <1589473809-16708-1-git-send-email-pthombar@cadence.com>
References: <1589473809-16708-1-git-send-email-pthombar@cadence.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 May 2020 18:30:09 +0200
Parshuram Thombare <pthombar@cadence.com> wrote:

> This patch fix following issues.
> 1. Controller slots blocked for devices with static_addr
>    but no init_dyn_addr may limit the number of I3C devices
>    on the bus which gets dynamic address in DAA. So
>    instead of attaching all the devices with static_addr,
>    now we only attach the devices which successfully
>    complete SETDASA. Remaining devices are handled in DAA.
> 2. Since we alreay handled devices with init_dyn_addr, removed
>    it's handling from i3c_master_add_i3c_dev_locked().
>    Now only case handled is devices already with dyn_addr
>    participated in DAA, and again got new dyn_addr with an
>    extra slot in the master controller.

I don't get that one.

> 3. Removed unnecessary i3c_master_reattach_i3c_dev() from
>    i3c_master_add_i3c_dev_locked(), right away after finding
>    if duplicate device exists in the I3C list.
>    In case of different new and old dyn_addr
>    i3c_master_reattach_i3c_dev() will fail which is wrong,
>    and in case of same dyn_addr it doesn't add anything new.

I think we should fix re-attach instead, which is what we discussed
with Przemek if I remember correctly.

> 

Can you please split the patch accordingly (one fix per commit)?

> Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  drivers/i3c/master.c | 111 ++++++++++++++++++-------------------------
>  1 file changed, 46 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 5f4bd52121fe..f1d929b58549 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -1375,6 +1375,11 @@ static int i3c_master_reattach_i3c_dev(struct i3c_dev_desc *dev,
>  		i3c_bus_set_addr_slot_status(&master->bus,
>  					     dev->info.dyn_addr,
>  					     I3C_ADDR_SLOT_I3C_DEV);
> +
> +		if (old_dyn_addr)
> +			i3c_bus_set_addr_slot_status(&master->bus,
> +						     old_dyn_addr,
> +						     I3C_ADDR_SLOT_FREE);
>  	}
>  
>  	if (master->ops->reattach_i3c_dev) {
> @@ -1426,33 +1431,52 @@ static void i3c_master_detach_i2c_dev(struct i2c_dev_desc *dev)
>  		master->ops->detach_i2c_dev(dev);
>  }
>  
> -static void i3c_master_pre_assign_dyn_addr(struct i3c_dev_desc *dev)
> +static void i3c_master_pre_assign_dyn_addr(struct i3c_master_controller *master,
> +					   struct i3c_dev_boardinfo *boardinfo)
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
> +	/*
> +	 * We anyway don't attach devices which are not addressable
> +	 * (no static_addr and dyn_addr) and devices with static_addr
> +	 * but no init_dyn_addr will participate in DAA.
> +	 */
> +	if (!boardinfo->static_addr || !boardinfo->init_dyn_addr)
> +		return;
> +
> +	i3cdev = i3c_master_alloc_i3c_dev(master, &info);
> +	if (IS_ERR(i3cdev))
>  		return;
>  
> -	ret = i3c_master_setdasa_locked(master, dev->info.static_addr,
> -					dev->boardinfo->init_dyn_addr);
> +	i3cdev->boardinfo = boardinfo;
> +
> +	ret = i3c_master_attach_i3c_dev(master, i3cdev);
>  	if (ret)
>  		return;
>  
> -	dev->info.dyn_addr = dev->boardinfo->init_dyn_addr;
> -	ret = i3c_master_reattach_i3c_dev(dev, 0);
> +	ret = i3c_master_setdasa_locked(master, i3cdev->info.static_addr,
> +					i3cdev->boardinfo->init_dyn_addr);
>  	if (ret)
> -		goto err_rstdaa;
> +		goto err_setdasa;
>  
> -	ret = i3c_master_retrieve_dev_info(dev);
> +	i3cdev->info.dyn_addr = i3cdev->boardinfo->init_dyn_addr;
> +	ret = i3c_master_reattach_i3c_dev(i3cdev, 0);
>  	if (ret)
>  		goto err_rstdaa;
>  
> -	return;
> +	ret = i3c_master_retrieve_dev_info(i3cdev);
> +	if (ret)
> +		goto err_rstdaa;
>  
>  err_rstdaa:
> -	i3c_master_rstdaa_locked(master, dev->boardinfo->init_dyn_addr);
> +	i3c_master_rstdaa_locked(master, i3cdev->boardinfo->init_dyn_addr);
> +err_setdasa:
> +	i3c_master_detach_i3c_dev(i3cdev);
> +	i3c_master_free_i3c_dev(i3cdev);
>  }
>  
>  static void
> @@ -1619,8 +1643,8 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
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
> @@ -1647,7 +1671,6 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
>  	enum i3c_addr_slot_status status;
>  	struct i2c_dev_boardinfo *i2cboardinfo;
>  	struct i3c_dev_boardinfo *i3cboardinfo;
> -	struct i3c_dev_desc *i3cdev;
>  	struct i2c_dev_desc *i2cdev;
>  	int ret;
>  
> @@ -1679,34 +1702,6 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
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
> @@ -1746,8 +1741,8 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
>  	 * Pre-assign dynamic address and retrieve device information if
>  	 * needed.
>  	 */
> -	i3c_bus_for_each_i3cdev(&master->bus, i3cdev)
> -		i3c_master_pre_assign_dyn_addr(i3cdev);
> +	list_for_each_entry(i3cboardinfo, &master->boardinfo.i3c, node)
> +		i3c_master_pre_assign_dyn_addr(master, i3cboardinfo);
>  
>  	ret = i3c_master_do_daa(master);
>  	if (ret)
> @@ -1811,7 +1806,7 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
>  {
>  	struct i3c_device_info info = { .dyn_addr = addr };
>  	struct i3c_dev_desc *newdev, *olddev;
> -	u8 old_dyn_addr = addr, expected_dyn_addr;
> +	u8 old_dyn_addr = addr;
>  	struct i3c_ibi_setup ibireq = { };
>  	bool enable_ibi = false;
>  	int ret;
> @@ -1866,39 +1861,25 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
>  		i3c_master_free_i3c_dev(olddev);
>  	}
>  
> -	ret = i3c_master_reattach_i3c_dev(newdev, old_dyn_addr);
> -	if (ret)
> -		goto err_detach_dev;
> -
>  	/*
>  	 * Depending on our previous state, the expected dynamic address might
>  	 * differ:
>  	 * - if the device already had a dynamic address assigned, let's try to
> -	 *   re-apply this one
> -	 * - if the device did not have a dynamic address and the firmware
> -	 *   requested a specific address, pick this one
> +	 *   re-apply this one. Device with dyn_addr participated in DAA ?
>  	 * - in any other case, keep the address automatically assigned by the
>  	 *   master
>  	 */
> -	if (old_dyn_addr && old_dyn_addr != newdev->info.dyn_addr)
> -		expected_dyn_addr = old_dyn_addr;
> -	else if (newdev->boardinfo && newdev->boardinfo->init_dyn_addr)
> -		expected_dyn_addr = newdev->boardinfo->init_dyn_addr;
> -	else
> -		expected_dyn_addr = newdev->info.dyn_addr;
> -
> -	if (newdev->info.dyn_addr != expected_dyn_addr) {
> +	if (old_dyn_addr && old_dyn_addr != newdev->info.dyn_addr) {
>  		/*
>  		 * Try to apply the expected dynamic address. If it fails, keep
>  		 * the address assigned by the master.
>  		 */
>  		ret = i3c_master_setnewda_locked(master,
>  						 newdev->info.dyn_addr,
> -						 expected_dyn_addr);
> +						 old_dyn_addr);
>  		if (!ret) {
> -			old_dyn_addr = newdev->info.dyn_addr;
> -			newdev->info.dyn_addr = expected_dyn_addr;
> -			i3c_master_reattach_i3c_dev(newdev, old_dyn_addr);
> +			newdev->info.dyn_addr = old_dyn_addr;
> +			i3c_master_reattach_i3c_dev(newdev, addr);
>  		} else {
>  			dev_err(&master->dev,
>  				"Failed to assign reserved/old address to device %d%llx",

