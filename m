Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A1CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30B34207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590650439;
	bh=kWn6kw1Q2rkL1n7RefUBr2BzgAg9cR7AKr0/+z9extc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=G0U122sCm2pph+qQLP8S4cdi0tsqSvCy5wuhWWN1D0RgOzAscQ2z9unCcI3nIpVJU
	 yr+lhIfXg4jNrZ1qEdr4VblJTysOZXA/T4Ki6WU+DUwVGWx+6pn9b9N5BdcvESFHLq
	 3vySzQd+nCY3Z9epGk/OeWCu72GskOl44eqUNwqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgE1HUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:41232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE1HUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:20:38 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D01F2075F;
        Thu, 28 May 2020 07:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590650437;
        bh=kWn6kw1Q2rkL1n7RefUBr2BzgAg9cR7AKr0/+z9extc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OsdsHxMbca8zhRGEVlk5VITCzm8AJQa72/CWd/aexN2r7xEHs5HqoE3h3hlMMiv+b
         OCU0m0Jas7xxAILv9BtPTNyJDbiaUVs/zyFuVNilSOEMJsKZV/UiRxc3QyzsheC/VK
         qzQBQPZo5GundMsRnIOT37uVKm+HeSC03UJDGyiY=
Date:   Thu, 28 May 2020 08:20:31 +0100
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Stephen Boyd <swboyd@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Luis Lozano <llozano@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: vdso32: force vdso32 to be compiled as -marm
Message-ID: <20200528072031.GA22156@willie-the-truck>
References: <20200526173117.155339-1-ndesaulniers@google.com>
 <2f58c2a4-0f37-d507-7767-00161c6b5d98@arm.com>
 <CAKwvOd=Oy_OfRbL6-q-3CAHxWBNBKE+HkfNfgCiP726u+4dU1Q@mail.gmail.com>
 <20200527180839.GA16411@willie-the-truck>
 <CAKwvOdm5hGzJ0WY_GAywRZ1c8MkA=H7imY0rrVgB4MgtyJ+iRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm5hGzJ0WY_GAywRZ1c8MkA=H7imY0rrVgB4MgtyJ+iRg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 11:17:33AM -0700, Nick Desaulniers wrote:
> On Wed, May 27, 2020 at 11:08 AM Will Deacon <will@kernel.org> wrote:
> >
> > On Wed, May 27, 2020 at 10:55:24AM -0700, Nick Desaulniers wrote:
> > > On Wed, May 27, 2020 at 6:45 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > > >
> > > > On 2020-05-26 18:31, Nick Desaulniers wrote:
> > > > > Custom toolchains that modify the default target to -mthumb cannot
> > > > > compile the arm64 compat vdso32, as
> > > > > arch/arm64/include/asm/vdso/compat_gettimeofday.h
> > > > > contains assembly that's invalid in -mthumb.  Force the use of -marm,
> > > > > always.
> > > >
> > > > FWIW, this seems suspicious - the only assembly instructions I see there
> > > > are SWI(SVC), MRRC, and a MOV, all of which exist in Thumb for the
> > > > -march=armv7a baseline that we set.
> > > >
> > > > On a hunch, I've just bodged "VDSO_CFLAGS += -mthumb" into my tree and
> > > > built a Thumb VDSO quite happily with Ubuntu 19.04's
> > > > gcc-arm-linux-gnueabihf. What was the actual failure you saw?
> > >
> > > From the link in the commit message: `write to reserved register 'R7'`
> > > https://godbolt.org/z/zwr7iZ
> > > IIUC r7 is reserved for the frame pointer in THUMB?
> > >
> > > What is the implicit default of your gcc-arm-linux-gnueabihf at -O2?
> > > -mthumb, or -marm?
> >
> > Hmm, but this *is* weird because if I build a 32-bit kernel then I get
> > either an ARM or a Thumb-2 VDSO depending on CONFIG_THUMB2_KERNEL. I'm
> > not sure if that's deliberate, but both build and appear to work.
> 
> That's because there's 3 VDSO's when it comes to ARM:
> arm64's 64b vdso: arch/arm64/kernel/vdso
> arm64's 32b vdso: arch/arm64/kernel/vdso32/
> arm's 32b vdso: arch/arm/kernel/vdso.c

Yes, I know that :)

> When you build a 32b kernel, you're only making use of the last of
> those three; the arm64 vdso and vdso32 code is irrelevant.
> This patch is specific to the second case, which is the 32b compat
> vdso for a 64b kernel.

Sure, but if you can build a Thumb-2 vDSO object for arch/arm/ using then
we should be able to build a Thumb-2 compat vDSO for arch/arm64, and your
patch is papering over a deeper issue. Generally, having the compat vDSO
behave differently to the arch/arm/ vDSO is indicative of something being
broken.

In other words, if your patch was correct (not sure that it is) then I
would expect a corresponding change to arch/arm/ to pass -marm when
CONFIG_THUMB2_KERNEL=y. Make sense?

Will
