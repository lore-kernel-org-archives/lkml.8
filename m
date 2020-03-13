Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CF8C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F5E20746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584103369;
	bh=zIiBLpsC2cdf0q4TDq2aJKvTn5547w1lAXM8kNFd8n8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b1R16zv2xRxnj84I5WINHzoeYKnkmL6AhN3SLKDvDTmz3dtZNS3+t/OmYyhCb48BO
	 Egu9rfbeJ2smP8u+TMGgEDE5Uqef9tA4CYpSMHxdA0NksHYx7SZjVRIqHYjT1POBuz
	 L/pylqj+P/MHTQGCMkd9mFvXHUy9Bsk6fCH61Oro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgCMMms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:42:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgCMMms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:42:48 -0400
Received: from localhost (unknown [171.76.107.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 096B820768;
        Fri, 13 Mar 2020 12:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584103366;
        bh=zIiBLpsC2cdf0q4TDq2aJKvTn5547w1lAXM8kNFd8n8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YKqDBkWaJDWrQwNGF5uNuVNxqC3SdFkhG82BMiUpvT/6fhH4FmsniXwwHXqxQIaxK
         1178LargHGszpbV/DakUIHcNHVFiNoo9UQy3MTJ7zkuVGCX88nHPHcoc+8MFrRM1Hz
         4ruyA0ue65UvD48oCXBI85pLogN2sBnNW/HBPcjU=
Date:   Fri, 13 Mar 2020 18:12:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the slave-dma tree with Linus' tree
Message-ID: <20200313124242.GK4885@vkoul-mobl>
References: <20200312162614.1b6b2b0e@canb.auug.org.au>
 <68408777-afd4-78c0-9e15-fa7ac050bb17@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68408777-afd4-78c0-9e15-fa7ac050bb17@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-03-20, 09:16, Peter Ujfalusi wrote:
> Hi Stephen, Vinod,
> 
> On 12/03/2020 7.26, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the slave-dma tree got a conflict in:
> > 
> >   drivers/dma/ti/k3-udma.c
> > 
> > between commit:
> > 
> >   16cd3c670183 ("dmaengine: ti: k3-udma: Workaround for RX teardown with stale data in peer")
> > 
> > from Linus' tree
> 
> In Linus' tree the drivers/dma/ti/k3-udma.c latest commit is:
> 8390318c04bb ("dmaengine: ti: k3-udma: Fix terminated transfer handling")
> 
> git log --oneline drivers/dma/ti/k3-udma.c shows:
> 8390318c04bb dmaengine: ti: k3-udma: Fix terminated transfer handling
> c7450bb211f3 dmaengine: ti: k3-udma: Use the channel direction in pause/resume functions
> 6cf668a4ef82 dmaengine: ti: k3-udma: Use the TR counter helper for slave_sg and cyclic
> a97934071fc3 dmaengine: ti: k3-udma: Move the TR counter calculation to helper function
> 16cd3c670183 dmaengine: ti: k3-udma: Workaround for RX teardown with stale data in peer
> 1c83767c9d41 dmaengine: ti: k3-udma: Use ktime/usleep_range based TX completion check
> 6c0157be02f0 dmaengine: ti: k3-udma: fix spelling mistake "limted" -> "limited"
> d70241913413 dmaengine: ti: k3-udma: Add glue layer for non DMAengine users
> 25dcb5dd7b7c dmaengine: ti: New driver for K3 UDMA
> 
> > and commit:
> > 
> >   db8d9b4c9b30 ("dmaengine: ti: k3-udma: Implement custom dbg_summary_show for debugfs")
> 
> However slave-dma's next branch shows the following log for k3-udma.c:
> db8d9b4c9b30 dmaengine: ti: k3-udma: Implement custom dbg_summary_show for debugfs
> 0ebcf1a274c5 dmaengine: ti: k3-udma: Implement support for atype (for virtualization)
> 6c0157be02f0 dmaengine: ti: k3-udma: fix spelling mistake "limted" -> "limited"
> d70241913413 dmaengine: ti: k3-udma: Add glue layer for non DMAengine users
> 25dcb5dd7b7c dmaengine: ti: New driver for K3 UDMA
> 
> The 5.6-rc5 patches (1c83767c9d41...8390318c04bb) is not present in slave-dma/next which
> causes the conflict.

Yeah I typically dont merge fixes to next, unless we have a dependency.

> > from the slave-dma tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> 
> I ended up with the exactly same resolution patch when merging dlave-dma/next
> to Linus' tree.

Thanks for confirming.. I will let Linus know about this, I dont think
we need to do much here :)

-- 
~Vinod
