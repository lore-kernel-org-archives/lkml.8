Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DFCC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA0D2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 09:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgEUJGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 05:06:49 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:36857 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgEUJGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 05:06:44 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MmyzH-1jA5ln49dn-00k66s for <linux-kernel@vger.kernel.org>; Thu, 21 May
 2020 11:06:41 +0200
Received: by mail-qk1-f179.google.com with SMTP id i5so6449398qkl.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 02:06:40 -0700 (PDT)
X-Gm-Message-State: AOAM531cBW7Lzb0s/pSomG/+0ovL4HrobnfzG1WCMIP3TO3e0dVyNkYB
        kLehjkPZgpXO6+7uJRrTV2FtbLvX2pGz7kYqCiI=
X-Google-Smtp-Source: ABdhPJzY8tA9XFsf4PrVPQEo6j/Vx7xBZ9oGKpIW2en2BlP6PygE3gCqxjy8F3kyxcIPHi56fHEG7aFtx3du0f0szRs=
X-Received: by 2002:a37:434b:: with SMTP id q72mr9383265qka.352.1590051999841;
 Thu, 21 May 2020 02:06:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200518091222.27467-1-sudeep.holla@arm.com> <158999823818.135150.13263761266508812198.b4-ty@kernel.org>
 <CAK8P3a0bx2eOFSqM7ihNkJBWU_KKSh0vGJZZdvpkH=1nppingw@mail.gmail.com>
 <20200521070629.GB1131@bogus> <CAK8P3a1h1MR4Mq2sSV_FDUodrfaKRFtyOuOOGPWAbPYbzjc4YQ@mail.gmail.com>
 <20200521075755.GA4668@willie-the-truck> <20200521081055.GD1131@bogus>
In-Reply-To: <20200521081055.GD1131@bogus>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 May 2020 11:06:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3dV0B26XE3oFQGTFf8EWV0AHoLudNtpSSB_t+pCfkOkQ@mail.gmail.com>
Message-ID: <CAK8P3a3dV0B26XE3oFQGTFf8EWV0AHoLudNtpSSB_t+pCfkOkQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] firmware: smccc: Add basic SMCCC v1.2 +
 ARCH_SOC_ID support
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>, harb@amperecomputing.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:yIM2W/q0Bw8x7qkenLwwDmcIfv3YcVEQq9kTP1xSPqV3x9HuMV0
 Qbxbu4YeGKHlk+P8Vpz303ZoqODG629dCXk6Z5jgWzIAynLQKGdDEmixaa+1/BKhbFgCkI7
 b4jEJtrbKHe82/mKS8nmICjBNgLdAgRZwqGZ3V6sKox7vhZic6WUlm4DTP+GyNTJBEvK40E
 bLfllV6y2cFF3X8wcogsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o8NpqzRGB30=:cQlkXGNG64e24D95ul95RL
 qBkf8cgWRi5rgMtKnMfvmj1mJ9fcPqRpvX2ZFMsDGEdfTXdyEWgjYXz7MW/uvTndUQMVhVbzr
 vq6fa/Hx9TCXWg7ljL+xmaGbGpxd1hLjbaPW+mOWjdi1NbQ7VSge4MzBHi4P4PfCvj7aWAN/t
 ghbndPqWRujV2MKXiw3n/Jmd1UHG89HYDF20Ov0oc1cy6hXpuRwIITOb28akdMXTMQkmi/YTd
 hm6ihlzFE0Z5cr6ln7PlpcI3p7lg3P2lxVPocHcevFO/yBj4mNzGnSrBtbe9WWOlEDEP2CUk0
 MZZTxL/kVSodSWcwOYuES56Vzjw7YOnShS+UBV8gvYVXSrO6bH5rKIR+7XaMlSnGCnTKQ0iAJ
 DWNhpswmE8+yFiXLv3MMTvcGnfKk9A//9sQ/z7SBDrn9Yk4zDPc3sLF7z7rEH6NhNjRFvQ0Lx
 QO5Sj0Kgwn0Hn5zAr5GU3AuGCZ7c849ugsPd8LN1eIB5uWxhVRIB8zSGcB03LbsMUbdxJpNs3
 N7gvJa2mCWb/s9eHGFEpV/ijDYdiYVwSmIsrjC1TDeGwlQHmOam90QvmgddecPehY3AHUYQJs
 rZ4TDxw9vmQjEy6liYiVW0xMOnrOHJXZOgl2hnJ5ja75OpXI/cIYEZoluAF3FyQ97tDTGa41+
 hfrPEuiOJFRvO3l2SN4wG8ybwG9f/k6bYMeZCoIxs8IN5FxIxI8DdPrQxvvJ3rXMzrF9K6OC6
 L0wP+opQUQvPBactkoR2ARJonXaOpFVeXXITbqUHDRAVzI9oTzP6UashTfpQ4oTiwr49P2CIJ
 EpqRUssSIRtliAg33uVXzeV7YY6foRDdOs6Kd/Lx5sIqU84CdQ=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 10:11 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> On Thu, May 21, 2020 at 08:57:56AM +0100, Will Deacon wrote:
