Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE589C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACB112072F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591775841;
	bh=i0GKyEEgP/d/WJmGZui0xw8vOIPmyZHfPnzNhX2dXNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AezP9vqcYVqjYYJMQirZQW7smmbXMq4aw6xQkZG68nAyfNvY5t8mjLpOE+viH5ipr
	 vZ5COg8ybkyuR47ZQEoUaZps44JL1UR6ShaVOqp79i2Xww4oHVvGeRBX/LCTdsim3Z
	 K3ViFj/gyAlhrxIECeKAQIKuT/decXzcRZnYiL74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgFJH5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:57:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726512AbgFJH5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:57:18 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AE8A206C3;
        Wed, 10 Jun 2020 07:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591775836;
        bh=i0GKyEEgP/d/WJmGZui0xw8vOIPmyZHfPnzNhX2dXNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oxMoP3RQ2ZxDZxQTVNc7pdMDGnBLbnF57UtXv+oyWa4vg9Hb5X4nGwZgiUStJ6RMQ
         Sm9U7RUCEGHGt2X1UAxqeI3BNMCWnXNcVHvwLeZzs2JIdF+8XyUHUBX3O0Q8dM7HZb
         vpCZBYiRTIqYWBlpmD2TuPFmrBAnDOXYjA7iEn7w=
Date:   Wed, 10 Jun 2020 08:57:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        tabba@google.com, qwandor@google.com, ardb@kernel.org
Subject: Re: [RFC PATCH 0/3] firmware: Add support for PSA FF-A interface
Message-ID: <20200610075711.GC15939@willie-the-truck>
References: <20200601094512.50509-1-sudeep.holla@arm.com>
 <20200604133746.GA2951@willie-the-truck>
 <20200609174123.GA5732@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200609174123.GA5732@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Tue, Jun 09, 2020 at 06:41:23PM +0100, Sudeep Holla wrote:
> On Thu, Jun 04, 2020 at 02:37:46PM +0100, Will Deacon wrote:
> > On Mon, Jun 01, 2020 at 10:45:09AM +0100, Sudeep Holla wrote:
> > > Sorry for posting in the middle of merge window and I must have done
> > > this last week itself. This is not the driver I had thought about posting
> > > last week. After I started cleaning up and looking at Will's KVM prototype[1]
> > > for PSA FF-A (previously known as SPCI),
> >
> > Yes, I need to do the Big Rename at some point. Joy.
> >
> 
> 😁 

Renamed version here:

https://android-kvm.googlesource.com/linux/+/refs/heads/willdeacon/psa-ffa

although I haven't psyched myself up to write yaml yet.

> > Setting the static RX/TX buffer allocation aside, why is a DT node needed
> > at all for the case where Linux is running purely as an FF-A client? I
> > thought everything should be discoverable via FFA_VERSION, FFA_FEATURES,
> > FFA_PARTITION_INFO_GET and FFA_ID_GET? That should mean we can get away
> > without a binding at all for the client case.
> >
> 
> Agreed, I added for RxTx buffers and initially to build the parent/child
> hierarchy for all users of the driver. Initially I was assuming only
> in-kernel users and now I agree we should avoid any in kernel users if
> possible.
> 
> One thing to note FFA_PARTITION_INFO_GET relies on Rx buffers to send the
> information to the caller. So we need to have established buffers before
> that and one of the reason you don't find that in this RFC. I dropped that
> too which I wanted initially.

Ok, sounds like we should at least get to a position where we can enumerate
things, though.

> > > Sorry for long email and too many questions, but I thought it is easier
> > > this way to begin with than throwing huge code implementing loads of APIs
> > > with no users(expect example partition) especially that I am posting this
> > > during merge window.
> >
> > No problem. Maybe it would help if I described roughly what we were thinking
> > of doing for KVM (this is open for discussion, of course):
> >
> >  1. Describe KVM-managed partitions in the DT, along the lines of [1]
> >  2. Expose each partition as a file to userspace. E.g.:
> >
> >     /dev/spci/:
> >
> > 	self
> > 	e3a48fa5-dc54-4a8b-898b-bdc4dfeeb7b8
> > 	49f65057-d002-4ae2-b4ee-d31c7940a13d
> >
> >     Here, self would be a symlink to the host uuid. The host uuid file
> >     would implement FFA_MEM operations using an ioctl(), so you could,
> >     for example, share a user buffer with multiple partitions by issuing
> >     a MEM_SHARE ioctl() on self, passing the fds for the borrower partitions
> >     as arguments. Messaging would be implemented as ioctl()s on the
> >     partition uuid files themselves.
> >
> 
> OK, IIUC that covers mostly KVM implementation. We still need a way to
> share the RxTx buffer info to the partitions and DT/ACPI(?) is one
> possible way. Based on you comment about not needing DT node, do you have
> any other way to communicate the buffer info to the partitions ?

This is only a concern if KVM chooses to provide the Rx/Tx buffer pair
though, right? If we punt that down the road for the moment, then we can
just rely on FFA_RXTX_MAP for now.

> > For communicating with partitions that are not managed by KVM (e.g. trusted
> > applications), it's not clear to me how much of that will be handled in
> > kernel or user. I think it would still be worth exposing the partitions as
> > files, but perhaps having them root only or just returning -EPERM for the
> > ioctl() if a kernel driver has claimed the partition as its own? Ideally,
> > FF-A would allow us to transition some of the Trusted OS interfacing code
> > out to userspace, but I don't know how realistic that is.
> >
> 
> Ah good, so we can still manage in-kernel users this way but we need to
> provide interface to such a driver which I agree that we need to avoid
> if possible.
> 
> > Anyway, to enable this, I think we need a clear separation in the kernel
> > between the FF-A code and the users:
> Agreed.
> 
> > KVM will want to expose things as above, but if drivers need to use this
> > stuff as well then they can plug in as additional users and we don't have to
> > worry about tripping over the RX/TX buffers etc.
> >
> 
> I am confused a bit. When you refer drivers above, are you referring to
> drivers in host kernel(hypervisor) or in the partitions. I fail to
> imagine need for the former.

I'm referring to in-kernel users in the host kernel. For KVM-managed guests,
we may not need these, although signalling things like system shutdown might
be better off done without relying on userspace. But my point is really that
separating the buffer management from the users means we can serialise
consumers, whether they are in-kernel or out in userspace.

> > What do you think, and do you reckon you can spin a cut-down driver that
> > implements the common part of the logic (since I know you've written much
> > of this code already)?
> >
> 
> I am not sure if I am aligned with your thoughts on the buffer sharing
> yet.

Ok, please let me know if you have any more questions.

Will
