Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5100C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A68AE206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgFJK3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:29:22 -0400
Received: from foss.arm.com ([217.140.110.172]:56562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbgFJK3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:29:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 400191FB;
        Wed, 10 Jun 2020 03:29:21 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5FE5E3F73D;
        Wed, 10 Jun 2020 03:29:19 -0700 (PDT)
Date:   Wed, 10 Jun 2020 11:29:17 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Stephen Boyd <swboyd@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] arm64: vdso32: add CONFIG_THUMB2_COMPAT_VDSO
Message-ID: <20200610102916.GA26099@gaia>
References: <20200528072031.GA22156@willie-the-truck>
 <20200608205711.109418-1-ndesaulniers@google.com>
 <20200609203502.GA21214@gaia>
 <CAKwvOdnDeYQ-tbyW8=tcKcbbFxtDzqk8dCUSzbBYP1amb9a2hg@mail.gmail.com>
 <20200610084755.GB17035@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610084755.GB17035@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 09:47:55AM +0100, Will Deacon wrote:
> On Tue, Jun 09, 2020 at 04:55:13PM -0700, Nick Desaulniers wrote:
> > On Tue, Jun 9, 2020 at 1:35 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Mon, Jun 08, 2020 at 01:57:08PM -0700, Nick Desaulniers wrote:
> > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > index 7f9d38444d6d..fe9e6b231cac 100644
> > > > --- a/arch/arm64/Kconfig
> > > > +++ b/arch/arm64/Kconfig
> > > > @@ -1299,6 +1299,14 @@ config COMPAT_VDSO
> > > >         You must have a 32-bit build of glibc 2.22 or later for programs
> > > >         to seamlessly take advantage of this.
> > > >
> > > > +config THUMB2_COMPAT_VDSO
> > > > +     bool "Compile the vDSO in THUMB2 mode"
> > > > +     depends on COMPAT_VDSO
> > > > +     default y
> > > > +     help
> > > > +       Compile the compat vDSO with -mthumb -fomit-frame-pointer if y, otherwise
> > > > +       as -marm.
> > >
> > > Now that we understood the issue (I think), do we actually need this
> > > choice? Why not going for -mthumb -fomit-frame-pointer always for the
> > > compat vdso?
> > 
> > "Why should the compat vdso be configurable?" is a fair question.  I
> > don't have an answer, but maybe some of the folks on thread do?
> > 
> > Our problem is more so "if the vdso is built as thumb, we need it also
> > explicitly built with -fomit-frame-pointer."  Whether it should be
> > built as thumb, arm, or configurable (and which default to pick in
> > that case) are still an open questions.  Will asked for it to be
> > configurable, so I sent a patch making it configurable.
> 
> It's configurable for 32-bit arm,

On 32-bit, the vdso mode is a side-effect of how we build the kernel
image. I guess we haven't put much thought into whether we want to keep
the vdso in Thumb-2 or ARM mode.

> so I was just following that as it's
> hardly a maintenance burden to support both. I suppose you could have
> a toolchain that only supports one or the other, but it does seem a little
> esoteric if you're building a kernel for an arm64 CPU.

We could leave the config option in if we ever need to change the compat
vdso mode. But as not to confuse others with too many options, maybe
add:

	bool "Compile the vDSO in THUMB2 mode" if EXPERT

Either way:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
