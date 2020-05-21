Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89ADBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70FA120738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728586AbgEUILC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 04:11:02 -0400
Received: from foss.arm.com ([217.140.110.172]:42080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728374AbgEUILC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 04:11:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 863E7D6E;
        Thu, 21 May 2020 01:11:01 -0700 (PDT)
Received: from bogus (unknown [10.37.12.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D689D3F52E;
        Thu, 21 May 2020 01:10:58 -0700 (PDT)
Date:   Thu, 21 May 2020 09:10:55 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>, harb@amperecomputing.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/7] firmware: smccc: Add basic SMCCC v1.2 +
 ARCH_SOC_ID support
Message-ID: <20200521081055.GD1131@bogus>
References: <20200518091222.27467-1-sudeep.holla@arm.com>
 <158999823818.135150.13263761266508812198.b4-ty@kernel.org>
 <CAK8P3a0bx2eOFSqM7ihNkJBWU_KKSh0vGJZZdvpkH=1nppingw@mail.gmail.com>
 <20200521070629.GB1131@bogus>
 <CAK8P3a1h1MR4Mq2sSV_FDUodrfaKRFtyOuOOGPWAbPYbzjc4YQ@mail.gmail.com>
 <20200521075755.GA4668@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521075755.GA4668@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 08:57:56AM +0100, Will Deacon wrote:
> On Thu, May 21, 2020 at 09:34:10AM +0200, Arnd Bergmann wrote:
> > On Thu, May 21, 2020 at 9:07 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > On Wed, May 20, 2020 at 11:54:16PM +0200, Arnd Bergmann wrote:
> > > > On Wed, May 20, 2020 at 11:29 PM Will Deacon <will@kernel.org> wrote:
> > > > > Applied to arm64 (for-next/smccc), thanks!
> > > > >
> > > > > Arnd -- Sudeep's reply to you about the sysfs groups seemed reasonable to me,
> > > > > but please shout if you'd rather I dropped this in order to pursue an
> > > > > alternative approach.
> > > >
> > > > I missed the reply earlier, thanks for pointing me to it again.
> 
> D'oh, I took your silence as "no objections". Oh well!
> 
> > > > I'm not entirely convinced, but don't revert it for now because of that,
> > > > I assume we can find a solution.
> 
> Ok, cheers. It's on a separate branch so it's easy enough to drop if
> necessary (i.e. no reverts needed). Sudeep -- please send any extra patches
> on top of the branch.
>

Indeed, it is also last patch in the series. However if Arnd is happy
with the sysfs names, we can move to generic code later without breaking
anything.

We need not revert or drop it now. I will leave that to you or Arnd to
decide. Just that it may be too late to get acks for all the soc sysfs
drivers in time for v5.8

I am fine if you want to drop the last patch.

> > > I liked your idea of making this generic and hardcode values if required
> > > for other drivers. I will take a look at that/
> > >
> > > > However, please have a look at the build failure report for patch 5
> > > > and fix it if you can see what went wrong.
> > > >
> > >
> > > Any pointers for that failure ? I seem to have missed them. I pushed
> > > branch couple of times to my tree but got build success both times.
> > > Any specific config or compilers ?
> > 
> > See below for the reply from the 0day build bot to your email. It seems it
> > was not sent to the mailing list, but you were on Cc. Looking at it now,
> > the fix should be trivial.
> 
> [...]
> 
> > >> drivers/firmware/smccc/smccc.c:14:13: warning: no previous prototype for function 'arm_smccc_version_init' [-Wmissing-prototypes]
> > void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
> > ^
> > drivers/firmware/smccc/smccc.c:14:1: note: declare 'static' if the
> > function is not intended to be used outside of this translation unit
> > void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
> 
> I saw that when I applied the patches, but since the function is called from
> another compilation unit (psci/psci.o), I just ignored it as we have loads
> of these already and it only screams if you build with W=1.
> 

/me confused. Do you need the fix for this warning or you are happy to ignore?

-- 
Regards,
Sudeep
