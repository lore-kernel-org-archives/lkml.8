Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E80EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 04:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7711C2078B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 04:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597205804;
	bh=dDly0umphm6eP9IgKi/bR1Xe7oJc3DuJ9fqY6LBtYDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lA/Q+fiGeONCoxQIYodFJbAqJmYLqdcgiVCYZonS0gQSDKlFntS9yEPQQAyMoWgga
	 FyPIluKqXU3u0i4GCYbXpy1+kloJFwOn4liu9gyTR0CFGCu7sII4FWyeuisLQodiLX
	 Ylo414JENlY794tvT7gwvO6vbaPTPZU/xL1b/hwo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgHLEQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 00:16:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgHLEQn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 00:16:43 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ED7820675;
        Wed, 12 Aug 2020 04:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597205802;
        bh=dDly0umphm6eP9IgKi/bR1Xe7oJc3DuJ9fqY6LBtYDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VeowWUTysyFtRAIrl0D4aCP0IHl0b5n89L2/ZZ2LePcAZ17DbiBC3rafcEvn5ZcJK
         XXJy+0wYqEpgSzeqhowquInzzTMHLic6eZDtjkVFYcr7zmYtqQsMzXaj1w2vkcdI13
         Ecg+eLXiysn80D9+v2fJ74bqqnYiT5FNtlwZUPOU=
Date:   Wed, 12 Aug 2020 09:46:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     kernel test robot <lkp@intel.com>,
        Hyun Kwon <hyun.kwon@xilinx.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Tejas Upadhyay <tejasu@xilinx.com>,
        Michal Simek <monstr@monstr.eu>
Subject: Re: drivers/dma/xilinx/xilinx_dpdma.c:1172
 xilinx_dpdma_synchronize() error: double unlocked 'chan->vchan.lock' (orig
 line 1170)
Message-ID: <20200812041638.GT12965@vkoul-mobl>
References: <202008120657.drkFgIsC%lkp@intel.com>
 <20200811225006.GF17446@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811225006.GF17446@pendragon.ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Laurent,

On 12-08-20, 01:50, Laurent Pinchart wrote:
> On Wed, Aug 12, 2020 at 06:37:59AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   c636eef2ee3696f261a35f34989842701a107895
> > commit: 7cbb0c63de3fc218fd06ecfedb477772a4d12f76 dmaengine: xilinx: dpdma: Add the Xilinx DisplayPort DMA engine driver
> > date:   4 weeks ago
> > config: h8300-randconfig-m031-20200811 (attached as .config)
> > compiler: h8300-linux-gcc (GCC) 9.3.0
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > 
> > smatch warnings:
> > drivers/dma/xilinx/xilinx_dpdma.c:1172 xilinx_dpdma_synchronize() error: double unlocked 'chan->vchan.lock' (orig line 1170)
> 
> Unless I'm mistaken, this is a false positive. I'd appreciate if someone
> could check if I'm missing something obvious.
> 
> > vim +1172 drivers/dma/xilinx/xilinx_dpdma.c
> > 
> >   1140	
> >   1141	/**
> >   1142	 * xilinx_dpdma_synchronize - Synchronize callback execution
> >   1143	 * @dchan: DMA channel
> >   1144	 *
> >   1145	 * Synchronizing callback execution ensures that all previously issued
> >   1146	 * transfers have completed and all associated callbacks have been called and
> >   1147	 * have returned.
> >   1148	 *
> >   1149	 * This function waits for the DMA channel to stop. It assumes it has been
> >   1150	 * paused by a previous call to dmaengine_terminate_async(), and that no new
> >   1151	 * pending descriptors have been issued with dma_async_issue_pending(). The
> >   1152	 * behaviour is undefined otherwise.
> >   1153	 */
> >   1154	static void xilinx_dpdma_synchronize(struct dma_chan *dchan)
> >   1155	{
> >   1156		struct xilinx_dpdma_chan *chan = to_xilinx_chan(dchan);
> >   1157		unsigned long flags;
> >   1158	
> >   1159		xilinx_dpdma_chan_stop(chan);
> >   1160	
> >   1161		spin_lock_irqsave(&chan->vchan.lock, flags);

Lock is held here

> >   1162		if (chan->desc.pending) {
> >   1163			vchan_terminate_vdesc(&chan->desc.pending->vdesc);

This should be called with lock held

> >   1164			chan->desc.pending = NULL;
> >   1165		}
> >   1166		if (chan->desc.active) {
> >   1167			vchan_terminate_vdesc(&chan->desc.active->vdesc);

same here

> >   1168			chan->desc.active = NULL;
> >   1169		}
> > > 1170		spin_unlock_irqrestore(&chan->vchan.lock, flags);

Dropped

> >   1171	
> > > 1172		vchan_synchronize(&chan->vchan);

This should be called without lock

So I agree with you, looks like a false positive to me as well

-- 
~Vinod
