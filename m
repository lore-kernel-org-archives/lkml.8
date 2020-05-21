Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D19AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75A932072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728885AbgEUJ0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:26:33 -0400
Received: from foss.arm.com ([217.140.110.172]:43216 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728719AbgEUJ0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:26:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93EE330E;
        Thu, 21 May 2020 02:26:32 -0700 (PDT)
Received: from bogus (unknown [10.37.12.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DCBB3F68F;
        Thu, 21 May 2020 02:26:30 -0700 (PDT)
Date:   Thu, 21 May 2020 10:26:27 +0100
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
Message-ID: <20200521092627.GB6425@bogus>
References: <20200518091222.27467-1-sudeep.holla@arm.com>
 <158999823818.135150.13263761266508812198.b4-ty@kernel.org>
 <CAK8P3a0bx2eOFSqM7ihNkJBWU_KKSh0vGJZZdvpkH=1nppingw@mail.gmail.com>
 <20200521070629.GB1131@bogus>
 <CAK8P3a1h1MR4Mq2sSV_FDUodrfaKRFtyOuOOGPWAbPYbzjc4YQ@mail.gmail.com>
 <20200521075755.GA4668@willie-the-truck>
 <20200521081055.GD1131@bogus>
 <CAK8P3a3dV0B26XE3oFQGTFf8EWV0AHoLudNtpSSB_t+pCfkOkQ@mail.gmail.com>
 <20200521091736.GA5091@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521091736.GA5091@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 10:17:39AM +0100, Will Deacon wrote:
> On Thu, May 21, 2020 at 11:06:23AM +0200, Arnd Bergmann wrote:
> > On Thu, May 21, 2020 at 10:11 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > Indeed, it is also last patch in the series. However if Arnd is happy
> > > with the sysfs names, we can move to generic code later without breaking
> > > anything.
> > >
> > > We need not revert or drop it now. I will leave that to you or Arnd to
> > > decide. Just that it may be too late to get acks for all the soc sysfs
> > > drivers in time for v5.8
> > >
> > > I am fine if you want to drop the last patch.
> > 
> > Ok, let's drop that patch then and make sure we do something that
> > everyone is happy with later on. I'm already in favor of adding
> > a more reliable soc_device instance based on this, but we need to
> > be sure we don't screw up the contents of the attributes when we
> > can't change them later.
> > 
> > > > > >> drivers/firmware/smccc/smccc.c:14:13: warning: no previous prototype for function 'arm_smccc_version_init' [-Wmissing-prototypes]
> > > > > void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
> > > > > ^
> > > > > drivers/firmware/smccc/smccc.c:14:1: note: declare 'static' if the
> > > > > function is not intended to be used outside of this translation unit
> > > > > void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
> > > >
> > > > I saw that when I applied the patches, but since the function is called from
> > > > another compilation unit (psci/psci.o), I just ignored it as we have loads
> > > > of these already and it only screams if you build with W=1.
> > > >
> > >
> > > /me confused. Do you need the fix for this warning or you are happy to ignore?
> > 
> > I want a fix for that, as I hope we can eventually turn this warning on by
> > default and stop playing whack-a-mole when they come up. Most of these
> > warnings are harmless, but occasionally the prototypes don't match exactly
> > and cause real bugs depending on the configuration, and ensuring both
> > sides include a common header file is an easy way to make it work
> > more reliably.
> > 
> > Note that the warning should come up for either W=1 or C=1, and I also
> > think that
> > new code should generally be written sparse-clean and have no warnings with
> > 'make C=1' as a rule.
> 
> Fair enough. Is anybody working on a tree-wide sweep for this, like we've
> done for other things such as zero-length arrays? If so, I can start
> enforcing this in the arch code as well (I haven't been so far, even though
> I do run sparse on every commit).
> 
> Anyway, I've dropped the last patch from the branch, and we can put a fix
> for the missing prototype on top.
> 

Thanks Will, sorry for the trouble. Though I can send the fix for the
missing prototype right away, I would like to get my clang setup working
as an opportunity. clang-8 that I have is failing vanilla v5.7-rc6
when expanding arm_smccc_1_1_*

-- 
Regards,
Sudeep
