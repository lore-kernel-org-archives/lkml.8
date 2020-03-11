Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F823C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E108020746
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583947087;
	bh=kSRd2vWUlnNIgg7VJGv6T4EyBaZG9+3GbIsDwtJPOLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eNPY3IckbziJ0JP/AUIX7wyI1kHR2UMvXxn9N1zOcBLEJc/KnjvBhK61TcDRUHlWl
	 D6CjC8vZxehpXpykjK1QeiPOTZYKcRb5d9+MGjkGhVYbyEq++P8es7ruB71SsHP8cF
	 utp4hmolOjrSgvqAkJik6/Dl5qMD0mey1KfvY074=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbgCKRSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:18:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:44424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730059AbgCKRSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:18:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB58220736;
        Wed, 11 Mar 2020 17:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583947085;
        bh=kSRd2vWUlnNIgg7VJGv6T4EyBaZG9+3GbIsDwtJPOLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XYKE+mrP7iqEs6IES9OU+6rgpsZQLgvsE9pMapPflmYEkyJlu5B/q4lmRuaHdzrSN
         QW0bR/ChigYgeV+OEjJikRzsPQeWiozwOykBkHi2JNMAeqM55nPdb5FZpuQYtn5eJE
         OYEEDpNCabuyYlp2uRw/fDRfmA9He3pw7ky+tx5s=
Date:   Wed, 11 Mar 2020 18:18:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     torvalds@linux-foundation.org, aros@gmx.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH] device core: fix dma_mask handling in
 platform_device_register_full
Message-ID: <20200311171802.GA3952198@kroah.com>
References: <20200311160710.376090-1-hch@lst.de>
 <20200311161423.GA3941932@kroah.com>
 <20200311161551.GA24878@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311161551.GA24878@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 05:15:51PM +0100, Christoph Hellwig wrote:
> On Wed, Mar 11, 2020 at 05:14:23PM +0100, Greg KH wrote:
> > On Wed, Mar 11, 2020 at 05:07:10PM +0100, Christoph Hellwig wrote:
> > > Ever since the generic platform device code started allocating DMA masks
> > > itself the code to allocate and leak a private DMA mask in
> > > platform_device_register_full has been superflous.  More so the fact that
> > > it unconditionally frees the DMA mask allocation in the failure path
> > > can lead to slab corruption if the function fails later on for a device
> > > where it didn't allocate the mask.  Just remove the offending code.
> > > 
> > > Fixes: cdfee5623290 ("driver core: initialize a default DMA mask for platform device")
> > > Reported-by: Artem S. Tashkinov <aros@gmx.com>
> > > Tested-by: Artem S. Tashkinov <aros@gmx.com>
> > 
> > No s-o-b from you?  :(
> > 
> > I can take this, or Linus, you can take this now if you want to as well:
> 
> Sorry, here it is:
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Is this still needed with the patch that Linus just committed to his
tree?

thanks,

greg k-h
