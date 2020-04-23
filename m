Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5904C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84E85214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 14:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587652293;
	bh=lI3x3Wgxq/DlxqjieCrseB2CoKABPYFIihFQcs7uAuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vh34MlxEcvFcBgAQpXvt+xNxNUsDq0G7BpjhBVkiL3/yYbvGi1qnvddh2OeFYyION
	 tqXNS5wEe0s9DEQoOJcjuJlEsBj3y+0C/FeA7y1gZkUeiTW7ZH6NvnsQAU4+BwT36i
	 nOIcKAZIdEhPn/w22X+iPPK1A52DZ1LkqM0+ZAbo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbgDWObd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 10:31:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:39034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgDWObc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 10:31:32 -0400
Received: from localhost (unknown [117.99.83.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33AF020728;
        Thu, 23 Apr 2020 14:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587652292;
        bh=lI3x3Wgxq/DlxqjieCrseB2CoKABPYFIihFQcs7uAuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fRY+2kfDUSjwGHmBG3P90xdDtebN6Az+VfjTLoi322j7th4zLubnSAoTZtg00p35q
         bX1IFR1EU3Kup5TwP2TnQNn+JjmeYQY6J9F2Vm41UYl5DoiS2en+iR8Bj6iZcy+8+e
         1Nlm3C+PJAgLj1MAYEpM7AIV9qZycz6NUMIAdw9o=
Date:   Thu, 23 Apr 2020 20:01:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        John Stultz <john.stultz@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andreas =?iso-8859-1?Q?B=F6hler?= <dev@aboehler.at>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 3/5] usb: xhci: Add support for Renesas controller
 with memory
Message-ID: <20200423143127.GK72691@vkoul-mobl>
References: <20200414164152.2786474-1-vkoul@kernel.org>
 <20200414164152.2786474-4-vkoul@kernel.org>
 <f61fbae0-28c5-c7ad-383f-2017a9e8597d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f61fbae0-28c5-c7ad-383f-2017a9e8597d@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-04-20, 17:07, Mathias Nyman wrote:
> On 14.4.2020 19.41, Vinod Koul wrote:
> > Some rensas controller like uPD720201 and uPD720202 need firmware to be
> > loaded. Add these devices in table and invoke renesas firmware loader
> > functions to check and load the firmware into device memory when
> > required.
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  drivers/usb/host/xhci-pci.c | 33 +++++++++++++++++++++++++++++++++
> >  drivers/usb/host/xhci.h     |  1 +
> >  2 files changed, 34 insertions(+)
> > 
> > diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> > index b6c2f5c530e3..11521e2e1720 100644
> > --- a/drivers/usb/host/xhci-pci.c
> > +++ b/drivers/usb/host/xhci-pci.c
> > @@ -15,6 +15,7 @@
> >  
> >  #include "xhci.h"
> >  #include "xhci-trace.h"
> > +#include "xhci-pci.h"
> >  
> >  #define SSIC_PORT_NUM		2
> >  #define SSIC_PORT_CFG2		0x880c
> > @@ -328,6 +329,21 @@ static int xhci_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
> >  	int retval;
> >  	struct xhci_hcd *xhci;
> >  	struct usb_hcd *hcd;
> > +	struct xhci_driver_data *driver_data;
> > +
> > +	driver_data = (struct xhci_driver_data *)id->driver_data;
> > +
> > +	if (driver_data && driver_data->quirks & XHCI_RENESAS_FW_QUIRK) {
> > +		retval = renesas_xhci_pci_probe(dev, id);
> > +		switch (retval) {
> > +		case 0: /* fw check success, continue */
> > +			break;
> > +		case 1: /* fw will be loaded by async load */
> > +			return 0;
> 
> This is no longer true, right?

Correct.

> To me it looks like renesas_xhci_pci_probe() returns 0 on success, both if
> firmware was already running or if successfully loaded, and negative on error

Yes now it does that and I will update this part..
> 
> While changing this the function name "renesas_xhci_pci_probe()" should be
> changed as well. This isn't anymore a separate firmware loading driver, just a
> a lot of renesas firmware loading code.
> 
> You could call renesas_xhci_check_request_fw() directly instead:
> 
> 	if (driver_data && driver_data->quirks & XHCI_RENESAS_FW_QUIRK) {
> 		retval = renesas_xhci_check_request_fw(dev, id);
> 		if (retval)
> 			return retval;
> 	}

Yes I can remove this layer and directly invoke the internal function..

Thanks for the comments

-- 
~Vinod
