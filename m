Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AF8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 734812076B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 06:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FExtYevT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgHKGYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 02:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgHKGYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:24:48 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34EEC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:24:47 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m8so7050131pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 23:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LsoMRioXZdnHA7LWOKjQoUr8rF3m3/FD0Wsolg0ec24=;
        b=FExtYevT+Odkcz8sRYEnceUtLa2xir5kP/ZTEh+p8P8FJadQIcfn53ktmrDGNcRTW3
         XRQY1YsYXTjkIJTcSD4g6p5CfRfbWegrUECy2owTyGX0A25JSUQa0gk/tbTwvDn+8D2l
         EMpXC6h4EdRFRwQruFJMvwuftzAzi6Uqj7p3509GyTCQ9i54Ae4RzcPzpNT/NauiO3Kd
         GHeLZyywbdQba0PF42OqSNXtXFHbBJ1hUwdvbX0q6/BdZuYjv5OBIFFWu376m7HnkdFq
         QdtN+2PJPDihmCekwnUmUXqPy4auUoOyL40F2ONdSMJrZgDyqykuRdwpHXRYESUiiMVy
         KjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LsoMRioXZdnHA7LWOKjQoUr8rF3m3/FD0Wsolg0ec24=;
        b=ucFE8I/O4t3JLsApzFj5Ae0xYTTGO2HChdEsijf6hzmr3H0+l+lwomWKU7tkXBvy5C
         xbFaajCXRrJo8wmVnSe5smkHVc0idJL+/gLJMgemVCFOjXwGj7AFJ9SOm30Wcm8+17TR
         4qPZLqBDFJDZ0n6k8ldt9AYIReUoLGc3LInM4YZ+JE8BWHIvyXQpFJe0V5Fhbr4bj6Gc
         ooHoDvY1n9rV4YOih3cio5RDfTssaSLHrjEy+FxmV5daITm7fE+jBOfLGGt1XhIinraq
         WWLD7U6ABmz1zLhH89JOMULg6Qqwl2zkaYQB968sP0cvpDdFzuDuwfLkzWQdG+eO+o3M
         l4fw==
X-Gm-Message-State: AOAM531lcH6JR/pbei0lT5rrwUxa3gm+qopZoTI697GJldVA0h+3pp72
        RCGaKJdXwTol78eeGuGEJ7Zl
X-Google-Smtp-Source: ABdhPJzoMWipffye/Hbm52HPqhGegi5rh3nn5BFeGhgDTSxpi2jq+nh7FpT+XL5UJsMBzwvMAqIh6A==
X-Received: by 2002:a65:6089:: with SMTP id t9mr25336367pgu.236.1597127086862;
        Mon, 10 Aug 2020 23:24:46 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:699:2bc7:b9eb:9a30:bf89:3f3d])
        by smtp.gmail.com with ESMTPSA id n3sm23640449pfq.131.2020.08.10.23.24.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Aug 2020 23:24:46 -0700 (PDT)
Date:   Tue, 11 Aug 2020 11:54:39 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/11] bus: mhi: core: Introduce debugfs entries for
 MHI
Message-ID: <20200811062439.GC2762@Mani-XPS-13-9360>
References: <1597096865-19636-1-git-send-email-bbhatt@codeaurora.org>
 <1597096865-19636-9-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597096865-19636-9-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 03:01:02PM -0700, Bhaumik Bhatt wrote:
