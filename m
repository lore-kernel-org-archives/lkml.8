Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15535C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 05:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E67F620782
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 05:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598851907;
	bh=+iWCXtm0IchpYyWlybKImJWZPrCTRJK+MWHDQjOjf7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zzqHPvSHMGJcS1ef5Vzxi67gjiQRdVBUGTMAfZ+xHIkext4Mpa+QUs3AMZudkSy9s
	 bindxzPGFG2B5rXhd0I+bapYziP0EDSLEGktrgittT32OeR+8YPGKNk0SSIMaI0obX
	 UqGIvJ6eaFCaMMMIp6cJ2DqwtRTQQ2GkaFhtvh/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgHaFbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 01:31:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:38692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgHaFbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 01:31:45 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF6320738;
        Mon, 31 Aug 2020 05:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598851904;
        bh=+iWCXtm0IchpYyWlybKImJWZPrCTRJK+MWHDQjOjf7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JWlsNfOk5jlHHbLY/i1jrjgUx1fSxP8Jw4sMX4p0vfzp7TQiH6HJgzHBP4GbwwEmF
         Q4BRAiBJSfpAnBJfkevUi2X78QirWoyqFyTscbSU3RR3yDdV9OErPRF55+PSnmhYLh
         JY1liCzzRaCzKy+87n7hJF57wQcSC/LRYyu9RtD4=
Date:   Mon, 31 Aug 2020 07:31:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     trix@redhat.com
Cc:     balbi@kernel.org, natechancellor@gmail.com,
        ndesaulniers@google.com, christophe.jaillet@wanadoo.fr,
        peter.chen@nxp.com, b-liu@ti.com, chunfeng.yun@mediatek.com,
        novikov@ispras.ru, yanaijie@huawei.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: net2272: assert for a valid dma request
Message-ID: <20200831053153.GB2366120@kroah.com>
References: <20200830183646.24930-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830183646.24930-1-trix@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 11:36:46AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis flags this representive problem
> 
> net2272.c:1541:8: warning: Dereference of null pointer
>     if ((req->req.length % ep->ep.maxpacket != 0) ||
>          ^~~~~~~~~~~~~~~
> This is mostly not a problem.
> 
> In net2272_handle_dma(), even though every path through
> the routine dereferences req, it is set to NULL when the
> ep->queue is empty.  If the eq->queue was ever empty this
> would have oops.
> 
> So the else statement should not be needed.  If it is,
> flag it as a BUG.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/usb/gadget/udc/net2272.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/net2272.c b/drivers/usb/gadget/udc/net2272.c
> index 44d1ea2307bb..8301723a8b1a 100644
> --- a/drivers/usb/gadget/udc/net2272.c
> +++ b/drivers/usb/gadget/udc/net2272.c
> @@ -1506,17 +1506,16 @@ static int net2272_stop(struct usb_gadget *_gadget)
>  static void
>  net2272_handle_dma(struct net2272_ep *ep)
>  {
> -	struct net2272_request *req;
> +	struct net2272_request *req = NULL;
>  	unsigned len;
>  	int status;
>  
>  	if (!list_empty(&ep->queue))
>  		req = list_entry(ep->queue.next,
>  				struct net2272_request, queue);
> -	else
> -		req = NULL;
>  
>  	dev_vdbg(ep->dev->dev, "handle_dma %s req %p\n", ep->ep.name, req);
> +	BUG_ON(!req);

No, fix this properly, don't paper over the issue by crashing (as Alan
said, never add a BUG_ON() for something that you can recover from, and
really, never add a BUG_ON() call at all, that's just being a lazy
programmer.)

If this can cause a NULL dereference later on, than correctly handle the
error here please.

thanks,

greg k-h
