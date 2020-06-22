Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F03C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D212075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 15:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592841287;
	bh=oRJB6h/bS+tqbd9R39cS2329vCq3WIUuVv0P5qICFUs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L+PayGCHFdvMkB6EkXZ75pJ0zqWUFUpSk6xfvq8/cBmPVb9zRSxuCE1MhCV31E0Vz
	 fITbLErscJMBFc3ujtrhPbHD95EN4iioxCQTS4wvslDXaIPUYPQEdehIEQUcT4+zeQ
	 gotaFbwrjQ4GcbMYe+9mlU5SawieGYVZFWkhyECE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgFVPyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 11:54:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgFVPyq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:54:46 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53FBF2074D;
        Mon, 22 Jun 2020 15:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592841286;
        bh=oRJB6h/bS+tqbd9R39cS2329vCq3WIUuVv0P5qICFUs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1rAAOtWug0zRuuAKt9uYzXZhuiodYywEsoqay8UQK3SGp4XmBOkmVS428PppVFfJK
         y+vATJ5E/6KVsCPPVP8gJwSOqDwxnogBkP0VDTbYzkWSkddu19cGnxO7R8uK4BKSly
         uwZBbjQd5lWiKAzjITZLVpbTBPJ4a2wHK2HK2n10=
Date:   Mon, 22 Jun 2020 21:24:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Thomas Ruf <freelancer@rufusul.de>
Cc:     Federico Vaga <federico.vaga@cern.ch>,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: DMA Engine: Transfer From Userspace
Message-ID: <20200622155440.GM2324254@vkoul-mobl>
References: <5614531.lOV4Wx5bFT@harkonnen>
 <fe199e18-be45-cadc-8bad-4a83ed87bfba@intel.com>
 <20200621072457.GA2324254@vkoul-mobl>
 <20200621203634.y3tejmh6j4knf5iz@cwe-513-vol689.cern.ch>
 <20200622044733.GB2324254@vkoul-mobl>
 <419762761.402939.1592827272368@mailbusiness.ionos.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419762761.402939.1592827272368@mailbusiness.ionos.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-06-20, 14:01, Thomas Ruf wrote:
> > On 22 June 2020 at 06:47 Vinod Koul <vkoul@kernel.org> wrote:
> > 
> > On 21-06-20, 22:36, Federico Vaga wrote:
> > > On Sun, Jun 21, 2020 at 12:54:57PM +0530, Vinod Koul wrote:
> > > > On 19-06-20, 16:31, Dave Jiang wrote:
> > > > > 
> > > > > 
> > > > > On 6/19/2020 3:47 PM, Federico Vaga wrote:
> > > > > > Hello,
> > > > > >
> > > > > > is there the possibility of using a DMA engine channel from userspace?
> > > > > >
> > > > > > Something like:
> > > > > > - configure DMA using ioctl() (or whatever configuration mechanism)
> > > > > > - read() or write() to trigger the transfer
> > > > > >
> > > > > 
> > > > > I may have supposedly promised Vinod to look into possibly providing
> > > > > something like this in the future. But I have not gotten around to do that
> > > > > yet. Currently, no such support.
> > > > 
> > > > And I do still have serious reservations about this topic :) Opening up
> > > > userspace access to DMA does not sound very great from security point of
> > > > view.
> > > 
> > > I was thinking about a dedicated module, and not something that the DMA engine
> > > offers directly. You load the module only if you need it (like the test module)
> > 
> > But loading that module would expose dma to userspace. 
> > > 
> > > > Federico, what use case do you have in mind?
> > > 
> > > Userspace drivers
> > 
> > more the reason not do do so, why cant a kernel driver be added for your
> > usage?
> 
> by chance i have written a driver allowing dma from user space using a memcpy like interface ;-)
> now i am trying to get this code upstream but was hit by the fact that DMA_SG is gone since Aug 2017 :-(
> 
> just let me introduce myself and the project:
> - coding in C since '91
> - coding in C++ since '98
> - a lot of stuff not relevant for this ;-)
> - working as a freelancer since Nov '19
> - implemented a "dma-sg-proxy" driver for my client in Mar/Apr '20 to copy camera frames from uncached memory to cached memory using a second dma on a Zynq platform
> - last week we figured out that we can not upgrade from "Xilinx 2019.2" (kernel 4.19.x) to "2020.1" (kernel 5.4.x) because the DMA_SG interface is gone
> - subscribed to dmaengine on friday, saw the start of this discussion on saturday
> - talked to my client today if it is ok to try to revive DMA_SG and get our driver upstream to avoid such problems in future

DMA_SG was removed as it had no users, if we have a user (in-kernel) we
can certainly revert that removal patch.
> 
> here the struct for the ioctl:
> 
> typedef struct {
>   unsigned int struct_size;
>   const void *src_user_ptr;
>   void *dst_user_ptr;
>   unsigned long length;
>   unsigned int timeout_in_ms;
> } dma_sg_proxy_arg_t;

Again, am not convinced opening DMA to userspace like this is a great
idea. Why not have Xilinx camera driver invoke the dmaengine and do
DMA_SG ?

-- 
~Vinod
