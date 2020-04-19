Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7123C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 11:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 965F321841
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 11:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="WmfvRi3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgDSLIM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 07:08:12 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:34864 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgDSLIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 07:08:12 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 079D45C9ADE;
        Sun, 19 Apr 2020 13:08:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1587294486;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a0hpRrCjohxzHvPf38IAgCtaSvu3v8WSSLh0hsDEMqw=;
        b=WmfvRi3jR7d1hRFCgk+w1SXChEMd+jClZqc2hGhn7eZqZyKobXpYwBSYbtGw+JtpTIM/pd
        bBT20gm7rLpg3P4dnoET5zVECvwL1nlC4d05IZaayjf0Q0vHxNkQpZJp474Av1riOXAIYd
        PGiZgTsTNn6hlKbpLvauWsxgKc6VTL0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Sun, 19 Apr 2020 13:08:05 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kristof Beyls <Kristof.Beyls@arm.com>,
        Stephen Hines <srhines@google.com>,
        Luis Lozano <llozano@google.com>,
        Jian Cai <caij2003@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Smith <Peter.Smith@arm.com>,
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
        linux-kernel@vger.kernel.org,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
In-Reply-To: <20200415144450.GF25745@shell.armlinux.org.uk>
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
 <20200415144450.GF25745@shell.armlinux.org.uk>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <ee12f583d2e2d4b9acdaeb213d3c4e25@agner.ch>
X-Sender: stefan@agner.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-15 16:44, Russell King - ARM Linux admin wrote:
> On Wed, Apr 15, 2020 at 02:58:05PM +0200, Arnd Bergmann wrote:
>> On Wed, Apr 15, 2020 at 12:32 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>> >
>> > On Tue, 14 Apr 2020 at 22:53, Kees Cook <keescook@chromium.org> wrote:
>> > >
>> > > I don't know if this will help, but I feel like folks might be talking
>> > > past each other a little here. I see two primary issues that are
>> > > colliding, and I just want to call them out specifically...
>> >
>> > To reiterate my point: I strongly prefer minor asm surgery over
>> > elaborate Kconfig plumbing if it means we can retain the functionality
>> > even when using LLVM tools. In particular, the use of macros to
>> > implement missing ISA support should be considered before any other
>> > solution, as these are already being used widely across architectures
>> > to fill in such gaps.
>>
>> +1
>>
>> > > What's a good middle ground here? For VLAs, I ended up getting akpm's
>> > > help by having him add -Wvla to his local builds and send nag emails
>> > > to people when they added VLAs. That's not really a thing here, but it
>> > > seems like there should be a way to avoid losing ground (in this case,
>> > > it's the erosion of attention: repeated known-issue warnings means the
>> > > CI gets ignored for the warnings on newly added issues). It does seem
>> > > to me like adding the negative depends is a reasonable first step: it
>> > > marks what hard things need fixing later without losing coverage for
>> > > things that can be more easily fixed now with available resources.
>> > >
>> > > For the specific iwmmxt.S case, perhaps the solution is the suggested
>> > > changes? I imagine it should be possible to do a binary diff to see zero
>> > > changes before/after.
>> >
>> > This code has been around since 2004. It has never been possible to
>> > assemble it with Clang's assembler. So the only thing this patch gives
>> > you is the ability to switch from a .config where IWMMXT was disabled
>> > by hand to one where it gets disabled automatically by Kconfig.
>> >
>> > So what hard-won ground are we losing here? Did IWMMXT recently get
>> > enabled in a defconfig that you care about?
>>
>> I mainly care about the build testing aspect here, it seems we are getting
>> close to having the clang integrated assembler working with all .S files
>> in the kernel (it used to work for none), and I'd like to do randconfig and
>> allmodconfig tests that include these as well. Disabling the option works
>> for me, but your suggestion with the added macros is clearly better.
> 
> However, to me it seems the approach has been "clang doesn't like X,
> the kernel has to change to suit clang" - sometimes at the expense
> of either functionality or maintainability of the kernel.

There are also quite some quirks which work around gcc/binutils
weirdness in the kernel. E.g. there are macros to make VFP support work
with older binutils versions.

I understand, Clang is the newcomer here. Breaking gcc/binutils is a
nogo, and functionality or maintainability should not suffer.

I think the important thing here is that whatever workarounds are
introduced that they are properly documented: Why is this required, how
does it work, and under what circumstances can it be removed again. This
should be in commit logs as well as inline.

> 
> Some of the changes have been good (provoking modernisation) but that's
> not true of everything - and I see nothing happening subsequently to
> rectify the situation.

And that is true with gcc/binutils work arounds which have been
introduced long time ago.

From my perspective, the kernel always tried to be very user oriented
when it comes to toolchain support: Rather than blacklist a known broken
toolchain version, work arounds have been introduced. And I think we
should treat Clang no different.

That being said, I am not saying we should hack up the kernel to make
Clang work no matter what. There are fixes made in Clang so we can avoid
introducing hacks in the kernel. There needs to be a balance.

Again, I think more important is that when we introduce work arounds in
Linux, that we make sure that such changes are properly document. This
will make cleanup a *lot* easier and therefor more likely down the road.

> 
> Had we gone down the path of disabling the build of iWMMXT, if anyone
> builds a kernel with clang for ARMv5 PXA and relies on iWMMXT, their
> userspace suddenly breaks because they used a different compiler and
> lost the necessary iWMMXT support in the kernel to allow userspace to
> operate, which isn't a nice approach.

That is actually a very good point and hasn't really been taken into
account in this discussion.

Currently the default behavior is that iWMMXT is enabled for all CPUs
supporting it. With the patch as-is, users who might try out Clang (with
integrated assembler) likely will not notice that iWMMXT is not
supported. They will be in for a surprise once they try to use user
space applications making use of iWMMXT instructions.

Avoiding such surprises would mean we either disable all iWMMXT
CPUs/architectures when using Clang's integrated assembler or make sure
they work with the integrated assembler.

Is there a nice way to print a warning at build time in this case?

> 
> Using macros is the best solution to work around clang, but should not
> be done at the expense of GNU AS which has proper support.

I guess making the macros a Clang only thing should be doable.

> 
> I'd say this: if clang wants to support building ARMv5, then it needs
> to support iWMMXT and stop forcing the kernel to adapt to Clang's
> incomplete implementations (which are no direct fault of the clang
> developers.)

So far I at least did not really look into supporting ARMv5
architectures when building with Clang. I would be fine to just disable
ARMv5 architecture when using Clang's integrated assembler, at least for
now.

However, iWMMXT is also supported by Marvell's PJ4 microarchitecture,
which is an ARMv7-A architecture. Hence this file is assembled when
building multi_v7_defconfig (since ARCH_DOVE is enabled there). So if we
consider iWMMXT mandatory to support an architecture, we would have to
disable more than "just" ARMv5.

That said, I still would prefer this patch over disabling all the
architectures. Keep in mind that integrated assembler needs to be
explicitly enabled (using LLVM_IAS=1).

While I fear that the asm macro surgery will not be that clean/trivial,
I still think its the best option. It side steps the problem of
accidentally breaking user space and ultimately allows to build more
configurations with Clang's integrated assembler.

--
Stefan
