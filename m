Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4D1C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65C412078B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZeyHf1lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370889AbgDOOqR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S370934AbgDOOp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:45:59 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E21EC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 07:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Q6y0RY1r/bsSQu1Pjhp5jZO0J0vCNZAdOGGiFado0tg=; b=ZeyHf1lpXQg+EMSv8Vfok/G9o
        ZJsoZldDhcd6jFsf4UKnLOBvEET5e+YndugH+ve6UE9kS3I6DjJnt9fQ6bFucg/hQSUbxYDgjM8L4
        RfzeXUZsn4k5GYAnWSSXOyTfqeW9tYzbrl7DusejqBnJRx9iLtpXjR8y6QbNvmEkrRIk+9zjB3/3D
        Qa96b5KO8niSZzlk9xmx46bCcUUMamdj/tYa7a1rCQAuR929SCG92lC6s4pUhsB7RgbTMkfQiUw4A
        R/ma6qh3WlWcb7GV2eZ9M0ICpTExfS2QpQFni+2bGeYsQDAwxXau45RDDpGhahCehnKArAFi5K/KK
        cYCHjcxag==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:46312)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jOjHj-00071l-VP; Wed, 15 Apr 2020 15:45:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jOjHW-00010F-Ku; Wed, 15 Apr 2020 15:44:50 +0100
Date:   Wed, 15 Apr 2020 15:44:50 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kristof Beyls <Kristof.Beyls@arm.com>,
        Stephen Hines <srhines@google.com>,
        Luis Lozano <llozano@google.com>,
        Jian Cai <caij2003@gmail.com>,
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
        Jian Cai <jiancai@google.com>,
        Doug Anderson <armlinux@m.disordat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
Message-ID: <20200415144450.GF25745@shell.armlinux.org.uk>
References: <CAK8P3a3uj7AHbAo4sNzr6KQx5Fk6v99k4ZixCgKo1tUuGoat9Q@mail.gmail.com>
 <CAMj1kXGXNxXGiC4dmNXHkZ6n=J0Fhim3oSwNx4Bz5m9fEphJvQ@mail.gmail.com>
 <20200410123301.GX25745@shell.armlinux.org.uk>
 <CAMj1kXFpknCfwb6JMdk_SHopnGqMswgSqaQUeAUEh5yaV10vJg@mail.gmail.com>
 <CAKwvOdk-xwuppJzxd1+5sfsC8jYiP3t8D=aTNaYxnFCRDiEUmQ@mail.gmail.com>
 <CAMj1kXFHb8th0rv1yjrsr=c1o-g9_ERPUy4itnrVN13fcQcXag@mail.gmail.com>
 <CAKwvOdm5aawsa2-=atB8z6W8zo8YVgdDEVbU3i4evDcpo1_AxQ@mail.gmail.com>
 <202004141258.6D9CB92507@keescook>
 <CAMj1kXG6_CO6pzeJCSeWiCDyLfWw+ZMuvkv_DLxe-si00fLd1Q@mail.gmail.com>
 <CAK8P3a3Ko0XTLUGwBxVM=nNebGr6ww66+cCKbYBrd9A4ME0__w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Ko0XTLUGwBxVM=nNebGr6ww66+cCKbYBrd9A4ME0__w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 02:58:05PM +0200, Arnd Bergmann wrote:
> On Wed, Apr 15, 2020 at 12:32 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Tue, 14 Apr 2020 at 22:53, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > I don't know if this will help, but I feel like folks might be talking
> > > past each other a little here. I see two primary issues that are
> > > colliding, and I just want to call them out specifically...
> >
> > To reiterate my point: I strongly prefer minor asm surgery over
> > elaborate Kconfig plumbing if it means we can retain the functionality
> > even when using LLVM tools. In particular, the use of macros to
> > implement missing ISA support should be considered before any other
> > solution, as these are already being used widely across architectures
> > to fill in such gaps.
> 
> +1
> 
> > > What's a good middle ground here? For VLAs, I ended up getting akpm's
> > > help by having him add -Wvla to his local builds and send nag emails
> > > to people when they added VLAs. That's not really a thing here, but it
> > > seems like there should be a way to avoid losing ground (in this case,
> > > it's the erosion of attention: repeated known-issue warnings means the
> > > CI gets ignored for the warnings on newly added issues). It does seem
> > > to me like adding the negative depends is a reasonable first step: it
> > > marks what hard things need fixing later without losing coverage for
> > > things that can be more easily fixed now with available resources.
> > >
> > > For the specific iwmmxt.S case, perhaps the solution is the suggested
> > > changes? I imagine it should be possible to do a binary diff to see zero
> > > changes before/after.
> >
> > This code has been around since 2004. It has never been possible to
> > assemble it with Clang's assembler. So the only thing this patch gives
> > you is the ability to switch from a .config where IWMMXT was disabled
> > by hand to one where it gets disabled automatically by Kconfig.
> >
> > So what hard-won ground are we losing here? Did IWMMXT recently get
> > enabled in a defconfig that you care about?
> 
> I mainly care about the build testing aspect here, it seems we are getting
> close to having the clang integrated assembler working with all .S files
> in the kernel (it used to work for none), and I'd like to do randconfig and
> allmodconfig tests that include these as well. Disabling the option works
> for me, but your suggestion with the added macros is clearly better.

However, to me it seems the approach has been "clang doesn't like X,
the kernel has to change to suit clang" - sometimes at the expense
of either functionality or maintainability of the kernel.

Some of the changes have been good (provoking modernisation) but that's
not true of everything - and I see nothing happening subsequently to
rectify the situation.

Had we gone down the path of disabling the build of iWMMXT, if anyone
builds a kernel with clang for ARMv5 PXA and relies on iWMMXT, their
userspace suddenly breaks because they used a different compiler and
lost the necessary iWMMXT support in the kernel to allow userspace to
operate, which isn't a nice approach.

Using macros is the best solution to work around clang, but should not
be done at the expense of GNU AS which has proper support.

I'd say this: if clang wants to support building ARMv5, then it needs
to support iWMMXT and stop forcing the kernel to adapt to Clang's
incomplete implementations (which are no direct fault of the clang
developers.)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
