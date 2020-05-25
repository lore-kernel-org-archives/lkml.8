Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22CCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87A8420723
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="smwQ83X7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731447AbgEYQ0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 12:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729338AbgEYQ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:26:32 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CC5C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 09:26:32 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nu7so149794pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 09:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7P+69zSItFSaF7MzlKMuY5SXRy3EOvJEQAB8khNVn2Y=;
        b=smwQ83X7PBxPy0PNhNlQu4hj6xx/fOpBxOInlzTZKqCi8W2Hrh4CYmCiSMq/l4x7MQ
         52zt8G1a3ltYmEv3PxZrAfrOTQ/Siu1NdleMCVSK9lml3BHQrZmU3fg2mhGdrDMzIUnu
         QfWCr3TJS7tm+WyJC4pw9jVlPfj7EDIFEubH6xx26N1bW5gEEiIE1hcpvplu49jEo6As
         8e3toxFOG8lltO6W2wgJ4oYM+/ZM9WwO54/ZPoi3X+RbHv4jE/MTqPmufnKuiZC2OIaE
         r0RtCUOofJX0cimRWmagivU3B5ukWdNEBW5yLSrzP6eX1Fl5DOC1aVJHPl+T0P91VHBa
         VKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7P+69zSItFSaF7MzlKMuY5SXRy3EOvJEQAB8khNVn2Y=;
        b=qlkYDADdBVGcTKcitC4OPOKPQrjah8NyBMfBNOlg4REZDCzc4USXhPMJcTiU+oDEL3
         fNoKkVV7dJ1NgCu9/dV7DxMhVQc6ymG9xYPkQP+gtWC5p7lDR9QZj/WrDEij2EpQ3+o2
         QaJHhdRijhFFVbu5hbExDequV0dcM/4lfWBnlssRu+6le5JU1HBxdAjEWNLZUaFnbHSI
         J5nwwaMgap4fpPO2G5N8M4KS6TSmHaleZqjOxIZkODiHnqvKcnr5MIOP01RyJndl/702
         8OvnA6CrETcNo+GKCluL9cCwFxj7WyaG8lOn/lVXA5cnh1aH7j77giy2P3S/CVJqdeQZ
         yM9w==
X-Gm-Message-State: AOAM532yoxzKSeHd1wUsj8fU1RDisVY89NFdUYLjsOEJa/7JlydgoKTK
        7AAkEmF/svsVXD+m0PiZK21Psw==
X-Google-Smtp-Source: ABdhPJzgO+c8zWQueJr7WqetohWK80T6oapYODm8rGJ28Aif+JKTgxn02KLsW8fmGmH4m0T1q9seSA==
X-Received: by 2002:a17:902:c38b:: with SMTP id g11mr29768262plg.189.1590423991775;
        Mon, 25 May 2020 09:26:31 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id n38sm2952792pgm.1.2020.05.25.09.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 09:26:31 -0700 (PDT)
Date:   Mon, 25 May 2020 09:26:26 -0700
From:   Fangrui Song <maskray@google.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] x86/boot: Check that there are no runtime relocations
Message-ID: <20200525162626.4covxuycii6bvmjg@google.com>
References: <CAKwvOd=qB+EoJwfAYUA9Hg7f9op4Q4W+TDnht8pLRG5bPX=29Q@mail.gmail.com>
 <20200524212816.243139-5-nivedita@alum.mit.edu>
 <CAMj1kXFjDMuLekYKiPoKDqJhfkY8UViApdMd3JaPmGbnKLO+NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMj1kXFjDMuLekYKiPoKDqJhfkY8UViApdMd3JaPmGbnKLO+NA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-25, Ard Biesheuvel wrote:
