Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC12EC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 03:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D00D206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 03:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKN4zkBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEFDp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 23:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgEFDp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 23:45:26 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D82CC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 20:45:26 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k133so320010oih.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 20:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zWB6cWjMNsKtRxqY/kkJuBnxLsHqY4CSraBHoWMjqp4=;
        b=OKN4zkBYDIz62lBDvEf3XM4DOuCpBniwoB2/yAFzUSYvxGBnmfmk4quJbCwxjP8DU4
         xLekmYvvK98w1NXnfe18epulQwaf2+My7yXmRnUncgTNHmX6BQEZFqAgF3JFDGeHWa8+
         Wbau+QfB/sZDYuLIB3bjX1iQJUToyR1I+k0IZkqJm/07hUnUAQQ1vRXD5CJ+h0n/aq+L
         3uf/30GOdRyiYkrNxBtM2huEyCGf5lQYugw3kkdLFna922yF/1J0v3s/y0DXrYoXzVzX
         f9rUeMCQmbgu9sXAYqxrKEs8BEJWpnKOVhsxzZo5g2Pj2d9a0C3KmGNJIMHH4kQRfRLk
         gY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zWB6cWjMNsKtRxqY/kkJuBnxLsHqY4CSraBHoWMjqp4=;
        b=YkYJYwNHKeej7uw/Ij+Rxfvsn42sMOhdvjllIguUHZbjfMLZ2Nyqc4s5i4XxdiO2eR
         4ohIghuj/Zkxi7W98L0xHhZ4tnEUPkyHHMrZSTcgVKHxSa7oAbXIwVkkAKHdDjnRqGBj
         poj+XmU5Ya64GlcbHsWua3FdOf439d+/wnV9ZwtjrWDTSfYRsn5LTG36lKLBx3/bdvaM
         hEtRGbsDQ1c8KsdrHCeKwyDmY0oK6rst54ZsG8ysz8AzI+RdwpO9jawRi3EjEn4rSm0K
         NxoTuGc30/fkT7tl2GSqGYVbxAoB5KiyAd8qYa/o9qNjYsMMV1qXDihiJ34C8atn+ErH
         f5lQ==
X-Gm-Message-State: AGi0PubsttBn6cJlVWliDpGn+IbJZqocuwOgecJieNIjrY9CswK5rf+B
        NTkqwZVscOuWSHTj9+wsVio=
X-Google-Smtp-Source: APiQypJeHUSXrgoOMLaldrkbNutzLGRo+2lOCXDoyA2v2XT/zC8q/zdCfYxUKlEywfZjTOMCYuVXBw==
X-Received: by 2002:a54:409a:: with SMTP id i26mr1403854oii.50.1588736725456;
        Tue, 05 May 2020 20:45:25 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id r6sm304439oom.26.2020.05.05.20.45.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 20:45:24 -0700 (PDT)
Date:   Tue, 5 May 2020 20:45:23 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
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
        clang-built-linux@googlegroups.com,
        Fangrui Song <maskray@google.com>
Subject: Re: [PATCH] arm64: disable patchable function entry on big-endian
 clang builds
Message-ID: <20200506034523.GA564255@ubuntu-s3-xlarge-x86>
References: <20200505141257.707945-1-arnd@arndb.de>
 <20200505142556.GF82823@C02TD0UTHF1T.local>
 <20200505194243.5bfc6ec6@blackhole>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505194243.5bfc6ec6@blackhole>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Fangrui, who implemented patchable_function_entry in LLVM/clang

On Tue, May 05, 2020 at 07:42:43PM +0200, Torsten Duwe wrote:
> Hi Arnd, Mark and others,
> 
> this may not be worth arguing but I'm currently fighting excessive
> workarounds in another area and so this triggers me, so I have to make
> a remark ;-)
> 
> On Tue, 5 May 2020 15:25:56 +0100
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
> > On Tue, May 05, 2020 at 04:12:36PM +0200, Arnd Bergmann wrote:
> > > Clang only supports the patchable_function_entry attribute on
> > > little-endian arm64 builds, but not on big-endian:
> > > 
> > > include/linux/kasan-checks.h:16:8: error: unknown attribute
> > > 'patchable_function_entry' ignored [-Werror,-Wunknown-attributes]
> > > 
> > > Disable that configuration with another dependency. Unfortunately
> > > the existing check is not enough, as $(cc-option) at this point does
> > > not pass the -mbig-endian flag.
> > 
> > Well that's unfortunate. :(
> > 
> > Do we know if this is deliberate and/or likely to change in future?

I am not sure this is deliberate, I don't see anything about endianness
in the commits that added this:

https://github.com/llvm/llvm-project/commit/4d1e23e3b3cd7c72a8b24dc5acb7e13c58a8de37
https://github.com/llvm/llvm-project/commit/22467e259507f5ead2a87d989251b4c951a587e4
https://github.com/llvm/llvm-project/commit/06b8e32d4fd3f634f793e3bc0bc4fdb885e7a3ac

> > This practically rules out a BE distro kernel with things like PAC,
> > which isn't ideal.

To be fair, are there big endian AArch64 distros?

https://wiki.debian.org/Arm64Port: "There is also a big-endian version
of the architecture/ABI: aarch64_be-linux-gnu but we're not supporting
that in Debian (so there is no corresponding Debian architecture name)
and hopefully will never have to. Nevertheless you might want to check
for this by way of completeness in upstream code."

OpenSUSE and Fedora don't appear to have support for big endian.

> But still better than cumulating workarounds. If clang's flags aren't
> orthogonal then that's a bug in clang. If I get a vote here I'm against
> it.
> 
> > > Fixes: 3b23e4991fb6 ("arm64: implement ftrace with regs")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > This looks fine for now, and we can add a version check in future, so:
>                                       ^^^^^^^^^^^^^^^^^^^
> see what I mean? And in the end another line of code you'll never again
> get rid of.

That's a rather pessimistic attitude to have. We've been rather good
about trying to fix stuff in the compiler rather than hacking up the
kernel.

> I suggest to get a quote from clang folks first about their schedule and
> regarded importance of patchable-function-entries on BE, and leave it as
> is: broken on certain clang configurations. It's not the kernel's fault.

We can file an upstream PR (https://bugs.llvm.org) to talk about this
(although I've CC'd Fangrui) but you would rather the kernel fail to
work properly than prevent the user from being able to select that
option? Why even have the "select" or "depends on" keyword then?

That said, I do think we should hold off on this patch until we hear
from the LLVM developers.

> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > Mark.
> > 
> > > ---
> > >  arch/arm64/Kconfig | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index 4b256fa6db7a..a33d6402b934 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -151,7 +151,7 @@ config ARM64
> > >  	select HAVE_DMA_CONTIGUOUS
> > >  	select HAVE_DYNAMIC_FTRACE
> > >  	select HAVE_DYNAMIC_FTRACE_WITH_REGS \
> > > -		if $(cc-option,-fies on y=2)
> > > +		if $(cc-option,-fpatchable-function-entry=2) &&
> > > !(CC_IS_CLANG && CPU_BIG_ENDIAN) select
> > > HAVE_EFFICIENT_UNALIGNED_ACCESS select HAVE_FAST_GUP
> > >  	select HAVE_FTRACE_MCOUNT_RECORD
> > > -- 
> > > 2.26.0
> > > 
> 

Cheers,
Nathan
