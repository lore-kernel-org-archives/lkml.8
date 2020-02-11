Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F41AC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65E3208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 13:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WxJg/u6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgBKNDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:03:11 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33810 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbgBKNDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 08:03:09 -0500
Received: by mail-qt1-f193.google.com with SMTP id h12so7853646qtu.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 05:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bas+/VrzdMy27Ru/nYIGc/kjNJVzSRBJ3GgmNCXPKdM=;
        b=WxJg/u6Na/pFoI949NKg7uYm3QzOQNt2Vp092Boa5ku+WMvifXoEKnS02wETWux/nZ
         +oi7+xcseC1PYs96v5w5jEg9BVsU2u+kLs5jS2Pa25nagRNGNTZUQdV1h/VgqtHLqydF
         s+XlnsHeAejkWpJ/IiFDRbkz5g4G9FHmdLdawEGc/fADvqH1cx/YAccoCARwukD4SGml
         HxjZOKGM9/ibw7z9Y+0LYCRe1EHG3lPGkTSrvNnsyPQAtFryEy/itYCSori7Zdqh6X6Y
         RP8xZUkvnLS00N/BzhjD3g9YqSbk9CY/I+l48i3/wtrUjvTbKQnBu+7oZ1JDYe3xhY89
         rFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bas+/VrzdMy27Ru/nYIGc/kjNJVzSRBJ3GgmNCXPKdM=;
        b=mFRJbF+VGHqXtezCTkBhAEbqtJBJUKttmmsb3Z6jQMg4boPG0C7lDRVK+sotHd58VS
         1+ZaU7lShXOyoo9FFKoArgl+DjuTCpnpOCfZLE03RnFJAvmwIv04g8SdOHLDeskDT7h0
         XfIOmxeq+rYNGb9iwn6as//cT4yJxgaEbVE3kFpCz7SCtm05HG3SQexpc90d1ie9g2xv
         QbltytAx5zr/7hGd+gO5R6mmkaYe66DN0D5fr6LWp4OE707V5Yp+bo3BFTRI7eGCFJPn
         e57vQN0YLIJu9DGpPw6z4nemuz3V5aAot5wlcj3Loa25s5Cyq4kTr8JsghpVv8T/f5XP
         Gmug==
X-Gm-Message-State: APjAAAW8LP3UZLUjsPWt3Fo+UqufSWOhUtnL3uhvnRfUKqjXdV6xXgfM
        l8PFTunXEeVOG/wxh3lLjFhsB2xIYNvnRnw0G3c15A==
X-Google-Smtp-Source: APXvYqwZkrX6NfWxgbWR+Da8udNZDtLP1WdUg2ATAhvMsNOYXKquFhuVhGBHy5pks6LhgDwaGSpyBkdfJ/ejv2R7ANA=
X-Received: by 2002:ac8:7159:: with SMTP id h25mr2278562qtp.380.1581426187228;
 Tue, 11 Feb 2020 05:03:07 -0800 (PST)
