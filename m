Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07808C2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 23:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB18E2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 23:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgDJXkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 19:40:46 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:51694 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgDJXkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 19:40:46 -0400
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23992495AbgDJXkmjfjpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org> + 1 other);
        Sat, 11 Apr 2020 01:40:42 +0200
Date:   Sat, 11 Apr 2020 00:40:42 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Kees Cook <keescook@chromium.org>
cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org,
        Fangrui Song <maskray@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3] MIPS: Truncate link address into 32bit for 32bit
 kernel
In-Reply-To: <202004101334.A641706F0@keescook>
Message-ID: <alpine.LFD.2.21.2004110032550.851719@eddie.linux-mips.org>
References: <20200407080611.859256-1-jiaxun.yang@flygoat.com> <20200410090634.3513101-1-jiaxun.yang@flygoat.com> <202004101334.A641706F0@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Apr 2020, Kees Cook wrote:

> > diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> > index d6e97df51cfb..0178f7085317 100644
> > --- a/arch/mips/kernel/Makefile
> > +++ b/arch/mips/kernel/Makefile
> > @@ -112,4 +112,13 @@ obj-$(CONFIG_MIPS_CPC)		+= mips-cpc.o
> >  obj-$(CONFIG_CPU_PM)		+= pm.o
> >  obj-$(CONFIG_MIPS_CPS_PM)	+= pm-cps.o
> >  
> > -CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
> > +# When linking a 32-bit executable the LLVM linker cannot cope with a
> > +# 32-bit load address that has been sign-extended to 64 bits.  Simply
> > +# remove the upper 32 bits then, as it is safe to do so with other
> > +# linkers.
> > +ifdef CONFIG_64BIT
> > +	load-ld			= $(VMLINUX_LOAD_ADDRESS)
> > +else
> > +	load-ld			= $(shell $(objtree)/arch/mips/tools/truncate32 $(VMLINUX_LOAD_ADDRESS))
> 
> This is major overkill. Just use the Makefile's builtin text
> manipulation:
> 
> load-ld = $(subst 0xffffffff,0x,$(VMLINUX_LOAD_ADDRESS))

 This looks like the best approach to me, thank you for the hint!  And we 
only ever want to strip 0xffffffff anyway.  (I forgot about this function 
of `make', doh!)

  Maciej
