Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E8AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8DCD206CB
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 11:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593604717;
	bh=nDHkQnF3GE7LeSK4D2XQD+Jb5LeVxf5LtuLUx72bPl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=it62Ee67UONcZK9tD4ruVrmVpGRsmq763w7y27aXOacZBhynX/NunTYzIcfUfHPfQ
	 vXobDKz4YAX1HuqnZa3bfCMfwpmrxhBhAWJmu5hRNvecoTZr9LnkDCkzB1emd1k3cF
	 6vsW0/Jf+0nW8WTHyU4BV1qihY7qb7qGcKmfoR0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730482AbgGAL6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 07:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730133AbgGAL6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 07:58:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B7342067D;
        Wed,  1 Jul 2020 11:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593604715;
        bh=nDHkQnF3GE7LeSK4D2XQD+Jb5LeVxf5LtuLUx72bPl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UQcpx0io+u/a7HSMAtKB8tJpIHuA9tVGeE/1lhqC+fzTxXp/XFbgQWyziKZCMUo4V
         9OmPXcF+enzCZDJ7tdbDXIq4TLpdl1kiP+3Fm8W6H/jzJqqM0PqwUVP/kzwmM7HC3u
         ALCWydllZlvVZhfCIR7+pO9v/EQ96aN/uME61ewI=
Date:   Wed, 1 Jul 2020 13:58:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [V2 PATCH] usb: mtu3: fix NULL pointer dereference
Message-ID: <20200701115821.GA2184169@kroah.com>
References: <1593502942-24455-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593502942-24455-1-git-send-email-chunfeng.yun@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 03:42:22PM +0800, Chunfeng Yun wrote:
> Some pointers are dereferenced before successful checks.
> 
> Reported-by: Markus Elfring <Markus.Elfring@web.de>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: nothing changed, but abandon another patch
> ---
>  drivers/usb/mtu3/mtu3_gadget.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/mtu3/mtu3_gadget.c b/drivers/usb/mtu3/mtu3_gadget.c
> index f93732e..1689ca8 100644
> --- a/drivers/usb/mtu3/mtu3_gadget.c
> +++ b/drivers/usb/mtu3/mtu3_gadget.c
> @@ -332,14 +332,21 @@ static int mtu3_gadget_queue(struct usb_ep *ep,
>  
>  static int mtu3_gadget_dequeue(struct usb_ep *ep, struct usb_request *req)
>  {
> -	struct mtu3_ep *mep = to_mtu3_ep(ep);
> -	struct mtu3_request *mreq = to_mtu3_request(req);
> +	struct mtu3_ep *mep;
> +	struct mtu3_request *mreq;
>  	struct mtu3_request *r;
> +	struct mtu3 *mtu;
>  	unsigned long flags;
>  	int ret = 0;
> -	struct mtu3 *mtu = mep->mtu;
>  
> -	if (!ep || !req || mreq->mep != mep)
> +	if (!ep || !req)
> +		return -EINVAL;

How will either of those ever be NULL?  The kernel will not call this
function with either of them being NULL, right?

> +
> +	mep = to_mtu3_ep(ep);
> +	mtu = mep->mtu;
> +
> +	mreq = to_mtu3_request(req);
> +	if (mreq->mep != mep)
>  		return -EINVAL;
>  
>  	dev_dbg(mtu->dev, "%s : req=%p\n", __func__, req);
> @@ -373,8 +380,8 @@ static int mtu3_gadget_dequeue(struct usb_ep *ep, struct usb_request *req)
>   */
>  static int mtu3_gadget_ep_set_halt(struct usb_ep *ep, int value)
>  {
> -	struct mtu3_ep *mep = to_mtu3_ep(ep);
> -	struct mtu3 *mtu = mep->mtu;
> +	struct mtu3_ep *mep;
> +	struct mtu3 *mtu;
>  	struct mtu3_request *mreq;
>  	unsigned long flags;
>  	int ret = 0;
> @@ -382,6 +389,9 @@ static int mtu3_gadget_ep_set_halt(struct usb_ep *ep, int value)
>  	if (!ep)
>  		return -EINVAL;

Same here, how can that ever happen?

>  
> +	mep = to_mtu3_ep(ep);
> +	mtu = mep->mtu;
> +
>  	dev_dbg(mtu->dev, "%s : %s...", __func__, ep->name);
>  
>  	spin_lock_irqsave(&mtu->lock, flags);
> @@ -422,11 +432,12 @@ static int mtu3_gadget_ep_set_halt(struct usb_ep *ep, int value)
>  /* Sets the halt feature with the clear requests ignored */
>  static int mtu3_gadget_ep_set_wedge(struct usb_ep *ep)
>  {
> -	struct mtu3_ep *mep = to_mtu3_ep(ep);
> +	struct mtu3_ep *mep;
>  
>  	if (!ep)
>  		return -EINVAL;

Again, same here.

thanks,

greg k-h