>On Sun, 24 May 2020 at 23:28, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>>
>> Add a linker script check that there are no runtime relocations, and
>> remove the old one that tries to check via looking for specially-named
>> sections in the object files.
>>
>> Drop the tests for -fPIE compiler option and -pie linker option, as they
>> are available in all supported gcc and binutils versions (as well as
>> clang and lld).
>>
>> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
>> ---
>>  arch/x86/boot/compressed/Makefile      | 28 +++-----------------------
>>  arch/x86/boot/compressed/vmlinux.lds.S | 11 ++++++++++
>>  2 files changed, 14 insertions(+), 25 deletions(-)
>>
>> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
>> index d3e882e855ee..679a2b383bfe 100644
>> --- a/arch/x86/boot/compressed/Makefile
>> +++ b/arch/x86/boot/compressed/Makefile
>> @@ -27,7 +27,7 @@ targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
>>         vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4
>>
>>  KBUILD_CFLAGS := -m$(BITS) -O2
>> -KBUILD_CFLAGS += -fno-strict-aliasing $(call cc-option, -fPIE, -fPIC)
>> +KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
>>  KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
>>  cflags-$(CONFIG_X86_32) := -march=i386
>>  cflags-$(CONFIG_X86_64) := -mcmodel=small
>> @@ -49,7 +49,7 @@ UBSAN_SANITIZE :=n
>>  KBUILD_LDFLAGS := -m elf_$(UTS_MACHINE)
>>  # Compressed kernel should be built as PIE since it may be loaded at any
>>  # address by the bootloader.
>> -KBUILD_LDFLAGS += $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
>> +KBUILD_LDFLAGS += -pie $(call ld-option, --no-dynamic-linker)
>>  LDFLAGS_vmlinux := -T
>>
>>  hostprogs      := mkpiggy
>> @@ -84,30 +84,8 @@ vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
>>  vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
>>  vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
>>
>> -# The compressed kernel is built with -fPIC/-fPIE so that a boot loader
>> -# can place it anywhere in memory and it will still run. However, since
>> -# it is executed as-is without any ELF relocation processing performed
>> -# (and has already had all relocation sections stripped from the binary),
>> -# none of the code can use data relocations (e.g. static assignments of
>> -# pointer values), since they will be meaningless at runtime. This check
>> -# will refuse to link the vmlinux if any of these relocations are found.
>> -quiet_cmd_check_data_rel = DATAREL $@
>> -define cmd_check_data_rel
>> -       for obj in $(filter %.o,$^); do \
>> -               $(READELF) -S $$obj | grep -qF .rel.local && { \
>> -                       echo "error: $$obj has data relocations!" >&2; \
>> -                       exit 1; \
>> -               } || true; \
>> -       done
>> -endef
>> -
>> -# We need to run two commands under "if_changed", so merge them into a
>> -# single invocation.
>> -quiet_cmd_check-and-link-vmlinux = LD      $@
>> -      cmd_check-and-link-vmlinux = $(cmd_check_data_rel); $(cmd_ld)
>> -
>>  $(obj)/vmlinux: $(vmlinux-objs-y) FORCE
>> -       $(call if_changed,check-and-link-vmlinux)
>> +       $(call if_changed,ld)
>>
>>  OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
>>  $(obj)/vmlinux.bin: vmlinux FORCE
>> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
>> index d826ab38a8f9..0ac14feacb24 100644
>> --- a/arch/x86/boot/compressed/vmlinux.lds.S
>> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
>> @@ -11,9 +11,15 @@ OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
>>  #ifdef CONFIG_X86_64
>>  OUTPUT_ARCH(i386:x86-64)
>>  ENTRY(startup_64)
>> +
>> +#define REL .rela
>> +
>>  #else
>>  OUTPUT_ARCH(i386)
>>  ENTRY(startup_32)
>> +
>> +#define REL .rel
>> +
>>  #endif
>>
>>  SECTIONS
>> @@ -42,6 +48,9 @@ SECTIONS
>>                 *(.rodata.*)
>>                 _erodata = . ;
>>         }
>> +       REL.dyn : {
>> +               *(REL.*)
>> +       }
>
>Do we really need the macro here? Could we just do

The output section name does not matter: it will be discarded by the linker.

>.rel.dyn : { *(.rel.* .rela.*) }

If for some reasons there is at least one SHT_REL and at least one
SHT_RELA, LLD will error "section type mismatch for .rel.dyn", while the
intended diagnostic is the assert below.

>(or even
>
>.rel.dyn  : { *(.rel.* }
>.rela.dyn : { *(.rela.*) }
>
>if the output section name matters, and always assert that both are empty)?

   .rel.dyn  : { *(.rel.* }
   .rela.dyn : { *(.rela.*) }

looks good to me.


FWIW I intend to add -z rel and -z rela to LLD: https://reviews.llvm.org/D80496#inline-738804
(binutils thread https://sourceware.org/pipermail/binutils/2020-May/111244.html)

In case someone builds the x86-64 kernel with -z rel, your suggested
input section description will work out of the box...


>>         .got : {
>>                 *(.got)
>>         }
>> @@ -83,3 +92,5 @@ ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT en
>>  #else
>>  ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
>>  #endif
>> +
>> +ASSERT(SIZEOF(REL.dyn) == 0, "Unexpected runtime relocations detected!")
>> --
>> 2.26.2
>>
