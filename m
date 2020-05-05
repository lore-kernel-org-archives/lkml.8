Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 331B8C47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B2EE206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgEERnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 13:43:16 -0400
Received: from verein.lst.de ([213.95.11.211]:36572 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729315AbgEERnQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 13:43:16 -0400
Received: by verein.lst.de (Postfix, from userid 107)
        id 3590468CEC; Tue,  5 May 2020 19:43:14 +0200 (CEST)
Received: from blackhole (p5B0D8880.dip0.t-ipconnect.de [91.13.136.128])
        by verein.lst.de (Postfix) with ESMTPSA id 4B6E268BFE;
        Tue,  5 May 2020 19:42:48 +0200 (CEST)
Date:   Tue, 5 May 2020 19:42:43 +0200
From:   Torsten Duwe <duwe@lst.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Torsten Duwe <duwe@suse.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Julien Thierry <jthierry@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] arm64: disable patchable function entry on big-endian
 clang builds
Message-ID: <20200505194243.5bfc6ec6@blackhole>
In-Reply-To: <20200505142556.GF82823@C02TD0UTHF1T.local>
References: <20200505141257.707945-1-arnd@arndb.de>
        <20200505142556.GF82823@C02TD0UTHF1T.local>
Organization: LST e.V.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Mark and others,

this may not be worth arguing but I'm currently fighting excessive
workarounds in another area and so this triggers me, so I have to make
a remark ;-)

On Tue, 5 May 2020 15:25:56 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Tue, May 05, 2020 at 04:12:36PM +0200, Arnd Bergmann wrote:
> > Clang only supports the patchable_function_entry attribute on
> > little-endian arm64 builds, but not on big-endian:
> > 
> > include/linux/kasan-checks.h:16:8: error: unknown attribute
> > 'patchable_function_entry' ignored [-Werror,-Wunknown-attributes]
> > 
> > Disable that configuration with another dependency. Unfortunately
> > the existing check is not enough, as $(cc-option) at this point does
> > not pass the -mbig-endian flag.
> 
> Well that's unfortunate. :(
> 
> Do we know if this is deliberate and/or likely to change in future?
> This practically rules out a BE distro kernel with things like PAC,
> which isn't ideal.

But still better than cumulating workarounds. If clang's flags aren't
orthogonal then that's a bug in clang. If I get a vote here I'm against
it.

> > Fixes: 3b23e4991fb6 ("arm64: implement ftrace with regs")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> This looks fine for now, and we can add a version check in future, so:
                                      ^^^^^^^^^^^^^^^^^^^
see what I mean? And in the end another line of code you'll never again
get rid of.

I suggest to get a quote from clang folks first about their schedule and
regarded importance of patchable-function-entries on BE, and leave it as
is: broken on certain clang configurations. It's not the kernel's fault.

> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> Mark.
> 
> > ---
> >  arch/arm64/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 4b256fa6db7a..a33d6402b934 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -151,7 +151,7 @@ config ARM64
> >  	select HAVE_DMA_CONTIGUOUS
> >  	select HAVE_DYNAMIC_FTRACE
> >  	select HAVE_DYNAMIC_FTRACE_WITH_REGS \
> > -		if $(cc-option,-fies on y=2)
> > +		if $(cc-option,-fpatchable-function-entry=2) &&
> > !(CC_IS_CLANG && CPU_BIG_ENDIAN) select
> > HAVE_EFFICIENT_UNALIGNED_ACCESS select HAVE_FAST_GUP
> >  	select HAVE_FTRACE_MCOUNT_RECORD
> > -- 
> > 2.26.0
> > 

