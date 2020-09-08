Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686BCC2BC11
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3322B2145D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqiVfXTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgIHU4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbgIHU4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 16:56:21 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A63C061757
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 13:56:20 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u3so214823pjr.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 13:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+1kwkhnnjfbD1n3YicFbQyeenHuldLrryzBMnu30RTk=;
        b=kqiVfXTqdvpE+D8HME82Bm/99OYWSZDGK7Oq76UCHFIRCcsokRD7oz4xAQHKlHR74v
         8jFd7Rm7VgphQioMxWqT6sB7WDRfEhiq+5dlPJB+VwsYe0Gws+0LJm6D9zwG/r15KK4j
         cuzPLvDpOo+kNSRVML9vt8TFZj2LIN0dx3+GMt+v/gfQiWWDTGc/5e1sfumXGI2CjeI6
         Wy++ioGxrd4TyZOe6AhKrFK49Dd0klSTZ4EyeBc8yeTCbAl+4UnrnXBHPmJZk+pzkRBq
         MO/Socm9d6L4MR4DbsbQU9qRVnfcNKA/i/3XI/d16ytiFjJKk9h0Y3hAMCxgdwcJ4siN
         gBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+1kwkhnnjfbD1n3YicFbQyeenHuldLrryzBMnu30RTk=;
        b=hVeqC7kXPK0gJTttKEdJZ/he/9r0osR4ZemFiRQwuTfRc4NK0DQDI5AEPbySzHSpf8
         Kqe56CkHZ6p2C19eC2FjMI4eBRHA7/0D9jhXJnqzsA4lXv8EQFKIKv/Q3fThYJoIaWJO
         5pZAd00jZ2DSgDBp7eYUDDCaSlwRSC6bmC0cwRVPfu76nwRGMArkM1gvd2A31Z4eTGJn
         8fAoGdIaM+yOVwpTN+UT7rODrZX2wix1jRg13C28iFBe5cgP0wKMDEC+y9mCcmmsT+14
         R66ZpbQ3qIVhA2hcPrPAcMn5FeRmNvLnqdVBbdj6x7nKxCCaPLKbY/hrzjTPS3VzHKwT
         4lDQ==
X-Gm-Message-State: AOAM532Qihii7ZRxg/dU6U3GmnO1e4dyI+KbmV1LQMEY5vooAkDqPGJn
        LolsN9gwdFIyrcAYtgiO+JII5Q==
X-Google-Smtp-Source: ABdhPJwmdCJZLAUsrl/QW5wKuUZMBwlVdVl2VXP+Jk7zMzVi2ljr8t2PHAqCINz0HMBlae3lzorpYw==
X-Received: by 2002:a17:90b:3444:: with SMTP id lj4mr574843pjb.78.1599598579801;
        Tue, 08 Sep 2020 13:56:19 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:f693:9fff:fef4:1b6d])
        by smtp.gmail.com with ESMTPSA id e14sm187682pgu.47.2020.09.08.13.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 13:56:19 -0700 (PDT)
Date:   Tue, 8 Sep 2020 13:56:12 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 11/28] kbuild: lto: postpone objtool
Message-ID: <20200908205612.GA1060586@google.com>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-12-samitolvanen@google.com>
 <202009031513.B558594FB9@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009031513.B558594FB9@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 03:19:43PM -0700, Kees Cook wrote:
> On Thu, Sep 03, 2020 at 01:30:36PM -0700, Sami Tolvanen wrote:
> > With LTO, LLVM bitcode won't be compiled into native code until
> > modpost_link, or modfinal for modules. This change postpones calls
> > to objtool until after these steps.
> > 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> 
> For a "fail fast" style of building, it makes sense to have objtool run
> as early as possible, so it makes sense to keep the current behavior in
> non-LTO mode. I do wonder, though, if there is a real benefit to having
> "fail fast" case. I imagine a lot of automated builds are using
> --keep-going with make, and actually waiting until the end to do the
> validation means more code will get build-tested before objtool rejects
> the results. *shrug*
> 
> > ---
> >  arch/Kconfig              |  2 +-
> >  scripts/Makefile.build    |  2 ++
> >  scripts/Makefile.modfinal | 24 ++++++++++++++++++++++--
> >  scripts/link-vmlinux.sh   | 23 ++++++++++++++++++++++-
> >  4 files changed, 47 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 71392e4a8900..7a418907e686 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -599,7 +599,7 @@ config LTO_CLANG
> >  	depends on $(success,$(NM) --help | head -n 1 | grep -qi llvm)
> >  	depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
> >  	depends on ARCH_SUPPORTS_LTO_CLANG
> > -	depends on !FTRACE_MCOUNT_RECORD
> > +	depends on HAVE_OBJTOOL_MCOUNT || !(X86_64 && DYNAMIC_FTRACE)
> >  	depends on !KASAN
> >  	depends on !GCOV_KERNEL
> >  	select LTO
> > diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> > index c348e6d6b436..b8f1f0d65a73 100644
> > --- a/scripts/Makefile.build
> > +++ b/scripts/Makefile.build
> > @@ -218,6 +218,7 @@ cmd_record_mcount = $(if $(findstring $(strip $(CC_FLAGS_FTRACE)),$(_c_flags)),
> >  endif # USE_RECORDMCOUNT
> >  
> >  ifdef CONFIG_STACK_VALIDATION
> > +ifndef CONFIG_LTO_CLANG
> >  ifneq ($(SKIP_STACK_VALIDATION),1)
> >  
> >  __objtool_obj := $(objtree)/tools/objtool/objtool
> > @@ -253,6 +254,7 @@ objtool_obj = $(if $(patsubst y%,, \
> >  	$(__objtool_obj))
> >  
> >  endif # SKIP_STACK_VALIDATION
> > +endif # CONFIG_LTO_CLANG
> >  endif # CONFIG_STACK_VALIDATION
> >  
> >  # Rebuild all objects when objtool changes, or is enabled/disabled.
> > diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
> > index 1005b147abd0..909bd509edb4 100644
> > --- a/scripts/Makefile.modfinal
> > +++ b/scripts/Makefile.modfinal
> > @@ -34,10 +34,30 @@ ifdef CONFIG_LTO_CLANG
> >  # With CONFIG_LTO_CLANG, reuse the object file we compiled for modpost to
> >  # avoid a second slow LTO link
> >  prelink-ext := .lto
> > -endif
> > +
> > +# ELF processing was skipped earlier because we didn't have native code,
> > +# so let's now process the prelinked binary before we link the module.
> > +
> > +ifdef CONFIG_STACK_VALIDATION
> > +ifneq ($(SKIP_STACK_VALIDATION),1)
> > +cmd_ld_ko_o +=								\
> > +	$(objtree)/tools/objtool/objtool				\
> > +		$(if $(CONFIG_UNWINDER_ORC),orc generate,check)		\
> > +		--module						\
> > +		$(if $(CONFIG_FRAME_POINTER),,--no-fp)			\
> > +		$(if $(CONFIG_GCOV_KERNEL),--no-unreachable,)		\
> > +		$(if $(CONFIG_RETPOLINE),--retpoline,)			\
> > +		$(if $(CONFIG_X86_SMAP),--uaccess,)			\
> > +		$(if $(USE_OBJTOOL_MCOUNT),--mcount,)			\
> > +		$(@:.ko=$(prelink-ext).o);
> > +
> > +endif # SKIP_STACK_VALIDATION
> > +endif # CONFIG_STACK_VALIDATION
> 
> I wonder if objtool_args could be reused here instead of having two
> places to keep in sync? It looks like that might mean moving things
> around a bit before this patch, since I can't quite see if
> Makefile.build's variables are visible to Makefile.modfinal?

It doesn't look like they are. I suppose we could move objtool_args to
Makefile.lib. Masahiro, any thoughts?

Sami