> Introduce debugfs entries to show state, register, channel, device,
> and event rings information. Allow the host to dump registers,
> issue device wake, and change the MHI timeout to help in debug.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/Kconfig         |   8 +
>  drivers/bus/mhi/core/Makefile   |   5 +-
>  drivers/bus/mhi/core/debugfs.c  | 409 ++++++++++++++++++++++++++++++++++++++++
>  drivers/bus/mhi/core/init.c     |   7 +
>  drivers/bus/mhi/core/internal.h |  24 +++
>  include/linux/mhi.h             |   2 +
>  6 files changed, 452 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/bus/mhi/core/debugfs.c
> 
> diff --git a/drivers/bus/mhi/Kconfig b/drivers/bus/mhi/Kconfig
> index a8bd9bd..6a217ff 100644
> --- a/drivers/bus/mhi/Kconfig
> +++ b/drivers/bus/mhi/Kconfig
> @@ -12,3 +12,11 @@ config MHI_BUS
>  	 communication protocol used by the host processors to control
>  	 and communicate with modem devices over a high speed peripheral
>  	 bus or shared memory.
> +
> +config MHI_BUS_DEBUG
> +	bool "Debugfs support for the MHI bus"
> +	depends on MHI_BUS && DEBUG_FS
> +	help
> +	 Enable debugfs support for use with the MHI transport. Allows
> +	 reading and/or modifying some values within the MHI controller
> +	 for debug and test purposes.
> diff --git a/drivers/bus/mhi/core/Makefile b/drivers/bus/mhi/core/Makefile
> index 66e2700..460a548 100644
> --- a/drivers/bus/mhi/core/Makefile
> +++ b/drivers/bus/mhi/core/Makefile
> @@ -1,3 +1,2 @@
> -obj-$(CONFIG_MHI_BUS) := mhi.o
> -
> -mhi-y := init.o main.o pm.o boot.o
> +obj-$(CONFIG_MHI_BUS) := init.o main.o pm.o boot.o
> +obj-$(CONFIG_MHI_BUS_DEBUG) += debugfs.o
> diff --git a/drivers/bus/mhi/core/debugfs.c b/drivers/bus/mhi/core/debugfs.c
> new file mode 100644
> index 0000000..a249aa6
> --- /dev/null
> +++ b/drivers/bus/mhi/core/debugfs.c
> @@ -0,0 +1,409 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
> + *
> + */
> +
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/list.h>
> +#include <linux/mhi.h>
> +#include "internal.h"
> +
> +static int mhi_debugfs_states_show(struct seq_file *m, void *d)
> +{
> +	struct mhi_controller *mhi_cntrl = m->private;
> +
> +	/* states */
> +	seq_printf(m, "PM state: %s Device: %s MHI state: %s EE: %s wake: %s\n",
> +		   to_mhi_pm_state_str(mhi_cntrl->pm_state),
> +		   mhi_is_active(mhi_cntrl) ? "Active" : "Inactive",
> +		   TO_MHI_STATE_STR(mhi_cntrl->dev_state),
> +		   TO_MHI_EXEC_STR(mhi_cntrl->ee),
> +		   mhi_cntrl->wake_set ? "true" : "false");
> +
> +	/* counters */
> +	seq_printf(m, "M0: %u M2: %u M3: %u", mhi_cntrl->M0, mhi_cntrl->M2,
> +		   mhi_cntrl->M3);
> +
> +	seq_printf(m, " device wake: %u pending packets: %u\n",
> +		   atomic_read(&mhi_cntrl->dev_wake),
> +		   atomic_read(&mhi_cntrl->pending_pkts));
> +
> +	return 0;
> +}
> +
> +static int mhi_debugfs_events_show(struct seq_file *m, void *d)
> +{
> +	struct mhi_controller *mhi_cntrl = m->private;
> +	struct mhi_event *mhi_event;
> +	struct mhi_event_ctxt *er_ctxt;
> +	int i;
> +
> +	if (!mhi_is_active(mhi_cntrl)) {
> +		seq_puts(m, "Device not ready\n");
> +		return -ENODEV;
> +	}
> +
> +	er_ctxt = mhi_cntrl->mhi_ctxt->er_ctxt;
> +	mhi_event = mhi_cntrl->mhi_event;
> +	for (i = 0; i < mhi_cntrl->total_ev_rings;
> +						i++, er_ctxt++, mhi_event++) {
> +		struct mhi_ring *ring = &mhi_event->ring;
> +
> +		if (mhi_event->offload_ev) {
> +			seq_printf(m, "Index: %d is an offload event ring\n",
> +				   i);
> +			continue;
> +		}
> +
> +		seq_printf(m, "Index: %d intmod count: %lu time: %lu",
> +			   i, (er_ctxt->intmod & EV_CTX_INTMODC_MASK) >>
> +			   EV_CTX_INTMODC_SHIFT,
> +			   (er_ctxt->intmod & EV_CTX_INTMODT_MASK) >>
> +			   EV_CTX_INTMODT_SHIFT);
> +
> +		seq_printf(m, " base: 0x%0llx len: 0x%llx", er_ctxt->rbase,
> +			   er_ctxt->rlen);
> +
> +		seq_printf(m, " rp: 0x%llx wp: 0x%llx", er_ctxt->rp,
> +			   er_ctxt->wp);
> +
> +		seq_printf(m, " local rp: 0x%llx db: 0x%llx\n", (u64)ring->rp,
> +			   mhi_event->db_cfg.db_val);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mhi_debugfs_channels_show(struct seq_file *m, void *d)
> +{
> +	struct mhi_controller *mhi_cntrl = m->private;
> +	struct mhi_chan *mhi_chan;
> +	struct mhi_chan_ctxt *chan_ctxt;
> +	int i;
> +
> +	if (!mhi_is_active(mhi_cntrl)) {
> +		seq_puts(m, "Device not ready\n");
> +		return -ENODEV;
> +	}
> +
> +	mhi_chan = mhi_cntrl->mhi_chan;
> +	chan_ctxt = mhi_cntrl->mhi_ctxt->chan_ctxt;
> +	for (i = 0; i < mhi_cntrl->max_chan; i++, chan_ctxt++, mhi_chan++) {
> +		struct mhi_ring *ring = &mhi_chan->tre_ring;
> +
> +		if (mhi_chan->offload_ch) {
> +			seq_printf(m, "%s(%u) is an offload channel\n",
> +				   mhi_chan->name, mhi_chan->chan);
> +			continue;
> +		}
> +
> +		if (!mhi_chan->mhi_dev)
> +			continue;
> +
> +		seq_printf(m,
> +			   "%s(%u) state: 0x%lx brstmode: 0x%lx pollcfg: 0x%lx",
> +			   mhi_chan->name, mhi_chan->chan, (chan_ctxt->chcfg &
> +			   CHAN_CTX_CHSTATE_MASK) >> CHAN_CTX_CHSTATE_SHIFT,
> +			   (chan_ctxt->chcfg & CHAN_CTX_BRSTMODE_MASK) >>
> +			   CHAN_CTX_BRSTMODE_SHIFT, (chan_ctxt->chcfg &
> +			   CHAN_CTX_POLLCFG_MASK) >> CHAN_CTX_POLLCFG_SHIFT);
> +
> +		seq_printf(m, " type: 0x%x event ring: %u", chan_ctxt->chtype,
> +			   chan_ctxt->erindex);
> +
> +		seq_printf(m, " base: 0x%llx len: 0x%llx wp: 0x%llx",
> +			   chan_ctxt->rbase, chan_ctxt->rlen, chan_ctxt->wp);
> +
> +		seq_printf(m, " local rp: 0x%llx local wp: 0x%llx db: 0x%llx\n",
> +			   (u64)ring->rp, (u64)ring->wp,
> +			   mhi_chan->db_cfg.db_val);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mhi_device_info_show(struct device *dev, void *data)
> +{
> +	struct mhi_device *mhi_dev;
> +
> +	if (dev->bus != &mhi_bus_type)
> +		return 0;
> +
> +	mhi_dev = to_mhi_device(dev);
> +
> +	seq_printf((struct seq_file *)data, "%s: type: %s dev_wake: %u",
> +		   mhi_dev->name, mhi_dev->dev_type ? "Controller" : "Transfer",
> +		   mhi_dev->dev_wake);
> +
> +	/* for transfer device types only */
> +	if (mhi_dev->dev_type == MHI_DEVICE_XFER)
> +		seq_printf((struct seq_file *)data, " channels: %u(UL)/%u(DL)",
> +			   mhi_dev->ul_chan_id, mhi_dev->dl_chan_id);
> +
> +	seq_puts((struct seq_file *)data, "\n");
> +
> +	return 0;
> +}
> +
> +static int mhi_debugfs_devices_show(struct seq_file *m, void *d)
> +{
> +	struct mhi_controller *mhi_cntrl = m->private;
> +
> +	if (!mhi_is_active(mhi_cntrl)) {
> +		seq_puts(m, "Device not ready\n");
> +		return -ENODEV;
> +	}
> +
> +	device_for_each_child(mhi_cntrl->cntrl_dev, m, mhi_device_info_show);
> +
> +	return 0;
> +}
> +
> +static int mhi_debugfs_regdump_show(struct seq_file *m, void *d)
> +{
> +	struct mhi_controller *mhi_cntrl = m->private;
> +	enum mhi_state state;
> +	enum mhi_ee_type ee;
> +	int i, ret = -EIO;
> +	u32 val;
> +	void __iomem *mhi_base = mhi_cntrl->regs;
> +	void __iomem *bhi_base = mhi_cntrl->bhi;
> +	void __iomem *bhie_base = mhi_cntrl->bhie;
> +	void __iomem *wake_db = mhi_cntrl->wake_db;
> +	struct {
> +		const char *name;
> +		int offset;
> +		void __iomem *base;
> +	} regs[] = {
> +		{ "MHI_REGLEN", MHIREGLEN, mhi_base},
> +		{ "MHI_VER", MHIVER, mhi_base},
> +		{ "MHI_CFG", MHICFG, mhi_base},
> +		{ "MHI_CTRL", MHICTRL, mhi_base},
> +		{ "MHI_STATUS", MHISTATUS, mhi_base},
> +		{ "MHI_WAKE_DB", 0, wake_db},
> +		{ "BHI_EXECENV", BHI_EXECENV, bhi_base},
> +		{ "BHI_STATUS", BHI_STATUS, bhi_base},
> +		{ "BHI_ERRCODE", BHI_ERRCODE, bhi_base},
> +		{ "BHI_ERRDBG1", BHI_ERRDBG1, bhi_base},
> +		{ "BHI_ERRDBG2", BHI_ERRDBG2, bhi_base},
> +		{ "BHI_ERRDBG3", BHI_ERRDBG3, bhi_base},
> +		{ "BHIE_TXVEC_DB", BHIE_TXVECDB_OFFS, bhie_base},
> +		{ "BHIE_TXVEC_STATUS", BHIE_TXVECSTATUS_OFFS, bhie_base},
> +		{ "BHIE_RXVEC_DB", BHIE_RXVECDB_OFFS, bhie_base},
> +		{ "BHIE_RXVEC_STATUS", BHIE_RXVECSTATUS_OFFS, bhie_base},
> +		{ NULL },
> +	};
> +
> +	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state))
> +		return ret;
> +
> +	seq_printf(m, "Host PM state: %s Device state: %s EE: %s\n",
> +		   to_mhi_pm_state_str(mhi_cntrl->pm_state),
> +		   TO_MHI_STATE_STR(mhi_cntrl->dev_state),
> +		   TO_MHI_EXEC_STR(mhi_cntrl->ee));
> +
> +	state = mhi_get_mhi_state(mhi_cntrl);
> +	ee = mhi_get_exec_env(mhi_cntrl);
> +	seq_printf(m, "Device EE: %s state: %s\n", TO_MHI_EXEC_STR(ee),
> +		   TO_MHI_STATE_STR(state));
> +
> +	for (i = 0; regs[i].name; i++) {
> +		if (!regs[i].base)
> +			continue;
> +		ret = mhi_read_reg(mhi_cntrl, regs[i].base, regs[i].offset,
> +				   &val);
> +		if (ret)
> +			continue;
> +
> +		seq_printf(m, "%s: 0x%x\n", regs[i].name, val);
> +	}
> +
> +	return 0;
> +}
> +
> +static int mhi_debugfs_device_wake_show(struct seq_file *m, void *d)
> +{
> +	struct mhi_controller *mhi_cntrl = m->private;
> +	struct mhi_device *mhi_dev = mhi_cntrl->mhi_dev;
> +
> +	if (!mhi_is_active(mhi_cntrl)) {
> +		seq_puts(m, "Device not ready\n");
> +		return -ENODEV;
> +	}
> +
> +	seq_printf(m,
> +		   "Wake count: %d\n%s\n", mhi_dev->dev_wake,
> +		   "Usage: echo get/put > device_wake to vote/unvote for M0");
> +
> +	return 0;
> +}
> +
> +static ssize_t mhi_debugfs_device_wake_write(struct file *file,
> +					     const char __user *ubuf,
> +					     size_t count, loff_t *ppos)
> +{
> +	struct seq_file	*m = file->private_data;
> +	struct mhi_controller *mhi_cntrl = m->private;
> +	struct mhi_device *mhi_dev = mhi_cntrl->mhi_dev;
> +	char buf[16];
> +	int ret = -EINVAL;
> +
> +	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
> +		return -EFAULT;
> +
> +	if (!strncmp(buf, "get", 3)) {
> +		ret = mhi_device_get_sync(mhi_dev);
> +	} else if (!strncmp(buf, "put", 3)) {
> +		mhi_device_put(mhi_dev);
> +		ret = 0;
> +	}
> +
> +	return ret ? ret : count;
> +}
> +
> +static int mhi_debugfs_timeout_ms_show(struct seq_file *m, void *d)
> +{
> +	struct mhi_controller *mhi_cntrl = m->private;
> +
> +	seq_printf(m, "%u ms\n", mhi_cntrl->timeout_ms);
> +
> +	return 0;
> +}
> +
> +static ssize_t mhi_debugfs_timeout_ms_write(struct file *file,
> +					    const char __user *ubuf,
> +					    size_t count, loff_t *ppos)
> +{
> +	struct seq_file	*m = file->private_data;
> +	struct mhi_controller *mhi_cntrl = m->private;
> +	u32 timeout_ms;
> +
> +	if (kstrtou32_from_user(ubuf, count, 0, &timeout_ms))
> +		return -EINVAL;
> +
> +	mhi_cntrl->timeout_ms = timeout_ms;
> +
> +	return count;
> +}
> +
> +static int mhi_debugfs_states_open(struct inode *inode, struct file *fp)
> +{
> +	return single_open(fp, mhi_debugfs_states_show, inode->i_private);
> +}
> +
> +static int mhi_debugfs_events_open(struct inode *inode, struct file *fp)
> +{
> +	return single_open(fp, mhi_debugfs_events_show, inode->i_private);
> +}
> +
> +static int mhi_debugfs_channels_open(struct inode *inode, struct file *fp)
> +{
> +	return single_open(fp, mhi_debugfs_channels_show, inode->i_private);
> +}
> +
> +static int mhi_debugfs_devices_open(struct inode *inode, struct file *fp)
> +{
> +	return single_open(fp, mhi_debugfs_devices_show, inode->i_private);
> +}
> +
> +static int mhi_debugfs_regdump_open(struct inode *inode, struct file *fp)
> +{
> +	return single_open(fp, mhi_debugfs_regdump_show, inode->i_private);
> +}
> +
> +static int mhi_debugfs_device_wake_open(struct inode *inode, struct file *fp)
> +{
> +	return single_open(fp, mhi_debugfs_device_wake_show, inode->i_private);
> +}
> +
> +static int mhi_debugfs_timeout_ms_open(struct inode *inode, struct file *fp)
> +{
> +	return single_open(fp, mhi_debugfs_timeout_ms_show, inode->i_private);
> +}
> +
> +static const struct file_operations debugfs_states_fops = {
> +	.open = mhi_debugfs_states_open,
> +	.release = single_release,
> +	.read = seq_read,
> +};
> +
> +static const struct file_operations debugfs_events_fops = {
> +	.open = mhi_debugfs_events_open,
> +	.release = single_release,
> +	.read = seq_read,
> +};
> +
> +static const struct file_operations debugfs_channels_fops = {
> +	.open = mhi_debugfs_channels_open,
> +	.release = single_release,
> +	.read = seq_read,
> +};
> +
> +static const struct file_operations debugfs_devices_fops = {
> +	.open = mhi_debugfs_devices_open,
> +	.release = single_release,
> +	.read = seq_read,
> +};
> +
> +static const struct file_operations debugfs_regdump_fops = {
> +	.open = mhi_debugfs_regdump_open,
> +	.release = single_release,
> +	.read = seq_read,
> +};
> +
> +static const struct file_operations debugfs_device_wake_fops = {
> +	.open = mhi_debugfs_device_wake_open,
> +	.write = mhi_debugfs_device_wake_write,
> +	.release = single_release,
> +	.read = seq_read,
> +};
> +
> +static const struct file_operations debugfs_timeout_ms_fops = {
> +	.open = mhi_debugfs_timeout_ms_open,
> +	.write = mhi_debugfs_timeout_ms_write,
> +	.release = single_release,
> +	.read = seq_read,
> +};
> +
> +static struct dentry *mhi_debugfs_root;
> +
> +void mhi_create_debugfs(struct mhi_controller *mhi_cntrl)
> +{
> +	mhi_cntrl->debugfs_dentry =
> +			debugfs_create_dir(dev_name(mhi_cntrl->cntrl_dev),
> +					   mhi_debugfs_root);
> +
> +	debugfs_create_file("states", 0444, mhi_cntrl->debugfs_dentry,
> +			    mhi_cntrl, &debugfs_states_fops);
> +	debugfs_create_file("events", 0444, mhi_cntrl->debugfs_dentry,
> +			    mhi_cntrl, &debugfs_events_fops);
> +	debugfs_create_file("channels", 0444, mhi_cntrl->debugfs_dentry,
> +			    mhi_cntrl, &debugfs_channels_fops);
> +	debugfs_create_file("devices", 0444, mhi_cntrl->debugfs_dentry,
> +			    mhi_cntrl, &debugfs_devices_fops);
> +	debugfs_create_file("regdump", 0444, mhi_cntrl->debugfs_dentry,
> +			    mhi_cntrl, &debugfs_regdump_fops);
> +	debugfs_create_file("device_wake", 0644, mhi_cntrl->debugfs_dentry,
> +			    mhi_cntrl, &debugfs_device_wake_fops);
> +	debugfs_create_file("timeout_ms", 0644, mhi_cntrl->debugfs_dentry,
> +			    mhi_cntrl, &debugfs_timeout_ms_fops);
> +}
> +
> +void mhi_destroy_debugfs(struct mhi_controller *mhi_cntrl)
> +{
> +	debugfs_remove_recursive(mhi_cntrl->debugfs_dentry);
> +	mhi_cntrl->debugfs_dentry = NULL;
> +}
> +
> +void mhi_debugfs_init(void)
> +{
> +	mhi_debugfs_root = debugfs_create_dir(mhi_bus_type.name, NULL);
> +}
> +
> +void mhi_debugfs_exit(void)
> +{
> +	debugfs_remove_recursive(mhi_debugfs_root);
> +}
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index e2011ec..d2c0f6e 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -4,6 +4,7 @@
>   *
>   */
>  
> +#include <linux/debugfs.h>
>  #include <linux/device.h>
>  #include <linux/dma-direction.h>
>  #include <linux/dma-mapping.h>
> @@ -915,6 +916,8 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
>  
>  	mhi_cntrl->mhi_dev = mhi_dev;
>  
> +	mhi_create_debugfs(mhi_cntrl);
> +
>  	return 0;
>  
>  error_add_dev:
> @@ -937,6 +940,8 @@ void mhi_unregister_controller(struct mhi_controller *mhi_cntrl)
>  	struct mhi_chan *mhi_chan = mhi_cntrl->mhi_chan;
>  	unsigned int i;
>  
> +	mhi_destroy_debugfs(mhi_cntrl);
> +
>  	kfree(mhi_cntrl->mhi_cmd);
>  	kfree(mhi_cntrl->mhi_event);
>  
> @@ -1284,11 +1289,13 @@ struct bus_type mhi_bus_type = {
>  
>  static int __init mhi_init(void)
>  {
> +	mhi_debugfs_init();
>  	return bus_register(&mhi_bus_type);
>  }
>  
>  static void __exit mhi_exit(void)
>  {
> +	mhi_debugfs_exit();
>  	bus_unregister(&mhi_bus_type);
>  }
>  
> diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
> index 5a81a42..7989269 100644
> --- a/drivers/bus/mhi/core/internal.h
> +++ b/drivers/bus/mhi/core/internal.h
> @@ -570,6 +570,30 @@ struct mhi_chan {
>  /* Default MHI timeout */
>  #define MHI_TIMEOUT_MS (1000)
>  
> +/* debugfs related functions */
> +#ifdef CONFIG_MHI_BUS_DEBUG
> +void mhi_create_debugfs(struct mhi_controller *mhi_cntrl);
> +void mhi_destroy_debugfs(struct mhi_controller *mhi_cntrl);
> +void mhi_debugfs_init(void);
> +void mhi_debugfs_exit(void);
> +#else
> +static inline void mhi_create_debugfs(struct mhi_controller *mhi_cntrl)
> +{
> +}
> +
> +static inline void mhi_destroy_debugfs(struct mhi_controller *mhi_cntrl)
> +{
> +}
> +
> +static inline void mhi_debugfs_init(void)
> +{
> +}
> +
> +static inline void mhi_debugfs_exit(void)
> +{
> +}
> +#endif
> +
>  struct mhi_device *mhi_alloc_device(struct mhi_controller *mhi_cntrl);
>  
>  int mhi_destroy_device(struct device *dev, void *data);
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index d360020..3a3e857 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -290,6 +290,7 @@ struct mhi_controller_config {
>   * @cntrl_dev: Pointer to the struct device of physical bus acting as the MHI
>   *            controller (required)
>   * @mhi_dev: MHI device instance for the controller
> + * @debugfs_dentry: MHI controller debugfs directory
>   * @regs: Base address of MHI MMIO register space (required)
>   * @bhi: Points to base of MHI BHI register space
>   * @bhie: Points to base of MHI BHIe register space
> @@ -367,6 +368,7 @@ struct mhi_controller_config {
>  struct mhi_controller {
>  	struct device *cntrl_dev;
>  	struct mhi_device *mhi_dev;
> +	struct dentry *debugfs_dentry;
>  	void __iomem *regs;
>  	void __iomem *bhi;
>  	void __iomem *bhie;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
