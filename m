Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E43C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 296C720663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OsFrigUr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730646AbgF2T1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732668AbgF2T1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:27:42 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261EEC0307A9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:51:02 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t6so8498391pgq.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jfw7xgsCVT4+P8rZ+eOB1eWDoXiGwe+YmdSqzX3C0Y4=;
        b=OsFrigUrq4Pn3wi9zJd39zKVZnTXtfVlYWiWLAFcBkkrEfrTqrDwN3a/RzrUPrITDV
         KUJsfwzxBf0AcERXqQmyH3K8gn4c3AH2JVGzZHqliBqfeVLkal/91qHUGwb14sVN3kc3
         EO4Dh00rQ9lc3BkpEnvqsP3oCB+tYCEkjVdmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jfw7xgsCVT4+P8rZ+eOB1eWDoXiGwe+YmdSqzX3C0Y4=;
        b=NQSwuUFvGZJdWT2+4wUcirSYl6ccHGQSKnm3R9kTxPqPok38sxohOg1O8sWiHVyuH5
         yLbrcVfRfZglh6BHxs06MzPDvjUIC4FT96Vmh4t/t/+7EzYoEcLTBIOd7doHgcHqfJKa
         MCpsNQKN2CFmSy8RLhkZJM75S7sDT4z3SI7KZF8SoFKM3fsl2YJBJ8mI1y4ljuJnLlMO
         HYMIIhNIdAyD0LLiguRh0gmxNZl163/OGcflzTEJx6867ZJTh5fFJ99Q6sh0uhLNSPfW
         QYD+Ll56mu5NgimfkIO17s2qKMQlAP6xIKpIBOaDcUt0V+GiLDPqfnZPI+xAy0J83ngi
         78WA==
X-Gm-Message-State: AOAM5331+PyOaH4LSD5F0ghlD9sH5fjSwoPlOQGotwmtO9aULicVH48N
        wl/ut3FThPX+fTdmaTICpLM0QBLK/B8=
X-Google-Smtp-Source: ABdhPJwm48vv+qqoIOljYXXwtVlwcziTxV/OcXjiwIEmnc3wZz8EWPfxn0vWZUMCzLdUqVKL3rkizA==
X-Received: by 2002:a62:758b:: with SMTP id q133mr1865322pfc.289.1593445861687;
        Mon, 29 Jun 2020 08:51:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a8sm165949pfi.29.2020.06.29.08.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 08:51:00 -0700 (PDT)
Date:   Mon, 29 Jun 2020 08:50:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] x86/boot/compressed: Force hidden visibility for
 all symbol references
Message-ID: <202006290849.940FAE8C9B@keescook>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-3-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629140928.858507-3-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 10:09:23AM -0400, Arvind Sankar wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> Eliminate all GOT entries in the decompressor binary, by forcing hidden
> visibility for all symbol references, which informs the compiler that
> such references will be resolved at link time without the need for
> allocating GOT entries.
> 
> To ensure that no GOT entries will creep back in, add an assertion to
> the decompressor linker script that will fire if the .got section has
> a non-zero size.
> 
> [Arvind: fixup -include hidden.h to -include $(srctree)/$(src)/hidden.h]
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Acked-by: Arvind Sankar <nivedita@alum.mit.edu>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> From: Ard Biesheuvel <ardb@kernel.org>
> Link: https://lore.kernel.org/r/20200523120021.34996-3-ardb@kernel.org
> ---
>  arch/x86/boot/compressed/Makefile      |  1 +
>  arch/x86/boot/compressed/hidden.h      | 19 +++++++++++++++++++
>  arch/x86/boot/compressed/vmlinux.lds.S |  1 +
>  3 files changed, 21 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/hidden.h
> 
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 7619742f91c9..b01c8aed0f23 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -42,6 +42,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
>  KBUILD_CFLAGS += -Wno-pointer-sign
>  KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
>  KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
> +KBUILD_CFLAGS += -include $(srctree)/$(src)/hidden.h
>  
>  KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
>  GCOV_PROFILE := n
> diff --git a/arch/x86/boot/compressed/hidden.h b/arch/x86/boot/compressed/hidden.h
> new file mode 100644
> index 000000000000..49a17b6b5962
> --- /dev/null
> +++ b/arch/x86/boot/compressed/hidden.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * When building position independent code with GCC using the -fPIC option,
> + * (or even the -fPIE one on older versions), it will assume that we are
> + * building a dynamic object (either a shared library or an executable) that
> + * may have symbol references that can only be resolved at load time. For a
> + * variety of reasons (ELF symbol preemption, the CoW footprint of the section
> + * that is modified by the loader), this results in all references to symbols
> + * with external linkage to go via entries in the Global Offset Table (GOT),
> + * which carries absolute addresses which need to be fixed up when the
> + * executable image is loaded at an offset which is different from its link
> + * time offset.
> + *
> + * Fortunately, there is a way to inform the compiler that such symbol
> + * references will be satisfied at link time rather than at load time, by
> + * giving them 'hidden' visibility.
> + */
> +
> +#pragma GCC visibility push(hidden)

Is this recognized by Clang? I'm assuming so, since I see this already
being used in drivers/firmware/efi/libstub/hidden.h

> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index b17d218ccdf9..4bcc943842ab 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -81,6 +81,7 @@ SECTIONS
>  	DISCARDS
>  }
>  
> +ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
>  #ifdef CONFIG_X86_64
>  ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
>  #else

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
