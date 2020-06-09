Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B453C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CCD92074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 17:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbgFIRlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 13:41:35 -0400
Received: from foss.arm.com ([217.140.110.172]:45884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728603AbgFIRlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 13:41:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFDAB1F1;
        Tue,  9 Jun 2020 10:41:32 -0700 (PDT)
Received: from bogus (unknown [10.37.12.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1ECB93F73D;
        Tue,  9 Jun 2020 10:41:30 -0700 (PDT)
Date:   Tue, 9 Jun 2020 18:41:23 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        tabba@google.com, qwandor@google.com, ardb@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH 0/3] firmware: Add support for PSA FF-A interface
Message-ID: <20200609174123.GA5732@bogus>
References: <20200601094512.50509-1-sudeep.holla@arm.com>
 <20200604133746.GA2951@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200604133746.GA2951@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry for the delay, got distracted with some other bug fix.)

On Thu, Jun 04, 2020 at 02:37:46PM +0100, Will Deacon wrote:
> Hi Sudeep, [+Fuad, Andrew and Ard]
>
> (To other interested readers: if you haven't seen it, the FF-A spec is here:
>  https://static.docs.arm.com/den0077/a/DEN0077A_PSA_Firmware_Framework_Arm_v8-A_1.0_EAC.pdf
>  since this discussion makes no sense without that, and a tiny bit of sense
>  with it. It used to be called "SPCI" but it was recently renamed.)
>

Thanks for adding all interested parties.

> On Mon, Jun 01, 2020 at 10:45:09AM +0100, Sudeep Holla wrote:
> > Sorry for posting in the middle of merge window and I must have done
> > this last week itself. This is not the driver I had thought about posting
> > last week. After I started cleaning up and looking at Will's KVM prototype[1]
> > for PSA FF-A (previously known as SPCI),
>
> Yes, I need to do the Big Rename at some point. Joy.
>

😁 

> > I got more doubts on alignment and dropped huge chunk of interface APIs in
> > the driver in order to keep it simple, and get aligned more with that
> > prototype and avoid scanning lots of code unnecessary.
>
> You also dropped most of the code, so this doesn't really do anything in
> its current form ;)
>

Yes, it was intentional 😉 

> > Here are few things to clarify:
> >
> > 1. DT bindings
> > ---------------
> > 	I was initially against adding bindings for Tx/Rx buffers for
> > 	partitions. As per the spec, an endpoint could allocate the
> > 	buffer pair and use the FFA_RXTX_MAP interface to map it with the
> > 	Hypervisor(KVM here). However looking at the prototype and also
> > 	I remember you mentioning that it is not possible to manage buffers
> > 	in that way. Please confirm if you plan to add the buffer details
> > 	fetcthing them through ioctls in KVM and adding them to VM DT nodes
> > 	in KVM userspace. I will update the bindings accordingly.
>
> I think it's useful to have a mode of operation where the hypervisor
> allocates the RX/TX buffers and advertises them in the DT. However, we
> can always add this later, so there's no need to have it in the binding
> from the start. Best start as simple as possible, I reckon.
>

OK

> Setting the static RX/TX buffer allocation aside, why is a DT node needed
> at all for the case where Linux is running purely as an FF-A client? I
> thought everything should be discoverable via FFA_VERSION, FFA_FEATURES,
> FFA_PARTITION_INFO_GET and FFA_ID_GET? That should mean we can get away
> without a binding at all for the client case.
>

Agreed, I added for RxTx buffers and initially to build the parent/child
hierarchy for all users of the driver. Initially I was assuming only
in-kernel users and now I agree we should avoid any in kernel users if
possible.

One thing to note FFA_PARTITION_INFO_GET relies on Rx buffers to send the
information to the caller. So we need to have established buffers before
that and one of the reason you don't find that in this RFC. I dropped that
too which I wanted initially.

> > 2. Driver
> > ---------
> > a. Support for multiple partitions in a VM
> > ------------------------------------------
> > 	I am not sure if there is need for supporting multiple partitions
> > 	within a VM. It should be possible to do so as I expect to create
> > 	device for each partition entry under arm-psa-ffa devicetree node.
> > 	However, I don't want to assume something that will never be a
> > 	usecase. However I don't think this will change must of the
> > 	abstraction as we need to keep the interface API implementation
> > 	separate to support different partitions on various platforms.
>
> I think Ard has a case for something like this, where a VM actually consists
> of multiple partitions so that S-EL0 services can be provided from NS-EL0.
> However, he probably wants that for a dynamically created VM, so we'd
> need a way to instantiate an FFA namespace for the VM. Maybe that can be
> done entirely in userspace by the VMM...
>

