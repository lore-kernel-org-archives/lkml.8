Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53696C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381D120738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbgEUHe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 03:34:29 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:41449 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgEUHe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:34:29 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mf0uq-1j8fV303AY-00ga8m for <linux-kernel@vger.kernel.org>; Thu, 21 May
 2020 09:34:27 +0200
Received: by mail-qt1-f180.google.com with SMTP id l1so4762343qtp.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 00:34:26 -0700 (PDT)
X-Gm-Message-State: AOAM533taj6KA7SVKqm1fsZJgZ1izEI7UMlV8pTmbfGBCtLa+BGq2Q/9
        14frZ9KUVZgvIcuLiQmaV02BcXm6Vv0ifq2CrGI=
X-Google-Smtp-Source: ABdhPJxnsPk1WNTtsvf8fhSOyGmjCrOWIuCaXauuuKsPPLG9MR6ID63YO2HcldF53ySp52GBmUg8rx4fvtvFEUEOuDo=
X-Received: by 2002:ac8:6a09:: with SMTP id t9mr9261420qtr.7.1590046465853;
 Thu, 21 May 2020 00:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200518091222.27467-1-sudeep.holla@arm.com> <158999823818.135150.13263761266508812198.b4-ty@kernel.org>
 <CAK8P3a0bx2eOFSqM7ihNkJBWU_KKSh0vGJZZdvpkH=1nppingw@mail.gmail.com> <20200521070629.GB1131@bogus>
In-Reply-To: <20200521070629.GB1131@bogus>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 21 May 2020 09:34:10 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1h1MR4Mq2sSV_FDUodrfaKRFtyOuOOGPWAbPYbzjc4YQ@mail.gmail.com>
Message-ID: <CAK8P3a1h1MR4Mq2sSV_FDUodrfaKRFtyOuOOGPWAbPYbzjc4YQ@mail.gmail.com>
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
X-Provags-ID: V03:K1:9ctHrALeRxubEVBYPO/Ee+kyoGoYLY14OF91e3wyVq8SrR5wBWJ
 wnYUiTc0Tkpjb1QUJipdvlhJPCJjKgsRPpABJqd4Z/A84BaoMvpQo4cMloXXSRKWd6+bwd6
 pZFA/LkfhVzu4icHh3oHOxep5lUMn0FnToc/9AeOSpHkhi5sdGyy2nea8YN/pvPO7K300Ib
 tepJS2VyR0w/d0OCj63XQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D9od9alfoaA=:ZJ1G8BawjbnNcx3F1iJUD0
 30giguLWEpCse2BB1D/oEmQWKaSYR00tuq6h0ZZBfAIGq+LNgJdYUBEzCYOLWyVxqWB6Yg5NU
 S9ToG4BsUQzmiWxIW28e84HQxipKEWvnN0Dq1hywvkQeJhSZ+hK64Q7vZlg4pvA5DFbnv0mRU
 +7LtLTxeYHF9HjcJDGr1NGplHSMpH6MfF0MfwJ0nPhAu17x8HLy8QhZSGP4aMe103SxVdKvWx
 92jIcYn1+D2kDsZtKaumAlIj/P91kkaMQ1fazl7Du83ysrHnGD8/OBkz5FIbl4lHsV1b56b3v
 cJfHT5OmdRwOevPrycXT6tsAC3+RhTRHWamehH9cSXWyS8pdDyxI7tnIG7VagPztNXmDqiCb7
 sLd+rrZDUIg9XVbtjd3qyIjlymq616qQ5l/3Dy+2dWSjW59zVhaD52M/5+MUIBwwZpaIuq/6m
 nqfohfzQ5G2lilO4/ro3QS7LwT2QRP2mQCl2h8/Q7qbm/K2wBNXQWfrpGRRD5lEAqtwaRlNSb
 65u5Qznas/MUfy6PhIrNcfsU8XnGXXYZDIEVUSicoLgCU1U80cXDeHBu255ZyHht8UpBdP1t6
 Tdpo88PqDiVlIqyL73XI++A8BT/rTQJr5E1mn+JPV2a/hryf9AizYbkkVMwutC+MR4EWr4aSP
 wfcv3bZ9olFQIeeHo6gyE6JT8Zg9TPSwblNBT/+NXR81k2UJXzkil/qrurKvKG/McINEtsjy1
 PtfZ4nrhOE6Y5pocenAhXwpw9FD1rQ0UGD3kh0mBfOJPEPno1i2nY9D77+D4aCAISum4Lh4D8
 P3Vb24IlnxMWJRJiwCVDh6kDvFRffz+bDSQ8cyLrX32/8DqIdU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 9:07 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, May 20, 2020 at 11:54:16PM +0200, Arnd Bergmann wrote:
