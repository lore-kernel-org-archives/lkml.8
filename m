Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA96AC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ECC6217BA
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgIGPJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:09:41 -0400
Received: from netrider.rowland.org ([192.131.102.5]:58485 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730114AbgIGO7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:59:01 -0400
Received: (qmail 763064 invoked by uid 1000); 7 Sep 2020 10:59:00 -0400
Date:   Mon, 7 Sep 2020 10:59:00 -0400
From:   "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
To:     Hamish Martin <Hamish.Martin@alliedtelesis.co.nz>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] usb: ohci: Add per-port overcurrent quirk
Message-ID: <20200907145900.GC762136@rowland.harvard.edu>
References: <20200904032247.11345-1-hamish.martin@alliedtelesis.co.nz>
 <20200904032247.11345-2-hamish.martin@alliedtelesis.co.nz>
 <20200904154517.GB694058@rowland.harvard.edu>
 <9ba7b4dda9ef40e3c4c9b3f1c33075e04601ef61.camel@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ba7b4dda9ef40e3c4c9b3f1c33075e04601ef61.camel@alliedtelesis.co.nz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 01:50:10AM +0000, Hamish Martin wrote:
> Hi Alan,
> 
> Thanks for your quick feedback. My replies are inline below.
> 
> On Fri, 2020-09-04 at 11:45 -0400, Alan Stern wrote:
> > On Fri, Sep 04, 2020 at 03:22:46PM +1200, Hamish Martin wrote:
> > > Some integrated OHCI controller hubs do not expose all ports of the
> > > hub
> > > to pins on the SoC. In some cases the unconnected ports generate
> > > spurious overcurrent events. For example the Broadcom 56060/Ranger
> > > 2 SoC
> > > contains a nominally 3 port hub but only the first port is wired.
> > > 
> > > Default behaviour for ohci-platform driver is to use "ganged"
> > > overcurrent protection mode. This leads to the spurious overcurrent
> > > events affecting all ports in the hub.
> > > 
> > > Allow this to be rectified by specifying per-port overcurrent
> > > protection
> > > mode via the device tree.
> > > 
> > > Signed-off-by: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
> > > ---
> > >  drivers/usb/host/ohci-hcd.c      | 4 ++++
> > >  drivers/usb/host/ohci-platform.c | 3 +++
> > >  drivers/usb/host/ohci.h          | 1 +
> > >  3 files changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-
> > > hcd.c
> > > index dd37e77dae00..01e3d75e29d9 100644
> > > --- a/drivers/usb/host/ohci-hcd.c
> > > +++ b/drivers/usb/host/ohci-hcd.c
> > > @@ -687,6 +687,10 @@ static int ohci_run (struct ohci_hcd *ohci)
> > >  		val |= RH_A_NPS;
> > >  		ohci_writel (ohci, val, &ohci->regs->roothub.a);
> > >  	}
> > > +	if (ohci->flags & OHCI_QUIRK_PER_PORT_OC) {
> > > +		val |= RH_A_OCPM;
> > > +		ohci_writel(ohci, val, &ohci->regs->roothub.a);
> > > +	}
> > 
> > I don't think this is right, for two reasons.  First, isn't per-port 
> > overcurrent protection the default?
> 
> Not as far as I understand the current code. Just above where my patch
> applies, the RH_A_OCPM (and RH_A_PSM) bits are explicitly cleared in
> 'val' with:
>     val &= ~(RH_A_PSM | RH_A_OCPM);
> 
> This, coupled with the OHCI_QUIRK_HUB_POWER being set by virtue of the
> 'distrust_firmware' module param defaulting true, reads to me like the
> default is for ganged over-current protection. And that is my
> experience in this case. 

You're right about that.  I hadn't noticed before; it makes little sense 
to have a quirk that defaults to true.

It's not easy to tell the full story from the kernel history; that 
module parameter predates the Git era.  I did learn that it was modified 
in 2.6.3-rc3 and goes back even farther: see

	https://marc.info/?l=linux-usb-devel&m=110628457424684&w=2

> If none of the quirks are selected then all of the fiddling with 'val'
> never gets written to 'ohci->regs->roothub.a'
> 
> I'd appreciate your reading of that analysis because I'm by no means
> sure of it.
> 
> > 
> > Second, RH_A_OCPM doesn't do anything unless RH_A_NOCP is clear.
> 
> Correct, and that is my mistake. If I progress to a v2 of this patch I
> will update accordingly.

Shall we try changing the parameter's default value?  The USB subsystem 
is a lot more mature and reliable now than it was back in 2004.

Alan Stern
