Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64470C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE38206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgEERJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 13:09:29 -0400
Received: from foss.arm.com ([217.140.110.172]:45982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729998AbgEERJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 13:09:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DB5831B;
        Tue,  5 May 2020 10:09:28 -0700 (PDT)
Received: from bogus (unknown [10.37.12.47])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FC133F305;
        Tue,  5 May 2020 10:09:26 -0700 (PDT)
Date:   Tue, 5 May 2020 18:09:23 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Peng Fan <peng.fan@nxp.com>,
        Marc Zyngier <maz@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: fix psci dependency
Message-ID: <20200505170923.GB23612@bogus>
References: <20200505140820.536615-1-arnd@arndb.de>
 <20200505150421.GA23612@bogus>
 <20200505162135.GB27127@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505162135.GB27127@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 05:21:36PM +0100, Mark Rutland wrote:
> On Tue, May 05, 2020 at 04:04:21PM +0100, Sudeep Holla wrote:
> > Hi Arnd,
> >
> > On Tue, May 05, 2020 at 04:08:08PM +0200, Arnd Bergmann wrote:
> > > When CONFIG_ARM_PSCI_FW is disabled but CONFIG_HAVE_ARM_SMCCC is enabled,
> > > arm-scmi runs into a link failure:
> > >
> > > arm-linux-gnueabi-ld: drivers/firmware/arm_scmi/smc.o: in function `smc_send_message':
> > > smc.c:(.text+0x200): undefined reference to `arm_smccc_1_1_get_conduit'
> > >
> > > Use an inline helper to default to version v1.0 in the absence of psci.
> > >
> >
> > Thanks for fixing this. I was thinking if we can separate PSCI and SMCCC
> > quickly as a fix for this but I think he needs to be discussed in detail.
> >
> > I am fine with this fix as is and happy to apply to my tree if no one
> > objects.
> >
> > Sorry but taking this patch as opportunity to discuss how to carry the
> > dependency in future. Just a proposal,
> >
> > 1. Introduce a DT node for SMCCC v1.2+
> > 2. The new SMCCC driver(strictly speaking library/few APIs) can probe
> >    independent of PSCI if DT node is present
> > 3. Else we fallback on PSCI and detect the SMCCC version for v1.1 and
> >    v1.2
> > 4. Assume v1.0 if
> > 	a. PSCI FEATURE returns NOT_SUPPORTED for ARM_SMCCC_VERSION_FUNC_ID
> > 	b. CONFIG_ARM_PSCI{,_FW} is not defined
> >
> > Mark/Will/Marc,
> >
> > Any other use-case config missed above ?
>
> Do we need to support SMCCC without PSCI? Is anyone goingto build a
> sysyem with SMCCC but no PSCI functionality?
>

May be arm32 using all new fancy specification we may come up to solve
certain areas but continue to use legacy boot/power methods. I may be
wrong. E.g: Today we enable HAVE_ARM_SMCCC for armv7 and above but not
all have PSCI enabled.

> If not, then given we can always probe SMCCC from PSCI (for both ACPI
> and DT), I'd prefer to support only support doing things that way
> around. i.e. have SMCCC depend on PSCI.
>

OK, but we still have above config.

> Otherwise I suspect we're inviting more problems than a dependency on
> PSCI.
>

Agreed and I am happy to keep it as is.

--
Regards,
Sudeep
