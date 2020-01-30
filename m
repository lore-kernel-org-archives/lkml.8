Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEDCC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A9612083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 08:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580372709;
	bh=oLADHjwsZK/zmHyFtHVsSOYErltf5rGudZWVt9X53gQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CjkFOW/6jMW+OJPMIjj7gnEwg404tQs2Ir843kZrkJ8oPbd/gjRmYDjBz+LHAYHPe
	 TuDYkrt2HT7nBT7fQz7JxsoAi9PMGaKEtBQXtvdIIcefdH4exHkoqLiupMy9IgTfzd
	 UUhD6YoA3a3sJFhxDV9Fe3A++DoOp69+e41lzLTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgA3IZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 03:25:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:54734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbgA3IZI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 03:25:08 -0500
Received: from localhost (unknown [117.99.87.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2739206D5;
        Thu, 30 Jan 2020 08:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580372707;
        bh=oLADHjwsZK/zmHyFtHVsSOYErltf5rGudZWVt9X53gQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P+qhIqJa76JfwK7WzQlywJzMe3cyG8N4B/5+L+1h7UrZwiDF+xemU8OYiAEEpbMSO
         gWoo1Jn5IkfyJFb3w1k/JihqxhbvXbYnSXzCrOrE8NqUn2y9MkbB3wVUI9ZpO5MLGU
         wcxyTiwbpXEqr49mtNa7oEi3kckbyOL8jL/H+f5g=
Date:   Thu, 30 Jan 2020 13:55:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     dmaengine@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2] dmaengine: Fix return value for dma_requrest_chan()
 in case of failure
Message-ID: <20200130082503.GD2841@vkoul-mobl>
References: <CGME20200130070850eucas1p1a7a09e2bec2f6fe652f206b61a8a04ae@eucas1p1.samsung.com>
 <20200130070834.17537-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130070834.17537-1-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-01-20, 08:08, Marek Szyprowski wrote:
> Commit 71723a96b8b1 ("dmaengine: Create symlinks between DMA channels and
> slaves") changed the dma_request_chan() function flow in such a way that
> it always returns EPROBE_DEFER in case of channels that cannot be found.
> This break the operation of the devices which have optional DMA channels
> as it puts their drivers in endless deferred probe loop. Fix this by
> propagating the proper error value.

Fixed the title and Applied, thanks

-- 
~Vinod
