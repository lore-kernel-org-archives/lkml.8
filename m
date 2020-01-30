Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94345C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 623E920CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 22:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d+1GtPTW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgA3WEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 17:04:07 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42028 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbgA3WEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 17:04:07 -0500
Received: by mail-pf1-f196.google.com with SMTP id 4so2184426pfz.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 14:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n+A9Sx+NAJWYedW4n2tIiVzmJW2dkc/pU/Gt5hSqf6c=;
        b=d+1GtPTWlR/snBZ+43fitICGSmmyJ5n6vv7mFpMznofVG8ZdIzy3GMY+Xhoh3QvSxX
         YWLh7jYlx00SIQy+il+HadTAEoIXs68ACynQty2mToNVcVFQBJDJZvxGVNTDw4/ojprj
         QvcGQQWLek9d2bP7GnJaiSEeTUNjREqPV9yNk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n+A9Sx+NAJWYedW4n2tIiVzmJW2dkc/pU/Gt5hSqf6c=;
        b=EP92oqXVfMKKsQtVW1//IHY+m2X/KngSppinjBdi2EapErGZdv81jxsYBpB6faMlPk
         YXMe8S4HjEdatME/xaXyoMIoBRGYTReX1dtR5zh557vQRye4MZKX2YzrX6XrgHKNepxn
         7vNckN1Il2hWaEXkeVi755/kkB6D7FZ9F53VkGPDptVjC4zbCkCpv90glSA/d0h3O6JB
         YrtZ671E61OrOarf3ge9umC/sb2pfZMu5EOA9O6Ndxncgz4+F56yEa6YDm+ciPbCDSSG
         bjMOsPh18ER5oNGu/q2R6ezyNWTSSIKMeOQBzEgqtZm3zELc9IsFF40gV+v+WGXk1oyC
         /zhw==
X-Gm-Message-State: APjAAAXpvwWJgMBssRcUdNMNA6cONxk5zVWqzMeUrSky3paXMJPfui+C
        PJzRYwiBTErYbu9N0stsX/Jv2g==
X-Google-Smtp-Source: APXvYqxfDuQ31K2PH60+cElEEgLxwTnz181+0mp5RwiDq4ouAY1fzQKjf23rjXH0AQU8CEjFaSDnGg==
X-Received: by 2002:a63:6d05:: with SMTP id i5mr7229857pgc.120.1580421846379;
        Thu, 30 Jan 2020 14:04:06 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x7sm7813179pfp.93.2020.01.30.14.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 14:04:05 -0800 (PST)
Date:   Thu, 30 Jan 2020 14:04:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH] Add RUNTIME_DISCARD_EXIT to generic DISCARDS
Message-ID: <202001301402.7E23309E2C@keescook>
References: <20200130180048.2901-1-hjl.tools@gmail.com>
 <202001301139.F8859A4@keescook>
 <CAMe9rOrrrZFWgVpsKAWjHKzVh3ZziFLs2ua0m0Ewymrjs-b+EA@mail.gmail.com>
 <202001301152.DF108B6CC@keescook>
 <CAMe9rOp1SJvsjSMtDFi4HWKPpu2eePCDiedTPAndUEL5-HSU1w@mail.gmail.com>
 <CAMe9rOqYh3QEdT16C8TOCBhYqfzsYJ6re0x+MDjpad9_59krZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMe9rOqYh3QEdT16C8TOCBhYqfzsYJ6re0x+MDjpad9_59krZw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 12:47:07PM -0800, H.J. Lu wrote:
> From bde2821f5e01a5f49b227c6fb8ba6195c26381a9 Mon Sep 17 00:00:00 2001
> From: "H.J. Lu" <hjl.tools@gmail.com>
> Date: Thu, 30 Jan 2020 12:31:22 -0800
> Subject: [PATCH] Add RUNTIME_DISCARD_EXIT to generic DISCARDS
> 
> In x86 kernel, .exit.text and .exit.data sections are discarded at
> runtime not by linker.  Add RUNTIME_DISCARD_EXIT to generic DISCARDS
> and define it in x86 kernel linker script to keep them.

Thanks for doing this! :) (I wasn't sure about _CALL, thanks also for
checking that.)

(The patch is missing your SoB?)

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/x86/kernel/vmlinux.lds.S     |  1 +
>  include/asm-generic/vmlinux.lds.h | 10 ++++++++--
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index e3296aa028fe..7206e1ac23dd 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -21,6 +21,7 @@
>  #define LOAD_OFFSET __START_KERNEL_map
>  #endif
>  
> +#define RUNTIME_DISCARD_EXIT
>  #define EMITS_PT_NOTE
>  #define RO_EXCEPTION_TABLE_ALIGN	16
>  
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index e00f41aa8ec4..6b943fb8c5fd 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -894,10 +894,16 @@
>   * section definitions so that such archs put those in earlier section
>   * definitions.
>   */
> +#ifdef RUNTIME_DISCARD_EXIT
> +#define EXIT_DISCARDS
> +#else
> +#define EXIT_DISCARDS							\
> +	EXIT_TEXT							\
> +	EXIT_DATA
> +#endif
>  #define DISCARDS							\
>  	/DISCARD/ : {							\
> -	EXIT_TEXT							\
> -	EXIT_DATA							\
> +	EXIT_DISCARDS							\
>  	EXIT_CALL							\
>  	*(.discard)							\
>  	*(.discard.*)							\
> -- 
> 2.24.1
> 


-- 
Kees Cook

