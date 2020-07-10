Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9796C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCCC6207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgGJIBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:01:23 -0400
Received: from foss.arm.com ([217.140.110.172]:57782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgGJIBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:01:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0958031B;
        Fri, 10 Jul 2020 01:01:22 -0700 (PDT)
Received: from bogus (unknown [10.37.8.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B2FB3F9AB;
        Fri, 10 Jul 2020 01:01:18 -0700 (PDT)
Date:   Fri, 10 Jul 2020 09:01:16 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Paul Murphy <paul.j.murphy@linux.intel.com>
Cc:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Paul Murphy <paul.j.murphy@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/7] mailbox: keembay-scmi-mailbox: Add support for Keem
 Bay mailbox
Message-ID: <20200710075931.GB1189@bogus>
References: <20200616155613.121242-1-daniele.alessandrelli@linux.intel.com>
 <20200616155613.121242-3-daniele.alessandrelli@linux.intel.com>
 <20200708203428.GB31671@bogus>
 <491f994c6f87a542e49fe37c8a75ab46f1b3712b.camel@linux.intel.com>
 <537a4c$cobr4j@orsmga004-auth.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <537a4c$cobr4j@orsmga004-auth.jf.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 02:28:10PM +0100, Paul Murphy wrote:
> 
> On 7/9/20 13:23, Daniele Alessandrelli wrote:
> > Hi Sudeep,
> > 
> > Thanks for your review.
> > 
> > On Wed, 2020-07-08 at 21:34 +0100, Sudeep Holla wrote:
> > > On Tue, Jun 16, 2020 at 04:56:08PM +0100, Daniele Alessandrelli
> > > wrote:
> > > > From: Paul Murphy <paul.j.murphy@intel.com>
> > > > 
> > > > Keem Bay SoC has a ARM trusted firmware-based secure monitor which
> > > > acts
> > > > as the SCP for the purposes of power management over SCMI.
> > > > 
> > > > This driver implements the transport layer for SCMI to function.
> > > > 
> > > Please use the smc transport support in
> > > driver/firmware/arm_scmi/smc.c
> > > for this. You don't need mailbox support for SMC/HVC. Basically you
> > > don't need this driver at all and you have everything you need to
> > > support
> > > what you want.
> > > 
> > > Let me know if you face issues.
> > > 
> > Sorry, we didn't know about the SMC transport support for SCMI. Looks
> > like it was added only recently, while our driver was already developed
> > and waiting to be upstreamed.
> > 
> > I agree that we can drop this driver and switch to the SMC transport as
> > you suggested, but I think we'll have to modify our bootloader SiP
> > service slightly. Paul, can you elaborate?
> > 
> 
> Just one question.
> 
> In our patch, we pass the shared memory address as the second argument of
> the SiP service, as it means we don't have to hardcode that in our firmware.
> Sudeep, do you know if it was intentional in smc_send_message() to leave
> that out? If we leave it out, we are requiring the secure monitor to
> hardcode the shared memory address.
> 

Please post a patch adding the address as 2nd parameter. Cc Peng Fan from
NXP who is the original author of the file. I was also wondering why have
I not added the address when I extended support for multiple channel/shmem
with smc/hvc. One key point here is that firmware *must not* return
INVALID PARAMETER and *must* ignore it.

May be we can add a note while adding that the firmware can ignore that
parameter if it supports only one channel && hardcoded in the firmware.
It needs to be PA as obtained from the DT. Since it is custom SIP id, it
needs to be well documented.

-- 
Regards,
Sudeep
