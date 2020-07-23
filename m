Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD9DC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FBF622B43
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYGzU3Lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbgGWQRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:17:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28121 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727044AbgGWQRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:17:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595521065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3ya2q/pmXB2bMNADifztEkwpspxnV8zEC+vy/TVroGU=;
        b=hYGzU3Lk7urjfeOlexzYVPSbBZ5jvI3yPtbl13uLlcst1KuJvGFriItGCaeNZLhVDjo5bH
        dnUcMIczxIy1FaMuxZKK+ggbO/8XOYLj3Dcm7XSiFM05k6Q9vSa2o5jWX2EU5G63/ixmyU
        YBl7q/3CzvOfkkXclRU9yZW/4cC162s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-229-ItGpXHZ7MzKcHuwYcIw36w-1; Thu, 23 Jul 2020 12:17:42 -0400
X-MC-Unique: ItGpXHZ7MzKcHuwYcIw36w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCA4C80BCB2;
        Thu, 23 Jul 2020 16:17:37 +0000 (UTC)
Received: from w520.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B85511010427;
        Thu, 23 Jul 2020 16:17:35 +0000 (UTC)
Date:   Thu, 23 Jul 2020 10:17:35 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Alan Stern <stern@rowland.harvard.edu>
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
Message-ID: <20200723101735.3222c289@w520.home>
In-Reply-To: <20200723153821.GC1352396@rowland.harvard.edu>
References: <1595419068-4812-1-git-send-email-WeitaoWang-oc@zhaoxin.com>
        <20200722124414.GA3153105@kroah.com>
        <20200722145913.GB1310843@rowland.harvard.edu>
        <1bf449377e3448bc9c8bc7b64d7b7990@zhaoxin.com>
        <20200722221817.542971a2@x1.home>
        <20200723153821.GC1352396@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 11:38:21 -0400
Alan Stern <stern@rowland.harvard.edu> wrote:

> On Wed, Jul 22, 2020 at 10:18:17PM -0600, Alex Williamson wrote:
> > On Thu, 23 Jul 2020 02:59:55 +0000
> > "Weitao Wang(BJ-RD)" <WeitaoWang@zhaoxin.com> wrote:
> >  =20
> > > On , Jul 22, 2020 at 02:44:14PM +0200, Alan wrote: =20
> > > > On Wed, Jul 22, 2020 at 02:44:14PM +0200, Greg KH wrote:   =20
> > > > > On Wed, Jul 22, 2020 at 07:57:48PM +0800, WeitaoWangoc wrote:   =
=20
> > > > > > This bug is found in Zhaoxin platform, but it's a commom code b=
ug.
> > > > > > Fail sequence:
> > > > > > step1: Unbind UHCI controller from native driver;
> > > > > > step2: Bind UHCI controller to vfio-pci, which will put UHCI co=
ntroller in one   =20
> > > > vfio   =20
> > > > > >        group's device list and set UHCI's dev->driver_data to s=
truct   =20
> > > > vfio-pci(for UHCI)   =20
> > > > >
> > > > > Hah, that works?  How do you do that properly?  What code does th=
at?   =20
> > > >
> > > > Yeah, that can't possibly work.  The USB core expects that any host
> > > > controller device (or at least, any PCI host controller device) has=
 its
> > > > driver_data set to point to a struct usb_hcd.  It doesn't expect a =
host
> > > > controller to be bound to anything other than a host controller dri=
ver.
> > > >
> > > > Things could easily go very wrong here.  For example, suppose at th=
is
> > > > point the ehci-hcd driver just happens to bind to the EHCI controll=
er.
> > > > When this happens, the EHCI controller hardware takes over all the =
USB
> > > > connections that were routed to the UHCI controller.  How will vfio=
-pci
> > > > deal with that?  Pretty ungracefully, I imagine. =20
> >=20
> > The issue I believe we're seeing here is not with vfio-pci trying to do
> > anything with the device, the IOMMU grouping would prevent a user from
> > opening any device within the group while other devices within the
> > group are bound to host drivers. =20
>=20
> You've lost me.  (A) What is IOMMU grouping?  (B) How does it prevent=20
> users from opening devices?  (C) What do users have to do with the=20
> problem anyway (USB host controllers and drivers have to do things on=20
> their own even without user intervention)?

