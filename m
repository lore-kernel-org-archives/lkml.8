Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE36FC433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB8E2083E
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgH3VWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 17:22:51 -0400
Received: from netrider.rowland.org ([192.131.102.5]:42775 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726179AbgH3VWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 17:22:51 -0400
Received: (qmail 528317 invoked by uid 1000); 30 Aug 2020 17:22:49 -0400
Date:   Sun, 30 Aug 2020 17:22:49 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     trix@redhat.com
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        natechancellor@gmail.com, ndesaulniers@google.com,
        christophe.jaillet@wanadoo.fr, peter.chen@nxp.com, b-liu@ti.com,
        chunfeng.yun@mediatek.com, novikov@ispras.ru, yanaijie@huawei.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: net2272: assert for a valid dma request
Message-ID: <20200830212249.GA528080@rowland.harvard.edu>
References: <20200830183646.24930-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830183646.24930-1-trix@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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

This patch really seems to be overkill.  In particular, Linus Torvalds 
feels very strongly that people should not add BUG or BUG_ON calls 
except in extreme situations -- which this isn't.

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

There's no point in adding this.  If the function goes on to dereference 
a NULL pointer, you'll get the same effect in any case -- an oops.

If you want to make the point that req had better not be NULL, just get 
rid of the "if" test entirely.  You could even change the list_entry to 
list_first_entry.

Alan Stern
