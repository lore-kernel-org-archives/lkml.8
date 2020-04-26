Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDAFC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 17:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F8872071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 17:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587920845;
	bh=m/VKesCt+bSjvJbxbM7RgCA5iwVllI10bgTkvbJ77BQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LsAyNqHtXJgNTrZF4fTyXRlUtN+kj50sN1Tfy0NWuNY0RgA/wUwL/jN3d1D2LzWlv
	 HvLCup83kVD3bK3PyHf7XYaDC/3adUmf1wswFsmjeoSsB2F+qyW92zXCCjr9m306NH
	 Cd9CTXpNvaxfPq9q0gWZJhGGQ0XpZxQfuj4kBGMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgDZRHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 13:07:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:50394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgDZRHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 13:07:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2538206DD;
        Sun, 26 Apr 2020 17:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587920843;
        bh=m/VKesCt+bSjvJbxbM7RgCA5iwVllI10bgTkvbJ77BQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cFGxIVfTY+0wzn3ctsM/1XSTavz4OoQyJ5MhlQ4Rzl2/13oTi9RZdwPSiNXCsa8/Y
         /6yS6AGbt96EmBEuySmvWZL+AKEiEqclFAE3N8TtUNTjz5/NyYiqzCjiSy8eBlkIS2
         7FcDVl6aBxlifq9E4BrpnKPbmaaI9n3AppCpTEIs=
Date:   Sun, 26 Apr 2020 19:07:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     John Oldman <john.oldman@polehill.co.uk>
Cc:     devel@driverdev.osuosl.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Staging: mt7621-dma: mtk-hsdma.c: Fix Missing a blank
 line after declarations
Message-ID: <20200426170719.GA2138855@kroah.com>
References: <20200426161319.23941-1-john.oldman@polehill.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200426161319.23941-1-john.oldman@polehill.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 05:13:19PM +0100, John Oldman wrote:
> Fixed coding style issue

No you didn't :)

> 
> Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
> ---
>  drivers/staging/mt7621-dma/mtk-hsdma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/mt7621-dma/mtk-hsdma.c b/drivers/staging/mt7621-dma/mtk-hsdma.c
> index 14592ed9ce98..dd35d0bce6ca 100644
> --- a/drivers/staging/mt7621-dma/mtk-hsdma.c
> +++ b/drivers/staging/mt7621-dma/mtk-hsdma.c
> @@ -157,6 +157,7 @@ struct mtk_hsdam_engine {
>  	struct device_dma_parameters dma_parms;
>  	void __iomem *base;
>  	struct tasklet_struct task;
> +
>  	volatile unsigned long chan_issued;
>  
>  	struct mtk_hsdma_chan chan[1];

This file seems to be the "does the submitter look at the patch they are
sending" litmus test.

Does that really do what you think it does?

thanks,

greg k-h
