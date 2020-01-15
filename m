Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7685CC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4387B24671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579091513;
	bh=mj/hReSoRHp5ydIC4cRcSvA+mXisS9dp2mIrgDLg1zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cYrh+8JQcvVF5YahmPzgu1jDkpKoqwrzG2Rt7CykeG46oTm8sjvPB0hdulxjjkc1J
	 Vs7ZJMVOJZNcZdNhy4kNhE8IFPNO8pcvDqWBtdst5G+PdJAG/PcorU0sKZU0hlyHok
	 kQshnZ6SIfkwCiXAgIo1XPQ3f4+AJW+linmdx7c8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgAOMbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:31:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:50964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgAOMbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:31:52 -0500
Received: from localhost (unknown [223.226.122.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B68A0214AF;
        Wed, 15 Jan 2020 12:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579091511;
        bh=mj/hReSoRHp5ydIC4cRcSvA+mXisS9dp2mIrgDLg1zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yB1CEdipMT24qNy8hy+KhE7gUIehT6Af306QNSUVUtQWok+N54kT9/FshiIHE1jwD
         G/fq4ukzF+hoQFC22Pz5JKTdrfyMPxhHvni+G11vjQHuDaPFV97A5DsVfaGRikPSx/
         RkTYR3KBIQMu66Vo0pvTYyAKL3aCUNh8F4SPyCVE=
Date:   Wed, 15 Jan 2020 18:01:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Maxime Ripard <mripard@kernel.org>,
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
Message-ID: <20200115123137.GJ2818@vkoul-mobl>
References: <20200110141140.28527-1-stefan@olimex.com>
 <20200110141140.28527-2-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200110141140.28527-2-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-01-20, 16:11, Stefan Mavrodiev wrote:
> Currently the cyclic transfers can be used only with normal DMAs. They
> can be used by pcm_dmaengine module, which is required for implementing
> sound with sun4i-hdmi encoder. This is so because the controller can
> accept audio only from a dedicated DMA.
> 
> This patch enables them, following the existing style for the
> scatter/gather type transfers.

I presume you want this to go with drm tree (if not let me know) so:

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
