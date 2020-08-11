Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415D1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 22:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1626D204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 22:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="WULtYCFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgHKWuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 18:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgHKWuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 18:50:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3821CC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 15:50:22 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5F7DF9A8;
        Wed, 12 Aug 2020 00:50:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1597186220;
        bh=z0+tnkTy0eTpC44ri8cQIX/D1k5LuXDoUMZ0F3SL5CU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WULtYCFh3fQcGhgKvsmcXIU7qlug+miUSADw8VaZE4bAEQINy0wZa//WQe+IrPeoa
         Wj8kpszqs3XjkrlBn2Fpls37ex28l2YwCiCjN/tl8b3rZxRjklIZDh88PCl47pEkS1
         176H8sjAplphuYnBoB1zbCZKZOu3g2ZiRlzgwV7A=
Date:   Wed, 12 Aug 2020 01:50:06 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Michal Simek <monstr@monstr.eu>
Subject: Re: drivers/dma/xilinx/xilinx_dpdma.c:1172
 xilinx_dpdma_synchronize() error: double unlocked 'chan->vchan.lock' (orig
 line 1170)
Message-ID: <20200811225006.GF17446@pendragon.ideasonboard.com>
References: <202008120657.drkFgIsC%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202008120657.drkFgIsC%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 06:37:59AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   c636eef2ee3696f261a35f34989842701a107895
> commit: 7cbb0c63de3fc218fd06ecfedb477772a4d12f76 dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver
> date:   4 weeks ago
> config: h8300-randconfig-m031-20200811 (attached as .config)
> compiler: h8300-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> smatch warnings:
> drivers/dma/xilinx/xilinx_dpdma.c:1172 xilinx_dpdma_synchronize() error: double unlocked 'chan->vchan.lock' (orig line 1170)

Unless I'm mistaken, this is a false positive. I'd appreciate if someone
could check if I'm missing something obvious.

> vim +1172 drivers/dma/xilinx/xilinx_dpdma.c
> 
>   1140	
>   1141	/**
>   1142	 * xilinx_dpdma_synchronize - Synchronize callback execution
>   1143	 * @dchan: DMA channel
>   1144	 *
>   1145	 * Synchronizing callback execution ensures that all previously issued
>   1146	 * transfers have completed and all associated callbacks have been called and
>   1147	 * have returned.
>   1148	 *
>   1149	 * This function waits for the DMA channel to stop. It assumes it has been
>   1150	 * paused by a previous call to dmaengine_terminate_async(), and that no new
>   1151	 * pending descriptors have been issued with dma_async_issue_pending(). The
>   1152	 * behaviour is undefined otherwise.
>   1153	 */
>   1154	static void xilinx_dpdma_synchronize(struct dma_chan *dchan)
>   1155	{
>   1156		struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
>   1157		unsigned long flags;
>   1158	
>   1159		xilinx_dpdma_chan_stop(chan);
>   1160	
>   1161		spin_lock_irqsave(&chan->vchan.lock, flags);
>   1162		if (chan->desc.pending) {
>   1163			vchan_terminate_vdesc(&chan->desc.pending->vdesc);
>   1164			chan->desc.pending = NULL;
>   1165		}
>   1166		if (chan->desc.active) {
>   1167			vchan_terminate_vdesc(&chan->desc.active->vdesc);
>   1168			chan->desc.active = NULL;
>   1169		}
> > 1170		spin_unlock_irqrestore(&chan->vchan.lock, flags);
>   1171	
> > 1172		vchan_synchronize(&chan->vchan);
>   1173	}
>   1174	
> 

-- 
Regards,

Laurent Pinchart
