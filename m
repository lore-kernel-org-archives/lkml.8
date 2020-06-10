Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7FAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 787AB2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591778883;
	bh=XmJ4HSxl4hqG6l3t1jcWoLYOgV//M491zGdVj+6y1cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i9UvTR4sWD0ZwyO1b3ApxZX4kAQVtzMEM1IGMC8lvIneGRdEpdk5RE51CT+POAGxT
	 I5Soovhur+KlPIwlcjg8DKYIC2609gXu3D5oABEsH3dhyZtI+8TCyqlf7IRTSSFNtT
	 6hrRmKAKk7Lo25PrcL9WemnKxhoLDzm0rLIYTCWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgFJIsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:48:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:54724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgFJIsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:48:01 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDCFD2078C;
        Wed, 10 Jun 2020 08:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591778881;
        bh=XmJ4HSxl4hqG6l3t1jcWoLYOgV//M491zGdVj+6y1cs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yPQ0Gn3ME6yN2FN9zfRHpgCOwfCYNMmgtZNq/1Qc1Y9lWLTi7EgLBE+ceOFwekFAr
         BPy2IzPJIwhEykv0N0q/1FvwtRO8QIPl5WmVzTw24LCdU4SPKU5ktMLNX0I0Zc+Dh/
         URIKegjZCtuwKT88nDENRmGm4av/IJGbwrYZqVzw=
Date:   Wed, 10 Jun 2020 09:47:55 +0100
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Stephen Boyd <swboyd@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Luis Lozano <llozano@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] arm64: vdso32: add CONFIG_THUMB2_COMPAT_VDSO
Message-ID: <20200610084755.GB17035@willie-the-truck>
References: <20200528072031.GA22156@willie-the-truck>
 <20200608205711.109418-1-ndesaulniers@google.com>
 <20200609203502.GA21214@gaia>
 <CAKwvOdnDeYQ-tbyW8=tcKcbbFxtDzqk8dCUSzbBYP1amb9a2hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnDeYQ-tbyW8=tcKcbbFxtDzqk8dCUSzbBYP1amb9a2hg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 04:55:13PM -0700, Nick Desaulniers wrote:
> On Tue, Jun 9, 2020 at 1:35 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > On Mon, Jun 08, 2020 at 01:57:08PM -0700, Nick Desaulniers wrote:
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index 7f9d38444d6d..fe9e6b231cac 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -1299,6 +1299,14 @@ config COMPAT_VDSO
> > >         You must have a 32-bit build of glibc 2.22 or later for programs
> > >         to seamlessly take advantage of this.
> > >
> > > +config THUMB2_COMPAT_VDSO
> > > +     bool "Compile the vDSO in THUMB2 mode"
> > > +     depends on COMPAT_VDSO
> > > +     default y
> > > +     help
> > > +       Compile the compat vDSO with -mthumb -fomit-frame-pointer if y, otherwise
> > > +       as -marm.
> >
> > Now that we understood the issue (I think), do we actually need this
> > choice? Why not going for -mthumb -fomit-frame-pointer always for the
> > compat vdso?
> 
> "Why should the compat vdso be configurable?" is a fair question.  I
> don't have an answer, but maybe some of the folks on thread do?
> 
> Our problem is more so "if the vdso is built as thumb, we need it also
> explicitly built with -fomit-frame-pointer."  Whether it should be
> built as thumb, arm, or configurable (and which default to pick in
> that case) are still an open questions.  Will asked for it to be
> configurable, so I sent a patch making it configurable.

It's configurable for 32-bit arm, so I was just following that as it's
hardly a maintenance burden to support both. I suppose you could have
a toolchain that only supports one or the other, but it does seem a little
esoteric if you're building a kernel for an arm64 CPU.

Will
