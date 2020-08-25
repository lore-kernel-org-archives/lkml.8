Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C416BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 01:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B7C120706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 01:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598320499;
	bh=8liFKs4k+yVhsTqWuq1fT5tgIhX6tVveELlJ+6rfGo4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LGf59CCj9x5f4aDJC7gqMMOR4tNXr2yM/WcbL5hKiLV7Ft/6X9mzYMU6NjrbESvx/
	 1RfBpN1EgpM6ELRKR5uqm0EfRqOstCb17Nswr6U9aECp7rB/SE5DCTRLSIcFCtNEFf
	 Exoel1ONqGKW1ihzaaOI7tuAdVWRy3sggfGCohoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgHYBy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 21:54:58 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:64801 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgHYByy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 21:54:54 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 07P1se50013557
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 10:54:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 07P1se50013557
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1598320481;
        bh=CKR+6kF2zsUjEyroT6l5Mabjj0JoFdiFLY9EUgK/rQ8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HQxo0Hh7Sm5JG0iakkdNULPO+O/YRaJuetg5u/z7Fk8S92cXnhIloTHHzH8WaJkVd
         Xejqn+70d53Js00cyi7nmKdOT9KV8nSMzCfXo1rwEy4LihwpP3zrDXCzfOlZWdY30D
         AKVsMZ5dKZryNDNqReWswAtHUwk9uMOZmqfZx5M3ipUOuGTgUOhRpgJyFTPHFEGKe3
         jzHXhdO0sBkCMVuS0QgWTijXHR3Q4LZ6KLg+Q5Hawu4UFUJM3Nd0RjQfjKBl8GMto0
         m16Wy6NIJDW70QRluQHpwJDNnXx3D7WvsY2jM5VCxKJ2ZTP4YQ9zq5GJwUKi1KD25c
         lGMm/0ZFHS08Q==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id y8so5516346vsq.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 18:54:40 -0700 (PDT)
X-Gm-Message-State: AOAM531O/l5yQvWBK6l9vWYx5jGoO/44Nwxsu4lYFawWYRDKpzZ5ou5D
        69V6lCJJlJ2IQEkxcFkQ0GINc0+k0FczM4+WZo8=
X-Google-Smtp-Source: ABdhPJxtngz7TxbxCeluS12D2Qfi3T9+Y5D803T91Bizs97Eo7PG4UP+u1bzFArjaN3MuZQ253ptlO5Ciye13ANcgWA=
X-Received: by 2002:a67:bb06:: with SMTP id m6mr4408946vsn.54.1598320479429;
 Mon, 24 Aug 2020 18:54:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200812160017.GA30302@linux-8ccs> <CAMj1kXFfSLvujJYk4Em6T+UvAUDW3VX0BibsD43z30Q_TSsehg@mail.gmail.com>
 <20200812200019.GY3982@worktop.programming.kicks-ass.net> <CAMj1kXEn5o_7OOqgcntOPCqBYmpY74OkGqQ_bUBJvHG6Q9GVLA@mail.gmail.com>
 <20200813130422.GA16938@linux-8ccs> <CAMj1kXErCQYNN9r5siGNukc+9KC=QnER8LfFXVfbHdeDivYztg@mail.gmail.com>
 <20200821121959.GC20833@willie-the-truck> <CAMj1kXEyLMQz7+Fmv7i0FAu4x0uDmh7aUpbfuXaqs6k6XGog7w@mail.gmail.com>
 <20200821123036.GA21158@willie-the-truck> <CAMj1kXHgHo59vuua49rAoLfSt36JKSzFMMH+Z=y+3jNjbFPZsg@mail.gmail.com>
 <20200824152359.GA32398@linux-8ccs>
