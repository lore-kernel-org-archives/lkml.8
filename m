Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F15EC4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:56:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AFC920757
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588582574;
	bh=MhFLYRO7XaP7fMKVc1tvDLu2Kr7aT3LU5gaPh+z5200=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HTqTlX6SQ5dO8DzUZuur4FsSc6lQE+LAnyJHidYcCVWynNETWTUJ9Ttu/c/UfRv3u
	 o6NPaCouceLfth5/qmr+RTUMepd0iRYhFX5UFA3y+Gl+U994T27LlkGIC31KOpM+Jn
	 8nVfDgXOJKdmiWYnRY/J8CYWkJHe9l40Uk3o9sEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgEDI4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 04:56:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbgEDI4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 04:56:12 -0400
Received: from localhost (unknown [171.76.84.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C571820735;
        Mon,  4 May 2020 08:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588582572;
        bh=MhFLYRO7XaP7fMKVc1tvDLu2Kr7aT3LU5gaPh+z5200=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=saOSuDr9/mx+Wr6MWKtfutLUlLljmHWSE99JOGgqzenvNEpSLx0hWLk+xYpEQDatG
         8otGDo/cbdSrpAg7caQnSlwkDznnkBDxfiWl+xgn3dfJ6uAvB3CaGBGljwQCeX6Bht
         M1wkULb2HL2AOPg0+4qt//9PIOTsKMXWzw+PDyVA=
Date:   Mon, 4 May 2020 14:26:08 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the slave-dma-fixes tree
Message-ID: <20200504085608.GR1375924@vkoul-mobl>
References: <20200504185326.6c50e387@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504185326.6c50e387@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-05-20, 18:53, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   c76d6569de67 ("dmaengine: owl: Use correct lock in owl_dma_get_pchan()")
> 
> Fixes tag
> 
>   Fixes: 47e20577c24d ("dmaengine: Add Actions Semi Owl family S900 DMA
> 
> has these problem(s):
> 
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
> 
> Please do not split Fixes tags over more than one line.
> 
> Also, please keep all the commit message tags together at the end of
> the commit message.

Updated and pushed out, thanks for notifying

-- 
~Vinod
