Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F452C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8BA2467B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 23:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YRaFDTvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgA0Xel (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 18:34:41 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37783 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0Xel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 18:34:41 -0500
Received: by mail-pg1-f195.google.com with SMTP id q127so5967276pga.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 15:34:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fwPuLOZX/o8vjqlDCVTFY15+P0fnQe7CE6TakilvlE8=;
        b=YRaFDTvc4S+IJUd3pcsFBtl6Ja6s2412aP/+AHITNKqpRtSgp0lr0NpuYqb2hbZsgb
         6hYgbAeXILIA8DwZ2yHa/+lTWO+aesV9j7exMlhQBlNl+kanOrK5P6PD72NGN6iRCF3B
         5cBlns6SfJwQT3aCgq7q9+e2ocFRGBsD5vvjM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fwPuLOZX/o8vjqlDCVTFY15+P0fnQe7CE6TakilvlE8=;
        b=i+1gA31BDF9p6IIx/PftzUGBZnQ71rtOxc1BrglUJTu4yvq2tlglRsQRvOobdR82qL
         2XflhEzUM7/5BSEAX6NnghwXZ0Go7vh77S2Tb1ZHbUrJ67lPR+wRBz7r80K/Lq0PQNjm
         Z4OPYl8UOaLQLFPLVz8rpN/JQQJaJCoddTaDN/PYGcyHYfHc9BVOcEEddnw5LUEj8QT+
         VCoJBCO95T9B+2APGv8rmPMlI0EZOFuqIlNiQ+7CsGr0bWqNY9vhwb7i7szuFlDiJTew
         0hXgAMOO9BbG8MQ2x9erN9UNyBqrmKtwBXerrhZcTMjOtjcgkF5RLmA7QPK7p7Rk0+zJ
         9BqQ==
X-Gm-Message-State: APjAAAUjeVecezHsfG8gdn8SSvs7V4aBvpMtj4lSk4lZHlGOVNp7ibnl
        8Z/CU4WsCK9ZUCt6LymeQvTsXmTVkH4=
X-Google-Smtp-Source: APXvYqxknG1EHkkvN5bA63WfjTojRXqWzVFGuy1/805Nk5iRQshIkr708pXqW2ZvYv57qSXKO7p85A==
X-Received: by 2002:a62:cec7:: with SMTP id y190mr997401pfg.191.1580168080344;
        Mon, 27 Jan 2020 15:34:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s22sm173971pji.30.2020.01.27.15.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 15:34:39 -0800 (PST)
Date:   Mon, 27 Jan 2020 15:34:38 -0800
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
Subject: Re: [PATCH 2/2] x86: Discard .note.gnu.property sections in vmlinux
Message-ID: <202001271531.B9ACE2A@keescook>
References: <20200124181819.4840-1-hjl.tools@gmail.com>
 <20200124181819.4840-3-hjl.tools@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124181819.4840-3-hjl.tools@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:18:19AM -0800, H.J. Lu wrote:
> With the command-line option, -mx86-used-note=yes, the x86 assembler
> in binutils 2.32 and above generates a program property note in a note
> section, .note.gnu.property, to encode used x86 ISAs and features.
> But x86 kernel linker script only contains a signle NOTE segment:
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
> which may not be incompatible with note.gnu.property sections.  Since
> note.gnu.property section in kernel image is unused, this patch discards
> .note.gnu.property sections in kernel linker script by adding
> 
>  /DISCARD/ : {
>   *(.note.gnu.property)
>  }

I think this is happening in the wrong place? Shouldn't this be in the
DISCARDS macro in include/asm-generic/vmlinux.lds.h instead?

> before .notes sections.  Since .exit.text and .exit.data sections are
> discarded at runtime, it undefines EXIT_TEXT and EXIT_DATA to exclude
> .exit.text and .exit.data sections from default discarded sections.

This looks like a separate issue (though maybe related to DISCARDS)?

-Kees

> 
> Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/kernel/vmlinux.lds.S | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 3a1a819da137..6c6cc26b0177 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -150,6 +150,11 @@ SECTIONS
>  	_etext = .;
>  	. = ALIGN(PAGE_SIZE);
>  
> +	/* .note.gnu.property sections should be discarded */
> +	/DISCARD/ : {
> +		*(.note.gnu.property)
> +	}
> +
>  	X86_ALIGN_RODATA_BEGIN
>  	RO_DATA(PAGE_SIZE)
>  	X86_ALIGN_RODATA_END
> @@ -413,6 +418,12 @@ SECTIONS
>  	STABS_DEBUG
>  	DWARF_DEBUG
>  
> +	/* Sections to be discarded.  EXIT_TEXT and EXIT_DATA discard at runtime.
> +	 * not link time.  */
> +#undef EXIT_TEXT
> +#define EXIT_TEXT
> +#undef EXIT_DATA
> +#define EXIT_DATA
>  	DISCARDS
>  	/DISCARD/ : {
>  		*(.eh_frame)
> -- 
> 2.24.1
> 

-- 
Kees Cook
