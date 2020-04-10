Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC71FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 07:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86103206F7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 07:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2AWKS56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDJHoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 03:44:44 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46103 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgDJHon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 03:44:43 -0400
Received: by mail-oi1-f196.google.com with SMTP id q204so771218oia.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 00:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kWTF/iK3b5Sk5JeUHvp98Y6uzIRDCjSO+zOeV+snwFg=;
        b=E2AWKS56FjZI1ulMBAgJoihDoWbZ8jgWGAUsyH559GWXe5gFIeG1pB2iN5UhZ04GBy
         deC4EHLDX4JUyOJYxJIH6nfKFYEGv5jJL90norCB/55Y2zwqi84NF0fXrWWJQLW1X9mC
         Rx6XCsw+34OiIwrcNkcqMxUFHx51zGnU0T9SuG2VEVpRtvSUbNqOgEMnpi32eB0ycj3w
         9LO5rc0m5sR3bvQ1bcvHmcxmu8zeulZ5m7kvrKSH0EKxbQMeYZRDuLSnLAzP+aab1xF1
         3MveE1X2iBtxpfRFXy+Jy5q4fBTz6bJIPnt8ReHewVivnAC/nvhGWDFg2v7iKV3+KL9Q
         HSnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kWTF/iK3b5Sk5JeUHvp98Y6uzIRDCjSO+zOeV+snwFg=;
        b=ls2DwPPvIh2eLmfpMw3Mi4otQ/AfLThqqsUcUO1st7zk9KAiLKAWeRBk1y5J5qWohW
         2drBxFDGBwPAnFcd/epne3myVNjwUdcez9lTLjRhk8Q+OOQdssHwgiF3vwXZhhdtylhZ
         qo75gdPT3J4IAQB+K0V8X2F7wCOOFPrTkHSKFHrceuDqtGuT6E6IexADY47pe5zUTeXv
         tHoP4B0hkcwATbBy/1RIK61LpslupbRzCB9Jvww6I0TbJhSBFF96JAzNuUbK7dZYHQ/T
         hxwa7Rg7LdAglOGAMeJEqIQ2ta0vfYEpuSlHm2zAZGC+7ohNq72fPtqmrMNupq/gSGqE
         YfKg==
X-Gm-Message-State: AGi0Puaqnh/M8z8XopPOPGUDhyo55/Waqf4V8mFaP7rDUugEzjy0guRq
        vjcIflA25wA9zlQIG2Htegg=
X-Google-Smtp-Source: APiQypIgPHVdf7cXscxZNmG06PutggZYCLmyQWf/ZESoTnKqvn2liHmHeSgkvHLbppkxmXfoXy+xyQ==
X-Received: by 2002:aca:8ce:: with SMTP id 197mr2401139oii.35.1586504682521;
        Fri, 10 Apr 2020 00:44:42 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id w23sm825835otk.20.2020.04.10.00.44.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Apr 2020 00:44:41 -0700 (PDT)
Date:   Fri, 10 Apr 2020 00:44:40 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Jian Cai <caij2003@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        manojgupta@google.com, Peter.Smith@arm.com, stefan@agner.ch,
        samitolvanen@google.com, ilie.halip@gmail.com, jiancai@google.com,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
Message-ID: <20200410074440.GA35316@ubuntu-s3-xlarge-x86>
References: <20200409232728.231527-1-caij2003@gmail.com>
 <CA+icZUWJLGfp-UVhXDaCR=Xnce7phE1ffPHC4RzM8mXPhBaV9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+icZUWJLGfp-UVhXDaCR=Xnce7phE1ffPHC4RzM8mXPhBaV9g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 08:38:05AM +0200, Sedat Dilek wrote:
