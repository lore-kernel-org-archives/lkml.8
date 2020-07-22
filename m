Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBAFC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C0620729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732432AbgGVORm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:17:42 -0400
Received: from netrider.rowland.org ([192.131.102.5]:54667 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726003AbgGVORm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:17:42 -0400
Received: (qmail 1312491 invoked by uid 1000); 22 Jul 2020 10:17:41 -0400
Date:   Wed, 22 Jul 2020 10:17:41 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Evgeny Novikov <novikov@ispras.ru>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Corentin Labbe <clabbe@baylibre.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: Re: [PATCH] usb: gadget: net2280: fix memory leak on probe error
 handling paths
Message-ID: <20200722141741.GA1310843@rowland.harvard.edu>
References: <20200721201558.20069-1-novikov@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721201558.20069-1-novikov@ispras.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 11:15:58PM +0300, Evgeny Novikov wrote:
> Driver does not release memory for device on error handling paths in
> net2280_probe() when gadget_release() is not registered yet.
> 
> The patch fixes the bug like in other similar drivers.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
> ---
>  drivers/usb/gadget/udc/net2280.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
> index 5eff85eeaa5a..d5fe071b2db2 100644
> --- a/drivers/usb/gadget/udc/net2280.c
> +++ b/drivers/usb/gadget/udc/net2280.c
> @@ -3781,8 +3781,10 @@ static int net2280_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	return 0;
>  
>  done:
> -	if (dev)
> +	if (dev) {
>  		net2280_remove(pdev);
> +		kfree(dev);
> +	}
>  	return retval;
>  }

This patch seems to be the tip of an iceberg.  Following through its 
implications led to a couple of discoveries.

usb_del_gadget_udc() calls device_unregister(&gadget->dev).  Once this 
call returns, gadget has to be regarded as a stale pointer.  But the 
very next line of code does:

	memset(&gadget->dev, 0x00, sizeof(gadget->dev));

for no apparent reason.  I'm amazed this hasn't caused problems already.  
Is there any justification for keeping this memset?  It's hard to 
imagine that it does any good.

Similarly, net2280_remove() calls usb_del_gadget_udc(&dev->gadget) at 
its start, and so dev must be a stale pointer for the entire remainder 
of the routine.  But it gets used repeatedly.  Surely we ought to have 
a device_get() and device_put() in there.

Alan Stern