The alternate driver in question here is vfio-pci, which allows IOMMU
protected userspace driver access to a device.  A primary use case of
vfio is to assign PCI devices to a VM, where QEMU is the userspace
driver.  An IOMMU group is a set of one or more devices that are
considered to be DMA isolated from other groups of devices.  DMA
isolation includes, for instance, the potential for peer-to-peer
between devices which cannot be managed by the IOMMU.  DMA between PCIe
functions within a multifunction slot are generally considered to be
non-isolated from one another unless they implement PCIe Access Control
Services (ACS) to indicate isolation.  I've never seen a USB controller
implement ACS, nor should they due to the interactions between
functions, therefore all the USB functions within a slot will be
grouped together.

The vfio framework will not allow users to access groups for which some
of the devices within the group are bound to active host drivers,
therefore in this scenario where we have one USB function bound to a
host driver and the other bound to vfio-pci, the user would not be able
to access the device and the vfio-pci usage of the device is
essentially nothing more than a stub driver until driver binding of the
other devices within the group changes.  IOW, vfio-pci is not trying to
make use of the device with this split binding, the report here is only
a fault seen in the process of moving all of the functions to vfio-pci,
which would then make the devices accessible to the user.

> >  So it should be fine if the EHCI
> > device takes over the other ports, but it's not ok that ehci-hcd
> > assumes the driver private data for any other UHCI/OHCI/EHCI device in
> > the same slot is something that it's free to modify.  It really seems
> > there should be some sort of companion device registration/opt-in
> > rather than modifying unvalidated data. =20
>=20
> Until now that hasn't been necessary, since nobody wanted to bind a=20
> different driver to these devices.
>=20
> > > > The only way to make this work at all is to unbind both uhci-hcd and
> > > > ehci-hcd first.  Then after both are finished you can safely bind
> > > > vfio-pci to the EHCI controller and the UHCI controllers (in that
> > > > order).
> > > >   =20
> > > I'm agree with you, unbind both uhci-hcd and ehci-hcd first then bind=
 to
> > > vfio-pci is a more reasonable sequence. Our experiments prove that th=
is
> > > sequence is indeed good as expected.
> > > However, I did not find a formal document to prescribe this order.
> > > Unfortunately, some application software such as virt-manager/qemu as=
sign
> > > UHCI/EHCI to guest OS has the same bind/unbind sequence as test =E2=
=80=9Cby hand=E2=80=9D.
> > > Do we need to consider compatibility with this application scenario? =
=20
> >=20
> > Unbinding all functions first, before binding any to vfio-pci should
> > indeed work, thanks to the for_each_companion() function at least
> > testing for null private data before going further.  I'd still argue
> > though that these hcd drivers are overstepping their authority by
> > walking the PCI bus and assuming any device in the same slot, matching
> > a set of class codes, is making use of a driver with a known data
> > structure that they're allowed to modify. =20
>=20
> Until recently that has been a valid assumption.
>=20
> >  Even if we claim that the
> > user needs to know what they're doing when they change driver binding,
> > that's a pretty subtle interaction with no validation.  Thanks, =20
>=20
> It's worse than that.  We're not just dealing with a software=20
> interaction issue -- the _hardware_ for these devices also interacts. =20
> That's the real reason why the driver for the device on one slot has to=20
> be aware of the driver for the device on a different slot.
>=20
> Adding a mechanism for software registration or validation won't fix the=
=20
> hardware issues.  Relying on a protocol that requires all the devices to=
=20
> be unbound before any of them are bound to a new class of drivers, on=20
> the other hand, will fix the problem.

The IOMMU grouping restriction does solve the hardware issue, so long
as one driver doesn't blindly assume the driver private data for
another device and modify it.  I do agree that your solution would
work, requiring all devices are unbound before any can be bound, but it
also seems difficult to manage.  The issue is largely unique to USB
AFAIK.  On the other hand, drivers coordinating with each other to
register their _private_ data as share-able within a set of drivers
seems like a much more direct and explicit interaction between the
drivers.  Thanks,

Alex