> On Fri, Apr 10, 2020 at 1:28 AM Jian Cai <caij2003@gmail.com> wrote:
> >
> > iwmmxt.S contains XScale instructions LLVM ARM backend does not support.
> > Skip this file if LLVM integrated assemmbler or LLD is used to build ARM
> > kernel.
> >
> > Signed-off-by: Jian Cai <caij2003@gmail.com>
> > ---
> >  arch/arm/Kconfig | 2 +-
> >  init/Kconfig     | 6 ++++++
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 66a04f6f4775..39de8fc64a73 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -804,7 +804,7 @@ source "arch/arm/mm/Kconfig"
> >
> >  config IWMMXT
> >         bool "Enable iWMMXt support"
> > -       depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4 || CPU_PJ4B
> > +       depends on !AS_IS_CLANG && !LD_IS_LLD && (CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4 || CPU_PJ4B)
> >         default y if PXA27x || PXA3xx || ARCH_MMP || CPU_PJ4 || CPU_PJ4B
> >         help
> >           Enable support for iWMMXt context switching at run time if
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 1c12059e0f7e..b0ab3271e900 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -19,6 +19,12 @@ config GCC_VERSION
> >  config CC_IS_CLANG
> >         def_bool $(success,$(CC) --version | head -n 1 | grep -q clang)
> >
> > +config AS_IS_CLANG
> > +       def_bool $(success,$(AS) --version | head -n 1 | grep -q clang)
> > +
> > +config LD_IS_LLD
> > +       def_bool $(success,$(LD) --version | head -n 1 | grep -q LLD)
> > +
> >  config CLANG_VERSION
> >         int
> >         default $(shell,$(srctree)/scripts/clang-version.sh $(CC))
> > --
> > 2.26.0.110.g2183baf09c-goog
> 
> Yesterday, when looking trough commits in Linus tree, I saw:
> 
> "init/kconfig: Add LD_VERSION Kconfig"
> 
> Nick had a patchset to distinguish LINKER via Kconfig (I cannot find
> it right now).

Probably referring to this?

https://github.com/samitolvanen/linux/commit/61889e01f0ed4f07a9d631f163bba6c6637bfa46

> So we should do all this the way CC_IS_XXX CC_VERSION handling is done.
> 
> I just want to point to [2] where we can rework (simplify) this
> handling for CC and LD handling in a further step.
> In one of Peter Z. tree someone started to do so (I was inspired by that).
> 
> Unfortunately, the hunk from [1] is IMHO a bit mis-placed and CC and
> LD handling should stay together:
> 
> CC_IS_XXX where XXX is GCC or CLANG
> CC_VERSION where CC is GCC or CLANG

Are you suggesting unifying GCC_VERSION and CLANG_VERSION or am I
misunderstanding what you wrote here? Do you mean XXX_VERSION where XXX
is GCC or CLANG?

> LD_IS_XXX where XXX is BFD or GOLD or LLD
> LD_VERSION

ld.gold is no longer allowed to link the kernel so there is no point in
accounting for it in Kconfig. That leaves only ld.bfd and ld.lld to
account for. I do not think there is a point in adding LD_IS_BFD;
!LD_IS_LLD covers that since there is not another linker (at least that
I am aware of) that links the kernel.

Compiler is different because it technically has three options if icc
even still works to build the kernel.

LD_VERISON is explicitly an ld.bfd thing due to the way ld-version.sh
is written:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/ld-version.sh

There is not much of a reason to try and make LLD work with that given
we do not need it now. I am of the mindset that proactively changing
something only makes life more difficult down the road and makes things
harder to maintain.

We could suggest renaming that config to GNU_LD_VERSION and gnu-ld-version.sh
to be slightly more accurate but I am not sure that is necessary since
again, CONFIG_LD_IS_LLD will handle any incompatibilities that we
encounter with LD_VERSION, just like we do with CLANG_VERSION/GCC_VERSION.
See my commit for the __gnu_mcount_nc thing in ARM for an example of
that (CONFIG_CC_IS_GCC still needs to be specified).

https://git.kernel.org/linus/b0fe66cf095016e0b238374c10ae366e1f087d11

> Just my €0,02.
> 
> Regards,
> - Sedat -
> 
> [1] https://git.kernel.org/linus/9553d16fa671b9621c5e2847d08bd90d3be3349c
> [2] https://github.com/ClangBuiltLinux/linux/issues/941
> 

Cheers,
Nathan
