Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6BBC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2BE20775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505691AbgDONAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:00:08 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:41019 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730906AbgDOM60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:58:26 -0400
Received: from mail-qt1-f179.google.com ([209.85.160.179]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MLAF0-1jfp1x0mdG-00ID8r for <linux-kernel@vger.kernel.org>; Wed, 15 Apr
 2020 14:58:23 +0200
Received: by mail-qt1-f179.google.com with SMTP id q17so12770198qtp.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 05:58:23 -0700 (PDT)
X-Gm-Message-State: AGi0PubKvuDuinOra+hcq4ZBZpO8BH9YHgBWT1p4c1zm+dKOXcPtiJp+
        wkhcYA+xpPU8WAjfQ0BOs/46qfM8zpwnOIb725w=
X-Google-Smtp-Source: APiQypLmb1bYsqGBxxmmhAYIpYg+E9AqYkcfzIMIIhGI/UjPoCq3S810wOoySTAVykqPSkerK29SOUSk3ZdF6ygThUU=
X-Received: by 2002:ac8:6757:: with SMTP id n23mr8081126qtp.304.1586955502081;
 Wed, 15 Apr 2020 05:58:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com> <CAK8P3a3uj7AHbAo4sNzr6KQx5Fk6v99k4ZixCgKo1tUuGoat9Q@mail.gmail.com>
 <CAMj1kXGXNxXGiC4dmNXHkZ6n=J0Fhim3oSwNx4Bz5m9fEphJvQ@mail.gmail.com>
 <20200410123301.GX25745@shell.armlinux.org.uk> <CAMj1kXFpknCfwb6JMdk_SHopnGqMswgSqaQUeAUEh5yaV10vJg@mail.gmail.com>
 <CAKwvOdk-xwuppJzxd1+5sfsC8jYiP3t8D=aTNaYxnFCRDiEUmQ@mail.gmail.com>
 <CAMj1kXFHb8th0rv1yjrsr=c1o-g9_ERPUy4itnrVN13fcQcXag@mail.gmail.com>
 <CAKwvOdm5aawsa2-=atB8z6W8zo8YVgdDEVbU3i4evDcpo1_AxQ@mail.gmail.com>
 <202004141258.6D9CB92507@keescook> <CAMj1kXG6_CO6pzeJCSeWiCDyLfWw+ZMuvkv_DLxe-si00fLd1Q@mail.gmail.com>
In-Reply-To: <CAMj1kXG6_CO6pzeJCSeWiCDyLfWw+ZMuvkv_DLxe-si00fLd1Q@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Apr 2020 14:58:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Ko0XTLUGwBxVM=nNebGr6ww66+cCKbYBrd9A4ME0__w@mail.gmail.com>
Message-ID: <CAK8P3a3Ko0XTLUGwBxVM=nNebGr6ww66+cCKbYBrd9A4ME0__w@mail.gmail.com>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kristof Beyls <Kristof.Beyls@arm.com>,
        Stephen Hines <srhines@google.com>,
        Luis Lozano <llozano@google.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
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
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:oBq4mQ79ir5f/pWuHXK2ecdTR1b1OYhz1uJFFN9zvrfd5Hp5FVG
 jDwRgbg/hkcVwtVwXyBmE7OrHj+Fg1rbiWAr+TtH/CL3e+8i1yWgZbdMGGlRf+ZnYB+vCGa
 a82T09mBdTxxCrJfjEKJDzugoQYaI3lfsje8MVTQfdDJCoiya+quIxner0V01876PJmRdgK
 FYNBjbj+NxudAXcrqimKg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xWWKkKdeclk=:KH8P7cbJQBjQh6O/sY01/6
 0nspAt2GmnhDkDf9iS7BBnQItlPTJVdIM4+/DZb9Sj5GsG2CiD+Pe6S/LMnxtXGa4/iZyt2Uk
 cQOgQut3uReG1RTSLixtK9joY9bPYaupZaySTknadX5hjlH1eSp3uwGcX7K9uTuUx9FqLPxr4
 /3HmqH9MD2o/vo2C6L15XCSorM1yL8bScWsy63bBhvwJyaOwzWnF3e+AphDWfByvq7BwgIvBY
 Hnv4C27w4Oh6/mwLd/DLEwLhxHK6IJhIQ0A4CShdjqbAgo+qeRKbaueLtT2vCkpvuAvDu4PpP
 dymqHXDmqmA82/ihUPbHTpAci04MfXueGO04kH4rw8xsrWXWFTvc8gNaBPqpcA+31n2axKzDD
 BReBLeIQVASbETLEf8nyBZKkefUWczJLwFq5Y01nh4HHdyBx+VINk2jj9Ia/deJWbRS4KCW3y
 9wplW8JRXPWVkt6yNuKDtbyygHmNKVk3iqegMQSSzNjyLL+Xz8TBrBA5L3PweMXSPrtqLlT4J
 Lu6oK74lILlcS3T2JNf4e4upjJahS7pFP48Mfijanw0OlX4RXoOO1l6NAw+TqvhWaruw4jO8M
 61ISXpY0oELc9Q1yX1AjDVXSV+MaX0L43Hbfnr8eu4SEmIdZQyBMRzgSilWrii3FVlC0lVMkj
 xP2SXyL2Iw7ob6LjHmyAtlmzocnuSR97ptTTQvCXizE1VaRr/5JolLusdZ7/mcrEsSFCoE2xs
 6I55OTiX+IK5Ib4SuVWRy9Yd57kJBVqp81/xTowZjRKTyWo5hOzcLrbha8aAXyV+zD1FJtEj2
 9MHWGlDpy6vXl4m2ytEJjd4f8GCt1AnVLH4zxR87CHAy7vopcI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 12:32 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 14 Apr 2020 at 22:53, Kees Cook <keescook@chromium.org> wrote:
> >
> > I don't know if this will help, but I feel like folks might be talking
> > past each other a little here. I see two primary issues that are
> > colliding, and I just want to call them out specifically...
>
> To reiterate my point: I strongly prefer minor asm surgery over
> elaborate Kconfig plumbing if it means we can retain the functionality
> even when using LLVM tools. In particular, the use of macros to
> implement missing ISA support should be considered before any other
> solution, as these are already being used widely across architectures
> to fill in such gaps.

+1

> > What's a good middle ground here? For VLAs, I ended up getting akpm's
> > help by having him add -Wvla to his local builds and send nag emails
> > to people when they added VLAs. That's not really a thing here, but it
> > seems like there should be a way to avoid losing ground (in this case,
> > it's the erosion of attention: repeated known-issue warnings means the
> > CI gets ignored for the warnings on newly added issues). It does seem
> > to me like adding the negative depends is a reasonable first step: it
> > marks what hard things need fixing later without losing coverage for
> > things that can be more easily fixed now with available resources.
> >
> > For the specific iwmmxt.S case, perhaps the solution is the suggested
> > changes? I imagine it should be possible to do a binary diff to see zero
> > changes before/after.
>
> This code has been around since 2004. It has never been possible to
> assemble it with Clang's assembler. So the only thing this patch gives
> you is the ability to switch from a .config where IWMMXT was disabled
> by hand to one where it gets disabled automatically by Kconfig.
>
> So what hard-won ground are we losing here? Did IWMMXT recently get
> enabled in a defconfig that you care about?

I mainly care about the build testing aspect here, it seems we are getting
close to having the clang integrated assembler working with all .S files
in the kernel (it used to work for none), and I'd like to do randconfig and
allmodconfig tests that include these as well. Disabling the option works
for me, but your suggestion with the added macros is clearly better.

        Arnd
