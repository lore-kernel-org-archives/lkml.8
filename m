Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6B9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17436206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591785147;
	bh=nzcMgvSYVSQG6LYhiykQ51gcCDtdIOzGzyxHLuoknuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Pjb2hOofxte9UNAIv5Mu2ef62oa0Y9LBwWn+TeJpdjC5eHUaBYAn8BaS1Ym/MJzJ2
	 1cITn9WWKDdc9PlrA5+FPPjAJwp+yjlweK/0Lt6qJ39LxbIJfHcETvfOsjnU0DtCPu
	 LqK9xXkyQYFTVA/s5nybcrEft3xMJTasARmOtFJw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgFJKc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:32:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgFJKcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:32:25 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FE8220656;
        Wed, 10 Jun 2020 10:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591785144;
        bh=nzcMgvSYVSQG6LYhiykQ51gcCDtdIOzGzyxHLuoknuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PHzbqu6umdAvaggxxISjlUMDbHo6Z0Z9HQuD87acFKVnvoWCEjXL+kvvc/LN6txF+
         Iv/+6aNc+d/l2HGBZjVA8VRJaQF4wUifPS5fZe0hia32prs7PPtQYV8lfaDLSPn2c3
         m6N765mptbSyW31qK4/VndvZKOF7XT8Q5n2HnTtI=
Date:   Wed, 10 Jun 2020 11:32:19 +0100
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <20200610103218.GA18350@willie-the-truck>
References: <20200528072031.GA22156@willie-the-truck>
 <20200608205711.109418-1-ndesaulniers@google.com>
 <20200609203502.GA21214@gaia>
 <CAKwvOdnDeYQ-tbyW8=tcKcbbFxtDzqk8dCUSzbBYP1amb9a2hg@mail.gmail.com>
 <20200610084755.GB17035@willie-the-truck>
 <20200610102916.GA26099@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610102916.GA26099@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 11:29:17AM +0100, Catalin Marinas wrote:
> On Wed, Jun 10, 2020 at 09:47:55AM +0100, Will Deacon wrote:
> > On Tue, Jun 09, 2020 at 04:55:13PM -0700, Nick Desaulniers wrote:
> > > On Tue, Jun 9, 2020 at 1:35 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > > On Mon, Jun 08, 2020 at 01:57:08PM -0700, Nick Desaulniers wrote:
> > > > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > > > index 7f9d38444d6d..fe9e6b231cac 100644
> > > > > --- a/arch/arm64/Kconfig
> > > > > +++ b/arch/arm64/Kconfig
> > > > > @@ -1299,6 +1299,14 @@ config COMPAT_VDSO
> > > > >         You must have a 32-bit build of glibc 2.22 or later for programs
> > > > >         to seamlessly take advantage of this.
> > > > >
> > > > > +config THUMB2_COMPAT_VDSO
> > > > > +     bool "Compile the vDSO in THUMB2 mode"
> > > > > +     depends on COMPAT_VDSO
> > > > > +     default y
> > > > > +     help
> > > > > +       Compile the compat vDSO with -mthumb -fomit-frame-pointer if y, otherwise
> > > > > +       as -marm.
> > > >
> > > > Now that we understood the issue (I think), do we actually need this
> > > > choice? Why not going for -mthumb -fomit-frame-pointer always for the
> > > > compat vdso?
> > > 
> > > "Why should the compat vdso be configurable?" is a fair question.  I
> > > don't have an answer, but maybe some of the folks on thread do?
> > > 
> > > Our problem is more so "if the vdso is built as thumb, we need it also
> > > explicitly built with -fomit-frame-pointer."  Whether it should be
> > > built as thumb, arm, or configurable (and which default to pick in
> > > that case) are still an open questions.  Will asked for it to be
> > > configurable, so I sent a patch making it configurable.
> > 
> > It's configurable for 32-bit arm,
> 
> On 32-bit, the vdso mode is a side-effect of how we build the kernel
> image. I guess we haven't put much thought into whether we want to keep
> the vdso in Thumb-2 or ARM mode.

I think your guess is correct!

> > so I was just following that as it's
> > hardly a maintenance burden to support both. I suppose you could have
> > a toolchain that only supports one or the other, but it does seem a little
> > esoteric if you're building a kernel for an arm64 CPU.
> 
> We could leave the config option in if we ever need to change the compat
> vdso mode. But as not to confuse others with too many options, maybe
> add:
> 
> 	bool "Compile the vDSO in THUMB2 mode" if EXPERT
> 
> Either way:
> 
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Cheers, I'll add the dependency on EXPERT since I agree it's probably not
something most people would want to touch. I'll also change the text to say
"compat vDSO" not just vDSO.

Will
