Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AD5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25BA1207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgGPONP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:13:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:54539 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726537AbgGPONN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:13:13 -0400
IronPort-SDR: DKGO7TGHVNJ277zNQTqkVc/mXBl7mCqbE2CBkGF6GdAgPmIgFYvHOU0qmRxz6gXnDZzr0NiiQE
 WFAzl8/0jJ1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="150762277"
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; 
   d="scan'208";a="150762277"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 07:13:11 -0700
IronPort-SDR: YUFmZip9rdFMIzQSQOog48cRe8PWI2Qm8HnMO8YJy1e1uPyxpkW1X644OLnrPBnv1v5qM/lvVc
 VvSsrAmHxPbg==
X-IronPort-AV: E=Sophos;i="5.75,359,1589266800"; 
   d="scan'208";a="308644306"
Received: from unknown (HELO dalessan-mobl1.ir.intel.com) ([10.251.86.10])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 07:13:09 -0700
Message-ID: <b4d22e4a5154a9ad4c224eb2dfaeb61ed1680834.camel@linux.intel.com>
Subject: Re: [PATCH] firmware: arm_scmi: Pass shmem address to SMCCC call
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Peng Fan <peng.fan@nxp.com>,
        "Paul J. Murphy" <paul.j.murphy@linux.intel.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        linux-kernel@vger.kernel.org,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Date:   Thu, 16 Jul 2020 15:13:03 +0100
In-Reply-To: <5f74221b-aec7-7715-19d1-5cbb406f1bdc@gmail.com>
References: <20200715165518.57558-1-daniele.alessandrelli@linux.intel.com>
         <5f74221b-aec7-7715-19d1-5cbb406f1bdc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

Thanks for you feedback.

On Wed, 2020-07-15 at 15:43 -0700, Florian Fainelli wrote:
> 
> On 7/15/2020 9:55 AM, Daniele Alessandrelli wrote:
> > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > 
> > Currently, when SMC/HVC is used as transport, the base address of
> > the
> > shared memory used for communication is not passed to the SMCCC
> > call.
> > This means that such an address must be hard-coded into the
> > bootloader.
> > 
> > In order to increase flexibility and allow the memory layout to be
> > changed without modifying the bootloader, this patch adds the
> > shared
> > memory base address to the a1 argument of the SMCCC call.
> > 
> > On the Secure Monitor side, the service call implementation can
> > therefore read the a1 argument in order to know the location of the
> > shared memory to use. This change is backward compatible to
> > existing
> > service call implementations as long as they don't check for a1 to
> > be
> > zero.
> 
> resource_size_t being defined after phys_addr_t, its size is
> different
> between 32-bit, 32-bit with PAE and 64-bit so it would probably make
> more sense to define an physical address alignment, or maybe an
> address
> that is in multiple of 4KBytes so you can address up to 36-bits of
> physical address even on a 32-bit only system?

I see your point. After a quick look, I think that, practically, the
issue is with ARM32 LPAE addresses, for which phys_addr_t is a u64. So,
basically, for AArch32 systems with LPAE the 64-bit shmem_paddr gets
truncated to 32-bit when it's passed to the SMC32/HVC32 call.

To solve that, I would prefer splitting the address between two SMC
parameters (a1 = addr_lo, a2 = addr_hi), instead of imposing an
arbitrary alignment. Would that be reasonable?

> 
> What discovery mechanism does the OS have that the specified address
> within the SMCCC call has been accepted by the firmware given the
> return
> value of that SMCCC call does not appear to be used or checked? Do we
> just expect a timeout initializing the SCMI subsystem?

The return code is actually checked at the end of the function:
https://elixir.bootlin.com/linux/v5.8-rc4/source/drivers/firmware/arm_scmi/smc.c#L118

But in the meantime scmi_rx_callback() has already been called. Not
sure if that's intentional or a possible bug.

> 
> Given that the kernel must somehow reserve this memory as a shared
> memory area for obvious reasons, and the trusted firmware must also
> ensure it treats this memory region with specific permissions in its
> translation regime, does it really make sense to give that much
> flexibility?

Well, the trusted firmware might reserve a bigger region to be used for
other service as well. In other words, the MMU of TF-A is not necessary
specifically set up for this region, but, possibly, for a bigger
general shared region.

Passing the SCMI shmem to the SMC call allows the shmem to be moved
within such bigger shared memory without modifying the trusted
firmware.

> 
> If your boot loader has FDT patching capability, maybe it can also do
> a
> SMC call to provide the address to your trusted firmware, prior to
> loading the Linux kernel, and then they both agree, prior to boot
> about
> the shared memory address?

Yes, that's a possible solution, but it looks more complicated to me,
since it adds an additional component (the boot loader) to the
equation, while the goal of this patch was to reduce the coupling
between components (namely the DT/kernel and the trusted firmware).

I guess my question is: if we fix the handling of LPAE addresses and
the SMC return code, what is the drawback of having the shmem address
passed to the SMC?

Anyway, I should have mentioned this in the commit message (sorry for
not doing so), but I submitted this patch because initial feedback from
Sudeep was positive [1]; but if there is no consensus around it I'm
fine with dropping it.

[1] https://lore.kernel.org/lkml/20200710075931.GB1189@bogus/

> 
> > Signed-off-by: Daniele Alessandrelli <
> > daniele.alessandrelli@intel.com>
> > Signed-off-by: Paul J. Murphy <paul.j.murphy@intel.com>
> > ---
> >  drivers/firmware/arm_scmi/smc.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/arm_scmi/smc.c
> > b/drivers/firmware/arm_scmi/smc.c
> > index 49bc4b0e8428..aef3a58f8266 100644
> > --- a/drivers/firmware/arm_scmi/smc.c
> > +++ b/drivers/firmware/arm_scmi/smc.c
> > @@ -21,12 +21,14 @@
> >   *
> >   * @cinfo: SCMI channel info
> >   * @shmem: Transmit/Receive shared memory area
> > + * @shmem_paddr: Physical address of shmem
> >   * @func_id: smc/hvc call function id
> >   */
> >  
> >  struct scmi_smc {
> >  	struct scmi_chan_info *cinfo;
> >  	struct scmi_shared_mem __iomem *shmem;
> > +	resource_size_t shmem_paddr;
> >  	struct mutex shmem_lock;
> >  	u32 func_id;
> >  };
> > @@ -73,6 +75,7 @@ static int smc_chan_setup(struct scmi_chan_info
> > *cinfo, struct device *dev,
> >  		dev_err(dev, "failed to ioremap SCMI Tx shared
> > memory\n");
> >  		return -EADDRNOTAVAIL;
> >  	}
> > +	scmi_info->shmem_paddr = res.start;
> >  
> >  	ret = of_property_read_u32(dev->of_node, "arm,smc-id",
> > &func_id);
> >  	if (ret < 0)
> > @@ -109,7 +112,8 @@ static int smc_send_message(struct
> > scmi_chan_info *cinfo,
> >  
> >  	shmem_tx_prepare(scmi_info->shmem, xfer);
> >  
> > -	arm_smccc_1_1_invoke(scmi_info->func_id, 0, 0, 0, 0, 0, 0, 0,
> > &res);
> > +	arm_smccc_1_1_invoke(scmi_info->func_id, scmi_info-
> > >shmem_paddr, 0, 0,
> > +			     0, 0, 0, 0, &res);
> >  	scmi_rx_callback(scmi_info->cinfo, shmem_read_header(scmi_info-
> > >shmem));
> >  
> >  	mutex_unlock(&scmi_info->shmem_lock);
> > 

