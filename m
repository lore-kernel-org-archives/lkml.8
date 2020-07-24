Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B48FC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A750206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 19:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxBmKivf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgGXTRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:17:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26063 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726572AbgGXTRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 15:17:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595618237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJj/7mTJTokfFN7V2SBXvCQ6TJ6IN4DPcE0cHn1s29c=;
        b=CxBmKivfJaKx+RiMkJeQYD4/c0/Kg5lTuE8xgboLRdk/szxaVv18+89/XeExAxK9IrqkPH
        QEJ209rK67mlSVtF77pL7G1Iq5kumsSJtVWV9+RQNav/cqyoQtu6/rsPjeizcjAdcaEBHo
        TIZbpgJtV41dlD5klgY8xVC7wW3Uukk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-6BoaiVaGM7ebz50loHlDeQ-1; Fri, 24 Jul 2020 15:17:13 -0400
X-MC-Unique: 6BoaiVaGM7ebz50loHlDeQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D39CF800464;
        Fri, 24 Jul 2020 19:17:10 +0000 (UTC)
Received: from x1.home (ovpn-112-71.phx2.redhat.com [10.3.112.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80C546FEFE;
        Fri, 24 Jul 2020 19:17:09 +0000 (UTC)
Date:   Fri, 24 Jul 2020 13:17:08 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     WeitaoWang-oc <WeitaoWang-oc@zhaoxin.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
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
Message-ID: <20200724131708.0a0f3358@x1.home>
In-Reply-To: <11a7a3e67d6c40cd9fd06cd4d6300283@zhaoxin.com>
References: <1595419068-4812-1-git-send-email-WeitaoWang-oc@zhaoxin.com>
        <20200722124414.GA3153105@kroah.com>
        <20200722145913.GB1310843@rowland.harvard.edu>
        <1bf449377e3448bc9c8bc7b64d7b7990@zhaoxin.com>
        <20200722221817.542971a2@x1.home>
        <20200723153821.GC1352396@rowland.harvard.edu>
        <20200723101735.3222c289@w520.home>
        <20200723163835.GA1357775@rowland.harvard.edu>
        <11a7a3e67d6c40cd9fd06cd4d6300283@zhaoxin.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 12:57:49 +0000
WeitaoWang-oc <WeitaoWang-oc@zhaoxin.com> wrote:

> On Thu, 23 Jul 2020 12:38:21 -0400, Alan wrote:
> > On Thu, Jul 23, 2020 at 10:17:35AM -0600, Alex Williamson wrote:  
> > > The IOMMU grouping restriction does solve the hardware issue, so long
> > > as one driver doesn't blindly assume the driver private data for
> > > another device and modify it.  
> > 
> > Correction: The IOMMU grouping restriction solves the hardware issue for
> > vfio-pci.  It won't necessarily help if some other driver comes along
> > and wants to bind to this hardware.
> >   
> > >   I do agree that your solution would
> > > work, requiring all devices are unbound before any can be bound, but it
> > > also seems difficult to manage.  The issue is largely unique to USB
> > > AFAIK.  On the other hand, drivers coordinating with each other to
> > > register their _private_ data as share-able within a set of drivers
> > > seems like a much more direct and explicit interaction between the
> > > drivers.  Thanks,  
> > 
> > Yes, that makes sense.  But it would have to be implemented in the
> > driver core, not in particular subsystems like USB or PCI.  And it might
> > be seen as overkill, given that only UHCI/OHCI/EHCI devices require this
> > sort of sharing AFAIK.
> > 
> > Also, when you think about it, what form would such coordination among
> > drivers take?  From your description, it sounds like the drivers would
> > agree to avoid accessing each other's private data if the proper
> > registration wasn't in place.
> > 
> > On the other hand, a stronger and perhaps more robust approach would be
> > to enforce the condition that non-cooperating drivers are never bound to
> > devices in the same group at the same time.  That's basically what I'm
> > proposing here -- the question is whether the enforcement should be
> > instituted in the kernel or should merely be part of a standard protocol
> > followed by userspace drivers.
> > 
> > Given that it's currently needed in only one place, it seems reasonable
> > to leave this as a "gentlemen's agreement" in userspace for the time
> > being instead of adding it to the kernel.
> > 	  
> 
> Provided that EHCI and UHCI host controller declare not support P2P and
> ACS. So, we can assign EHCI and UHCI host controller to different IOMMU 
> group separately. We assign EHCI host controller to host and assign UHCI
> host controller to VM. Then, ehci_hcd driver load/unload operation in host
> will cause the same issue as discussed

And you have an example of such a device?  I expect these do not exist,
nor should they.  It seems like it would be an improper use of ACS.
Thanks,

Alex

