Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28CAC2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966002078E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 20:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iIXb8hrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgDJUpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 16:45:42 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43626 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgDJUpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 16:45:41 -0400
Received: by mail-pl1-f193.google.com with SMTP id z6so1010933plk.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 13:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iij7zgytwGd4FsiXK28RwDWIfgaOYgN4ssh5i9GAVys=;
        b=iIXb8hrVUdblD8Qt9cfCbOMlx7kiRGdihRYhXdGg/tymxxmG3+EhB8U9nNGGPkuY+H
         +ifeOuvnFBH9TuzI16pZ6VmLe2Z45tOXmGIHdBUWfAAm6rszOQnwIi7qbWKvXAY6slVq
         +g+dUftt0GmYEgBflilHq/894shvDcwD3244A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iij7zgytwGd4FsiXK28RwDWIfgaOYgN4ssh5i9GAVys=;
        b=LqS9aFVACEF809JBt3FXOixIKQ7BfSLndxzJmi494YqF0nl6YZCU4jtmTrL5PXRLdN
         u6n/Kxt3oWvJYZ5S0kQ9SgG2UNto3V2hm5oI+aLVDnb8VzY48YeU16CSOoyvx/G1c/lg
         q/pMhs8WF4dVlBKPyA9LkhSuZ3TmwuFkLJ0elF70e/X2EVeYVrmHTrmDqU1RZMkE0AY3
         xeaFfLueNoHcCU5BYQfJ06+TkNVS87YUFv5LfGD0HOqmSCnIxFklHs10fes1oadnYi0h
         efwdLe3qlEy8UZ1APykf/TuxsJ9A8AABDM0Nsow1apWEttHpWUTRGuMSwpwxBIvcLSfu
         pZ3Q==
X-Gm-Message-State: AGi0PuZ+xJ7IPqhJjeRIL5U+KsvA7Jto5cof1iUIdQ6kRKGboPCRQUB1
        UhfnqCqd+kMEtVFguy/3LW0IuA==
X-Google-Smtp-Source: APiQypJoR3ChpIJlC+sDlXkEJrcf0eDJfm7xKW5c3isC/P4tJPJJS3fU5BEECvtKOi4KnIcLHNCB3w==
X-Received: by 2002:a17:90b:8c4:: with SMTP id ds4mr7707878pjb.44.1586551540896;
        Fri, 10 Apr 2020 13:45:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 80sm2302307pgb.45.2020.04.10.13.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 13:45:40 -0700 (PDT)
Date:   Fri, 10 Apr 2020 13:45:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, macro@linux-mips.org,
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
Message-ID: <202004101334.A641706F0@keescook>
References: <20200407080611.859256-1-jiaxun.yang@flygoat.com>
 <20200410090634.3513101-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410090634.3513101-1-jiaxun.yang@flygoat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 05:06:23PM +0800, Jiaxun Yang wrote:
> LLD failed to link vmlinux with 64bit load address for 32bit ELF
> while bfd will strip 64bit address into 32bit silently.
> To fix LLD build, we should truncate load address provided by platform
> into 32bit for 32bit kernel.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Reviewed-by: Fangrui Song <maskray@google.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> 
> --
> V2: Take MaskRay's shell magic.
> 
> V3: After spent an hour on dealing with special character issue in
> Makefile, I gave up to do shell hacks and write a util in C instead.
> Thanks Maciej for pointing out Makefile variable problem.
> ---
>  arch/mips/Makefile             |  2 ++
>  arch/mips/kernel/Makefile      | 11 ++++++++++-
>  arch/mips/kernel/vmlinux.lds.S |  2 +-
>  arch/mips/tools/.gitignore     |  1 +
>  arch/mips/tools/Makefile       |  5 +++++
>  arch/mips/tools/truncate32.c   | 29 +++++++++++++++++++++++++++++
>  6 files changed, 48 insertions(+), 2 deletions(-)
>  create mode 100644 arch/mips/tools/truncate32.c
> 
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index e1c44aed8156..633e9de4d262 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -14,6 +14,7 @@
>  
>  archscripts: scripts_basic
>  	$(Q)$(MAKE) $(build)=arch/mips/tools elf-entry
> +	$(Q)$(MAKE) $(build)=arch/mips/tools truncate32
>  ifeq ($(CONFIG_CPU_LOONGSON3_WORKAROUNDS),y)
>  	$(Q)$(MAKE) $(build)=arch/mips/tools loongson3-llsc-check
>  endif
> @@ -261,6 +262,7 @@ include arch/mips/Kbuild.platforms
>  ifdef CONFIG_PHYSICAL_START
>  load-y					= $(CONFIG_PHYSICAL_START)
>  endif
> +export VMLINUX_LOAD_ADDRESS		:= $(load-y)
>  
>  entry-y				= $(shell $(objtree)/arch/mips/tools/elf-entry vmlinux)
>  cflags-y			+= -I$(srctree)/arch/mips/include/asm/mach-generic
> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> index d6e97df51cfb..0178f7085317 100644
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -112,4 +112,13 @@ obj-$(CONFIG_MIPS_CPC)		+= mips-cpc.o
>  obj-$(CONFIG_CPU_PM)		+= pm.o
>  obj-$(CONFIG_MIPS_CPS_PM)	+= pm-cps.o
>  
> -CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
> +# When linking a 32-bit executable the LLVM linker cannot cope with a
> +# 32-bit load address that has been sign-extended to 64 bits.  Simply
> +# remove the upper 32 bits then, as it is safe to do so with other
> +# linkers.
> +ifdef CONFIG_64BIT
> +	load-ld			= $(VMLINUX_LOAD_ADDRESS)
> +else
> +	load-ld			= $(shell $(objtree)/arch/mips/tools/truncate32 $(VMLINUX_LOAD_ADDRESS))

