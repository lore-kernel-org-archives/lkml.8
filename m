Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9F3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CAAD2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593011488;
	bh=nYl8l1Sm+SCWmjeb4Ljbgr5wKM1Z7Cv6vgBTchUl1N4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zT+K7LTOgyHVopTZvTsyPvxZlMApeT7FSNR5vqa6VpRUfXAWArNxcgDO1uNmdNKlm
	 8ykW+lw1REo2hl2aZ2uWicKKEGviCK3xpoIKJYUwZa5gombfecBCYJoASzRcIQu7uT
	 c6V7xK1KZcXrVBlmAreplZzY4jWkaUeiGtis0wAM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404214AbgFXPL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:51734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390829AbgFXPL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:11:26 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D53C320656;
        Wed, 24 Jun 2020 15:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593011485;
        bh=nYl8l1Sm+SCWmjeb4Ljbgr5wKM1Z7Cv6vgBTchUl1N4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PVjN7CQcIFGqOKfaSA8dQDmv6Z2sQ+55jE75SlIg41a6pZFmOIxzvBZHw5wXf99n0
         v9yg3BrdhsDJU+uYF0L9Uv/eZjSx9SWOjZeU2ppc9bAjTwwd721aKQyt07v/CO9nmJ
         Xw2b/a0MWS/C2uC3g9skEETF2RE2CO3dPUz00NVM=
Date:   Wed, 24 Jun 2020 20:41:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH v8 2/3] phy: zynqmp: Add PHY driver for the Xilinx ZynqMP
 Gigabit Transceiver
Message-ID: <20200624151121.GF2324254@vkoul-mobl>
References: <20200513172239.26444-1-laurent.pinchart@ideasonboard.com>
 <20200513172239.26444-3-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513172239.26444-3-laurent.pinchart@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Mostly this looks fine to me, some minor nitpicks below:

On 13-05-20, 20:22, Laurent Pinchart wrote:
> +config PHY_XILINX_ZYNQMP
> +	tristate "Xilinx ZynqMP PHY driver"
> +	depends on ARCH_ZYNQMP

Can we add COMPILE_TEST here so that this driver gets wider compile
coverage?

> +++ b/drivers/phy/xilinx/phy-zynqmp.c
> @@ -0,0 +1,995 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * phy-zynqmp.c - PHY driver for Xilinx ZynqMP GT.
> + *
> + * Copyright (C) 2018-20 Xilinx Inc.

2018-2020 please

> +/* Number of GT lanes */
> +#define NUM_LANES			4

Should this be coded in driver like this? Maybe future versions of
hardware will have more lanes..? Why not describe this in DT?
> +
> +/* SIOU SATA control register */
> +#define SATA_CONTROL_OFFSET		0x0100
> +
> +/* Total number of controllers */
> +#define CONTROLLERS_PER_LANE		5

Same question for this as well..

> +/*
> + * I/O Accessors
> + */
> +
> +static inline u32 xpsgtr_read(struct xpsgtr_dev *gtr_dev, u32 reg)
> +{
> +	return readl(gtr_dev->serdes + reg);
> +}
> +
> +static inline void xpsgtr_write(struct xpsgtr_dev *gtr_dev, u32 reg, u32 value)
> +{
> +	writel(value, gtr_dev->serdes + reg);
> +}
> +
> +static inline void xpsgtr_clr_set(struct xpsgtr_dev *gtr_dev, u32 reg,
> +				  u32 clr, u32 set)

wouldn't it be apt to rename this to xpsgtr_modify() and with args as
value and mask, somehow I find that more simpler...

Also, please align second line with opening brace of preceding line

-- 
~Vinod
