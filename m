Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E57C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5194C2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590047883;
	bh=4lM/8ShYtWTr1Pw2EKWG6DtgkHZzD7Wz1k87Xzi6HFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=04bPffj1qLvqizFl8WPy25wC09j+4DBKkrciXoIXd+Vjt/RB3HXVAkg9HarIszKtC
	 2OgsIBy1iuYEcPUgVAB5HfTGndRnEJ8rQDyoftedyXcHsWeO5y8yG33oSc/dyYzjg2
	 E1Sg3n0p/VzHEk49mwmKk8JeLVlVxV/zu3MUC0qg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgEUH6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 03:58:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728399AbgEUH6C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:58:02 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAB332065F;
        Thu, 21 May 2020 07:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590047881;
        bh=4lM/8ShYtWTr1Pw2EKWG6DtgkHZzD7Wz1k87Xzi6HFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HY+eX+3wW8axbeDNmoF0xI9NLvnL9Gmq4GjQ8bgzy/k8kxiCQPsggsu9KVYa3Nvr2
         fy+LEkd1RklhMh/qZbSdi/UVuBG1Mec6Fvwb3lFNtOzQAldPGf0dwr0Mmd13yLLQ2Z
         MxO3HXq1CgEVUpIjZXlKLJ8YZSMvdMobRHiUkdgo=
Date:   Thu, 21 May 2020 08:57:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>, harb@amperecomputing.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/7] firmware: smccc: Add basic SMCCC v1.2 +
 ARCH_SOC_ID support
Message-ID: <20200521075755.GA4668@willie-the-truck>
References: <20200518091222.27467-1-sudeep.holla@arm.com>
 <158999823818.135150.13263761266508812198.b4-ty@kernel.org>
 <CAK8P3a0bx2eOFSqM7ihNkJBWU_KKSh0vGJZZdvpkH=1nppingw@mail.gmail.com>
 <20200521070629.GB1131@bogus>
 <CAK8P3a1h1MR4Mq2sSV_FDUodrfaKRFtyOuOOGPWAbPYbzjc4YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1h1MR4Mq2sSV_FDUodrfaKRFtyOuOOGPWAbPYbzjc4YQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 09:34:10AM +0200, Arnd Bergmann wrote:
> On Thu, May 21, 2020 at 9:07 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > On Wed, May 20, 2020 at 11:54:16PM +0200, Arnd Bergmann wrote:
> > > On Wed, May 20, 2020 at 11:29 PM Will Deacon <will@kernel.org> wrote:
> > > > Applied to arm64 (for-next/smccc), thanks!
> > > >
> > > > Arnd -- Sudeep's reply to you about the sysfs groups seemed reasonable to me,
> > > > but please shout if you'd rather I dropped this in order to pursue an
> > > > alternative approach.
> > >
> > > I missed the reply earlier, thanks for pointing me to it again.

D'oh, I took your silence as "no objections". Oh well!

> > > I'm not entirely convinced, but don't revert it for now because of that,
> > > I assume we can find a solution.

Ok, cheers. It's on a separate branch so it's easy enough to drop if
necessary (i.e. no reverts needed). Sudeep -- please send any extra patches
on top of the branch.

> > I liked your idea of making this generic and hardcode values if required
> > for other drivers. I will take a look at that/
> >
> > > However, please have a look at the build failure report for patch 5
> > > and fix it if you can see what went wrong.
> > >
> >
> > Any pointers for that failure ? I seem to have missed them. I pushed
> > branch couple of times to my tree but got build success both times.
> > Any specific config or compilers ?
> 
> See below for the reply from the 0day build bot to your email. It seems it
> was not sent to the mailing list, but you were on Cc. Looking at it now,
> the fix should be trivial.

[...]

> >> drivers/firmware/smccc/smccc.c:14:13: warning: no previous prototype for function 'arm_smccc_version_init' [-Wmissing-prototypes]
> void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
> ^
> drivers/firmware/smccc/smccc.c:14:1: note: declare 'static' if the
> function is not intended to be used outside of this translation unit
> void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)

I saw that when I applied the patches, but since the function is called from
another compilation unit (psci/psci.o), I just ignored it as we have loads
of these already and it only screams if you build with W=1.

Will
