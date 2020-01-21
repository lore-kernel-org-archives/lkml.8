Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4C5C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C02324654
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579595720;
	bh=heTsX97URT+i6grSByTb7+bV4lKDgcTZRQJGkR1/X7k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a03lU+kkqaz7Pd4py/2DnzNIAUhOIfQatvYadDJL+9WFbzLsfcV84SKG3kPUMCLm2
	 GpJacEngWkYZ2qa0zbyVjPy0Ufx5N57rma1fZ/qoud1hgZ3dS7dGty19+TDKlcqclk
	 67xzf0ZRGnJHPUYNvPbIl5oWlPZWsRXN90bIX79I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgAUIfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:35:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:60662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbgAUIfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:35:19 -0500
Received: from localhost (unknown [171.76.119.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C749F20661;
        Tue, 21 Jan 2020 08:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579595718;
        bh=heTsX97URT+i6grSByTb7+bV4lKDgcTZRQJGkR1/X7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sCrALuQ9saD06F1M+KuWYDpzQ7BvCCl+jMEOwG8342XNSZMuyYJmigYu5e77zxgc6
         L6Pv0e2nitaAKcfPvUaHK/r8+XNT2LTomHWalmLBUzp6HfnfZwIY66+u4yOSbIKrjU
         ZyyvvwDoLoISCnvRVqzouMDs+sgfBO7t/1O97Z14=
Date:   Tue, 21 Jan 2020 14:05:14 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Stefan Mavrodiev <stefan@olimex.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/2] dmaengine: sun4i: Add support for cyclic requests
 with dedicated DMA
Message-ID: <20200121083514.GE2841@vkoul-mobl>
References: <20200110141140.28527-1-stefan@olimex.com>
 <20200110141140.28527-2-stefan@olimex.com>
 <20200115123137.GJ2818@vkoul-mobl>
 <20200115170731.vt6twfhvuwjrbbup@gilmour.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115170731.vt6twfhvuwjrbbup@gilmour.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-01-20, 18:07, Maxime Ripard wrote:
> On Wed, Jan 15, 2020 at 06:01:37PM +0530, Vinod Koul wrote:
> > On 10-01-20, 16:11, Stefan Mavrodiev wrote:
> > > Currently the cyclic transfers can be used only with normal DMAs. They
> > > can be used by pcm_dmaengine module, which is required for implementing
> > > sound with sun4i-hdmi encoder. This is so because the controller can
> > > accept audio only from a dedicated DMA.
> > >
> > > This patch enables them, following the existing style for the
> > > scatter/gather type transfers.
> >
> > I presume you want this to go with drm tree (if not let me know) so:
> >
> > Acked-by: Vinod Koul <vkoul@kernel.org>
> 
> There's no need for it to go through DRM, it can go through your tree :)

okay in that case I have applied now :), thanks

-- 
~Vinod
