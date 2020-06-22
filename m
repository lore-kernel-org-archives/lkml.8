Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF9DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:06:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6854320716
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UIzUj+ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbgFVWGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730689AbgFVWGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:06:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092C7C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:06:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id h10so8866580pgq.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NZrrNoLnR5tCsJjwkOg87lF2Y56Tb3KMrg75SysWUh0=;
        b=UIzUj+ug47F49Sp5vy/xR5WhNyTvMNN8hgmawE2K2svYVAvNR0eQkRlHf/Lm0FZZ/X
         7StKvXgVAWbI70D4t9TSVT46cI8wFgWe18KjZIUU2gbeYlypeQsSuhPwI5EvJGBXCknL
         /Sjqg8ACv3WsHhLOyyN1tYm7FtO7k1lZ7q32rJdr8zHbaa4KTHMBuv2T1BhpwNtUagCo
         l8awFGTwHbMp5iHCVsrWdKZ6GOvVD5DtxBa7R/FXwcFNEinFzoIb9d5pNE8nG9vruzlQ
         ZaHn86AGS9putBcaNX0ZgGsgbwCZlbN6Wefc6qbtKgCp3IYJF+C29+n//2QRwmI9FUmO
         aMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NZrrNoLnR5tCsJjwkOg87lF2Y56Tb3KMrg75SysWUh0=;
        b=AkkofzXvOEzbjsElMMsAG0zFofcQ+wnOr7Q20K4t1nSxKJ58+q5qBYBJ0Lq7NjZEv3
         FlyGWnG4aLqScXWMVGReBHPquDrJHkbejKK3LTe+DqMjeFtuUj2KirmY/1VdRMF+rUW7
         AKqVTYd4yRoJ9Qlg8lzUnxgAadMnxxRfdhtOAf0Sp1JT9JmfTsAMrRNd5aT6okQzooni
         ObI+OywpWFK3Xa6d/bTnMiuDj/hfZeaDz/2tSfBTVBjbpYfD+PmS111dfVejhEyYvTfe
         qE4OhA8A+QiEP5WonLhQuMtPQDKXKf8qrpQ1rE50sjVjLivLpyyHJVM7KFb2U4cLkMc0
         JXWw==
X-Gm-Message-State: AOAM531PTEzlnnRrWGKZZsrsjp6q6+nNvFDaqQCjyrPo/OPSW/AoUTm+
        1vnCVtZwqhKqTq75fC1ybPcDZQ==
X-Google-Smtp-Source: ABdhPJyNkaobMn6YLoXR3doV+X4hJSzTo2xEgfFEsiR9ry8ddLYa0F9ofhKFdLKf1wkYt7vFqeoUEA==
X-Received: by 2002:a63:1d4d:: with SMTP id d13mr6212600pgm.28.1592863592255;
        Mon, 22 Jun 2020 15:06:32 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id g65sm14702797pfb.61.2020.06.22.15.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:06:31 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:06:28 -0700
From:   Fangrui Song <maskray@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] x86/boot: Warn on orphan section placement
Message-ID: <20200622220628.t5fklwmbtqoird5f@google.com>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-4-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200622205341.2987797-4-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-22, Kees Cook wrote:
>We don't want to depend on the linker's orphan section placement
>heuristics as these can vary between linkers, and may change between
>versions. All sections need to be explicitly named in the linker
>script.
>
>Add the common debugging sections. Discard the unused note, rel, plt,
>dyn, and hash sections that are not needed in the compressed vmlinux.
>Disable .eh_frame generation in the linker and enable orphan section
>warnings.
>
>Signed-off-by: Kees Cook <keescook@chromium.org>
>---
> arch/x86/boot/compressed/Makefile      |  3 ++-
> arch/x86/boot/compressed/vmlinux.lds.S | 11 +++++++++++
> 2 files changed, 13 insertions(+), 1 deletion(-)
>
>diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
>index 7619742f91c9..646720a05f89 100644
>--- a/arch/x86/boot/compressed/Makefile
>+++ b/arch/x86/boot/compressed/Makefile
>@@ -48,6 +48,7 @@ GCOV_PROFILE := n
> UBSAN_SANITIZE :=n
>
> KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
>+KBUILD_LDFLAGS += $(call ld-option,--no-ld-generated-unwind-info)
> # Compressed kernel should be built as PIE since it may be loaded at any
> # address by the bootloader.
> ifeq ($(CONFIG_X86_32),y)
>@@ -59,7 +60,7 @@ else
> KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z noreloc-overflow" \
> 	&& echo "-z noreloc-overflow -pie --no-dynamic-linker")
> endif
>-LDFLAGS_vmlinux := -T
>+LDFLAGS_vmlinux := --orphan-handling=warn -T
>
> hostprogs	:= mkpiggy
> HOST_EXTRACFLAGS += -I$(srctree)/tools/include
>diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
>index 8f1025d1f681..6fe3ecdfd685 100644
>--- a/arch/x86/boot/compressed/vmlinux.lds.S
>+++ b/arch/x86/boot/compressed/vmlinux.lds.S
>@@ -75,5 +75,16 @@ SECTIONS
> 	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
> 	_end = .;
>
>+	STABS_DEBUG
>+	DWARF_DEBUG
>+
> 	DISCARDS
>+	/DISCARD/ : {
>+		*(.note.*)
>+		*(.rela.*) *(.rela_*)
>+		*(.rel.*) *(.rel_*)
>+		*(.plt) *(.plt.*)
>+		*(.dyn*)
>+		*(.hash) *(.gnu.hash)
>+	}
> }
>-- 
>2.25.1

LLD may report warnings for 3 synthetic sections if they are orphans:

ld.lld: warning: <internal>:(.symtab) is being placed in '.symtab'
ld.lld: warning: <internal>:(.shstrtab) is being placed in '.shstrtab'
ld.lld: warning: <internal>:(.strtab) is being placed in '.strtab'

Are they described?
