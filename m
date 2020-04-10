Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01869C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 12:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE8FA20679
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 12:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="l4BUxrAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDJMeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 08:34:18 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:60780 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgDJMeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 08:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=E1lO6MOH92TXjApRphPPU5REy5FFZ6ZxwRqdljo4K0I=; b=l4BUxrAoEycXsvzjLPbLhvRWn
        YmPDjlzo97j79NsDCZtIMpz+tOfJ6KLwqm+t16Gc3OahvC/q8epEK3btHhPJNFVvr2sM8sdKkSn0O
        4dqEY51qKb2+5UdFgeMYM+wTw0sXrrvHXl39ewXQXl5F0x5+LLa2OlyZWp7kIhy4tA3+R0NzIIOgN
        kItZyIUPPxOA1wiAS+fi/bo/hE4vTQXzskPL5uLJRtijka6wht30pxwQV3PLU/MYve1PNywLKPCPg
        CFQndh/X1J624Qe8ASBS0LUWvin4+mitfm5r9Ev/oGnDniUty9HF16ILDX85hnwTYHwUrPUbXS9b1
        IcuRBqUUA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:36520)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jMsqM-0001Tt-Nz; Fri, 10 Apr 2020 13:33:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jMsqD-0003m7-Pl; Fri, 10 Apr 2020 13:33:01 +0100
Date:   Fri, 10 Apr 2020 13:33:01 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jian Cai <caij2003@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Smith <Peter.Smith@arm.com>,
        Stefan Agner <stefan@agner.ch>,
        David Howells <dhowells@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Manoj Gupta <manojgupta@google.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        jiancai@google.com, Doug Anderson <armlinux@m.disordat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
Message-ID: <20200410123301.GX25745@shell.armlinux.org.uk>
References: <20200409232728.231527-1-caij2003@gmail.com>
 <CAK8P3a3uj7AHbAo4sNzr6KQx5Fk6v99k4ZixCgKo1tUuGoat9Q@mail.gmail.com>
 <CAMj1kXGXNxXGiC4dmNXHkZ6n=J0Fhim3oSwNx4Bz5m9fEphJvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGXNxXGiC4dmNXHkZ6n=J0Fhim3oSwNx4Bz5m9fEphJvQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 01:15:08PM +0200, Ard Biesheuvel wrote:
> On Fri, 10 Apr 2020 at 11:56, Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Fri, Apr 10, 2020 at 1:28 AM Jian Cai <caij2003@gmail.com> wrote:
> > >
> > > iwmmxt.S contains XScale instructions LLVM ARM backend does not support.
> > > Skip this file if LLVM integrated assemmbler or LLD is used to build ARM
> > > kernel.
> > >
> > > Signed-off-by: Jian Cai <caij2003@gmail.com>
> >
> > It clearly makes sense to limit the Kconfig option to compilers that
> > can actually build it.
> > A few questions though:
> >
> > - Given that Armada XP with its PJ4B was still marketed until fairly
> > recently[1],
> >   wouldn't it make sense to still add support for it? Is it a lot of work?
> >
> 
> The part of that file that the assembler chokes on hasn't been touched
> by anyone since Nico added it 15+ years ago. It can only be built in
> ARM mode, and it disassembles to the sequence below (the ld/st fe/fp
> mnemonics are not document in recent versions of the ARM ARM, and
> aren't understood by Clang either)

For older CPUs, it doesn't matter what the latest ARM ARM says, the
appropriate version of the ARM ARM is the one relevant for the CPU
architecture.  This is a mistake frequently made, and it's been pointed
out by Arm Ltd in the past (before ARMv6 even came on the scene) that
keeping older revisions is necessary if you want to be interested in
the older architectures.

However, there's an additional complication here: DEC's license from
Arm Ltd back in the days of StrongARM allowed them to make changes to
the architecture - that was passed over to Intel when they bought that
part of DEC.  Consequently, these "non-Arm vendor" cores contain
extensions that are not part of the ARM ARM.  iWMMXT is one such
example, which first appeared in the Intel PXA270 SoC (an ARMv5
derived CPU).

In fact, several of the features found in later versions of the ARM
architecture came from DEC and Intel enhancements.

If your compiler/assembler only implements what is in the latest ARM
ARM, then it is not going to be suitable for these older CPUs and
alternate vendor "ARM compatible" CPUs.

> Instead of playing all these tricks with Kconfig, couldn't we simply
> insert the bare opcodes and be done with it?

That gets close to a GPL violation; the GPL requires that source code
be in the preferred form for making modifications. Encoding raw opcodes
can in no way be argued to be the preferred form. Arguing that raw
opcodes is acceptable sets a precedent that makes it acceptable for
other "works" to do the same, which makes arguments against firmware
supplied as a hexdump null and void.

Using macros to emulate the instructions and create the appropriate
opcodes is an alternative; we already have that for some of the VFP
code as early toolchains had no support for the VFP instructions.

So no, bare opcodes are unacceptable.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