Interesting...

> > b. SMCCC interface
> > ------------------
> > 	This is something I messed up completely while trying to add
> > 	support for SMCCC v1.2. It now supports x0-x17 as parameter
> > 	registers(input) and return registers(output). I started simple
> > 	with x0-x7 as both input and output as PSA FF-A needs that at
> > 	most. But extending to x0-x17 then became with messy in my
> > 	implementation. That's the reason I dropped it completely
> > 	here and thought of checking it first.
> >
> > 	Do we need to extend the optimisations that were done to handle
> > 	ARCH_WORKAROUND_{1,2}. Or should be just use a version with x0-x7
> > 	as both input and ouput. Hyper-V guys need full x0-x17 support.
> >
> > 	I need some guidance as what is the approach preferred ?
>
> I think we can start off with x0-x7 and extend if later if we need to.
>

Sure

> > 3. Partitions
> > -------------
> > 	I am not sure if we have a full define partition that we plan to
> > 	push upstream. Without one, we can have a sample/example partition
> > 	to test all the interface APIs, but is that fine with respect to
> > 	what we want upstream ? Any other thoughts that helps to test the
> > 	driver ?
>
> I think that's the best you can do for now. We can probably help with
> testing as our stuff gets off the ground.
>

OK

> > Sorry for long email and too many questions, but I thought it is easier
> > this way to begin with than throwing huge code implementing loads of APIs
> > with no users(expect example partition) especially that I am posting this
> > during merge window.
>
> No problem. Maybe it would help if I described roughly what we were thinking
> of doing for KVM (this is open for discussion, of course):
>
>  1. Describe KVM-managed partitions in the DT, along the lines of [1]
>  2. Expose each partition as a file to userspace. E.g.:
>
>     /dev/spci/:
>
> 	self
> 	e3a48fa5-dc54-4a8b-898b-bdc4dfeeb7b8
> 	49f65057-d002-4ae2-b4ee-d31c7940a13d
>
>     Here, self would be a symlink to the host uuid. The host uuid file
>     would implement FFA_MEM operations using an ioctl(), so you could,
>     for example, share a user buffer with multiple partitions by issuing
>     a MEM_SHARE ioctl() on self, passing the fds for the borrower partitions
>     as arguments. Messaging would be implemented as ioctl()s on the
>     partition uuid files themselves.
>

OK, IIUC that covers mostly KVM implementation. We still need a way to
share the RxTx buffer info to the partitions and DT/ACPI(?) is one
possible way. Based on you comment about not needing DT node, do you have
any other way to communicate the buffer info to the partitions ?

>  3. We'll need some (all?) of these patches to unmap memory from the host
>     when necessary:
>
>     https://lwn.net/Articles/821215/
>
>     (for nVHE, we'll have a stage-2 for the host so we can unmap there as
>     well)
>

Sounds more fun.

> For communicating with partitions that are not managed by KVM (e.g. trusted
> applications), it's not clear to me how much of that will be handled in
> kernel or user. I think it would still be worth exposing the partitions as
> files, but perhaps having them root only or just returning -EPERM for the
> ioctl() if a kernel driver has claimed the partition as its own? Ideally,
> FF-A would allow us to transition some of the Trusted OS interfacing code
> out to userspace, but I don't know how realistic that is.
>

Ah good, so we can still manage in-kernel users this way but we need to
provide interface to such a driver which I agree that we need to avoid
if possible.

> Anyway, to enable this, I think we need a clear separation in the kernel
> between the FF-A code and the users:
Agreed.

> KVM will want to expose things as above, but if drivers need to use this
> stuff as well then they can plug in as additional users and we don't have to
> worry about tripping over the RX/TX buffers etc.
>

I am confused a bit. When you refer drivers above, are you referring to
drivers in host kernel(hypervisor) or in the partitions. I fail to
imagine need for the former.

> What do you think, and do you reckon you can spin a cut-down driver that
> implements the common part of the logic (since I know you've written much
> of this code already)?
>

I am not sure if I am aligned with your thoughts on the buffer sharing
yet.

--
Regards,
Sudeep