This is major overkill. Just use the Makefile's builtin text
manipulation:

load-ld = $(subst 0xffffffff,0x,$(VMLINUX_LOAD_ADDRESS))

And note that a shell failure here would be entirely ignored, so the use
of die() in the proposed helper wouldn't actually stop a build, etc.

> +endif
> +CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS) -DVMLINUX_LINK_ADDRESS=$(load-ld)
> diff --git a/arch/mips/kernel/vmlinux.lds.S b/arch/mips/kernel/vmlinux.lds.S
> index a5f00ec73ea6..5226cd8e4bee 100644
> --- a/arch/mips/kernel/vmlinux.lds.S
> +++ b/arch/mips/kernel/vmlinux.lds.S
> @@ -55,7 +55,7 @@ SECTIONS
>  	/* . = 0xa800000000300000; */
>  	. = 0xffffffff80300000;
>  #endif
> -	. = VMLINUX_LOAD_ADDRESS;
> +	. = VMLINUX_LINK_ADDRESS;
>  	/* read-only */
>  	_text = .;	/* Text and read-only data */
>  	.text : {
> diff --git a/arch/mips/tools/.gitignore b/arch/mips/tools/.gitignore
> index 794817dfb389..58ead412c8d3 100644
> --- a/arch/mips/tools/.gitignore
> +++ b/arch/mips/tools/.gitignore
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  elf-entry
>  loongson3-llsc-check
> +truncate32
> diff --git a/arch/mips/tools/Makefile b/arch/mips/tools/Makefile
> index b851e5dcc65a..69debb18bbb4 100644
> --- a/arch/mips/tools/Makefile
> +++ b/arch/mips/tools/Makefile
> @@ -8,3 +8,8 @@ hostprogs += loongson3-llsc-check
>  PHONY += loongson3-llsc-check
>  loongson3-llsc-check: $(obj)/loongson3-llsc-check
>  	@:
> +
> +hostprogs += truncate32
> +PHONY += truncate32

Isn't the special variable named ".PHONY"? (And also is that only for
things the don't get written to disk, but truncate32 is...)

> +truncate32: $(obj)/truncate32
> +	@:
> diff --git a/arch/mips/tools/truncate32.c b/arch/mips/tools/truncate32.c
> new file mode 100644
> index 000000000000..82c19b4c32da
> --- /dev/null
> +++ b/arch/mips/tools/truncate32.c
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +
> +__attribute__((noreturn))
> +static void die(const char *msg)
> +{
> +	fputs(msg, stderr);
> +	exit(EXIT_FAILURE);
> +}
> +
> +int main(int argc, const char *argv[])
> +{
> +	unsigned long long val;
> +
> +	if (argc != 2)
> +		die("Usage: truncate32 <address>\n");
> +
> +	val = strtoull(argv[1], NULL, 0);
> +
> +	if ((val & 0xffffffff00000000) != 0xffffffff00000000)
> +		die("Invalid input\n");
> +
> +	val = val & 0xffffffff;
> +	printf("0x%08llx\n", val);
> +
> +	return EXIT_SUCCESS;
> +}
> -- 
> 2.26.0.rc2
> 

-- 
Kees Cook
