Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E5CC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C932253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579608849;
	bh=Qq3v/FQs81Z4u3h/BT7zP7lIhmAukfuHUqvLomvAe2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FY3Da8gKyJ6OUjUb2Tw6m7d3ABEP/2ts4nX9twABJ31ucpHc7TBE/rRs0x9AD5Xq4
	 pUmHz7zknVauQdOVmGZ4qAeICQzVVRW/sjHxL/nu0T7nS9tQes8ZLhCEb4oieK9Nvy
	 90GS/Nca8bmMpHaBmliDiWYaN5RibIu8fPCMGxGw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbgAUMOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:14:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:42134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgAUMOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:14:08 -0500
Received: from localhost (unknown [171.76.119.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B222A2073A;
        Tue, 21 Jan 2020 12:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579608847;
        bh=Qq3v/FQs81Z4u3h/BT7zP7lIhmAukfuHUqvLomvAe2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M3SfLdxAoH9lXTgviaGdxEEl8nstuFNd2zRY3BHNhdqp7YUCg7QXEXKixsKmRxHX3
         9F0Fa3pogu6a6IKs20YUE+vsokLsny+vHu5lpHCodkcVtQ6ZtO+ZwVolZpTq89HxKb
         C+IU7xZmZtRhEW3HAO68Aly8DcgIt2c0aG6kJffQ=
Date:   Tue, 21 Jan 2020 17:44:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
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
Message-ID: <20200121121402.GP2841@vkoul-mobl>
References: <20200110141140.28527-1-stefan@olimex.com>
 <20200110141140.28527-2-stefan@olimex.com>
 <20200115123137.GJ2818@vkoul-mobl>
 <20200115170731.vt6twfhvuwjrbbup@gilmour.lan>
 <20200121083514.GE2841@vkoul-mobl>
 <54b1a38f-3903-49b7-d20b-f97824a528ba@olimex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54b1a38f-3903-49b7-d20b-f97824a528ba@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-01-20, 13:37, Stefan Mavrodiev wrote:
> 
> On 1/21/20 10:35 AM, Vinod Koul wrote:
> > On 15-01-20, 18:07, Maxime Ripard wrote:
> > > On Wed, Jan 15, 2020 at 06:01:37PM +0530, Vinod Koul wrote:
> > > > On 10-01-20, 16:11, Stefan Mavrodiev wrote:
> > > > > Currently the cyclic transfers can be used only with normal DMAs. They
> > > > > can be used by pcm_dmaengine module, which is required for implementing
> > > > > sound with sun4i-hdmi encoder. This is so because the controller can
> > > > > accept audio only from a dedicated DMA.
> > > > > 
> > > > > This patch enables them, following the existing style for the
> > > > > scatter/gather type transfers.
> > > > I presume you want this to go with drm tree (if not let me know) so:
> > > > 
> > > > Acked-by: Vinod Koul <vkoul@kernel.org>
> > > There's no need for it to go through DRM, it can go through your tree :)
> > okay in that case I have applied now :), thanks
> > 
> Hi,
> 
> Should I keep this patch in the future series or drop it?

Drop it :) It would be in linux-next tomorrow!

-- 
~Vinod
