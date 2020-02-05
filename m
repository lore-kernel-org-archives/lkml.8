Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D354FC352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC4B217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 11:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580903952;
	bh=e2wpDkaca94WD5/bWbgprPG9Vj1e3ghMDbeVWFnC7pE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aKlxzVUshTpFDtuh1WnYuqcJ9HZXJ0d3pOhtrnxieJ/zYY+i4vegelLfx4FKsMSsw
	 /74n9OpSKT+i1S61svUTn9o8rrw1bRECzZ+w688UMJYqESQyaj106Cdz16d6ye+8Xw
	 5e4gTIjxiFtXQSZ1jzWFxNByp9aEiCdgQimZ3GyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgBEL7M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 06:59:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:47700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgBEL7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 06:59:11 -0500
Received: from localhost (unknown [122.178.239.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1CB4217F4;
        Wed,  5 Feb 2020 11:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580903950;
        bh=e2wpDkaca94WD5/bWbgprPG9Vj1e3ghMDbeVWFnC7pE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i+T2aI18PEwzwPN66edZzxNyr1exqENkEPYyPzuqFmOkbeMADS1niFPCUm4eumM4g
         tHOY+IUkpDB9RbEY+KuYCn1gfEKlXNMdbfxIViOy+lN15E3W7rUs37XcfTcFVANG+U
         0YAObt+d/CnW2Em9D1vT97V2wrWlREYxu5MB8UnM=
Date:   Wed, 5 Feb 2020 17:29:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards
 dma_request_slave_chan()
Message-ID: <20200205115906.GF2618@vkoul-mobl>
References: <20200203101806.2441-1-peter.ujfalusi@ti.com>
 <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <20200204062118.GS2841@vkoul-mobl>
 <CAHp75VeRemcJkMMB7D2==Y-A4We=s1ntojZoPRdVS8vs+dB_Ew@mail.gmail.com>
 <20200205044352.GC2618@vkoul-mobl>
 <13dcf3d9-06ca-d793-525d-12f6d7cd27c1@ti.com>
 <20200205113155.GE2618@vkoul-mobl>
 <7b8d9ab2-1734-d54b-ab6e-b620866ce0ce@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b8d9ab2-1734-d54b-ab6e-b620866ce0ce@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-02-20, 13:56, Peter Ujfalusi wrote:
> Hi Vinod,
> 
> On 05/02/2020 13.31, Vinod Koul wrote:
> >> Looking at the commit which added it and I still don't get the point.
> >> If any of the channel is in use then we should not allow the DMA driver
> >> to go away at all.
> > 
> > Not really, if the device is already gone, we cant do much about it. We
> > have to handle that gracefully rather than oopsing
> 
> Ah, I have not thought about that. True.
> 
> > The important part is that the device is gone. Think about a device on
> > PCI card which is yanked off or a USB device unplugged. Device is
> > already gone, you can't communicate with it anymore. So all we can do is
> > handle the condition and exit, hence the new method to let driver know.
> 
> But for most devices this is not applicable, I also wondered what should
> I do in order to silence the print. Just add an empty device_release?

I will send a patch removing this before we hit release :) so nothing to
be done unless you have a hotpluggable device then would be good to add this.

Thanks
-- 
~Vinod
