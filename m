Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11A4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C07572063A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ejEL51Fe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgA3WwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:52:17 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43770 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgA3WwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 17:52:17 -0500
Received: by mail-pl1-f194.google.com with SMTP id p11so1908712plq.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 14:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eaWMUtXcOeIEHnvDinmqZzdKFQeL2HEGtQM6ZC3zDaU=;
        b=ejEL51FeSlA7f3DlyTEeDXC2pe93wORkySV3bmhw/BO6aB42bwX7V7tjSj9J6P2SHp
         f5/HYe3bVMgbAD4gac0DFdBMI8KHgQxFd0hUJQ1yFyQYmiMFlExiolbkXivF6/OdZ+Rj
         7bfSnjiXzvTFSo8uhQG+GzZKOsC20MowmNzKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eaWMUtXcOeIEHnvDinmqZzdKFQeL2HEGtQM6ZC3zDaU=;
        b=DlXiZkx20DeaN0GZFfkU+K2YPYWjSwz08Uk3pdrYaK1kyJOX9kCLkbUDqx1gci9A3y
         GzXW02/nwgRG1MPFJU4KkesR4rjkwFfSqAegBaXYv2MY7AOYbkbvwpj9zyubtBnavOjo
         1R9wHXxTr56RvuG/X/9Ajjroj0MzvoyH3QgWi1yfuf9+pzp1vnQOFzAF1c3eqjCzg3k7
         uKBC+MpCFtRC4QyDHBzjGZIgTpWmacfZhWoN3nJJs3awpdpUWTgBcgqMSMa+yMbzkCNK
         fwTN1aqZmtZF9uFh6FhjyTU3IBj96bBrNVMwm//W9aQ+9FL45hZlXXPdla8H9xG+HwNN
         2H7A==
X-Gm-Message-State: APjAAAWhQWRFDILH6/rnXASZghUPAFwN2YNYNWtdYO8gPG+UjBQfHFdv
        NQNY3JlPtQudK/ojYHzQb14u2A==
X-Google-Smtp-Source: APXvYqwuaul4KGpwmFeFZDa4/0hUeCp30cet4kZXjU9b1GuBJP7Qp5KLNa3km9ESjmx+/Cj0sBvgjw==
X-Received: by 2002:a17:90a:c24c:: with SMTP id d12mr8713302pjx.113.1580424736927;
        Thu, 30 Jan 2020 14:52:16 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r66sm8064315pfc.74.2020.01.30.14.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 14:52:16 -0800 (PST)
Date:   Thu, 30 Jan 2020 14:52:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH] Discard .note.gnu.property sections in generic NOTES
Message-ID: <202001301452.84D47F5@keescook>
References: <20200130224337.4150-1-hjl.tools@gmail.com>
 <20200130224337.4150-2-hjl.tools@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130224337.4150-2-hjl.tools@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 02:43:37PM -0800, H.J. Lu wrote:
> With the command-line option, -mx86-used-note=yes, the x86 assembler
> in binutils 2.32 and above generates a program property note in a note
> section, .note.gnu.property, to encode used x86 ISAs and features.  But
> kernel linker script only contains a single NOTE segment:
> 
> PHDRS {
>  text PT_LOAD FLAGS(5);
>  data PT_LOAD FLAGS(6);
>  percpu PT_LOAD FLAGS(6);
>  init PT_LOAD FLAGS(7);
>  note PT_NOTE FLAGS(0);
> }
> SECTIONS
> {
> ...
>  .notes : AT(ADDR(.notes) - 0xffffffff80000000) { __start_notes = .; KEEP(*(.not
> e.*)) __stop_notes = .; } :text :note
> ...
> }
> 
> The NOTE segment generated by kernel linker script is aligned to 4 bytes.
> But .note.gnu.property section must be aligned to 8 bytes on x86-64 and
> we get
> 
> [hjl@gnu-skx-1 linux]$ readelf -n vmlinux
> 
> Displaying notes found in: .notes
>   Owner                Data size Description
>   Xen                  0x00000006 Unknown note type: (0x00000006)
>    description data: 6c 69 6e 75 78 00
>   Xen                  0x00000004 Unknown note type: (0x00000007)
>    description data: 32 2e 36 00
>   xen-3.0              0x00000005 Unknown note type: (0x006e6558)
>    description data: 08 00 00 00 03
> readelf: Warning: note with invalid namesz and/or descsz found at offset 0x50
> readelf: Warning:  type: 0xffffffff, namesize: 0x006e6558, descsize:
> 0x80000000, alignment: 8
> [hjl@gnu-skx-1 linux]$
> 
> Since note.gnu.property section in kernel image is never used, this patch
> discards .note.gnu.property sections in kernel linker script by adding
> 
> /DISCARD/ : {
>   *(.note.gnu.property)
> }
> 
> before kernel NOTE segment in generic NOTES.
> 
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  include/asm-generic/vmlinux.lds.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index 6b943fb8c5fd..6659a7c07c84 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -818,7 +818,14 @@
>  #define TRACEDATA
>  #endif
>  
> +/*
> + * Discard .note.gnu.property sections which are unused and have
> + * different alignment requirement from kernel note sections.
> + */
>  #define NOTES								\
> +	/DISCARD/ : {							\
> +		*(.note.gnu.property)					\
> +	}								\
>  	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
>  		__start_notes = .;					\
>  		KEEP(*(.note.*))					\
> -- 
> 2.24.1
> 

-- 
Kees Cook
