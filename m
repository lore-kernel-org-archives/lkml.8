Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79895C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 04:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5597820737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 04:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQGIGFIa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgGWES0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 00:18:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37007 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726115AbgGWES0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 00:18:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595477905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wwl4F50oKkswHT9apgjy+aI/48kVRlBCaDpskw3i4WE=;
        b=MQGIGFIav5djzroqLzt1XT+1rRoYcbfwn1fCytFcbXOjgiy5STlZdZAkMKNZTvG8DNC81h
        rQf72zuW5nWCdX1cOGMKCw6zoSnZPFZB0C2MmpV/x9CzMpHjB7zGc8vRy1aYIt+HbXqFxC
        bLSFlEpHDvJo3bvf0sElZaCuR44DdcQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-dBpKknZyOf2oV-LpXVbrVg-1; Thu, 23 Jul 2020 00:18:21 -0400
X-MC-Unique: dBpKknZyOf2oV-LpXVbrVg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5706106B245;
        Thu, 23 Jul 2020 04:18:18 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 918D888D41;
        Thu, 23 Jul 2020 04:18:17 +0000 (UTC)
Date:   Wed, 22 Jul 2020 22:18:17 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Weitao Wang(BJ-RD)" <WeitaoWang@zhaoxin.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
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
        "Tony W. Wang(XA-RD)" <TonyWWang@zhaoxin.com>,
        "Cobe Chen(BJ-RD)" <CobeChen@zhaoxin.com>,
        "Tim Guo(BJ-RD)" <TimGuo@zhaoxin.com>,
        "wwt8723@163.com" <wwt8723@163.com>
Subject: Re: [PATCH] USB:Fix kernel NULL pointer when unbind UHCI form
 vfio-pci
Message-ID: <20200722221817.542971a2@x1.home>
In-Reply-To: <1bf449377e3448bc9c8bc7b64d7b7990@zhaoxin.com>
References: <1595419068-4812-1-git-send-email-WeitaoWang-oc@zhaoxin.com>
        <20200722124414.GA3153105@kroah.com>
        <20200722145913.GB1310843@rowland.harvard.edu>
        <1bf449377e3448bc9c8bc7b64d7b7990@zhaoxin.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 02:59:55 +0000
"Weitao Wang(BJ-RD)" <WeitaoWang@zhaoxin.com> wrote:

> On , Jul 22, 2020 at 02:44:14PM +0200, Alan wrote:
> > On Wed, Jul 22, 2020 at 02:44:14PM +0200, Greg KH wrote: =20
> > > On Wed, Jul 22, 2020 at 07:57:48PM +0800, WeitaoWangoc wrote: =20
> > > > This bug is found in Zhaoxin platform, but it's a commom code bug.
> > > > Fail sequence:
> > > > step1: Unbind UHCI controller from native driver;
> > > > step2: Bind UHCI controller to vfio-pci, which will put UHCI contro=
ller in one =20
> > vfio =20
> > > >        group's device list and set UHCI's dev->driver_data to struc=
t =20
> > vfio-pci(for UHCI) =20
> > >
> > > Hah, that works?  How do you do that properly?  What code does that? =
=20
> >
> > Yeah, that can't possibly work.  The USB core expects that any host
> > controller device (or at least, any PCI host controller device) has its
> > driver_data set to point to a struct usb_hcd.  It doesn't expect a host
> > controller to be bound to anything other than a host controller driver.
> >
> > Things could easily go very wrong here.  For example, suppose at this
> > point the ehci-hcd driver just happens to bind to the EHCI controller.
> > When this happens, the EHCI controller hardware takes over all the USB
> > connections that were routed to the UHCI controller.  How will vfio-pci
> > deal with that?  Pretty ungracefully, I imagine.

The issue I believe we're seeing here is not with vfio-pci trying to do
anything with the device, the IOMMU grouping would prevent a user from
opening any device within the group while other devices within the
group are bound to host drivers.  So it should be fine if the EHCI
device takes over the other ports, but it's not ok that ehci-hcd
assumes the driver private data for any other UHCI/OHCI/EHCI device in
the same slot is something that it's free to modify.  It really seems
there should be some sort of companion device registration/opt-in
rather than modifying unvalidated data.

> > The only way to make this work at all is to unbind both uhci-hcd and
> > ehci-hcd first.  Then after both are finished you can safely bind
> > vfio-pci to the EHCI controller and the UHCI controllers (in that
> > order).
> > =20
> I'm agree with you, unbind both uhci-hcd and ehci-hcd first then bind to
> vfio-pci is a more reasonable sequence. Our experiments prove that this
> sequence is indeed good as expected.
> However, I did not find a formal document to prescribe this order.
> Unfortunately, some application software such as virt-manager/qemu assign
> UHCI/EHCI to guest OS has the same bind/unbind sequence as test =E2=80=9C=
by hand=E2=80=9D.
> Do we need to consider compatibility with this application scenario?

Unbinding all functions first, before binding any to vfio-pci should
indeed work, thanks to the for_each_companion() function at least
testing for null private data before going further.  I'd still argue
though that these hcd drivers are overstepping their authority by
walking the PCI bus and assuming any device in the same slot, matching
a set of class codes, is making use of a driver with a known data
structure that they're allowed to modify.  Even if we claim that the
user needs to know what they're doing when they change driver binding,
that's a pretty subtle interaction with no validation.  Thanks,

Alex

