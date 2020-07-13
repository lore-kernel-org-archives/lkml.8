Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC6EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3CF2206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 14:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbgGMODl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 10:03:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:60886 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbgGMODk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 10:03:40 -0400
Received: from 89-64-85-181.dynamic.chello.pl (89.64.85.181) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.415)
 id c54b7b5dd9a458f8; Mon, 13 Jul 2020 16:03:38 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Len Brown <len.brown@intel.com>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/12] PM, libnvdimm: Add 'mem-quiet' state and callback for firmware activation
Date:   Mon, 13 Jul 2020 16:03:36 +0200
Message-ID: <9508531.urFA0jK61m@kreacher>
In-Reply-To: <CAPcyv4iiYMXO1fH0yQ2eBzpOWqPag0W=ebJwV6spGpNJQ9hnrg@mail.gmail.com>
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com> <23449996.3uVv1d17cZ@kreacher> <CAPcyv4iiYMXO1fH0yQ2eBzpOWqPag0W=ebJwV6spGpNJQ9hnrg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 9, 2020 9:04:30 PM CEST Dan Williams wrote:
> On Thu, Jul 9, 2020 at 7:57 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > On Tuesday, July 7, 2020 3:59:32 AM CEST Dan Williams wrote:
> > > The runtime firmware activation capability of Intel NVDIMM devices
> > > requires memory transactions to be disabled for 100s of microseconds.
> > > This timeout is large enough to cause in-flight DMA to fail and other
> > > application detectable timeouts. Arrange for firmware activation to be
> > > executed while the system is "quiesced", all processes and device-DMA
> > > frozen.
> > >
> > > It is already required that invoking device ->freeze() callbacks is
> > > sufficient to cease DMA. A device that continues memory writes outside
> > > of user-direction violates expectations of the PM core to be to
> > > establish a coherent hibernation image.
> > >
> > > That said, RDMA devices are an example of a device that access memory
> > > outside of user process direction. RDMA drivers also typically assume
> > > the system they are operating in will never be hibernated. A solution
> > > for RDMA collisions with firmware activation is outside the scope of
> > > this change and may need to rely on being able to survive the platform
> > > imposed memory controller quiesce period.
> >
> > Thanks for following my suggestion to use the hibernation infrastructure
> > rather than the suspend one, but I think it would be better to go a bit
> > further with that.
> >
> > Namely, after thinking about this a bit more I have come to the conclusion
> > that what is needed is an ability to execute a function, inside of the
> > kernel, in a "quiet" environment in which memory updates are unlikely.
> >
> > While the hibernation infrastructure as is can be used for that, kind of, IMO
> > it would be cleaner to introduce a helper for that, like in the (untested)
> > patch below, so if the "quiet execution environment" is needed, whoever
> > needs it may simply pass a function to hibernate_quiet_exec() and provide
> > whatever user-space I/F is suitable on top of that.
> >
> > Please let me know what you think.
> 
> This looks good to me in concept.
> 
> Would you expect that I trigger this from libnvdimm sysfs, or any
> future users of this functionality to trigger it through their own
> subsystem specific mechanisms?

Yes, I would.

> I have a place for it in libvdimm and could specify the activation
> method directly as "suspend" vs "live" activation.

Sounds good to me.

Cheers!



