Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEC4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74AA020776
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gkbzBoXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbgFVWfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730785AbgFVWfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:35:42 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240B5C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:35:42 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id u14so550208pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sSqm/4br/2XZ3zIDDWcwJQR4tM1nEgZwvHmLUOL6fDw=;
        b=gkbzBoXV4Pk/cNmx+qHZYboipX5IVfDpxc8N0j4sWU9Ludf+OeYYmtJSZCcAGy8rZg
         aLbU2nyoFvW8UdDGDNRtfLZmmmi4FZwyhj7kombdQ0MHdVzYE8eod+AIGnBwYk9LHuPk
         iWFxpYVFP2202q93vjwPazU6UlNrjNokyuUxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sSqm/4br/2XZ3zIDDWcwJQR4tM1nEgZwvHmLUOL6fDw=;
        b=bKDz9+GilsLY/fX0ysA9b0TfriMWuO9uQjKKHju3UF5fvhBVECR7mp6X6R1iqAZZ7E
         nhvITuLUEBRstRufPNInaNbdQiVzh2hF3tYUmUS3Q80zH27Wjihv88CJEgUtumbdgWfR
         K5VS4i+gk0GC/KYOMgnH97i4x0upqEaRmecBl1bqzxBWt4luBTxqom8RTGwbE1MF62R5
         V3vBP7AOkK7bu4NOmDo0YVX0Q0CvroqOeVf19irjwiBWH/PzZiIJ2RN+TFuaZJBaehHW
         SK1RCpjd7wYdSO1WP3DU1zAzvdwCqE9tgIBjfBDeqaAfV/N9V5iZTSDLLZAhXlXwYZB8
         uVpQ==
X-Gm-Message-State: AOAM5305Gqy0LF1DDsZpQoJPunYtHX+sbEGxprBF+ORSc6W4lQg6S9xe
        UeYATN8atJw8exHHDY1EXpTK3g==
X-Google-Smtp-Source: ABdhPJwfvvR6CY3UBJbGsQJ0ahPvjlO1N9U+ecKxneds6TnG8ZkzU5PH6UA/Txrico1+ry4kLnIw1w==
X-Received: by 2002:a17:902:bb81:: with SMTP id m1mr759742pls.134.1592865341616;
        Mon, 22 Jun 2020 15:35:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n7sm458148pjq.22.2020.06.22.15.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:35:40 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:35:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] x86/boot: Warn on orphan section placement
Message-ID: <202006221534.D22F51D37@keescook>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-4-keescook@chromium.org>
 <20200622220628.t5fklwmbtqoird5f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622220628.t5fklwmbtqoird5f@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 03:06:28PM -0700, Fangrui Song wrote:
> On 2020-06-22, Kees Cook wrote:
> > We don't want to depend on the linker's orphan section placement
> > heuristics as these can vary between linkers, and may change between
> > versions. All sections need to be explicitly named in the linker
> > script.
> > 
> > Add the common debugging sections. Discard the unused note, rel, plt,
> > dyn, and hash sections that are not needed in the compressed vmlinux.
> > Disable .eh_frame generation in the linker and enable orphan section
> > warnings.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > arch/x86/boot/compressed/Makefile      |  3 ++-
> > arch/x86/boot/compressed/vmlinux.lds.S | 11 +++++++++++
> > 2 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 7619742f91c9..646720a05f89 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -48,6 +48,7 @@ GCOV_PROFILE := n
> > UBSAN_SANITIZE :=n
> > 
> > KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
> > +KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
> > # Compressed kernel should be built as PIE since it may be loaded at any
> > # address by the bootloader.
> > ifeq ($(CONFIG_X86_32),y)
> > @@ -59,7 +60,7 @@ else
> > KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
> > 	&& echo "-z noreloc-overflow -pie --no-dynamic-linker")
> > endif
> > -LDFLAGS_vmlinux := -T
> > +LDFLAGS_vmlinux := --orphan-handling=warn -T
> > 
> > hostprogs	:= mkpiggy
> > HOST_EXTRACFLAGS += -I$(srctree)/tools/include
> > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > index 8f1025d1f681..6fe3ecdfd685 100644
> > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > @@ -75,5 +75,16 @@ SECTIONS
> > 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
> > 	_end = .;
> > 
> > +	STABS_DEBUG
> > +	DWARF_DEBUG
> > +
> > 	DISCARDS
> > +	/DISCARD/ : {
> > +		*(.note.*)
> > +		*(.rela.*) *(.rela_*)
> > +		*(.rel.*) *(.rel_*)
> > +		*(.plt) *(.plt.*)
> > +		*(.dyn*)
> > +		*(.hash) *(.gnu.hash)
> > +	}
> > }
> > -- 
> > 2.25.1
> 
> LLD may report warnings for 3 synthetic sections if they are orphans:
> 
> ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
> ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
> ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'
> 
> Are they described?

Ah, hm. I see gcc is just silent about these. It looks like both regular
and debug kernels end up with those sections for both GCC and Clang. How
would you expect them to be described?

-- 
Kees Cook