> > On Wed, May 20, 2020 at 11:29 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Mon, 18 May 2020 10:12:15 +0100, Sudeep Holla wrote:
> > > > This patch series adds support for SMCCCv1.2 ARCH_SOC_ID.
> > > > This doesn't add other changes added in SMCCC v1.2 yet. They will
> > > > follow these soon along with its first user SPCI/PSA-FF.
> > > >
> > > > This is tested using upstream TF-A + the patch[3] fixing the original
> > > > implementation there.
> > > >
> > > > [...]
> > >
> > > Applied to arm64 (for-next/smccc), thanks!
> > >
> > > [1/7] firmware: smccc: Add HAVE_ARM_SMCCC_DISCOVERY to identify SMCCC v1.1 and above
> > >       https://git.kernel.org/arm64/c/e5bfb21d98b6
> > > [2/7] firmware: smccc: Update link to latest SMCCC specification
> > >       https://git.kernel.org/arm64/c/15c704ab6244
> > > [3/7] firmware: smccc: Add the definition for SMCCCv1.2 version/error codes
> > >       https://git.kernel.org/arm64/c/0441bfe7f00a
> > > [4/7] firmware: smccc: Drop smccc_version enum and use ARM_SMCCC_VERSION_1_x instead
> > >       https://git.kernel.org/arm64/c/ad5a57dfe434
> > > [5/7] firmware: smccc: Refactor SMCCC specific bits into separate file
> > >       https://git.kernel.org/arm64/c/f2ae97062a48
> > > [6/7] firmware: smccc: Add function to fetch SMCCC version
> > >       https://git.kernel.org/arm64/c/a4fb17465182
> > > [7/7] firmware: smccc: Add ARCH_SOC_ID support
> > >       https://git.kernel.org/arm64/c/ce6488f0ce09
> > >
> > > Arnd -- Sudeep's reply to you about the sysfs groups seemed reasonable to me,
> > > but please shout if you'd rather I dropped this in order to pursue an
> > > alternative approach.
> >
> > I missed the reply earlier, thanks for pointing me to it again.
> >
> > I'm not entirely convinced, but don't revert it for now because of that,
> > I assume we can find a solution.
> >
>
> I liked your idea of making this generic and hardcode values if required
> for other drivers. I will take a look at that/
>
> > However, please have a look at the build failure report for patch 5
> > and fix it if you can see what went wrong.
> >
>
> Any pointers for that failure ? I seem to have missed them. I pushed
> branch couple of times to my tree but got build success both times.
> Any specific config or compilers ?

See below for the reply from the 0day build bot to your email. It seems it
was not sent to the mailing list, but you were on Cc. Looking at it now,
the fix should be trivial.

    Arnd

8<---
I love your patch! Perhaps something to improve:

[auto build test WARNING on soc/for-next]
[also build test WARNING on arm64/for-next/core linus/master v5.7-rc6
next-20200519]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Sudeep-Holla/firmware-smccc-Add-basic-SMCCC-v1-2-ARCH_SOC_ID-support/20200518-171401
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: arm64-randconfig-r026-20200519 (attached as .config)
compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project
135b877874fae96b4372c8a3fbfaa8ff44ff86e3)
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
-O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> drivers/firmware/smccc/smccc.c:14:13: warning: no previous prototype for function 'arm_smccc_version_init' [-Wmissing-prototypes]
void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
^
drivers/firmware/smccc/smccc.c:14:1: note: declare 'static' if the
function is not intended to be used outside of this translation unit
void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
^
static
1 warning generated.

vim +/arm_smccc_version_init +14 drivers/firmware/smccc/smccc.c

    13
  > 14 void __init arm_smccc_version_init(u32 version, enum
arm_smccc_conduit conduit)
    15 {
    16 smccc_version = version;
    17 smccc_conduit = conduit;
    18 }
    19
