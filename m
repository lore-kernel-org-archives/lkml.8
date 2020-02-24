Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795F5C38BE2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4297A20675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wAakMVhF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbgBXUeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:34:02 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:53318 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgBXUeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 15:34:01 -0500
Received: by mail-pj1-f65.google.com with SMTP id n96so248715pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 12:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=76eCXvzOdkKqMOkLCtpzKfQrkjuAlYbntrCFv9FhTZo=;
        b=wAakMVhFkoCmCt1tybQW5/NwAyhLvRI5YITs4R8raHQP4WvmEEPwlfA/svks+GPJKI
         vpZi03GoPklfdSJNGIZHmnD1QruxiqrYl3UvXUH+Alr3NK0l9UK28Uqt563huHw8lVBS
         6i6vAiraEiCe82svJH7Oq6XMxxE9aai2ymOPTWBgG6TLyligObYWIWTBDGMI3pjB6Smt
         idE4iNT61k42KKowi35oPPAhEfavrl/aFA4ZiyOnvGXI1uy1Fdmkh4aPQqQrAtNzlfoU
         qbFgw7YZ5ATlFUpn5OVVmDAf1NhOESmF7VLbPgtxhbEVgGKJ0yuogqXrINYN/W3XN03i
         kNpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=76eCXvzOdkKqMOkLCtpzKfQrkjuAlYbntrCFv9FhTZo=;
        b=Rtc/VoR5LK40gHdumQHF+hiRYmrdh7XT++V2b0TdtuX+zgtVFo87vBR740jJeuoK1K
         wC48LG8e21MZCRou02Syn5vPkn0Qd5TteigePgG6WlrOwpjHr+QoGX4AgJq2hD1V9kMM
         OpWK8XB4DMx6O6+DZpkq+owz7GuTsve1HFWpQItrqfVsLdBzGMLhZ0cnfIRWgYOeFVSG
         m73hjeyYY1Xc54iKG79ub0tOc5J6RjHIrHbmJ3gsbzqiHLuMKYtwDSQwWL1mPq6iZea6
         6R9lF7Y+0z1e1h7HWe5zKR7kfZQhZI2OIt0u+q29COKN3H9R0SjHqJaOBkixbN/21Ihf
         cCOw==
X-Gm-Message-State: APjAAAVlaVkKIOtat9/d94WDLEBilovR2ILXUwoM85EwnrhmKeQeMD4W
        OHNirUUmjpvMnm96yguFg6bXegzbWhbr/jpreDp3Xg==
X-Google-Smtp-Source: APXvYqxwSX9vAdTPoZ9Y/urk52LDOXK0RhqnZ1oSMEa+vh9tXtPXDjNr+HXJOf4z04Pu/CKM8RRfLdtPaDGDpOSIEM4=
X-Received: by 2002:a17:902:760e:: with SMTP id k14mr49014175pll.119.1582576440335;
 Mon, 24 Feb 2020 12:34:00 -0800 (PST)
MIME-Version: 1.0
References: <20200222235709.GA3786197@rani.riverdale.lan> <20200223193715.83729-2-nivedita@alum.mit.edu>
In-Reply-To: <20200223193715.83729-2-nivedita@alum.mit.edu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Feb 2020 12:33:49 -0800
Message-ID: <CAKwvOdniNba30cUX9QAZdVPg2MhjVETVgrvUUzwaHF70Dr3PrQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] arch/x86: Use -fno-asynchronous-unwind-tables to
 suppress .eh_frame sections
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 11:37 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> While discussing a patch to discard .eh_frame from the compressed
> vmlinux using the linker script, Fangrui Song pointed out [1] that these
> sections shouldn't exist in the first place because arch/x86/Makefile
> uses -fno-asynchronous-unwind-tables.

Another benefit is that -fno-asynchronous-unwind-tables may help
reduce the size of .text!
https://stackoverflow.com/a/26302715/1027966

>
> It turns out this is because the Makefiles used to build the compressed
> kernel redefine KBUILD_CFLAGS, dropping this flag.
>
> Add the flag to the Makefile for the compressed kernel, as well as the
> EFI stub Makefile to fix this.
>
> Also add the flag to boot/Makefile and realmode/rm/Makefile so that the
> kernel's boot code (boot/setup.elf) and realmode trampoline
> (realmode/rm/realmode.elf) won't be compiled with .eh_frame sections,
> since their linker scripts also just discard it.
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Suggested-By: Fangrui Song <maskray@google.com>
> [1] https://lore.kernel.org/lkml/20200222185806.ywnqhfqmy67akfsa@google.com/
> ---
>  arch/x86/boot/Makefile                | 1 +
>  arch/x86/boot/compressed/Makefile     | 1 +
>  arch/x86/realmode/rm/Makefile         | 1 +
>  drivers/firmware/efi/libstub/Makefile | 3 ++-
>  4 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
> index 012b82fc8617..24f011e0adf1 100644
> --- a/arch/x86/boot/Makefile
> +++ b/arch/x86/boot/Makefile
> @@ -68,6 +68,7 @@ clean-files += cpustr.h
>  KBUILD_CFLAGS  := $(REALMODE_CFLAGS) -D_SETUP
>  KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
>  KBUILD_CFLAGS  += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
> +KBUILD_CFLAGS  += -fno-asynchronous-unwind-tables
>  GCOV_PROFILE := n
>  UBSAN_SANITIZE := n
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 26050ae0b27e..c33111341325 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -39,6 +39,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
>  KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
>  KBUILD_CFLAGS += -Wno-pointer-sign
>  KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
> +KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
>
>  KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
>  GCOV_PROFILE := n
> diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
> index 99b6332ba540..b11ec5d8f8ac 100644
> --- a/arch/x86/realmode/rm/Makefile
> +++ b/arch/x86/realmode/rm/Makefile
> @@ -71,5 +71,6 @@ $(obj)/realmode.relocs: $(obj)/realmode.elf FORCE
>  KBUILD_CFLAGS  := $(REALMODE_CFLAGS) -D_SETUP -D_WAKEUP \
>                    -I$(srctree)/arch/x86/boot
>  KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
> +KBUILD_CFLAGS  += -fno-asynchronous-unwind-tables
>  GCOV_PROFILE := n
>  UBSAN_SANITIZE := n
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 98a81576213d..a1140c4ee478 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -12,7 +12,8 @@ cflags-$(CONFIG_X86)          += -m$(BITS) -D__KERNEL__ -O2 \
>                                    -mno-mmx -mno-sse -fshort-wchar \
>                                    -Wno-pointer-sign \
>                                    $(call cc-disable-warning, address-of-packed-member) \
> -                                  $(call cc-disable-warning, gnu)
> +                                  $(call cc-disable-warning, gnu) \
> +                                  -fno-asynchronous-unwind-tables

I think we want to add this flag a little lower, line 27 has:

KBUILD_CFLAGS     := $(cflags-y) -DDISABLE_BRANCH_PROFILING \

so the `cflags-y` variable you modify in this hunk will only set
-fno-asynchronous-unwind-tables for CONFIG_X86, which I don't think is
intentional.  Though when I run

$ llvm-readelf -S drivers/firmware/efi/libstub/lib.a | grep eh_frame

after doing an x86_64 defconfig, I don't get any hits. Do you observe
.eh_frame sections on any of these objects in this dir? (I'm fine
adding it to be safe, but I'm curious why I'm not seeing any
.eh_frame)

>
>  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
>  # disable the stackleak plugin
> --
> 2.24.1
>


-- 
Thanks,
~Nick Desaulniers
