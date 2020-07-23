Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38293C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D090206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729576AbgGWPiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:38:22 -0400
Received: from netrider.rowland.org ([192.131.102.5]:41639 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727885AbgGWPiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:38:22 -0400
Received: (qmail 1355350 invoked by uid 1000); 23 Jul 2020 11:38:21 -0400
Date:   Thu, 23 Jul 2020 11:38:21 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     "Weitao Wang\(BJ-RD\)" <WeitaoWang@zhaoxin.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        WeitaoWang-oc <WeitaoWang-oc@zhaoxin.com>,
        "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "hslester96@gmail.com" <hslester96@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Carsten_Schmid@mentor.com" <Carsten_Schmid@mentor.com>,
        "efremov@linux.com" <efremov@linux.com>,
        "Tony W. Wang\(XA-RD\)" <TonyWWang@zhaoxin.com>,
        "Cobe Chen\(BJ-RD\)" <CobeChen@zhaoxin.com>,
        "Tim Guo\(BJ-RD\)" <TimGuo@zhaoxin.com>,
        "wwt8723@163.com" <wwt8723@163.com>
Subject: Re: [PATCH] USB:Fix kernel NULL pointer when unbind UHCI form
 vfio-pci
Message-ID: <20200723153821.GC1352396@rowland.harvard.edu>
References: <1595419068-4812-1-git-send-email-WeitaoWang-oc@zhaoxin.com>
 <20200722124414.GA3153105@kroah.com>
 <20200722145913.GB1310843@rowland.harvard.edu>
 <1bf449377e3448bc9c8bc7b64d7b7990@zhaoxin.com>
 <20200722221817.542971a2@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200722221817.542971a2@x1.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 10:18:17PM -0600, Alex Williamson wrote:
> On Thu, 23 Jul 2020 02:59:55 +0000
> "Weitao Wang(BJ-RD)" <WeitaoWang@zhaoxin.com> wrote:
> 
> > On , Jul 22, 2020 at 02:44:14PM +0200, Alan wrote:
> > > On Wed, Jul 22, 2020 at 02:44:14PM +0200, Greg KH wrote:  
> > > > On Wed, Jul 22, 2020 at 07:57:48PM +0800, WeitaoWangoc wrote:  
> > > > > This bug is found in Zhaoxin platform, but it's a commom code bug.
> > > > > Fail sequence:
> > > > > step1: Unbind UHCI controller from native driver;
> > > > > step2: Bind UHCI controller to vfio-pci, which will put UHCI controller in one  
> > > vfio  
> > > > >        group's device list and set UHCI's dev->driver_data to struct  
> > > vfio-pci(for UHCI)  
> > > >
> > > > Hah, that works?  How do you do that properly?  What code does that?  
> > >
> > > Yeah, that can't possibly work.  The USB core expects that any host
> > > controller device (or at least, any PCI host controller device) has its
> > > driver_data set to point to a struct usb_hcd.  It doesn't expect a host
> > > controller to be bound to anything other than a host controller driver.
> > >
> > > Things could easily go very wrong here.  For example, suppose at this
> > > point the ehci-hcd driver just happens to bind to the EHCI controller.
> > > When this happens, the EHCI controller hardware takes over all the USB
> > > connections that were routed to the UHCI controller.  How will vfio-pci
> > > deal with that?  Pretty ungracefully, I imagine.
> 
> The issue I believe we're seeing here is not with vfio-pci trying to do
> anything with the device, the IOMMU grouping would prevent a user from
> opening any device within the group while other devices within the
> group are bound to host drivers.

You've lost me.  (A) What is IOMMU grouping?  (B) How does it prevent 
users from opening devices?  (C) What do users have to do with the 
problem anyway (USB host controllers and drivers have to do things on 
their own even without user intervention)?

>  So it should be fine if the EHCI
> device takes over the other ports, but it's not ok that ehci-hcd
> assumes the driver private data for any other UHCI/OHCI/EHCI device in
> the same slot is something that it's free to modify.  It really seems
> there should be some sort of companion device registration/opt-in
> rather than modifying unvalidated data.

Until now that hasn't been necessary, since nobody wanted to bind a 
different driver to these devices.

> > > The only way to make this work at all is to unbind both uhci-hcd and
> > > ehci-hcd first.  Then after both are finished you can safely bind
> > > vfio-pci to the EHCI controller and the UHCI controllers (in that
> > > order).
> > >  
> > I'm agree with you, unbind both uhci-hcd and ehci-hcd first then bind to
> > vfio-pci is a more reasonable sequence. Our experiments prove that this
> > sequence is indeed good as expected.
> > However, I did not find a formal document to prescribe this order.
> > Unfortunately, some application software such as virt-manager/qemu assign
> > UHCI/EHCI to guest OS has the same bind/unbind sequence as test “by hand”.
> > Do we need to consider compatibility with this application scenario?
> 
> Unbinding all functions first, before binding any to vfio-pci should
> indeed work, thanks to the for_each_companion() function at least
> testing for null private data before going further.  I'd still argue
> though that these hcd drivers are overstepping their authority by
> walking the PCI bus and assuming any device in the same slot, matching
> a set of class codes, is making use of a driver with a known data
> structure that they're allowed to modify.

Until recently that has been a valid assumption.

>  Even if we claim that the
> user needs to know what they're doing when they change driver binding,
> that's a pretty subtle interaction with no validation.  Thanks,

It's worse than that.  We're not just dealing with a software 
interaction issue -- the _hardware_ for these devices also interacts.  
That's the real reason why the driver for the device on one slot has to 
be aware of the driver for the device on a different slot.

Adding a mechanism for software registration or validation won't fix the 
hardware issues.  Relying on a protocol that requires all the devices to 
be unbound before any of them are bound to a new class of drivers, on 
the other hand, will fix the problem.

Alan Stern