MIME-Version: 1.0
References: <20200210225806.249297-1-trishalfonso@google.com>
In-Reply-To: <20200210225806.249297-1-trishalfonso@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 11 Feb 2020 14:02:55 +0100
Message-ID: <CACT4Y+Y=Qj6coWpY107Dj+TsUJK1nruWAC=QMZBDC5snNZRTOw@mail.gmail.com>
Subject: Re: [RFC PATCH v2] UML: add support for KASAN under x86_64
To:     Patricia Alfonso <trishalfonso@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        anton.ivanov@cambridgegreys.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        David Gow <davidgow@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 11:58 PM 'Patricia Alfonso' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Make KASAN run on User Mode Linux on x86_64.
>
> Depends on Constructor support in UML and is based off of
> "[RFC PATCH] um: implement CONFIG_CONSTRUCTORS for modules"
> (https://patchwork.ozlabs.org/patch/1234551/) and "[DEMO] um:
> demonstrate super early constructors"
> (https://patchwork.ozlabs.org/patch/1234553/) by
> Johannes.
>
> The location of the KASAN shadow memory, starting at
> KASAN_SHADOW_OFFSET, can be configured using the
> KASAN_SHADOW_OFFSET option. UML uses roughly 18TB of address
> space, and KASAN requires 1/8th of this. The default location of
> this offset is 0x100000000000. There is usually enough free space at
> this location; however, it is a config option so that it can be
> easily changed if needed.
>
> The UML-specific KASAN initializer uses mmap to map
> the roughly 2.25TB of shadow memory to the location defined by
> KASAN_SHADOW_OFFSET.
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
> ---
>
> Changes since v1:
>  - KASAN has been initialized much earlier.
>  - With the help of Johannes's RFC patch to implement constructors in
>    UML and Demo showing how kasan_init could take advantage of these
>    super early constructors, most of the "KASAN_SANITIZE := n" have
>    been removed.
>  - Removed extraneous code
>  - Fixed typos


I started reviewing this, but I am spotting things that I already
commented on, like shadow start and about shadow size const. Please
either address them, or answer why they are not addressed, or add some
kind of TODOs so that I don't write the same comment again.


>  arch/um/Kconfig              | 10 ++++++++++
>  arch/um/Makefile             |  6 ++++++
>  arch/um/include/asm/dma.h    |  1 +
>  arch/um/include/asm/kasan.h  | 30 ++++++++++++++++++++++++++++++
>  arch/um/kernel/Makefile      | 22 ++++++++++++++++++++++
>  arch/um/kernel/mem.c         | 19 +++++++++----------
>  arch/um/os-Linux/mem.c       | 19 +++++++++++++++++++
>  arch/um/os-Linux/user_syms.c |  4 ++--
>  arch/x86/um/Makefile         |  3 ++-
>  arch/x86/um/vdso/Makefile    |  3 +++
>  10 files changed, 104 insertions(+), 13 deletions(-)
>  create mode 100644 arch/um/include/asm/kasan.h
>
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 0917f8443c28..2b76dc273731 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -8,6 +8,7 @@ config UML
>         select ARCH_HAS_KCOV
>         select ARCH_NO_PREEMPT
>         select HAVE_ARCH_AUDITSYSCALL
> +       select HAVE_ARCH_KASAN if X86_64
>         select HAVE_ARCH_SECCOMP_FILTER
>         select HAVE_ASM_MODVERSIONS
>         select HAVE_UID16
> @@ -200,6 +201,15 @@ config UML_TIME_TRAVEL_SUPPORT
>
>           It is safe to say Y, but you probably don't need this.
>
> +config KASAN_SHADOW_OFFSET
> +       hex
> +       depends on KASAN
> +       default 0x100000000000
> +       help
> +         This is the offset at which the ~2.25TB of shadow memory is
> +         initialized and used by KASAN for memory debugging. The default
> +         is 0x100000000000.
> +
>  endmenu
>
>  source "arch/um/drivers/Kconfig"
> diff --git a/arch/um/Makefile b/arch/um/Makefile
> index d2daa206872d..28fe7a9a1858 100644
> --- a/arch/um/Makefile
> +++ b/arch/um/Makefile
> @@ -75,6 +75,12 @@ USER_CFLAGS = $(patsubst $(KERNEL_DEFINES),,$(patsubst -I%,,$(KBUILD_CFLAGS))) \
>                 -D_FILE_OFFSET_BITS=64 -idirafter $(srctree)/include \
>                 -idirafter $(objtree)/include -D__KERNEL__ -D__UM_HOST__
>
> +# Kernel config options are not included in USER_CFLAGS, but the option for KASAN
> +# should be included if the KASAN config option was set.
> +ifdef CONFIG_KASAN
> +       USER_CFLAGS+=-DCONFIG_KASAN=y
> +endif
> +
>  #This will adjust *FLAGS accordingly to the platform.
>  include $(ARCH_DIR)/Makefile-os-$(OS)
>
> diff --git a/arch/um/include/asm/dma.h b/arch/um/include/asm/dma.h
> index fdc53642c718..8aafd60d62bb 100644
> --- a/arch/um/include/asm/dma.h
> +++ b/arch/um/include/asm/dma.h
> @@ -5,6 +5,7 @@
>  #include <asm/io.h>
>
>  extern unsigned long uml_physmem;
> +extern unsigned long long physmem_size;
>
>  #define MAX_DMA_ADDRESS (uml_physmem)
>
> diff --git a/arch/um/include/asm/kasan.h b/arch/um/include/asm/kasan.h
> new file mode 100644
> index 000000000000..ba08061068cf
> --- /dev/null
> +++ b/arch/um/include/asm/kasan.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_UM_KASAN_H
> +#define __ASM_UM_KASAN_H
> +
> +#include <linux/init.h>
> +#include <linux/const.h>
> +
> +#define KASAN_SHADOW_OFFSET _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
> +#ifdef CONFIG_X86_64
> +#define KASAN_SHADOW_SIZE 0x100000000000UL
> +#else
> +#error "KASAN_SHADOW_SIZE is not defined for this sub-architecture"
> +#endif /* CONFIG_X86_64 */
> +
> +// used in kasan_mem_to_shadow to divide by 8
> +#define KASAN_SHADOW_SCALE_SHIFT 3
> +
> +#define KASAN_SHADOW_START (KASAN_SHADOW_OFFSET)
> +#define KASAN_SHADOW_END (KASAN_SHADOW_START + KASAN_SHADOW_SIZE)
> +
> +#ifdef CONFIG_KASAN
> +void kasan_init(void);
> +#else
> +static inline void kasan_init(void) { }
> +#endif /* CONFIG_KASAN */
> +
> +void kasan_map_memory(void *start, unsigned long len);
> +void kasan_unpoison_shadow(const void *address, size_t size);
> +
> +#endif /* __ASM_UM_KASAN_H */
> diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
> index 5aa882011e04..875e1827588b 100644
> --- a/arch/um/kernel/Makefile
> +++ b/arch/um/kernel/Makefile
> @@ -8,6 +8,28 @@
>  # kernel.
>  KCOV_INSTRUMENT                := n
>
> +# The way UMl deals with the stack causes seemingly false positive KASAN
> +# reports such as:
> +# BUG: KASAN: stack-out-of-bounds in show_stack+0x15e/0x1fb
> +# Read of size 8 at addr 000000006184bbb0 by task swapper/1
> +# ==================================================================
> +# BUG: KASAN: stack-out-of-bounds in dump_trace+0x141/0x1c5
> +# Read of size 8 at addr 0000000071057eb8 by task swapper/1
> +# ==================================================================
> +# BUG: KASAN: stack-out-of-bounds in get_wchan+0xd7/0x138
> +# Read of size 8 at addr 0000000070e8fc80 by task systemd/1
> +#
> +# With these files removed from instrumentation, those reports are
> +# eliminated, but KASAN still repeatedly reports a bug on syscall_stub_data:
> +# ==================================================================
> +# BUG: KASAN: stack-out-of-bounds in syscall_stub_data+0x299/0x2bf
> +# Read of size 128 at addr 0000000071457c50 by task swapper/1
> +
> +KASAN_SANITIZE_stacktrace.o := n
> +KASAN_SANITIZE_sysrq.o := n
> +KASAN_SANITIZE_process.o := n
> +
> +
>  CPPFLAGS_vmlinux.lds := -DSTART=$(LDS_START)           \
>                          -DELF_ARCH=$(LDS_ELF_ARCH)     \
>                          -DELF_FORMAT=$(LDS_ELF_FORMAT) \
> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> index 32fc941c80f7..7b7b8a0ee724 100644
> --- a/arch/um/kernel/mem.c
> +++ b/arch/um/kernel/mem.c
> @@ -18,21 +18,20 @@
>  #include <kern_util.h>
>  #include <mem_user.h>
>  #include <os.h>
> +#include <linux/sched/task.h>
>
> -extern int printf(const char *msg, ...);
> -static void early_print(void)
> +#ifdef CONFIG_KASAN
> +void kasan_init(void)
>  {
> -       printf("I'm super early, before constructors\n");
> +       kasan_map_memory((void *)KASAN_SHADOW_START, KASAN_SHADOW_SIZE);
> +       init_task.kasan_depth = 0;
> +       os_info("KernelAddressSanitizer initialized\n");
>  }
>
> -static void __attribute__((constructor)) constructor_test(void)
> -{
> -       printf("yes, you can see it\n");
> -}
> -
> -static void (*early_print_ptr)(void)
> +static void (*kasan_init_ptr)(void)
>  __attribute__((section(".kasan_init"), used))
> - = early_print;
> += kasan_init;
> +#endif
>
>  /* allocated in paging_init, zeroed in mem_init, and unchanged thereafter */
>  unsigned long *empty_zero_page = NULL;
> diff --git a/arch/um/os-Linux/mem.c b/arch/um/os-Linux/mem.c
> index 3c1b77474d2d..da7039721d35 100644
> --- a/arch/um/os-Linux/mem.c
> +++ b/arch/um/os-Linux/mem.c
> @@ -17,6 +17,25 @@
>  #include <init.h>
>  #include <os.h>
>
> +/**
> + * kasan_map_memory() - maps memory from @start with a size of @len.
> + * The allocated memory is filled with zeroes upon success.
> + * @start: the start address of the memory to be mapped
> + * @len: the length of the memory to be mapped
> + *
> + * This function is used to map shadow memory for KASAN in uml
> + */
> +void kasan_map_memory(void *start, size_t len)
> +{
> +       if (mmap(start,
> +                len,
> +                PROT_READ|PROT_WRITE,
> +                MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE|MAP_NORESERVE,
> +                -1,
> +                0) == MAP_FAILED)
> +               os_info("Couldn't allocate shadow memory %s", strerror(errno));
> +}
> +
>  /* Set by make_tempfile() during early boot. */
>  static char *tempdir = NULL;
>
> diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
> index 715594fe5719..cb667c9225ab 100644
> --- a/arch/um/os-Linux/user_syms.c
> +++ b/arch/um/os-Linux/user_syms.c
> @@ -27,10 +27,10 @@ EXPORT_SYMBOL(strstr);
>  #ifndef __x86_64__
>  extern void *memcpy(void *, const void *, size_t);
>  EXPORT_SYMBOL(memcpy);
> -#endif
> -
>  EXPORT_SYMBOL(memmove);
>  EXPORT_SYMBOL(memset);
> +#endif
> +
>  EXPORT_SYMBOL(printf);
>
>  /* Here, instead, I can provide a fake prototype. Yes, someone cares: genksyms.
> diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
> index 33c51c064c77..7dbd76c546fe 100644
> --- a/arch/x86/um/Makefile
> +++ b/arch/x86/um/Makefile
> @@ -26,7 +26,8 @@ else
>
>  obj-y += syscalls_64.o vdso/
>
> -subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o
> +subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o \
> +       ../lib/memmove_64.o ../lib/memset_64.o
>
>  endif
>
> diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
> index 0caddd6acb22..450efa0fb694 100644
> --- a/arch/x86/um/vdso/Makefile
> +++ b/arch/x86/um/vdso/Makefile
> @@ -3,6 +3,9 @@
>  # Building vDSO images for x86.
>  #
>
> +# do not instrument on vdso because KASAN is not compatible with user mode
> +KASAN_SANITIZE                 := n
> +
>  # Prevents link failures: __sanitizer_cov_trace_pc() is not linked in.
>  KCOV_INSTRUMENT                := n
>
> --
> 2.25.0.341.g760bfbb309-goog
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200210225806.249297-1-trishalfonso%40google.com.
