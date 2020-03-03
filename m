Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECF48C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7452073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583262661;
	bh=4NVTBacBsWlMTFEhPSv4sPsd4s0glorw7tyt6PZlIyU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G2LJ2ha1iwNrTEVu+PI017BFaF9iZHQItc8303BNIiXakq/4DspYYI0uYw4WYZ0dD
	 FnMLywuNpnnJ4XS/6vZ6q4ejIVjfNOHab+vNK03ON6ubtn3me91uo4b+1nKG68xqm9
	 ZtaqffdJruidY971vlpY72kHC43ttEsxGNL4zaWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbgCCTLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:11:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:47024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbgCCTLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:11:00 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B9F320CC7
        for <linux-kernel@vger.kernel.org>; Tue,  3 Mar 2020 19:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583262659;
        bh=4NVTBacBsWlMTFEhPSv4sPsd4s0glorw7tyt6PZlIyU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nzZjsN7os5wMg6j+xQykpxFbL6DqCQ0AU7uFBA4+ZBZNqdvUKdBzmozDpk1/9W6Xb
         5SyLhr8eQKWqQzLt/X3aWhZ0KPsQAsCgtwosBStNAPLjX29LPC2YGcvcM92b7t/hVC
         r8voHZh5jZ7jGt1CeZkgWnJNp4YkwkMQvFRsb170=
Received: by mail-wr1-f45.google.com with SMTP id j16so5868166wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 11:10:59 -0800 (PST)
X-Gm-Message-State: ANhLgQ3Dz87gbaeaYLsSa0s4zBMR14tMv0BM0fRulk0v6nOmZnpSSzQO
        PRWplGt4WImPUb64GY/jtbbCZ1bGqbmxn9lhC8rvtA==
X-Google-Smtp-Source: ADFU+vv4R2JsjxvCStaF4Sz+G3lQ9x00p2GuUKC7ZVY8WVBxrEiYeOMh9IFZznAIi/ABBEp6fO6zzCWed8525DJ7MnA=
X-Received: by 2002:adf:e742:: with SMTP id c2mr6731528wrn.262.1583262657609;
 Tue, 03 Mar 2020 11:10:57 -0800 (PST)
MIME-Version: 1.0
References: <20200301230537.2247550-1-nivedita@alum.mit.edu> <20200301230537.2247550-2-nivedita@alum.mit.edu>
In-Reply-To: <20200301230537.2247550-2-nivedita@alum.mit.edu>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 3 Mar 2020 20:10:46 +0100
X-Gmail-Original-Message-ID: <CAKv+Gu87ssM3g+Hc9cPJPy5oFkgFCtueovwxmLK-gTKzUbSLNQ@mail.gmail.com>
Message-ID: <CAKv+Gu87ssM3g+Hc9cPJPy5oFkgFCtueovwxmLK-gTKzUbSLNQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] x86/boot/compressed/32: Save the output address
 instead of recalculating it
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Mar 2020 at 00:05, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> In preparation for being able to decompress starting at a different
> address than startup_32, save the calculated output address instead of
> recalculating it later.
>

Could you expand this a bit? Are you talking about *running* the
decompressor code at another offset? Or about the space it uses. I
think I know but I'd like to be sure :-)


> We now keep track of three addresses:
>         %edx: startup_32 as we were loaded by bootloader
>         %ebx: new location of compressed kernel
>         %ebp: start of decompression buffer
>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/compressed/head_32.S | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/boot/compressed/head_32.S b/arch/x86/boot/compressed/head_32.S
> index 46bbe7ab4adf..894182500606 100644
> --- a/arch/x86/boot/compressed/head_32.S
> +++ b/arch/x86/boot/compressed/head_32.S
> @@ -75,11 +75,11 @@ SYM_FUNC_START(startup_32)
>   */
>         leal    (BP_scratch+4)(%esi), %esp
>         call    1f
> -1:     popl    %ebp
> -       subl    $1b, %ebp
> +1:     popl    %edx
> +       subl    $1b, %edx
>
>         /* Load new GDT */
> -       leal    gdt(%ebp), %eax
> +       leal    gdt(%edx), %eax
>         movl    %eax, 2(%eax)
>         lgdt    (%eax)
>
> @@ -92,13 +92,14 @@ SYM_FUNC_START(startup_32)
>         movl    %eax, %ss
>
>  /*
> - * %ebp contains the address we are loaded at by the boot loader and %ebx
> + * %edx contains the address we are loaded at by the boot loader and %ebx
>   * contains the address where we should move the kernel image temporarily
> - * for safe in-place decompression.
> + * for safe in-place decompression. %ebp contains the address that the kernel
> + * will be decompressed to.
>   */
>
>  #ifdef CONFIG_RELOCATABLE
> -       movl    %ebp, %ebx
> +       movl    %edx, %ebx
>         movl    BP_kernel_alignment(%esi), %eax
>         decl    %eax
>         addl    %eax, %ebx
> @@ -110,10 +111,10 @@ SYM_FUNC_START(startup_32)
>         movl    $LOAD_PHYSICAL_ADDR, %ebx
>  1:
>
> +       movl    %ebx, %ebp      // Save the output address for later
>         /* Target address to relocate to for decompression */
> -       movl    BP_init_size(%esi), %eax
> -       subl    $_end, %eax
> -       addl    %eax, %ebx
> +       addl    BP_init_size(%esi), %ebx
> +       subl    $_end, %ebx
>
>         /* Set up the stack */
>         leal    boot_stack_end(%ebx), %esp
> @@ -127,7 +128,7 @@ SYM_FUNC_START(startup_32)
>   * where decompression in place becomes safe.
>   */
>         pushl   %esi
> -       leal    (_bss-4)(%ebp), %esi
> +       leal    (_bss-4)(%edx), %esi
>         leal    (_bss-4)(%ebx), %edi
>         movl    $(_bss - startup_32), %ecx
>         shrl    $2, %ecx
> @@ -196,9 +197,7 @@ SYM_FUNC_START_LOCAL_NOALIGN(.Lrelocated)
>                                 /* push arguments for extract_kernel: */
>         pushl   $z_output_len   /* decompressed length, end of relocs */
>
> -       leal    _end(%ebx), %eax
> -       subl    BP_init_size(%esi), %eax
> -       pushl   %eax            /* output address */
> +       pushl   %ebp            /* output address */
>
>         pushl   $z_input_len    /* input_len */
>         leal    input_data(%ebx), %eax
> --
> 2.24.1
>
