Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4163EC33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 01:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1089D207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 01:53:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fePzYw1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729327AbgANBxf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 20:53:35 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54910 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbgANBxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 20:53:35 -0500
Received: by mail-pj1-f68.google.com with SMTP id kx11so4969701pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 17:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WpuWvQQCJJpFhKDiMXRidEs1Erww4c/L/BGmOGdRJLs=;
        b=fePzYw1z/qf7rVjlcXxiG56pBw0R4EgInEYnm0Cn6lscidAE10j62F9goBylbQGc/H
         h5OccjYVR01qlZ2MKU1ix01NSalR1kG8P6rhLkRHEI0YLUYJ7ox8vdSMsjtGV9Hwz8tx
         /qWhbfr5tDyn2Te+Ed1JpxVRRZyGrn3u1318s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WpuWvQQCJJpFhKDiMXRidEs1Erww4c/L/BGmOGdRJLs=;
        b=ulJjQh4A06wUYB3AgPHS8x/xw0sWk3NrC+2M+q4SKOXDx/ZlMGLRXsgL8Lkr4k3i/M
         RWRnSWS71XjiInXYnWM+UsFiMxXZjLIRLNPiOhfBxEaZoFln2VllnPbFZrTsNTXmgFHh
         opZu5mvNs0u3Ttkco0c5WPcqsXxXpBcVtlVyom0y0GKThj1cD2kqmqGOFVpx6u8DGx6k
         6HUolU9OEhJv/v+bwhYyteOOwScx1N/MDYBiyIGf/Vm0B/ue8ArthkPPqKLjAF7c/3rS
         u+oQbHjhcrIUPyR5zEFIVWm/wNrJW1YQz4CS6MqmnbgC1MkJkCG1fjgegAggcnEU7Ed/
         Z+eA==
X-Gm-Message-State: APjAAAWht6bURk7PasYj0jhTRNgU5WS5iFQWxnWHEtfED8PhABH+ExF4
        iGrFwIvySCIRGfdgn7ctaQmVBA==
X-Google-Smtp-Source: APXvYqzbKLmAzVTESEqyPpUS/sBRLK6AqgTNXbxlpN35dd7tKE681uebOhzYmdWz16Cg9a4DekWGVw==
X-Received: by 2002:a17:90a:5ac4:: with SMTP id n62mr26485294pji.59.1578966814268;
        Mon, 13 Jan 2020 17:53:34 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y203sm16268125pfb.65.2020.01.13.17.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 17:53:33 -0800 (PST)
Date:   Mon, 13 Jan 2020 17:53:32 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH v3] x86/vmlinux: Fix vmlinux.lds.S with pre-2.23 binutils
Message-ID: <202001131750.C1B8468@keescook>
References: <20200113161310.GA191743@rani.riverdale.lan>
 <20200113195337.604646-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113195337.604646-1-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 02:53:37PM -0500, Arvind Sankar wrote:
> Prior to binutils-2.23, ld treats the location counter as absolute if
> used outside an output section definition. From version 2.23 onwards,
> the location counter is treated as relative to an adjacent output
> section (usually the previous one, unless there isn't one or the
> location counter has been assigned to previously, in which case the next
> one).
> 
> The result is that a symbol definition in the linker script, such as
> 	_etext = .;
> that appears outside an output section definition makes _etext an
> absolute symbol prior to binutils-2.23 and a relative symbol from
> version 2.23 onwards. So when using a 2.21 or 2.22 vintage linker, the
> build fails with
> 	Invalid absolute R_X86_64_32S relocation: _etext
> for x86-64, and a similar message with R_386_32 for x86-32.
> 
> This can be reproduced with the official 2.21.1 and 2.22 binutils
> releases.
> 
> Commit b907693883fd ("x86/vmlinux: Actually use _etext for the end of
> the text segment") moved _etext out of the .text section to place it
> after the exception table, however since commit f0d7ee17d57c
> ("x86/vmlinux: Move EXCEPTION_TABLE to RO_DATA segment") this is no
> longer needed. Move _etext back inside .text to make it relative even
> with older linkers.
> 
> Commit c603a309cc75 ("x86/mm: Identify the end of the kernel area to be
> reserved") defines __end_of_kernel_reserve using the location counter
> outside an output section definition. Use __bss_stop instead of the
> location counter for the definition to make it relative with older
> linkers.
> 
> Fixes: b907693883fd ("x86/vmlinux: Actually use _etext for the end of the text segment")
> Fixes: c603a309cc75 ("x86/mm: Identify the end of the kernel area to be reserved")
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
> v3: Modify vmlinux.lds.S instead of adding more workarounds to tools/relocs.c
> 
>  arch/x86/kernel/vmlinux.lds.S | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 3a1a819da137..bad4e22384dc 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -144,10 +144,12 @@ SECTIONS
>  		*(.text.__x86.indirect_thunk)
>  		__indirect_thunk_end = .;
>  #endif
> +
> +		/* End of text section */
> +		_etext = .;
>  	} :text =0xcccc
>  
> -	/* End of text section, which should occupy whole number of pages */
> -	_etext = .;
> +	/* .text should occupy whole number of pages */
>  	. = ALIGN(PAGE_SIZE);

NAK: linkers can add things at the end of .text that will go missing from
the kernel if _etext isn't _outside_ the .text section, truly beyond the
end of the .text section. This patch will break Control Flow Integrity
checking since the jump tables are at the end of .text.

Boris, we're always working around weird linker problems; I don't see a
problem with the v2 patch to fix up old binutils...

-Kees

>  
>  	X86_ALIGN_RODATA_BEGIN
> @@ -372,7 +374,7 @@ SECTIONS
>  	 * explicitly reserved using memblock_reserve() or it will be discarded
>  	 * and treated as available memory.
>  	 */
> -	__end_of_kernel_reserve = .;
> +	__end_of_kernel_reserve = __bss_stop;
>  
>  	. = ALIGN(PAGE_SIZE);
>  	.brk : AT(ADDR(.brk) - LOAD_OFFSET) {
> -- 
> 2.24.1
> 

-- 
Kees Cook
