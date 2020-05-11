Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BBFC54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E6782082E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbgEKQiV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730561AbgEKQiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:38:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553D4C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:38:20 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 750D72A07F2;
        Mon, 11 May 2020 17:38:18 +0100 (BST)
Date:   Mon, 11 May 2020 18:38:16 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     <bbrezillon@kernel.org>, <vitor.soares@synopsys.com>,
        <pgaj@cadence.com>, <linux-i3c@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <praneeth@ti.com>
Subject: Re: [PATCH v7 4/7] i3c: master: add mastership handover support
Message-ID: <20200511183816.54e95659@collabora.com>
In-Reply-To: <1589202889-9186-1-git-send-email-pthombar@cadence.com>
References: <1589202702-4879-1-git-send-email-pthombar@cadence.com>
        <1589202889-9186-1-git-send-email-pthombar@cadence.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 May 2020 15:14:49 +0200
Parshuram Thombare <pthombar@cadence.com> wrote:

> Added mastership acquire and yield functions.
> 
> Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
> ---
>  drivers/i3c/master.c       | 187 +++++++++++++++++++++++++++++++++++--
>  include/linux/i3c/master.h |  23 +++++
>  2 files changed, 201 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 669bd7e45810..9c8250a6a2b0 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -16,6 +16,7 @@
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
>  #include <linux/workqueue.h>
> +#include <linux/iopoll.h>
>  
>  #include "internals.h"
>  
> @@ -467,6 +468,79 @@ static const char * const i3c_bus_mode_strings[] = {
>  	[I3C_BUS_MODE_MIXED_SLOW] = "mixed-slow",
>  };
>  
> +static int i3c_master_enable_mr_events(struct i3c_master_controller *master)
> +{
> +	int ret;
> +
> +	master->ops->enable_mr_events(master);
> +	i3c_bus_maintenance_lock(&master->bus);
> +	ret = i3c_master_enec_locked(master, I3C_BROADCAST_ADDR,
> +				     I3C_CCC_EVENT_MR | I3C_CCC_EVENT_HJ);
> +	i3c_bus_maintenance_unlock(&master->bus);
> +
> +	return ret;
> +}
> +
> +static int check_event_da_update(struct i3c_master_controller *m)
> +{
> +	return m->ops->check_event_set(m, I3C_SLV_DA_UPDATE);
> +}
> +
> +static int check_event_mr_done(struct i3c_master_controller *m)
> +{
> +	return m->ops->check_event_set(m, I3C_SLV_MR_DONE);
> +}
> +
> +/**
> + * i3c_master_acquire_bus() - acquire I3C bus mastership
> + * @m: I3C master object
> + *
> + * This function may sleep.
> + * It is expected to be called with normaluse_lock.
> + */
> +static int i3c_master_acquire_bus(struct i3c_master_controller *m)
> +{
> +	int ret = 0;
> +	u32 val;
> +
> +	/*
> +	 * Request mastership needs maintenance(write) lock. So, to avoid
> +	 * deadlock, release normaluse(read) lock, which is expected to be
> +	 * held before calling this function.
> +	 * normaluse(read) lock is expected to be held before calling
> +	 * this function to avoid race with maintenance activities
> +	 * like DEFSLVS processing etc
> +	 */
> +	i3c_bus_normaluse_unlock(&m->bus);
> +	i3c_bus_maintenance_lock(&m->bus);
> +
> +	if (m->this && m->this == m->bus.cur_master) {
> +		i3c_master_disec_locked(m, I3C_BROADCAST_ADDR,
> +					I3C_CCC_EVENT_MR |
> +					I3C_CCC_EVENT_HJ);
> +		goto mr_req_done;
> +	}
> +
> +	ret = readx_poll_timeout(check_event_da_update, m, val,
> +				 val, 100, 1000000);
> +	if (ret)
> +		goto mr_req_done;
> +
> +	ret = m->ops->request_mastership(m);
> +	if (ret)
> +		goto mr_req_done;
> +
> +	ret = readx_poll_timeout(check_event_mr_done, m, val,
> +				 val, 100, 1000000);

Those waits should be done in the master driver. Pass a timeout to
->request_master() or make it a property of the i3c_master_controller
if you like, but don't poll the status from the core.

> +	if (!ret)
> +		m->bus.cur_master = m->this;
> +
> +mr_req_done:
> +	i3c_bus_maintenance_unlock(&m->bus);
> +	i3c_bus_normaluse_lock(&m->bus);

You should downgrade the lock instead of releasing it. I really need to
get my head around this locking scheme because I'm pretty sure we had
good reasons for the locking/unlocking dance Przemek had in his series.

> +	return ret;
> +}
> +
>  static ssize_t mode_show(struct device *dev,
>  			 struct device_attribute *da,
>  			 char *buf)
> @@ -685,6 +759,33 @@ static int i3c_master_send_ccc_cmd_locked(struct i3c_master_controller *master,
>  	return 0;
>  }
>  
> +static int i3c_master_get_accmst_locked(struct i3c_master_controller *master,
> +					u8 addr)
> +{
> +	struct i3c_ccc_getaccmst *accmst;
> +	struct i3c_ccc_cmd_dest dest;
> +	struct i3c_ccc_cmd cmd;
> +	int ret;
> +
> +	accmst = i3c_ccc_cmd_dest_init(&dest, addr, sizeof(*accmst));
> +	if (!accmst)
> +		return -ENOMEM;
> +
> +	i3c_ccc_cmd_init(&cmd, true, I3C_CCC_GETACCMST, &dest, 1);
> +
> +	ret = i3c_master_send_ccc_cmd_locked(master, &cmd);
> +	if (ret)
> +		goto out;
> +
> +	if (dest.payload.len != sizeof(*accmst))
> +		ret = -EIO;
> +
> +out:
> +	i3c_ccc_cmd_dest_cleanup(&dest);
> +
> +	return ret;
> +}
> +
>  static struct i2c_dev_desc *
>  i3c_master_find_i2c_dev_by_addr(const struct i3c_master_controller *master,
>  				u16 addr)
> @@ -1558,10 +1659,6 @@ int i3c_master_set_info(struct i3c_master_controller *master,
>  	if (!i3c_bus_dev_addr_is_avail(&master->bus, info->dyn_addr))
>  		return -EINVAL;
>  
> -	if (I3C_BCR_DEVICE_ROLE(info->bcr) == I3C_BCR_I3C_MASTER &&
> -	    master->secondary)
> -		return -EINVAL;
> -
>  	if (master->this)
>  		return -EINVAL;
>  
> @@ -1570,7 +1667,9 @@ int i3c_master_set_info(struct i3c_master_controller *master,
>  		return PTR_ERR(i3cdev);
>  
>  	master->this = i3cdev;
> -	master->bus.cur_master = master->this;
> +
> +	if (!master->secondary)
> +		master->bus.cur_master = master->this;

This change doesn't seem related to this patch. Looks like this should
instead go to patch 3.

>  
>  	ret = i3c_master_attach_i3c_dev(master, i3cdev);
>  	if (ret)
> @@ -1612,6 +1711,73 @@ static void i3c_master_detach_free_devs(struct i3c_master_controller *master)
>  	}
>  }
>  
> +/**
> + * i3c_master_yield_bus() - yield I3C bus mastership
> + * @m: I3C master object
> + * @sec_mst_dyn_addr: address of device requesting mastership
> + *
> + * This function may sleep.
> + * It is expected to be called with normaluse_lock.
> + */
> +void
> +i3c_master_yield_bus(struct i3c_master_controller *m, u8 sec_mst_dyn_addr)
> +{
> +	struct i3c_dev_desc *i3cdev;
> +	int ret = 0;
> +
> +	i3c_bus_maintenance_lock(&m->bus);
> +	if (m->this != m->bus.cur_master)
> +		goto mr_yield_done;
> +
> +	/*
> +	 * Maintenance lock and master check above is used to
> +	 * avoid race amongst devices sending MR requests
> +	 * at the same time, as soon as ENEC MST is sent by the current
> +	 * master. It ensure that only one MR request is processed,
> +	 * rest MR requests on losing devices will timeout in wait MR
> +	 * DONE state. And next MR requests are blocked due to DISEC MST
> +	 * sent by current master in yield operation.
> +	 * New master should send ENEC MST once it's work is done.
> +	 * maintainanace lock is also needed for i3c_master_get_accmst_locked.
> +	 */
> +
> +	ret = i3c_master_disec_locked(m, I3C_BROADCAST_ADDR,
> +				      I3C_CCC_EVENT_MR |
> +				      I3C_CCC_EVENT_HJ);

Isn't it taken care of at the controller level? I'm fine sending it
here, but I suspect some controllers might actually auto-disable MRs
once they receive one.

> +	/*
> +	 * Once mastership is given to the new master, it is expected that
> +	 * MR is disabled prior to that and new master is responsible to
> +	 * enable it by broadcasting ENEC MR when it's work is done.
> +	 * If DISEC MR fails and we still go ahead with handover, chances
> +	 * are new master will get interrupted by unexpected MR requests.
> +	 */
> +	if (ret)
> +		goto mr_yield_done;
> +
> +	ret = i3c_master_get_accmst_locked(m, sec_mst_dyn_addr);
> +	if (ret)
> +		goto mr_yield_done;
> +
> +	i3c_bus_for_each_i3cdev(&m->bus, i3cdev) {
> +		if (sec_mst_dyn_addr == i3cdev->info.dyn_addr) {
> +			m->bus.cur_master = i3cdev;
> +			break;
> +		}
> +	}
> +
> +	/* Requesting device not found on i3c list. This should never happen. */
> +	if (m->this == m->bus.cur_master) {

	if (WARN_ON(m->this == m->bus.cur_master)) {

And you should probably check that before send DISEC.

> +		ret = -EAGAIN;
> +		WARN_ON(1);
> +	}
> +
> +mr_yield_done:
> +	i3c_bus_maintenance_unlock(&m->bus);
> +	if (ret)
> +		i3c_master_enable_mr_events(m);
> +}
> +EXPORT_SYMBOL_GPL(i3c_master_yield_bus);
> +
>  /**
>   * i3c_master_bus_init() - initialize an I3C bus
>   * @master: main master initializing the bus
> @@ -2472,6 +2638,10 @@ static int i3c_master_check_ops(const struct i3c_master_controller_ops *ops)
>  	     !ops->recycle_ibi_slot))
>  		return -EINVAL;
>  
> +	if (ops->request_mastership &&
> +	    (!ops->enable_mr_events || !ops->check_event_set))
> +		return -EINVAL;
> +
>  	return 0;
>  }
>  
> @@ -2485,10 +2655,6 @@ static int i3c_master_init(struct i3c_master_controller *master,
>  	struct i2c_dev_boardinfo *i2cbi;
>  	int ret;
>  
> -	/* We do not support secondary masters yet. */
> -	if (secondary)
> -		return -ENOTSUPP;
> -
>  	ret = i3c_master_check_ops(ops);
>  	if (ret)
>  		return ret;
> @@ -2608,6 +2774,9 @@ int i3c_master_register(struct i3c_master_controller *master,
>  	i3c_master_register_new_i3c_devs(master);
>  	i3c_bus_normaluse_unlock(&master->bus);
>  
> +	if (ops->request_mastership)
> +		ret = i3c_master_enable_mr_events(master);
> +
>  	return 0;
>  
>  err_del_dev:
> diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
> index 5124ff4831eb..dd67497ad8b1 100644
> --- a/include/linux/i3c/master.h
> +++ b/include/linux/i3c/master.h
> @@ -259,6 +259,16 @@ enum i3c_bus_mode {
>  	I3C_BUS_MODE_MIXED_SLOW,
>  };
>  
> +/**
> + * enum i3c_event - I3C master (currently acting as a slave) controller events
> + * @I3C_SLV_DA_UPDATE: I3C master has dynamic address
> + * @I3C_SLV_MR_DONE: I3C mastership request completed successfully
> + */
> +enum i3c_event {
> +	I3C_SLV_DA_UPDATE,
> +	I3C_SLV_MR_DONE,
> +};
> +
>  /**
>   * enum i3c_addr_slot_status - I3C address slot status
>   * @I3C_ADDR_SLOT_FREE: address is free
> @@ -418,6 +428,12 @@ struct i3c_bus {
>   *		      for a future IBI
>   *		      This method is mandatory only if ->request_ibi is not
>   *		      NULL.
> + * @request_mastership: send mastership request to the current master
> + * @enable_mr_events: enable mastership request handling by the controller
> + * @check_event_set: check events (enum i3c_event) such as device has dynamic
> + *		     address, mastership request is completed successfully.
> + * @sec_mst_dyn_addr: read current dynamic address of the I3C device from
> + *		      hardware.
>   */
>  struct i3c_master_controller_ops {
>  	int (*bus_init)(struct i3c_master_controller *master);
> @@ -445,6 +461,11 @@ struct i3c_master_controller_ops {
>  	int (*disable_ibi)(struct i3c_dev_desc *dev);
>  	void (*recycle_ibi_slot)(struct i3c_dev_desc *dev,
>  				 struct i3c_ibi_slot *slot);
> +	int (*request_mastership)(struct i3c_master_controller *master);
> +	void (*enable_mr_events)(struct i3c_master_controller *m);

Those 2 helper sound good.

> +	bool (*check_event_set)(struct i3c_master_controller *m,
> +				enum i3c_event);
> +	int (*sec_mst_dyn_addr)(struct i3c_master_controller *m);

I feel like this is HW-specific. I would just hide that in the driver
mastership-handover/DA-assignment handling. If we see enough
similarities in how other hardware handle those sequences we might want
to revise that, but I think it's a bit premature.

>  };
>  
>  /**
> @@ -510,6 +531,8 @@ struct i3c_master_controller {
>  #define i3c_bus_for_each_i3cdev(bus, dev)				\
>  	list_for_each_entry(dev, &(bus)->devs.i3c, common.node)
>  
> +void i3c_master_yield_bus(struct i3c_master_controller *m,
> +			  u8 sec_mst_dyn_addr);
>  int i3c_master_do_i2c_xfers(struct i3c_master_controller *master,
>  			    const struct i2c_msg *xfers,
>  			    int nxfers);

