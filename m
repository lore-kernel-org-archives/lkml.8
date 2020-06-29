Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D58C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1DB520842
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YYrun5Zs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbgF2TnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387988AbgF2Tmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:42:44 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579B0C0307B7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:04:07 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j12so8078139pfn.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bCcUKUF5r6yaBuJR+zxqwfyemuV81g4EzykEAUFhIxY=;
        b=YYrun5ZscNfXsw/t74AIeHq4eMNW2QBNA0p3Bb3c10bu6M+CnISJ6B+QzdC4GqhL+3
         iUomyqlsRE36TIjaFVf+wO0lCEqB9tbWDZHmvY46yc0nz3/4PdkZ3CxW4CqYsAm3vxLS
         lPtFY0XQs/cojVAOqUn/Cip9htTosvzyrmX/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bCcUKUF5r6yaBuJR+zxqwfyemuV81g4EzykEAUFhIxY=;
        b=WQ4gxviFXTAQTtlQScQDRZdsmsD0MRC//4A61niWtR1+MFRL6ebqFP2CCJKcJO29uR
         FPkQYuiznrNoo8ojkrHMCn0DpSZz1QNT4e03QICkjLyzAQj1Oo9Z90pKzfGdIhZw1H1F
         6S42KInHalZx3Ob7+n6q7lN9rX1L6H+G+6WGy/vC4DSzrSTZvg5CFpDWJKFW6YFSA+nl
         RdfD5PvL87tAZlREl3JWzHz4c4eWaxh8ntuH6lPCWpJmsPKx/oeiXX8CCqnvot1On2uf
         xHeC6wJISCuVsP1tpW+uru8M5dbYDx6yoG7xi2A+/dHnFX65jmF1sLO7SENbMDf5ljI0
         Kp1w==
X-Gm-Message-State: AOAM5339okYacJ58bSgvd/6R+/iWhJmNpbMyEupmiw98Ue2p6OcJYlov
        tAGsWwuS67Y57uZNylbGux7jJQ==
X-Google-Smtp-Source: ABdhPJyqlPlGC0cDhAfJhMnp27RTv3Ak2W8Xjp0hWvlNTD3qKBfDT4Wfs5MPdQKoEethPfWQnKWuCA==
X-Received: by 2002:a63:3005:: with SMTP id w5mr10723200pgw.441.1593446646832;
        Mon, 29 Jun 2020 09:04:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m7sm220299pgg.69.2020.06.29.09.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 09:04:05 -0700 (PDT)
Date:   Mon, 29 Jun 2020 09:04:04 -0700
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
Subject: Re: [PATCH v3 5/7] x86/boot: Remove run-time relocations from
 .head.text code
Message-ID: <202006290859.14DD408A29@keescook>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-6-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629140928.858507-6-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 10:09:26AM -0400, Arvind Sankar wrote:
> The assembly code in head_{32,64}.S, while meant to be
> position-independent, generates run-time relocations because it uses
> instructions such as
> 	leal	gdt(%edx), %eax
> which make the assembler and linker think that the code is using %edx as
> an index into gdt, and hence gdt needs to be relocated to its run-time
> address.
> 
> On 32-bit, with lld Dmitry Golovin reports that this results in a
> link-time error with default options (i.e. unless -z notext is
> explicitly passed):
>   LD      arch/x86/boot/compressed/vmlinux
> ld.lld: error: can't create dynamic relocation R_386_32 against local
> symbol in readonly segment; recompile object files with -fPIC or pass
> '-Wl,-z,notext' to allow text relocations in the output
> 
> With the BFD linker, this generates a warning during the build, if
> --warn-shared-textrel is enabled, which at least Gentoo enables by
> default:
>   LD      arch/x86/boot/compressed/vmlinux
> ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-only section `.head.text'
> ld: warning: creating a DT_TEXTREL in object
> 
> On 64-bit, it is not possible to link the kernel as -pie with lld, and
> it is only possible with a BFD linker that supports -z noreloc-overflow,
> i.e. versions >2.26. This is because these instructions cannot really be
> relocated: the displacement field is only 32-bits wide, and thus cannot
> be relocated for a 64-bit load address. The -z noreloc-overflow option
> simply overrides the linker error, and results in R_X86_64_RELATIVE
> relocations that apply a 64-bit relocation to a 32-bit field anyway.
> This happens to work because nothing will process these run-time
> relocations.

Are any of Thomas Garnier's PIE fixes useful here too? He had a lot of
fixes to make changes for PC-relative addressing in the various
assembly bits:
https://lore.kernel.org/lkml/20200228000105.165012-9-thgarnie@chromium.org/

> 
> Start fixing this by removing relocations from .head.text:
> - On 32-bit, use a base register that holds the address of the GOT and
>   reference symbol addresses using @GOTOFF, i.e.
> 	leal	gdt@GOTOFF(%edx), %eax
> - On 64-bit, most of the code can (and already does) use %rip-relative
>   addressing, however the .code32 bits can't, and the 64-bit code also
>   needs to reference symbol addresses as they will be after moving the
>   compressed kernel to the end of the decompression buffer.
>   For these cases, reference the symbols as an offset to startup_32 to
>   avoid creating relocations, i.e.
>   	leal	(gdt-startup_32)(%bp), %eax
>   This only works in .head.text as the subtraction cannot be represented
>   as a PC-relative relocation unless startup_32 is in the same section
>   as the code. Move efi32_pe_entry into .head.text so that it can use
>   the same method to avoid relocations.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Fangrui Song <maskray@google.com>

Nice.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
