Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7189C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11D5208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588258013;
	bh=aYO5VMgCMKsvgPngEI5AIQWgzzrYXij9AqpKosMbAEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pYb1Rs7AfMZC1vDOoPILUOOWe94v24S+iCtVpMC5YxC7BWUVYtmdkzXKKklM9vyrS
	 5/2QeOT6Mg/DNX4oxwizZIcg2VSnhoDbwypf8pwYJgjYNYIWoJX4O4fO9FwmXsEnjf
	 PvWxeKalKccZkLQWqnV0MELAoEm8oiHL6SQlT7Zk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgD3Oqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:46:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgD3Oqw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:46:52 -0400
Received: from localhost (unknown [122.182.217.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52C5120873;
        Thu, 30 Apr 2020 14:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588258012;
        bh=aYO5VMgCMKsvgPngEI5AIQWgzzrYXij9AqpKosMbAEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WO9Xh6vycyGrEyqikYT9gI9xtPOBLQLi6dAf8JX81WxpUBqDKUZ7MO4GIjr86atKu
         qVsLXD3JTrobn/FJzqv3cAyQtk8gFRTCMqMA+9lAdzFj+zp2yViwmKw6Jrs9Nf9+kf
         xLbabOrPC4OaWNZpLmBIOZJbu8+5uZiILJaioMUg=
Date:   Thu, 30 Apr 2020 20:16:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        John Stultz <john.stultz@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andreas =?iso-8859-1?Q?B=F6hler?= <dev@aboehler.at>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 2/5] usb: renesas-xhci: Add the renesas xhci driver
Message-ID: <20200430144641.GJ948789@vkoul-mobl.Dlink>
References: <20200430101019.1130956-1-vkoul@kernel.org>
 <20200430101019.1130956-3-vkoul@kernel.org>
 <8ffd119b-192f-8fcc-46cc-3a405e30338c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ffd119b-192f-8fcc-46cc-3a405e30338c@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-04-20, 17:36, Mathias Nyman wrote:
> On 30.4.2020 13.10, Vinod Koul wrote:
> > From: Christian Lamparter <chunkeey@googlemail.com>
> > 
> > This add a new driver for renesas xhci which is basically a firmware
> > loader for uPD720201 and uPD720202 w/o ROM. It uses xhci-pci driver for
> > most of the work.
> > 
> > This is added in Makefile before the xhci-pci driver so that it first
> > get probed for renesas devices before the xhci-pci driver has a chance
> > to claim any device.
> 
> Most of the above is no longer correct

Yes that is correct now, this para need to go.

> > diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> > index b191361257cc..c3a79f626393 100644
> > --- a/drivers/usb/host/Makefile
> > +++ b/drivers/usb/host/Makefile
> > @@ -70,7 +70,8 @@ obj-$(CONFIG_USB_OHCI_HCD_DAVINCI)	+= ohci-da8xx.o
> >  obj-$(CONFIG_USB_UHCI_HCD)	+= uhci-hcd.o
> >  obj-$(CONFIG_USB_FHCI_HCD)	+= fhci.o
> >  obj-$(CONFIG_USB_XHCI_HCD)	+= xhci-hcd.o
> > -obj-$(CONFIG_USB_XHCI_PCI)	+= xhci-pci.o
> > +usb-xhci-pci-objs		:= xhci-pci.o xhci-pci-renesas.o
> > +obj-$(CONFIG_USB_XHCI_PCI)	+= usb-xhci-pci.o
> 
> I don't think it's a good idea to rename the xhci-pci module to usb-xhci-pci
> 
> does
> 
> xhci-pci-y			:= xhci-pci.o xhci-pci-renesas.o
> obj-$(CONFIG_USB_XHCI_PCI)	+= xhci-pci.o
> 
> cause some kbuild issues?

Yes with this version I get the warning:
make[4]: Circular drivers/usb/host/xhci-pci.o <- drivers/usb/host/xhci-pci.o dependency dropped.

I don't speak enough Kbuild, but I guess it does make sense that we have
xhci-pci.o as target for both xhci-pci.o xhci-pci-renesas.o! That was
the reason for adding usb tag to this to resolve the conflict.

I am okay for any other mechanism which can work well here. Btw what
issues do you foresee with adding usb tag to module name.

-- 
~Vinod
