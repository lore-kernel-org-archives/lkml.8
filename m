Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38740C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F94F2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 08:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbgEUIGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 04:06:01 -0400
Received: from foss.arm.com ([217.140.110.172]:41986 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgEUIGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 04:06:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39EADD6E;
        Thu, 21 May 2020 01:06:00 -0700 (PDT)
Received: from bogus (unknown [10.37.12.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E097D3F52E;
        Thu, 21 May 2020 01:05:57 -0700 (PDT)
Date:   Thu, 21 May 2020 09:05:54 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steven Price <steven.price@arm.com>, harb@amperecomputing.com,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 0/7] firmware: smccc: Add basic SMCCC v1.2 +
 ARCH_SOC_ID support
Message-ID: <20200521080554.GC1131@bogus>
References: <20200518091222.27467-1-sudeep.holla@arm.com>
 <158999823818.135150.13263761266508812198.b4-ty@kernel.org>
 <CAK8P3a0bx2eOFSqM7ihNkJBWU_KKSh0vGJZZdvpkH=1nppingw@mail.gmail.com>
 <20200521070629.GB1131@bogus>
 <CAK8P3a1h1MR4Mq2sSV_FDUodrfaKRFtyOuOOGPWAbPYbzjc4YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1h1MR4Mq2sSV_FDUodrfaKRFtyOuOOGPWAbPYbzjc4YQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 09:34:10AM +0200, Arnd Bergmann wrote:
> On Thu, May 21, 2020 at 9:07 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Wed, May 20, 2020 at 11:54:16PM +0200, Arnd Bergmann wrote:
> > > On Wed, May 20, 2020 at 11:29 PM Will Deacon <will@kernel.org> wrote:
> > > >
> > > > On Mon, 18 May 2020 10:12:15 +0100, Sudeep Holla wrote:
> > > > > This patch series adds support for SMCCCv1.2 ARCH_SOC_ID.
> > > > > This doesn't add other changes added in SMCCC v1.2 yet. They will
> > > > > follow these soon along with its first user SPCI/PSA-FF.
> > > > >
> > > > > This is tested using upstream TF-A + the patch[3] fixing the original
> > > > > implementation there.
> > > > >
> > > > > [...]
> > > >
> > > > Applied to arm64 (for-next/smccc), thanks!
> > > >
> > > > [1/7] firmware: smccc: Add HAVE_ARM_SMCCC_DISCOVERY to identify SMCCC v1.1 and above
> > > >       https://git.kernel.org/arm64/c/e5bfb21d98b6
> > > > [2/7] firmware: smccc: Update link to latest SMCCC specification
> > > >       https://git.kernel.org/arm64/c/15c704ab6244
> > > > [3/7] firmware: smccc: Add the definition for SMCCCv1.2 version/error codes
> > > >       https://git.kernel.org/arm64/c/0441bfe7f00a
> > > > [4/7] firmware: smccc: Drop smccc_version enum and use ARM_SMCCC_VERSION_1_x instead
> > > >       https://git.kernel.org/arm64/c/ad5a57dfe434
> > > > [5/7] firmware: smccc: Refactor SMCCC specific bits into separate file
> > > >       https://git.kernel.org/arm64/c/f2ae97062a48
> > > > [6/7] firmware: smccc: Add function to fetch SMCCC version
> > > >       https://git.kernel.org/arm64/c/a4fb17465182
> > > > [7/7] firmware: smccc: Add ARCH_SOC_ID support
> > > >       https://git.kernel.org/arm64/c/ce6488f0ce09
> > > >
> > > > Arnd -- Sudeep's reply to you about the sysfs groups seemed reasonable to me,
> > > > but please shout if you'd rather I dropped this in order to pursue an
> > > > alternative approach.
> > >
> > > I missed the reply earlier, thanks for pointing me to it again.
> > >
> > > I'm not entirely convinced, but don't revert it for now because of that,
> > > I assume we can find a solution.
> > >
> >
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
> 

Ah, clang it is. I must start building with clang regularly.
Thanks for pointing it out. Somehow few of these kbuild-bot emails
has been marked junk last few days. Sorry for the noise.

-- 
Regards,
Sudeep
