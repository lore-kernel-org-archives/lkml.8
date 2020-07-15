Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9C70C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B05BB20657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwzvjHZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgGOIzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727930AbgGOIzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:55:44 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04939C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:55:44 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id p205so1413876iod.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=RsnVN0E19i3bHghc9pYkTMlrihhqaH+/1a+LCxqn6J8=;
        b=UwzvjHZgjR8vfGdEBbjZtNDn4fj5o2UBdEqSv9SDkqZVJAYZwQTyal1lb/jgTGun3C
         0jOcPVcRNyxYa1tC9ocDhc5wcOURTNYhB3OzBMoMppOCdKYRqEjg0z03ORA4VCgx/DvP
         fgrRO3Zo4x6PoSi57C0iAC1bc6Z/ejCtIj+//w/pPCG20j3SePm93TMWAmueRSWMfg9a
         AXzWmhHIlzNAdTUxCDYiMTF3jOPstnab1TfTAuQh0hvvJ/87BMEB+7A49c41wZ//maP2
         U1WSe1FBxjstKxebO+ms8ZLwbDT/JNVp70lksO9Ke8R7e0Zl5jq6dapCglSJtHetjSKE
         FP2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=RsnVN0E19i3bHghc9pYkTMlrihhqaH+/1a+LCxqn6J8=;
        b=aY5dC1Pc8050a/3dkbu2ZM2CsSqSEpj0SONMI8Q8SOGEm/w00Kbmikmrqbex6MtKN4
         AGDKorEyLqL+sKWPSGV+ycN/KpdXAtlLMCcuiqxEvbrCd9Gv7mA/llxTSqT9RmBgeOze
         NpDh0pXHNwoyakgIz2q5UWxaV304q2de/0YXDQvGehwRAXstX6niwfRsc8dzcsVO981J
         PB7KeFxFgGyrLkHzKsnYlsFoiWfYk/NP8AtZu1ZlTO35qqmKGegH0Y6oC8gyopfVm2ys
         VI42qTuEvWmQpDvFzV2mjTv/36fdnr2qNkuGBqbdkJz3Xr+RqsNM5yNIeq/HelPlNPe9
         aQSQ==
X-Gm-Message-State: AOAM533qKJtZLACUepW4Gh4mvQjbJv3HGOivCkvarXHKOYtr2HpjUI+h
        1WnjK1gMBgNDzRDM+gHV9IFexNQb06oNDPaViiw=
X-Google-Smtp-Source: ABdhPJy2Rjw6ADBkJ+lIiEYOqiVz6E18OPO6lkBkrDzxTPxAMQHQKE8JuBbWWGut2WpChG+sfTItV9q14L0SxTeqJBw=
X-Received: by 2002:a5e:9309:: with SMTP id k9mr8925467iom.135.1594803343386;
 Wed, 15 Jul 2020 01:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200714023836.2310569-1-nivedita@alum.mit.edu> <20200715004133.1430068-5-nivedita@alum.mit.edu>
In-Reply-To: <20200715004133.1430068-5-nivedita@alum.mit.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 15 Jul 2020 10:55:32 +0200
Message-ID: <CA+icZUWkPH8-4bGjVhNDyO4LqrSXqF5g9Fbh0bJo7kVhxC916Q@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] x86/boot: Add .text.* to setup.ld
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 2:41 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> gcc puts the main function into .text.startup when compiled with -Os (or
> -O2). This results in arch/x86/boot/main.c having a .text.startup
> section which is currently not included explicitly in the linker script
> setup.ld in the same directory.
>
> The BFD linker places this orphan section immediately after .text, so
> this still works. However, LLD git, since [1], is choosing to place it
> immediately after the .bstext section instead (this is the first code
> section). This plays havoc with the section layout that setup.elf
> requires to create the setup header, for eg on 64-bit:
>
>     LD      arch/x86/boot/setup.elf
>   ld.lld: error: section .text.startup file range overlaps with .header
>   >>> .text.startup range is [0x200040, 0x2001FE]
>   >>> .header range is [0x2001EF, 0x20026B]
>
>   ld.lld: error: section .header file range overlaps with .bsdata
>   >>> .header range is [0x2001EF, 0x20026B]
>   >>> .bsdata range is [0x2001FF, 0x200398]
>
>   ld.lld: error: section .bsdata file range overlaps with .entrytext
>   >>> .bsdata range is [0x2001FF, 0x200398]
>   >>> .entrytext range is [0x20026C, 0x2002D3]
>
>   ld.lld: error: section .text.startup virtual address range overlaps
>   with .header
>   >>> .text.startup range is [0x40, 0x1FE]
>   >>> .header range is [0x1EF, 0x26B]
>
>   ld.lld: error: section .header virtual address range overlaps with
>   .bsdata
>   >>> .header range is [0x1EF, 0x26B]
>   >>> .bsdata range is [0x1FF, 0x398]
>
>   ld.lld: error: section .bsdata virtual address range overlaps with
>   .entrytext
>   >>> .bsdata range is [0x1FF, 0x398]
>   >>> .entrytext range is [0x26C, 0x2D3]
>
>   ld.lld: error: section .text.startup load address range overlaps with
>   .header
>   >>> .text.startup range is [0x40, 0x1FE]
>   >>> .header range is [0x1EF, 0x26B]
>
>   ld.lld: error: section .header load address range overlaps with
>   .bsdata
>   >>> .header range is [0x1EF, 0x26B]
>   >>> .bsdata range is [0x1FF, 0x398]
>
>   ld.lld: error: section .bsdata load address range overlaps with
>   .entrytext
>   >>> .bsdata range is [0x1FF, 0x398]
>   >>> .entrytext range is [0x26C, 0x2D3]
>
> Add .text.* to the .text output section to fix this, and also prevent
> any future surprises if the compiler decides to create other such
> sections.
>
> [1] https://reviews.llvm.org/D75225
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Fangrui Song <maskray@google.com>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

> ---
>  arch/x86/boot/setup.ld | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
> index 24c95522f231..49546c247ae2 100644
> --- a/arch/x86/boot/setup.ld
> +++ b/arch/x86/boot/setup.ld
> @@ -20,7 +20,7 @@ SECTIONS
>         .initdata       : { *(.initdata) }
>         __end_init = .;
>
> -       .text           : { *(.text) }
> +       .text           : { *(.text .text.*) }
>         .text32         : { *(.text32) }
>
>         . = ALIGN(16);
> --
> 2.26.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200715004133.1430068-5-nivedita%40alum.mit.edu.
