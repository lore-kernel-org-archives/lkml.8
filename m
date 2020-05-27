Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B196FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8864C2084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590602927;
	bh=EkrxDgW2W7jklShbuK3ccGvQdpxTbQarzQKd6FLVLgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ux7b5nQlhthdAckuFTkySicdbbskIVYRCpuoFE2MtbkmpM9MnlLxczXOFmgpFRAX4
	 WEjPgLIzgj2DW+w2Kf2LRyO4KVFEXyTQcPRRyff4kj7RdD3TawsfSg70JjvKPAQFjV
	 DJYps9EFb7DgPInuM2UbHsj42fskWA04B4nZBf94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391910AbgE0SIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:08:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391899AbgE0SIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:08:46 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E03042075A;
        Wed, 27 May 2020 18:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590602926;
        bh=EkrxDgW2W7jklShbuK3ccGvQdpxTbQarzQKd6FLVLgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=deq7F0t+XNEaB9xXwmIRl6SLB0gmB4gu7wH7Dl6Jh7XBHRrdUXqFDcAa2b/sLRsSM
         0PS6NRMEJD3NHSvnod+9TTScg4YL3BnjVq0f2x8KOosnPSwza6vegMDcw7UZoEd5Vx
         CEH+0Dd5z3MQ4/ta9IbM9e70z/NAFCwNiwCHeGYI=
Date:   Wed, 27 May 2020 19:08:40 +0100
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
Message-ID: <20200527180839.GA16411@willie-the-truck>
References: <20200526173117.155339-1-ndesaulniers@google.com>
 <2f58c2a4-0f37-d507-7767-00161c6b5d98@arm.com>
 <CAKwvOd=Oy_OfRbL6-q-3CAHxWBNBKE+HkfNfgCiP726u+4dU1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=Oy_OfRbL6-q-3CAHxWBNBKE+HkfNfgCiP726u+4dU1Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 10:55:24AM -0700, Nick Desaulniers wrote:
> On Wed, May 27, 2020 at 6:45 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2020-05-26 18:31, Nick Desaulniers wrote:
> > > Custom toolchains that modify the default target to -mthumb cannot
> > > compile the arm64 compat vdso32, as
> > > arch/arm64/include/asm/vdso/compat_gettimeofday.h
> > > contains assembly that's invalid in -mthumb.  Force the use of -marm,
> > > always.
> >
> > FWIW, this seems suspicious - the only assembly instructions I see there
> > are SWI(SVC), MRRC, and a MOV, all of which exist in Thumb for the
> > -march=armv7a baseline that we set.
> >
> > On a hunch, I've just bodged "VDSO_CFLAGS += -mthumb" into my tree and
> > built a Thumb VDSO quite happily with Ubuntu 19.04's
> > gcc-arm-linux-gnueabihf. What was the actual failure you saw?
> 
> From the link in the commit message: `write to reserved register 'R7'`
> https://godbolt.org/z/zwr7iZ
> IIUC r7 is reserved for the frame pointer in THUMB?
> 
> What is the implicit default of your gcc-arm-linux-gnueabihf at -O2?
> -mthumb, or -marm?

Hmm, but this *is* weird because if I build a 32-bit kernel then I get
either an ARM or a Thumb-2 VDSO depending on CONFIG_THUMB2_KERNEL. I'm
not sure if that's deliberate, but both build and appear to work.

I'll drop this patch for now, while we figure it out a bit more.

Cheers,

Will