> > On Thu, May 21, 2020 at 09:34:10AM +0200, Arnd Bergmann wrote:
> > > On Thu, May 21, 2020 at 9:07 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > On Wed, May 20, 2020 at 11:54:16PM +0200, Arnd Bergmann wrote:
> > > > > On Wed, May 20, 2020 at 11:29 PM Will Deacon <will@kernel.org> wrote:
> > > > > > Applied to arm64 (for-next/smccc), thanks!
> > > > > >
> > > > > > Arnd -- Sudeep's reply to you about the sysfs groups seemed reasonable to me,
> > > > > > but please shout if you'd rather I dropped this in order to pursue an
> > > > > > alternative approach.
> > > > >
> > > > > I missed the reply earlier, thanks for pointing me to it again.
> >
> > D'oh, I took your silence as "no objections". Oh well!
> >
> > > > > I'm not entirely convinced, but don't revert it for now because of that,
> > > > > I assume we can find a solution.
> >
> > Ok, cheers. It's on a separate branch so it's easy enough to drop if
> > necessary (i.e. no reverts needed). Sudeep -- please send any extra patches
> > on top of the branch.
> >
>
> Indeed, it is also last patch in the series. However if Arnd is happy
> with the sysfs names, we can move to generic code later without breaking
> anything.
>
> We need not revert or drop it now. I will leave that to you or Arnd to
> decide. Just that it may be too late to get acks for all the soc sysfs
> drivers in time for v5.8
>
> I am fine if you want to drop the last patch.

Ok, let's drop that patch then and make sure we do something that
everyone is happy with later on. I'm already in favor of adding
a more reliable soc_device instance based on this, but we need to
be sure we don't screw up the contents of the attributes when we
can't change them later.

> > > >> drivers/firmware/smccc/smccc.c:14:13: warning: no previous prototype for function 'arm_smccc_version_init' [-Wmissing-prototypes]
> > > void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
> > > ^
> > > drivers/firmware/smccc/smccc.c:14:1: note: declare 'static' if the
> > > function is not intended to be used outside of this translation unit
> > > void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
> >
> > I saw that when I applied the patches, but since the function is called from
> > another compilation unit (psci/psci.o), I just ignored it as we have loads
> > of these already and it only screams if you build with W=1.
> >
>
> /me confused. Do you need the fix for this warning or you are happy to ignore?

I want a fix for that, as I hope we can eventually turn this warning on by
default and stop playing whack-a-mole when they come up. Most of these
warnings are harmless, but occasionally the prototypes don't match exactly
and cause real bugs depending on the configuration, and ensuring both
sides include a common header file is an easy way to make it work
more reliably.

Note that the warning should come up for either W=1 or C=1, and I also
think that
new code should generally be written sparse-clean and have no warnings with
'make C=1' as a rule.

      Arnd
