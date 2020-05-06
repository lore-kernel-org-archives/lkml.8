Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFF7C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 827892078E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgEFNpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:45:04 -0400
Received: from foss.arm.com ([217.140.110.172]:36894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726129AbgEFNpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:45:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01841D6E;
        Wed,  6 May 2020 06:45:03 -0700 (PDT)
Received: from bogus (unknown [10.37.8.198])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 369513F68F;
        Wed,  6 May 2020 06:45:01 -0700 (PDT)
Date:   Wed, 6 May 2020 14:44:53 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Peng Fan <peng.fan@nxp.com>, Marc Zyngier <maz@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: fix psci dependency
Message-ID: <20200506134438.GA27915@bogus>
References: <20200505140820.536615-1-arnd@arndb.de>
 <20200505150421.GA23612@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505150421.GA23612@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 04:04:21PM +0100, Sudeep Holla wrote:
> Hi Arnd,
>
> On Tue, May 05, 2020 at 04:08:08PM +0200, Arnd Bergmann wrote:
> > When CONFIG_ARM_PSCI_FW is disabled but CONFIG_HAVE_ARM_SMCCC is enabled,
> > arm-scmi runs into a link failure:
> >
> > arm-linux-gnueabi-ld: drivers/firmware/arm_scmi/smc.o: in function `smc_send_message':
> > smc.c:(.text+0x200): undefined reference to `arm_smccc_1_1_get_conduit'
> >
> > Use an inline helper to default to version v1.0 in the absence of psci.
> >
>
> Thanks for fixing this. I was thinking if we can separate PSCI and SMCCC
> quickly as a fix for this but I think he needs to be discussed in detail.
>
> I am fine with this fix as is and happy to apply to my tree if no one
> objects.
>
> Sorry but taking this patch as opportunity to discuss how to carry the
> dependency in future. Just a proposal,
>
> 1. Introduce a DT node for SMCCC v1.2+

Sorry for the confusion and the above note might have scared people.
Also I misunderstood some internal discussions we had as part of my
SMCCC SOC_ID series[1]. I realised(rather Mark made me realise) this
SCMI SMC is kind of dependent on PSCI as we reuse the conduit from there.
So for now I will make it depend on PSCI to fix the build temporarily.

Also I will try to work out if we can move HAVE_ARCH_SMCCC to something
like HAVE_ARCH_RAW_SMCCC and use HAVE_ARCH_SMCCC for newer changes that
depend on PSCI for probing and conduit. The legacy SMCCC can then go under
HAVE_ARCH_RAW_SMCCC. This was Mark's suggestion, I will try to work it
out and may be post it as part of my SMCCC SOC_ID series also moving
code under drivers/firmware/smccc

--
Regards,
Sudeep

[1] https://lore.kernel.org/r/20200504092905.10580-1-sudeep.holla@arm.com
