Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C9CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:46:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 143DB2070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgGQJqF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:46:05 -0400
Received: from foss.arm.com ([217.140.110.172]:44868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgGQJqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:46:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D10830E;
        Fri, 17 Jul 2020 02:46:04 -0700 (PDT)
Received: from bogus (unknown [10.37.8.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5B39E3F66E;
        Fri, 17 Jul 2020 02:46:02 -0700 (PDT)
Date:   Fri, 17 Jul 2020 10:45:55 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Peng Fan <peng.fan@nxp.com>,
        "Paul J. Murphy" <paul.j.murphy@linux.intel.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Pass shmem address to SMCCC call
Message-ID: <20200717094555.GA24501@bogus>
References: <20200715165518.57558-1-daniele.alessandrelli@linux.intel.com>
 <5f74221b-aec7-7715-19d1-5cbb406f1bdc@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f74221b-aec7-7715-19d1-5cbb406f1bdc@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 03:43:24PM -0700, Florian Fainelli wrote:
>
>
> On 7/15/2020 9:55 AM, Daniele Alessandrelli wrote:
> > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> >
> > Currently, when SMC/HVC is used as transport, the base address of the
> > shared memory used for communication is not passed to the SMCCC call.
> > This means that such an address must be hard-coded into the bootloader.
> >
> > In order to increase flexibility and allow the memory layout to be
> > changed without modifying the bootloader, this patch adds the shared
> > memory base address to the a1 argument of the SMCCC call.
> >
> > On the Secure Monitor side, the service call implementation can
> > therefore read the a1 argument in order to know the location of the
> > shared memory to use. This change is backward compatible to existing
> > service call implementations as long as they don't check for a1 to be
> > zero.
>
> resource_size_t being defined after phys_addr_t, its size is different
> between 32-bit, 32-bit with PAE and 64-bit so it would probably make
> more sense to define an physical address alignment, or maybe an address
> that is in multiple of 4KBytes so you can address up to 36-bits of
> physical address even on a 32-bit only system?
>

Good point, I had forgotten about LPAE. Thanks for pointing it out.

> What discovery mechanism does the OS have that the specified address
> within the SMCCC call has been accepted by the firmware given the return
> value of that SMCCC call does not appear to be used or checked? Do we
> just expect a timeout initializing the SCMI subsystem?
>

Agreed, we need to add the check for proper return value then and
definitely document it very clearly as we are trying to standardise
a call to vendor SiP FID space of SMCCC.

> Given that the kernel must somehow reserve this memory as a shared
> memory area for obvious reasons, and the trusted firmware must also
> ensure it treats this memory region with specific permissions in its
> translation regime, does it really make sense to give that much flexibility?
>

I expect so and this comes as shmem property from DT already. We are
just passing the value obtained from there as is. This is just to help
TFA or the firmware to identify the specific channel/shmem as SMC/HVC
otherwise has no way to do so.

> If your boot loader has FDT patching capability, maybe it can also do a
> SMC call to provide the address to your trusted firmware, prior to
> loading the Linux kernel, and then they both agree, prior to boot about
> the shared memory address?
>

Yes, but we definitely can't rely on such mechanism in the kernel. It is
more a platform choice as they run different bootloaders.

--
Regards,
Sudeep
