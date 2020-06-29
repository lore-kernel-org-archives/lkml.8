Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93219C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 663AD2065F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lVmQl/9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732173AbgF2T1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732667AbgF2T1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:27:42 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2BDC0307A4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:48:08 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i4so8201187pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YbRtal9fK3rQyK3//XqhJ7uvEkqJtbhUntiaS048PqQ=;
        b=lVmQl/9vcicknYCtmf+wmmVJ9Hp5s/oZowZHTmdWnufiebNIKHd/yoZyEphBN8bv1i
         wSdJ41MSNRU9mZrgR3nGThbzuNwL7mzHMYyB0v58G6indJNtcj29M9bAOf7rRExZczrI
         pENfWeL7AjMVwWjA0HFEWRXbkvqo13JG5fxNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YbRtal9fK3rQyK3//XqhJ7uvEkqJtbhUntiaS048PqQ=;
        b=mCdTT+knBkUvqNYSPQ0z2I1eV4N9Oul5wmEWlBI2UrkphZK5qRHBzLuOhmiU2YBTtQ
         GZiCkJydjFEYHk2Aan8YugNg47NKFK7vrNyWyIQQzAEl8f0vFgcJg1WR4pist9RAVg1I
         ijwSnZsHMXxSSBBoijnprTKhKhyW+xxLE40zUig336eoRGBKesfXNY1vtyCOBGUyB4gu
         BgGatDjjK5diyxNfNNnCOhzInqYtarpxXoCS4hH0QQ+k6EIDPKppQ4XDhOVjnCqSk2uq
         fwkoSOvM8jF1TR+5A5b+WiO4UEMdNoTZVwSAZFpA/xdkStmwAhqtEv9CsIYgs5B/osrz
         EEcg==
X-Gm-Message-State: AOAM530IQFODO/QkPGEx2aC4e2pdRiMnZlf91J61wbMLx7NkfIvumJFL
        OFZ8EZJ04LJVn0WU6G13zdmVMQ==
X-Google-Smtp-Source: ABdhPJwGlNoSYrl6H106zGFwoaq2I9OmCSpSObCsU5dYLmOEYrSIrUBR88RQPZvYQpl8s51vA4xK+A==
X-Received: by 2002:a17:90a:c003:: with SMTP id p3mr18791317pjt.178.1593445687987;
        Mon, 29 Jun 2020 08:48:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x7sm151435pfp.96.2020.06.29.08.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 08:48:07 -0700 (PDT)
Date:   Mon, 29 Jun 2020 08:48:05 -0700
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
Subject: Re: [PATCH v3 1/7] x86/boot/compressed: Move .got.plt entries out of
 the .got section
Message-ID: <202006290846.5A5C76A4D7@keescook>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629140928.858507-2-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 10:09:22AM -0400, Arvind Sankar wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> The .got.plt section contains the part of the GOT which is used by PLT
> entries, and which gets updated lazily by the dynamic loader when
> function calls are dispatched through those PLT entries.
> 
> On fully linked binaries such as the kernel proper or the decompressor,
> this never happens, and so in practice, the .got.plt section consists
> only of the first 3 magic entries that are meant to point at the _DYNAMIC
> section and at the fixup routine in the loader. However, since we don't
> use a dynamic loader, those entries are never populated or used.
> 
> This means that treating those entries like ordinary GOT entries, and
> updating their values based on the actual placement of the executable in
> memory is completely pointless, and we can just ignore the .got.plt
> section entirely, provided that it has no additional entries beyond
> the first 3 ones.
> 
> So add an assertion in the linker script to ensure that this assumption
> holds, and move the contents out of the [_got, _egot) memory range that
> is modified by the GOT fixup routines.
> 
> While at it, drop the KEEP(), since it has no effect on the contents
> of output sections that are created by the linker itself.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Acked-by: Arvind Sankar <nivedita@alum.mit.edu>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> From: Ard Biesheuvel <ardb@kernel.org>
> Link: https://lore.kernel.org/r/20200523120021.34996-2-ardb@kernel.org
> ---
>  arch/x86/boot/compressed/vmlinux.lds.S | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 8f1025d1f681..b17d218ccdf9 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -44,10 +44,13 @@ SECTIONS
>  	}
>  	.got : {
>  		_got = .;
> -		KEEP(*(.got.plt))
>  		KEEP(*(.got))
>  		_egot = .;
>  	}
> +	.got.plt : {
> +		*(.got.plt)
> +	}

This is also being done on arm64, and the section was specified slightly
differently (with INFO) which maybe should be done here too?

       .got.plt (INFO) : { *(.got.plt) }
       ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, ".got.plt not empty")

Otherwise, yes, looks good.

Reviewed-by: Kees Cook <keescook@chromium.org>

> +
>  	.data :	{
>  		_data = . ;
>  		*(.data)
> @@ -77,3 +80,9 @@ SECTIONS
>  
>  	DISCARDS
>  }
> +
> +#ifdef CONFIG_X86_64
> +ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
> +#else
> +ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
> +#endif
> -- 
> 2.26.2
> 

-- 
Kees Cook
