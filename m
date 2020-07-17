Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA4BC433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 325772076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgGQO7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:59:18 -0400
Received: from mga09.intel.com ([134.134.136.24]:9052 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbgGQO7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:59:18 -0400
IronPort-SDR: i4EZKVes78tRBl5DHtyTeIfGRNOxm6s+466ZTr3IMc3+dN8wCfrmcvAy1Vptlp/86vOzFwufhk
 YLUtgl7ALs3A==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="150980058"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="150980058"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 07:59:17 -0700
IronPort-SDR: Wm0+cJlTU1BiR9UmPbBVNJ+2ELECDjX8RZL5SSrzqXQlX/w5p7Iz1zPPytKBIA+w1xsxZmEC9K
 r/YaOXEWC7qw==
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="scan'208";a="460870755"
Received: from enaessen-mobl1.ger.corp.intel.com ([10.251.86.9])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 07:59:14 -0700
Message-ID: <c1e73640ce30bc08dfb8da72a3c3fc34f7f0e44d.camel@linux.intel.com>
Subject: Re: [PATCH] firmware: arm_scmi: Pass shmem address to SMCCC call
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        "Paul J. Murphy" <paul.j.murphy@linux.intel.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Date:   Fri, 17 Jul 2020 15:59:10 +0100
In-Reply-To: <20200717103120.GC24501@bogus>
References: <20200715165518.57558-1-daniele.alessandrelli@linux.intel.com>
         <5f74221b-aec7-7715-19d1-5cbb406f1bdc@gmail.com>
         <b4d22e4a5154a9ad4c224eb2dfaeb61ed1680834.camel@linux.intel.com>
         <faa53c11-3c72-9b9b-85ad-9d234f373b4d@gmail.com>
         <20200717103120.GC24501@bogus>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-17 at 11:31 +0100, Sudeep Holla wrote:
> On Thu, Jul 16, 2020 at 12:57:23PM -0700, Florian Fainelli wrote:
> > 
> > On 7/16/2020 7:13 AM, Daniele Alessandrelli wrote:
> > > Hi Florian,
> > > 
> > > Thanks for you feedback.
> > > 
> > > On Wed, 2020-07-15 at 15:43 -0700, Florian Fainelli wrote:
> > > > On 7/15/2020 9:55 AM, Daniele Alessandrelli wrote:
> > > > > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > > > > 
> > > > > Currently, when SMC/HVC is used as transport, the base
> > > > > address of
> > > > > the
> > > > > shared memory used for communication is not passed to the
> > > > > SMCCC
> > > > > call.
> > > > > This means that such an address must be hard-coded into the
> > > > > bootloader.
> > > > > 
> > > > > In order to increase flexibility and allow the memory layout
> > > > > to be
> > > > > changed without modifying the bootloader, this patch adds the
> > > > > shared
> > > > > memory base address to the a1 argument of the SMCCC call.
> > > > > 
> > > > > On the Secure Monitor side, the service call implementation
> > > > > can
> > > > > therefore read the a1 argument in order to know the location
> > > > > of the
> > > > > shared memory to use. This change is backward compatible to
> > > > > existing
> > > > > service call implementations as long as they don't check for
> > > > > a1 to
> > > > > be
> > > > > zero.
> > > > 
> > > > resource_size_t being defined after phys_addr_t, its size is
> > > > different
> > > > between 32-bit, 32-bit with PAE and 64-bit so it would probably
> > > > make
> > > > more sense to define an physical address alignment, or maybe an
> > > > address
> > > > that is in multiple of 4KBytes so you can address up to 36-bits 
> > > > of
> > > > physical address even on a 32-bit only system?
> > > 
> > > I see your point. After a quick look, I think that, practically,
> > > the
> > > issue is with ARM32 LPAE addresses, for which phys_addr_t is a
> > > u64. So,
> > > basically, for AArch32 systems with LPAE the 64-bit shmem_paddr
> > > gets
> > > truncated to 32-bit when it's passed to the SMC32/HVC32 call.
> > > 
> > > To solve that, I would prefer splitting the address between two
> > > SMC
> > > parameters (a1 = addr_lo, a2 = addr_hi), instead of imposing an
> > > arbitrary alignment. Would that be reasonable?
> > 
> > The low/high part would only be relevant on a 32-bit LPAE platform
> > which
> > is probably a corner case, I would just pass the shmem_paddr / 4096
> > since that is the smallest granule size and alignment possible and
> > it
> > still allows you to map up to 36-bits of physical address, which is
> > the
> > maximum that the long descriptor in LPAE can support. For 64-bit we
> > have
> > no such problems since we have the full register width.
> > 
> 
> OK, I will check if 32-bit identifier can be relaxed in the spec in
> which
> case we can avoid having DT binding for the identifier. If that is
> possible
> we could use addr/4k page size.
> 
> > > > What discovery mechanism does the OS have that the specified
> > > > address
> > > > within the SMCCC call has been accepted by the firmware given
> > > > the
> > > > return value of that SMCCC call does not appear to be used or
> > > > checked? Do
> > > > we just expect a timeout initializing the SCMI subsystem?
> > > 
> > > The return code is actually checked at the end of the function:
> > > https://elixir.bootlin.com/linux/v5.8-rc4/source/drivers/firmware/arm_scmi/smc.c#L118
> > > 
> > > But in the meantime scmi_rx_callback() has already been called.
> > > Not
> > > sure if that's intentional or a possible bug.
> > > 
> > > > Given that the kernel must somehow reserve this memory as a
> > > > shared
> > > > memory area for obvious reasons, and the trusted firmware must
> > > > also
> > > > ensure it treats this memory region with specific permissions
> > > > in its
> > > > translation regime, does it really make sense to give that much
> > > > flexibility?
> 
> I share same opinion as Florian here.
> 
> [...]
> 
> > > > If your boot loader has FDT patching capability, maybe it can
> > > > also do
> > > > a SMC call to provide the address to your trusted firmware,
> > > > prior to
> > > > loading the Linux kernel, and then they both agree, prior to
> > > > boot
> > > > about the shared memory address?
> > > 
> > > Yes, that's a possible solution, but it looks more complicated to
> > > me,
> > > since it adds an additional component (the boot loader) to the
> > > equation, while the goal of this patch was to reduce the coupling
> > > between components (namely the DT/kernel and the trusted
> > > firmware).
> > > 
> > > I guess my question is: if we fix the handling of LPAE addresses
> > > and
> > > the SMC return code, what is the drawback of having the shmem
> > > address
> > > passed to the SMC?
> > 
> > My only concern is that if somehow Linux gets assigned a shared
> > memory
> > range that is completely outside of what the trusted firmware has
> > already mapped, or is capable of addressing, or any combination
> > thereof,
> > it could be challenging to debug what is going on, especially if
> > INVALID
> > PARAMETER must not be returned (assuming this is to avoid Linux
> > discovering where other shared memory areas pertaining to the
> > firmware
> > reside?).
> > 
> 
> Valid point. Again, I was planning to use this as identifier and
> didn't
> think of the usecase Daniele mentions here.
> 
> > The other concern I have is that we are not documenting the various
> > SMCCC calling conventions, soon enough it will be come out of
> > control,
> > and we are already allowing people to define their own function IDs
> > and
> > parameters to call into the trusted firmware. This sounds like
> > something
> > that is so basic that it should be standardized from the top, by
> > ARM.
> > 
> 
> Completely agreed. I have failed to achieve that myself. Unless there
> is
> demand from partners/vendors, it will be dismissed by architects. All
> I managed to get in was the identifier as the argument for SMC/HVC to
> support multiple channels. However 32-bit id will be issue to be used
> with 64-bit address. I will see if we can drop that 32-bit
> requirement
> from the spec.

It seems that there is some demand already, but perhaps it needs to be
requested in a more official way? What is the recommended way to do so?

> 
> > > Anyway, I should have mentioned this in the commit message (sorry
> > > for
> > > not doing so), but I submitted this patch because initial
> > > feedback from
> > > Sudeep was positive [1]; but if there is no consensus around it
> > > I'm
> > > fine with dropping it.
> > > 
> > > [1] https://lore.kernel.org/lkml/20200710075931.GB1189@bogus/
> > 
> > My review is by no means authoritative however in deploying SCMI on
> > our
> > Broadcom STB platforms some experience was gained in the process
> > which
> > is how it piqued my interest. Thanks for providing more background
> > to
> > this patch, this does help.
> > 
> 
> Your knowledge is important and please always share the same and
> happy
> to take all your review into consideration always. End goal is to
> help
> all or most of the users of the driver if possible.
> 
> > We have opted for a solution where the boot loader knows about all
> > possible reserved regions prior to booting/loading the trusted
> > firmware
> > as well as the kernel, therefore it can pass that information to
> > both
> > and we never really had a situation where the two need to evolve in
> > an
> > uncoordinated way.
> 
> I agree and uncoordinated evolution may not be as simple as it is
> presented by Daniele earlier and I am not confident to support that.
> The main reason for giving positive response for this initially is
> for the addition of identifier which I always thought is required for
> supporting multiple channels. E.g. DVFS/Perf has dedicated channel.

I can see now that in the previous discussion there was some
misunderstanding on the intended use case. That's fine, I will drop the
patch for now, since hard-coding the shmem address in our trusted
firmware is fine with us (and so we don't really need this patch).

> 
> --
> Regards,
> Sudeep

