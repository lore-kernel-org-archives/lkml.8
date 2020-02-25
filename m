Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F268C35DF2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 04:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6867622527
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 04:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e2D5m+55"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgBYELJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 23:11:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36309 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbgBYELJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 23:11:09 -0500
Received: by mail-pl1-f193.google.com with SMTP id a6so4943708plm.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 20:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MkHxxhEagzR8fO3G4O/HlLJK/mMYB1QzhvsGboCFrcg=;
        b=e2D5m+55MgOua8JNZA6u6S1cmF9YCb6lODSmx3tlqoYssIW9+bCN4Ryq3udVAtid9A
         9ADASN2yhM030o/i+s67kTd2iMG/jQGNb8BzXTBVYikyROXOTNO3eS7EaZ3zAB9lCZUz
         5NO4JyzpD6uWgMvZ5WxtzJ94l4oA5x04E73yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MkHxxhEagzR8fO3G4O/HlLJK/mMYB1QzhvsGboCFrcg=;
        b=LqCdEfCDVuoIvfczEPfC1xmSTvPq6DGYw74of48V0iiY7vzaNh1H+D/HMJG9KXyH+4
         hC9KSevjcG4by+C+5sgMM80LpnERGYfXajtSjPiC9R7SkqVTmkx4yCSHNEqoFoQD+TXE
         zw6whJKv4Ptl9ubs6tVOgRE+4PFSs33sPDnNwltChmZa/gWMsrnPcB4zboJrgIWya8Xt
         jC43EXe2pqiN2KiGGMLZYovfv7OPUQdIx5d0eizIpOmA0puxHE5KyfBy4sJ3W//4uoNX
         jGC1altSu3MOmK1kB4awFgrEAjtbmLU8EqZ6TwdoPsxfopXLd9mVRFtSwb5EMXJgWC2Y
         m5tA==
X-Gm-Message-State: APjAAAUapElhlBkkCDrUVkalhgQQNgJwHf8WZ0dSxF6n1qdkZVtNyAZH
        GVS4dU8B6TVYgWtQX/KgFJ/cvA==
X-Google-Smtp-Source: APXvYqxZf1evj9PH7EN7l8Ijt4CO9mPOq7pBLoKJgH21mGYKIBEVV3RssUyjyzVpS88Uw8lSYpENDw==
X-Received: by 2002:a17:90a:d585:: with SMTP id v5mr2837638pju.4.1582603868803;
        Mon, 24 Feb 2020 20:11:08 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w14sm14460628pgi.22.2020.02.24.20.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 20:11:08 -0800 (PST)
Date:   Mon, 24 Feb 2020 20:11:07 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 2/2] arch/x86: Drop unneeded linker script discard of
 .eh_frame
Message-ID: <202002242011.541C9A57@keescook>
References: <CAKwvOdn6cxm9EpB7A9kLasttPwLY2csnhqgNAdkJ6_s2DP1-HA@mail.gmail.com>
 <20200224232129.597160-3-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224232129.597160-3-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 06:21:29PM -0500, Arvind Sankar wrote:
> Now that we don't generate .eh_frame sections for the files in setup.elf
> and realmode.elf, the linker scripts don't need the /DISCARD/ any more.
> 
> Remove the one in the main kernel linker script as well, since there are
> no .eh_frame sections already, and fix up a comment referencing .eh_frame.
> 
> Update the comment in asm/dwarf2.h referring to .eh_frame so it continues
> to make sense, as well as being more specific.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/boot/compressed/vmlinux.lds.S | 5 -----
>  arch/x86/boot/setup.ld                 | 1 -
>  arch/x86/include/asm/dwarf2.h          | 4 ++--
>  arch/x86/kernel/vmlinux.lds.S          | 7 ++-----
>  arch/x86/realmode/rm/realmode.lds.S    | 1 -
>  5 files changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 469dcf800a2c..508cfa6828c5 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -73,9 +73,4 @@ SECTIONS
>  #endif
>  	. = ALIGN(PAGE_SIZE);	/* keep ZO size page aligned */
>  	_end = .;
> -
> -	/* Discard .eh_frame to save some space */
> -	/DISCARD/ : {
> -		*(.eh_frame)
> -	}
>  }
> diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
> index 3da1c37c6dd5..24c95522f231 100644
> --- a/arch/x86/boot/setup.ld
> +++ b/arch/x86/boot/setup.ld
> @@ -52,7 +52,6 @@ SECTIONS
>  	_end = .;
>  
>  	/DISCARD/	: {
> -		*(.eh_frame)
>  		*(.note*)
>  	}
>  
> diff --git a/arch/x86/include/asm/dwarf2.h b/arch/x86/include/asm/dwarf2.h
> index ae391f609840..f71a0cce9373 100644
> --- a/arch/x86/include/asm/dwarf2.h
> +++ b/arch/x86/include/asm/dwarf2.h
> @@ -42,8 +42,8 @@
>  	 * Emit CFI data in .debug_frame sections, not .eh_frame sections.
>  	 * The latter we currently just discard since we don't do DWARF
>  	 * unwinding at runtime.  So only the offline DWARF information is
> -	 * useful to anyone.  Note we should not use this directive if
> -	 * vmlinux.lds.S gets changed so it doesn't discard .eh_frame.
> +	 * useful to anyone.  Note we should not use this directive if we
> +	 * ever decide to enable DWARF unwinding at runtime.
>  	 */
>  	.cfi_sections .debug_frame
>  #else
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index e3296aa028fe..5cab3a29adcb 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -313,8 +313,8 @@ SECTIONS
>  
>  	. = ALIGN(8);
>  	/*
> -	 * .exit.text is discard at runtime, not link time, to deal with
> -	 *  references from .altinstructions and .eh_frame
> +	 * .exit.text is discarded at runtime, not link time, to deal with
> +	 *  references from .altinstructions
>  	 */
>  	.exit.text : AT(ADDR(.exit.text) - LOAD_OFFSET) {
>  		EXIT_TEXT
> @@ -412,9 +412,6 @@ SECTIONS
>  	DWARF_DEBUG
>  
>  	DISCARDS
> -	/DISCARD/ : {
> -		*(.eh_frame)
> -	}
>  }
>  
>  
> diff --git a/arch/x86/realmode/rm/realmode.lds.S b/arch/x86/realmode/rm/realmode.lds.S
> index 64d135d1ee63..63aa51875ba0 100644
> --- a/arch/x86/realmode/rm/realmode.lds.S
> +++ b/arch/x86/realmode/rm/realmode.lds.S
> @@ -71,7 +71,6 @@ SECTIONS
>  	/DISCARD/ : {
>  		*(.note*)
>  		*(.debug*)
> -		*(.eh_frame*)
>  	}
>  
>  #include "pasyms.h"
> -- 
> 2.24.1
> 

-- 
Kees Cook
