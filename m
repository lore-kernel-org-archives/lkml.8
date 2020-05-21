Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC7EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E1920759
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590052665;
	bh=lrCsi5PPelpIf3uelRQPGB1wFFjJDgGZhs/G1Te3fZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mDZwtuvxqO1Lw/4pYeZsrvEkd734TLLybgNx78KPxw+FnYqQV26cC4H0SBsvL5EpK
	 PAEL+Kq8UvFg0Nmhlyz09RAXi/f4mFs0x8Z4me6ytAOq2c6Bqt/3p85rjm73DXgGu2
	 A8MaCB3Dlimc89sH8X0rG5zotsol5kxqycA18Niw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgEUJRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:17:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:53318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728686AbgEUJRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:17:44 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 76A19206BE;
        Thu, 21 May 2020 09:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590052664;
        bh=lrCsi5PPelpIf3uelRQPGB1wFFjJDgGZhs/G1Te3fZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DIlBfpyARv0vGa3tJkUPcxfnPdKc50TPwojk12d275MhOI1sRQ9w98/1yEf93mcvb
         fGzQMuJ4Yp96h/zonve+e907nxQne9iJCritIncVwG1NiNbA1b2Esh/dQWRpsOXRVg
         jffBqfWUGRvQ/Fh2FpTfyCE3CYN/FfRqGeJ2pHgM=
Date:   Thu, 21 May 2020 10:17:39 +0100
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
Message-ID: <20200521091736.GA5091@willie-the-truck>
References: <20200518091222.27467-1-sudeep.holla@arm.com>
 <158999823818.135150.13263761266508812198.b4-ty@kernel.org>
 <CAK8P3a0bx2eOFSqM7ihNkJBWU_KKSh0vGJZZdvpkH=1nppingw@mail.gmail.com>
 <20200521070629.GB1131@bogus>
 <CAK8P3a1h1MR4Mq2sSV_FDUodrfaKRFtyOuOOGPWAbPYbzjc4YQ@mail.gmail.com>
 <20200521075755.GA4668@willie-the-truck>
 <20200521081055.GD1131@bogus>
 <CAK8P3a3dV0B26XE3oFQGTFf8EWV0AHoLudNtpSSB_t+pCfkOkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3dV0B26XE3oFQGTFf8EWV0AHoLudNtpSSB_t+pCfkOkQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 11:06:23AM +0200, Arnd Bergmann wrote:
> On Thu, May 21, 2020 at 10:11 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > Indeed, it is also last patch in the series. However if Arnd is happy
> > with the sysfs names, we can move to generic code later without breaking
> > anything.
> >
> > We need not revert or drop it now. I will leave that to you or Arnd to
> > decide. Just that it may be too late to get acks for all the soc sysfs
> > drivers in time for v5.8
> >
> > I am fine if you want to drop the last patch.
> 
> Ok, let's drop that patch then and make sure we do something that
> everyone is happy with later on. I'm already in favor of adding
> a more reliable soc_device instance based on this, but we need to
> be sure we don't screw up the contents of the attributes when we
> can't change them later.
> 
> > > > >> drivers/firmware/smccc/smccc.c:14:13: warning: no previous prototype for function 'arm_smccc_version_init' [-Wmissing-prototypes]
> > > > void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
> > > > ^
> > > > drivers/firmware/smccc/smccc.c:14:1: note: declare 'static' if the
> > > > function is not intended to be used outside of this translation unit
> > > > void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
> > >
> > > I saw that when I applied the patches, but since the function is called from
> > > another compilation unit (psci/psci.o), I just ignored it as we have loads
> > > of these already and it only screams if you build with W=1.
> > >
> >
> > /me confused. Do you need the fix for this warning or you are happy to ignore?
> 
> I want a fix for that, as I hope we can eventually turn this warning on by
> default and stop playing whack-a-mole when they come up. Most of these
> warnings are harmless, but occasionally the prototypes don't match exactly
> and cause real bugs depending on the configuration, and ensuring both
> sides include a common header file is an easy way to make it work
> more reliably.
> 
> Note that the warning should come up for either W=1 or C=1, and I also
> think that
> new code should generally be written sparse-clean and have no warnings with
> 'make C=1' as a rule.

Fair enough. Is anybody working on a tree-wide sweep for this, like we've
done for other things such as zero-length arrays? If so, I can start
enforcing this in the arch code as well (I haven't been so far, even though
I do run sparse on every commit).

Anyway, I've dropped the last patch from the branch, and we can put a fix
for the missing prototype on top.

Will
