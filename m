Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D5B6C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F06207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgGQKIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:08:31 -0400
Received: from foss.arm.com ([217.140.110.172]:48054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgGQKI3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 06:08:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0042D6E;
        Fri, 17 Jul 2020 03:08:28 -0700 (PDT)
Received: from bogus (unknown [10.37.8.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18BAE3F66E;
        Fri, 17 Jul 2020 03:08:26 -0700 (PDT)
Date:   Fri, 17 Jul 2020 11:08:23 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        "Paul J. Murphy" <paul.j.murphy@linux.intel.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Subject: Re: [PATCH] firmware: arm_scmi: Pass shmem address to SMCCC call
Message-ID: <20200717100823.GB24501@bogus>
References: <20200715165518.57558-1-daniele.alessandrelli@linux.intel.com>
 <5f74221b-aec7-7715-19d1-5cbb406f1bdc@gmail.com>
 <b4d22e4a5154a9ad4c224eb2dfaeb61ed1680834.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4d22e4a5154a9ad4c224eb2dfaeb61ed1680834.camel@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 03:13:03PM +0100, Daniele Alessandrelli wrote:
> Hi Florian,
>
> Thanks for you feedback.
>
> On Wed, 2020-07-15 at 15:43 -0700, Florian Fainelli wrote:
> >
> > On 7/15/2020 9:55 AM, Daniele Alessandrelli wrote:
> > > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > >
> > > Currently, when SMC/HVC is used as transport, the base address of
> > > the
> > > shared memory used for communication is not passed to the SMCCC
> > > call.
> > > This means that such an address must be hard-coded into the
> > > bootloader.
> > >
> > > In order to increase flexibility and allow the memory layout to be
> > > changed without modifying the bootloader, this patch adds the
> > > shared
> > > memory base address to the a1 argument of the SMCCC call.
> > >
> > > On the Secure Monitor side, the service call implementation can
> > > therefore read the a1 argument in order to know the location of the
> > > shared memory to use. This change is backward compatible to
> > > existing
> > > service call implementations as long as they don't check for a1 to
> > > be
> > > zero.
> >
> > resource_size_t being defined after phys_addr_t, its size is
> > different
> > between 32-bit, 32-bit with PAE and 64-bit so it would probably make
> > more sense to define an physical address alignment, or maybe an
> > address
> > that is in multiple of 4KBytes so you can address up to 36-bits of
> > physical address even on a 32-bit only system?
>
> I see your point. After a quick look, I think that, practically, the
> issue is with ARM32 LPAE addresses, for which phys_addr_t is a u64. So,
> basically, for AArch32 systems with LPAE the 64-bit shmem_paddr gets
> truncated to 32-bit when it's passed to the SMC32/HVC32 call.
>
> To solve that, I would prefer splitting the address between two SMC
> parameters (a1 = addr_lo, a2 = addr_hi), instead of imposing an
> arbitrary alignment. Would that be reasonable?
>

Again beware of the fact that this is vendor SiP FID space of SMCCC.
Standardising that informally inside the Linux kernel is already bit
risky and challenging. I don't want to complicate it with above
splitting of address way.

> >
> > What discovery mechanism does the OS have that the specified address
> > within the SMCCC call has been accepted by the firmware given the
> > return
> > value of that SMCCC call does not appear to be used or checked? Do we
> > just expect a timeout initializing the SCMI subsystem?
>
> The return code is actually checked at the end of the function:
> https://elixir.bootlin.com/linux/v5.8-rc4/source/drivers/firmware/arm_scmi/smc.c#L118
>
> But in the meantime scmi_rx_callback() has already been called. Not
> sure if that's intentional or a possible bug.
>

Yes, thanks for the catch. Not sure if it was intentional, Peng ?
Even if it was I would like to fix as it is unnecessary to read response
from shmem which may have garbage or the input itself when the command
returns error.

> >
> > Given that the kernel must somehow reserve this memory as a shared
> > memory area for obvious reasons, and the trusted firmware must also
> > ensure it treats this memory region with specific permissions in its
> > translation regime, does it really make sense to give that much
> > flexibility?
>
> Well, the trusted firmware might reserve a bigger region to be used for
> other service as well. In other words, the MMU of TF-A is not necessary
> specifically set up for this region, but, possibly, for a bigger
> general shared region.
>
> Passing the SCMI shmem to the SMC call allows the shmem to be moved
> within such bigger shared memory without modifying the trusted
> firmware.
>

I am not entirely sure about this. I see this base address here as a
unique identifier referred in the SCMI specification(5.1.3.1 Doorbell):

"If the doorbell is SMC or HVC based, it should follow the SMC Calling
Convention [SMCCC]. The doorbell needs to provide the identifier of
the Shared Memory area that contains the payload. The Shared Memory area
containing the payload is updated with the SCMI return response when the
call returns. The identifier of the Shared Memory area should be 32-bits
and each identifier should map to a distinct Shared Memory area."

Sorry I seem to have missed the 32-bit part here when I said yes for
using address as the identifier. I wasn't explicit before when I said
I was OK for the address as 2nd parameter.

Now I recall that I was thinking about additional/optional property from
DT for this identifier, absence of which will be passing 0 as the id.

> >
> > If your boot loader has FDT patching capability, maybe it can also do
> > a
> > SMC call to provide the address to your trusted firmware, prior to
> > loading the Linux kernel, and then they both agree, prior to boot
> > about
> > the shared memory address?
>
> Yes, that's a possible solution, but it looks more complicated to me,
> since it adds an additional component (the boot loader) to the
> equation, while the goal of this patch was to reduce the coupling
> between components (namely the DT/kernel and the trusted firmware).
>

I agree with you too along with Florian's idea but I don't want to
rely on that in the kernel.

> I guess my question is: if we fix the handling of LPAE addresses and
> the SMC return code, what is the drawback of having the shmem address
> passed to the SMC?
>

My main worry is the 32-bit identifier as specified in the spec now. I
had missed that aspect in the spec when I agreed to use the address.

> Anyway, I should have mentioned this in the commit message (sorry for
> not doing so), but I submitted this patch because initial feedback from
> Sudeep was positive [1]; but if there is no consensus around it I'm
> fine with dropping it.
>
> [1] https://lore.kernel.org/lkml/20200710075931.GB1189@bogus/
>

Yes I am fine with the idea of adding identifier for distinguishing the
shmem if there are multiple channels. I haven't brought the idea of
changing that address w/o modifying TFA/firmware as IMO it is not that
simple. Florian has covered the reasons for the same already.

--
Regards,
Sudeep
