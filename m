Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62A7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 00:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF7020825
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 00:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbgGWA74 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 20:59:56 -0400
Received: from kernel.crashing.org ([76.164.61.194]:42458 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgGWA74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 20:59:56 -0400
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 06N0x954029225
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 22 Jul 2020 19:59:14 -0500
Message-ID: <35a367f7d71014cf9a6890abc248e18a3d07bc35.camel@kernel.crashing.org>
Subject: Re: [PATCH] usb: gadget: net2280: fix memory leak on probe error
 handling paths
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Evgeny Novikov <novikov@ispras.ru>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Corentin Labbe <clabbe@baylibre.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ldv-project@linuxtesting.org" <ldv-project@linuxtesting.org>
Date:   Thu, 23 Jul 2020 10:59:06 +1000
In-Reply-To: <2097231595446720@mail.yandex.ru>
References: <20200721201558.20069-1-novikov@ispras.ru>
         <20200722141741.GA1310843@rowland.harvard.edu>
         <2097231595446720@mail.yandex.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-22 at 22:56 +0300, Evgeny Novikov wrote:
> Hi Alan,
> 
> I have neither an appropriate hardware nor an experience to deal with
> issues that you mentioned. Our framework does not allow to detect
> them as well at the moment. At last, it seems that rather many
> drivers can suffer from these issues. So, it would be much better if
> somebody else will suggest necessary fixes and test them carefully.
> 
> BTW, you have already discussed the race within net2280_remove() with
> my colleague about 3 years ago. But you did not achieve a consensus
> at that time and no fixes were made after all.
> 
> Anyway, one can consider both issues independently on the one fixed
> by the patch.

FYI. It looks like I'm likely to resume my work on that driver in the
next few weeks in which case I could probably look into these Alan.

Cheers,
Ben.


> -- 
> Evgeny Novikov
> Linux Verification Center, ISP RAS
> http://linuxtesting.org
> 
> 22.07.2020, 17:17, "Alan Stern" <stern@rowland.harvard.edu>:
> > On Tue, Jul 21, 2020 at 11:15:58PM +0300, Evgeny Novikov wrote:
> > >  Driver does not release memory for device on error handling
> > > paths in
> > >  net2280_probe() when gadget_release() is not registered yet.
> > > 
> > >  The patch fixes the bug like in other similar drivers.
> > > 
> > >  Found by Linux Driver Verification project (linuxtesting.org).
> > > 
> > >  Signed-off-by: Evgeny Novikov <novikov@ispras.ru>
> > >  ---
> > >   drivers/usb/gadget/udc/net2280.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > >  diff --git a/drivers/usb/gadget/udc/net2280.c
> > > b/drivers/usb/gadget/udc/net2280.c
> > >  index 5eff85eeaa5a..d5fe071b2db2 100644
> > >  --- a/drivers/usb/gadget/udc/net2280.c
> > >  +++ b/drivers/usb/gadget/udc/net2280.c
> > >  @@ -3781,8 +3781,10 @@ static int net2280_probe(struct pci_dev
> > > *pdev, const struct pci_device_id *id)
> > >           return 0;
> > > 
> > >   done:
> > >  - if (dev)
> > >  + if (dev) {
> > >                   net2280_remove(pdev);
> > >  + kfree(dev);
> > >  + }
> > >           return retval;
> > >   }
> > 
> > This patch seems to be the tip of an iceberg. Following through its
> > implications led to a couple of discoveries.
> > 
> > usb_del_gadget_udc() calls device_unregister(&gadget->dev). Once
> > this
> > call returns, gadget has to be regarded as a stale pointer. But the
> > very next line of code does:
> > 
> >         memset(&gadget->dev, 0x00, sizeof(gadget->dev));
> > 
> > for no apparent reason. I'm amazed this hasn't caused problems
> > already.
> > Is there any justification for keeping this memset? It's hard to
> > imagine that it does any good.
> > 
> > Similarly, net2280_remove() calls usb_del_gadget_udc(&dev->gadget)
> > at
> > its start, and so dev must be a stale pointer for the entire
> > remainder
> > of the routine. But it gets used repeatedly. Surely we ought to
> > have
> > a device_get() and device_put() in there.
> > 
> > Alan Stern

