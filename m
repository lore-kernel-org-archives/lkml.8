Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B03C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD2E2071A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:38:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbgGWQih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:38:37 -0400
Received: from netrider.rowland.org ([192.131.102.5]:58361 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727044AbgGWQig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:38:36 -0400
Received: (qmail 1358681 invoked by uid 1000); 23 Jul 2020 12:38:35 -0400
Date:   Thu, 23 Jul 2020 12:38:35 -0400
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
Message-ID: <20200723163835.GA1357775@rowland.harvard.edu>
References: <1595419068-4812-1-git-send-email-WeitaoWang-oc@zhaoxin.com>
 <20200722124414.GA3153105@kroah.com>
 <20200722145913.GB1310843@rowland.harvard.edu>
 <1bf449377e3448bc9c8bc7b64d7b7990@zhaoxin.com>
 <20200722221817.542971a2@x1.home>
 <20200723153821.GC1352396@rowland.harvard.edu>
 <20200723101735.3222c289@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200723101735.3222c289@w520.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 10:17:35AM -0600, Alex Williamson wrote:
> The IOMMU grouping restriction does solve the hardware issue, so long
> as one driver doesn't blindly assume the driver private data for
> another device and modify it.

Correction: The IOMMU grouping restriction solves the hardware issue for 
vfio-pci.  It won't necessarily help if some other driver comes along 
and wants to bind to this hardware.

>   I do agree that your solution would
> work, requiring all devices are unbound before any can be bound, but it
> also seems difficult to manage.  The issue is largely unique to USB
> AFAIK.  On the other hand, drivers coordinating with each other to
> register their _private_ data as share-able within a set of drivers
> seems like a much more direct and explicit interaction between the
> drivers.  Thanks,

Yes, that makes sense.  But it would have to be implemented in the 
driver core, not in particular subsystems like USB or PCI.  And it might 
be seen as overkill, given that only UHCI/OHCI/EHCI devices require this 
sort of sharing AFAIK.

Also, when you think about it, what form would such coordination among 
drivers take?  From your description, it sounds like the drivers would 
agree to avoid accessing each other's private data if the proper 
registration wasn't in place.

On the other hand, a stronger and perhaps more robust approach would be 
to enforce the condition that non-cooperating drivers are never bound to 
devices in the same group at the same time.  That's basically what I'm 
proposing here -- the question is whether the enforcement should be 
instituted in the kernel or should merely be part of a standard protocol 
followed by userspace drivers.

Given that it's currently needed in only one place, it seems reasonable 
to leave this as a "gentlemen's agreement" in userspace for the time 
being instead of adding it to the kernel.

Alan Stern
