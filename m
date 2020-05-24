Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E16C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33282076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ALJxHnzX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbgEXWNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 18:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387850AbgEXWNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 18:13:31 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E93C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 15:13:31 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id n15so8060776pfd.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 15:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2tLotsYCPUeHq+EC4OZ2nCQeyCiq7TXwLeRalL2UPHk=;
        b=ALJxHnzXD6u3Xh9kh5uyarx37KeGNeq7fV7VYD4fxkXGvzCx1OEdUMQG4e+FN2iIpY
         ZMf6gFxhderJTO5gLY/bOYg6B5su2IzY8Hk/zEb5rd3PHLcSI5f9ZjPYnwGWdMLv/tQW
         jVg0uFbn4KJnhubHRVkTG37nd6RkkW+TW6kBjXVuKpGeEKjwTFAuqq1p3zjgtt5/+Ya0
         DZ6lSOlQIz5BADOLOsIDzRgYB/uTVkacylLOBZq/mz0lv7LlRPsF6jWFdAQPjmHzGz2s
         CNMOzkpFBcb4udvFMgKS4uKNapy2ipLVmjEoUrC2cIbtSOjw4igN9O7ZyCcpteIPorg/
         356w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2tLotsYCPUeHq+EC4OZ2nCQeyCiq7TXwLeRalL2UPHk=;
        b=S8MB2X9SYpYB8QF4EYgeDbWYWDzEfB2ORmAj/1QmHS9Cx/6kMONSk2VvlrO9tzBa1R
         XQKUNDnLaWqMSKxlKh4T9BFVLvWX34fVcBpfkm3hB8kR/lH8Yr4D3SAuVaElF1Ma8QM3
         CMpMiSmC5SgDLOroeWPZpRGjgs9UT6+6hU+47+tf+4Kbqiro8KGqJQL5OsnBGAK4p799
         X5Nyn1LgJqOVJj5GT5ydATmgBlHUd8V3Yf/osTKQUgCizF0Bz3RJqpUnxyFDxNGR0n2N
         ZlyE4P69F0E6u/0aSv76n6c4pwKp9sYP8/jMxyTzmafqC1GsIAQ0epN6bFMLq8Bw2RkR
         2K8w==
X-Gm-Message-State: AOAM531V1eiTKMcTJQ67C2mSCuVONm07iC0TMOMrInxeB/0Nxyu4HOZZ
        4u2jti8iYhTbUV36YU2UFbk6KQ==
X-Google-Smtp-Source: ABdhPJyD2ygP3HHWXFRI2ICeQgnbVaXMmbC3/r49TruM+KtN6I2ykB9NVBp+n18nUNz8uiAbWryagw==
X-Received: by 2002:aa7:8483:: with SMTP id u3mr14642476pfn.223.1590358410725;
        Sun, 24 May 2020 15:13:30 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id o190sm10706108pfb.178.2020.05.24.15.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 15:13:30 -0700 (PDT)
Date:   Sun, 24 May 2020 15:13:26 -0700
From:   Fangrui Song <maskray@google.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] x86/boot: Add .text.startup to setup.ld
Message-ID: <20200524221326.zo6zthdqecm2ke5t@google.com>
References: <CAKwvOd=qB+EoJwfAYUA9Hg7f9op4Q4W+TDnht8pLRG5bPX=29Q@mail.gmail.com>
 <20200524212816.243139-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200524212816.243139-2-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-24, Arvind Sankar wrote:
>gcc puts the main function into .text.startup when compiled with -Os (or
>-O2). This results in arch/x86/boot/main.c having a .text.startup
>section which is currently not included explicitly in the linker script
>setup.ld in the same directory.
>
>The BFD linker places this orphan section immediately after .text, so
>this still works. However, LLD git, since [1], is choosing to place it
>immediately after the .bstext section instead (this is the first code
>section). This plays havoc with the section layout that setup.elf
>requires to create the setup header, for eg on 64-bit:
>
>    LD      arch/x86/boot/setup.elf
>  ld.lld: error: section .text.startup file range overlaps with .header
>  >>> .text.startup range is [0x200040, 0x2001FE]
>  >>> .header range is [0x2001EF, 0x20026B]
>
>  ld.lld: error: section .header file range overlaps with .bsdata
>  >>> .header range is [0x2001EF, 0x20026B]
>  >>> .bsdata range is [0x2001FF, 0x200398]
>
>  ld.lld: error: section .bsdata file range overlaps with .entrytext
>  >>> .bsdata range is [0x2001FF, 0x200398]
>  >>> .entrytext range is [0x20026C, 0x2002D3]
>
>  ld.lld: error: section .text.startup virtual address range overlaps
>  with .header
>  >>> .text.startup range is [0x40, 0x1FE]
>  >>> .header range is [0x1EF, 0x26B]
>
>  ld.lld: error: section .header virtual address range overlaps with
>  .bsdata
>  >>> .header range is [0x1EF, 0x26B]
>  >>> .bsdata range is [0x1FF, 0x398]
>
>  ld.lld: error: section .bsdata virtual address range overlaps with
>  .entrytext
>  >>> .bsdata range is [0x1FF, 0x398]
>  >>> .entrytext range is [0x26C, 0x2D3]
>
>  ld.lld: error: section .text.startup load address range overlaps with
>  .header
>  >>> .text.startup range is [0x40, 0x1FE]
>  >>> .header range is [0x1EF, 0x26B]
>
>  ld.lld: error: section .header load address range overlaps with
>  .bsdata
>  >>> .header range is [0x1EF, 0x26B]
>  >>> .bsdata range is [0x1FF, 0x398]
>
>  ld.lld: error: section .bsdata load address range overlaps with
>  .entrytext
>  >>> .bsdata range is [0x1FF, 0x398]
>  >>> .entrytext range is [0x26C, 0x2D3]
>
>Explicitly pull .text.startup into the .text output section to avoid
>this.
>
>[1] https://reviews.llvm.org/D75225
>
>Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
>Reviewed-by: Fangrui Song <maskray@google.com>
>---
> arch/x86/boot/setup.ld | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
>index 24c95522f231..ed60abcdb089 100644
>--- a/arch/x86/boot/setup.ld
>+++ b/arch/x86/boot/setup.ld
>@@ -20,7 +20,7 @@ SECTIONS
> 	.initdata	: { *(.initdata) }
> 	__end_init = .;
>
>-	.text		: { *(.text) }
>+	.text		: { *(.text.startup) *(.text) }
> 	.text32		: { *(.text32) }
>
> 	. = ALIGN(16);
>-- 
>2.26.2

Should .text.startup* be used instead? If -ffunction-sections is used,

// a.c
int main() {}

gcc -O2 a.c                     # .text.startup
gcc -Os a.c                     # .text.startup

gcc -O2 -ffunction-sections a.c # .text.startup.main
gcc -Os -ffunction-sections a.c # .text.startup.main

-----

In case anyone wants to CC a GCC dev for the citation that 
  main compiles to `.text.startup` in -Os or -O2 mode, I have a small request
  that `.text.startup.` probably makes more sense. See

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=95095

I made an llvm change recently https://reviews.llvm.org/D79600