In-Reply-To: <20200824152359.GA32398@linux-8ccs>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 25 Aug 2020 10:54:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAT6n8j06DQTM-WpasEjmD-bK1Z=b9UVJ-F9tpn+mh8pUw@mail.gmail.com>
Message-ID: <CAK7LNAT6n8j06DQTM-WpasEjmD-bK1Z=b9UVJ-F9tpn+mh8pUw@mail.gmail.com>
Subject: Re: [PATCH v2] module: Harden STRICT_MODULE_RWX
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Mark Rutland <mark.rutland@arm.com>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 12:24 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Ard Biesheuvel [22/08/20 15:47 +0200]:
> >(+ Masahiro)
> >
> >On Fri, 21 Aug 2020 at 14:30, Will Deacon <will@kernel.org> wrote:
> >>
> >> On Fri, Aug 21, 2020 at 02:27:05PM +0200, Ard Biesheuvel wrote:
> >> > On Fri, 21 Aug 2020 at 14:20, Will Deacon <will@kernel.org> wrote:
> >> > >
> >> > > On Thu, Aug 13, 2020 at 03:07:13PM +0200, Ard Biesheuvel wrote:
> >> > > > On Thu, 13 Aug 2020 at 15:04, Jessica Yu <jeyu@kernel.org> wrote:
> >> > > > >
> >> > > > > +++ Ard Biesheuvel [13/08/20 10:36 +0200]:
> >> > > > > >On Wed, 12 Aug 2020 at 22:00, Peter Zijlstra <peterz@infradead.org> wrote:
> >> > > > > >>
> >> > > > > >> On Wed, Aug 12, 2020 at 06:37:57PM +0200, Ard Biesheuvel wrote:
> >> > > > > >> > I know there is little we can do at this point, apart from ignoring
> >> > > > > >> > the permissions - perhaps we should just defer the w^x check until
> >> > > > > >> > after calling module_frob_arch_sections()?
> >> > > > > >>
> >> > > > > >> My earlier suggestion was to ignore it for 0-sized sections.
> >> > > > > >
> >> > > > > >Only they are 1 byte sections in this case.
> >> > > > > >
> >> > > > > >We override the sh_type and sh_flags explicitly for these sections at
> >> > > > > >module load time, so deferring the check seems like a reasonable
> >> > > > > >alternative to me.
> >> > > > >
> >> > > > > So module_enforce_rwx_sections() is already called after
> >> > > > > module_frob_arch_sections() - which really baffled me at first, since
> >> > > > > sh_type and sh_flags should have been set already in
> >> > > > > module_frob_arch_sections().
> >> > > > >
> >> > > > > I added some debug prints to see which section the module code was
> >> > > > > tripping on, and it was .text.ftrace_trampoline. See this snippet from
> >> > > > > arm64's module_frob_arch_sections():
> >> > > > >
> >> > > > >                 else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE) &&
> >> > > > >                          !strcmp(secstrings + sechdrs[i].sh_name,
> >> > > > >                                  ".text.ftrace_trampoline"))
> >> > > > >                         tramp = sechdrs + i;
> >> > > > >
> >> > > > > Since Mauro's config doesn't have CONFIG_DYNAMIC_FTRACE enabled, tramp
> >> > > > > is never set here and the if (tramp) check at the end of the function
> >> > > > > fails, so its section flags are never set, so they remain WAX and fail
> >> > > > > the rwx check.
> >> > > >
> >> > > > Right. Our module.lds does not go through the preprocessor, so we
> >> > > > cannot add the #ifdef check there currently. So we should either drop
> >> > > > the IS_ENABLED() check here, or simply rename the section, dropping
> >> > > > the .text prefix (which doesn't seem to have any significance outside
> >> > > > this context)
> >> > > >
> >> > > > I'll leave it to Will to make the final call here.
> >> > >
> >> > > Why don't we just preprocess the linker script, like we do for the main
> >> > > kernel?
> >> > >
> >> >
> >> > That should work as well, I just haven't checked how straight-forward
> >> > it is to change that.
> >>
> >> Ok, if it's _not_ straightforward, then let's just drop the IS_ENABLED()
> >> altogether.
> >>
> >
> >I played around with this for a while, but failed to get Kbuild to
> >instantiate $(objtree)/arch/arm64/kernel/module.lds based on
> >$(srctree)/arch/arm64/kernel/module.lds.S and the cpp_lds_S rule.
> >Perhaps Masahiro has any suggestions here? Otherwise, let's just drop
> >the IS_ENABLED() check for now.
>
> I also tinkered around a bit and was able to generate
> $(objtree)/arch/arm64/kernel/module.lds based on
> $(srctree)/arch/arm64/kernel/module.lds.S only if I specified the
> former as the make target directly. Correct me if I'm wrong, but I
> guess this might be because the single build targets would utilize
> scripts/Makefile.build (where the cpp_lds_S rule is defined) while the
> module-related Makefiles don't seem to support .lds.S -> .lds in
> general.. Masahiro, how easy would it be to extend .lds.S -> .lds
> support to module linker scripts as well?
>
> Thanks,
>
> Jessica



If you want to generate
$(objtree)/arch/arm64/kernel/module.lds,
you need to tell it to the build system.

The following seems to work,
but please do NOT do this:


----------------->8--------------------
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index b45f0124cc16..4ae398c21111 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -116,7 +116,7 @@ endif
 CHECKFLAGS     += -D__aarch64__

 ifeq ($(CONFIG_ARM64_MODULE_PLTS),y)
-KBUILD_LDS_MODULE      += $(srctree)/arch/arm64/kernel/module.lds
+KBUILD_LDS_MODULE      += arch/arm64/kernel/module.lds
 endif

 ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_REGS),y)
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index a561cbb91d4d..693797e6db01 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -71,3 +71,5 @@ extra-y                                       +=
$(head-y) vmlinux.lds
 ifeq ($(CONFIG_DEBUG_EFI),y)
 AFLAGS_head.o += -DVMLINUX_PATH="\"$(realpath $(objtree)/vmlinux)\""
 endif
+
+always-$(CONFIG_MODULES) += module.lds
diff --git a/arch/arm64/kernel/module.lds b/arch/arm64/kernel/module.lds.S
similarity index 100%
rename from arch/arm64/kernel/module.lds
rename to arch/arm64/kernel/module.lds.S
----------------->8--------------------





The difference between
arch/arm64/kernel/vmlinux.lds and
arch/arm64/kernel/module.lds is that
we must keep the latter for external
module builds.

'make clean' cannot remove any
build artifact used for external modules,
but 'make mrproper' must remove them.

Let me think about it.



-- 
Best Regards
Masahiro Yamada
