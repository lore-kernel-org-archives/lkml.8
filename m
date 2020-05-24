Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E6AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD4F2076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZMp4pKiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388455AbgEXXth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 19:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388124AbgEXXtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 19:49:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CFCC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:49:36 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r10so7924792pgv.8
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ESumRBe9TIyOOMkHD+jslTQBV+iCmU03AWMD85ZvEjg=;
        b=ZMp4pKiQxLFMc7RHwEqUNBFQj6VkgRkIhbEBk4NDliCEsdRZ4GJv3a7HQx+GgIIrER
         6eswjlvJD9zxF3iOoHIVvq5THVOxXiweB6YUx8BAL+aifCg7E67Q5MzXLZxHvuao0470
         b7UffLco31BW55sJHVJSX1gr74znUzF6qWrm6wTHoJY03IDueAFK4MOEH00Nr+Zodbta
         CUcYywr7BIuJyL37YudlgKJ/QZWvLfsoTPQGmCsxW1UuZ/wKg2MIJ/d75ft2SItHIAPy
         +v4recEvB4y+WFhdvguxgRf3FI+HL30uiJA3mN3fzwDmzGbQoxPb8iCGK6lVtwOnSCdH
         2ucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ESumRBe9TIyOOMkHD+jslTQBV+iCmU03AWMD85ZvEjg=;
        b=cTAadTfMGz/ClZcIyvzhZw5sfiRoy2+RZYrQjC1jYt3Rw3WsIL89hZVvPoAYYL0GUo
         KsORHCyKMDqO8bxkRAnD33t35ApOnwOvG/Lue7O+Xnt4ZAG70C5s7SJYHdsQ5oSNGi3S
         EeQF6xrMxEuyolSRGOVtHVr81ARnmxhHCeXECnuQQ9SJCIKNgVl8kuHa+hmIimd7bTUN
         S1u+q2cj+ubps8XW7LGX9j7CrtogMHutwadsRQd70XRPVGESh7gu30p6mTNXR+R1v+Oj
         7z9GeR/IpVMwsbrbfAtquA+eZSD3JBv7mDGxI2/XWXv5NKO8k8G6tXsoFuVe4gxg/mYP
         UVqw==
X-Gm-Message-State: AOAM533uXDflsisucWrwTKS0DeQUKSRtpu62chDolkSQMOajmwqjPZ9u
        aYp2p5ZfMzsG+T3Fc4bcBbCD5A==
X-Google-Smtp-Source: ABdhPJwX5X3pPaZlfkN+kDeCnnVXPTjPNozsMmG+s8/7WpyLaIuIKLnZohhxma+O97opdNeMW3VUIg==
X-Received: by 2002:a63:5f11:: with SMTP id t17mr23359768pgb.177.1590364175509;
        Sun, 24 May 2020 16:49:35 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id k4sm3628240pfp.173.2020.05.24.16.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 16:49:34 -0700 (PDT)
Date:   Sun, 24 May 2020 16:49:31 -0700
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
Message-ID: <20200524234931.onovv64vjvrsfj33@google.com>
References: <CAKwvOd=qB+EoJwfAYUA9Hg7f9op4Q4W+TDnht8pLRG5bPX=29Q@mail.gmail.com>
 <20200524212816.243139-2-nivedita@alum.mit.edu>
 <20200524221326.zo6zthdqecm2ke5t@google.com>
 <20200524230054.GA280334@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200524230054.GA280334@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-24, Arvind Sankar wrote:
>On Sun, May 24, 2020 at 03:13:26PM -0700, Fangrui Song wrote:
>> On 2020-05-24, Arvind Sankar wrote:
>> >gcc puts the main function into .text.startup when compiled with -Os (or
>> >-O2). This results in arch/x86/boot/main.c having a .text.startup
>> >section which is currently not included explicitly in the linker script
>> >setup.ld in the same directory.
>> >
>> >The BFD linker places this orphan section immediately after .text, so
>> >this still works. However, LLD git, since [1], is choosing to place it
>> >immediately after the .bstext section instead (this is the first code
>> >section). This plays havoc with the section layout that setup.elf
>> >requires to create the setup header, for eg on 64-bit:
>> >
>> >    LD      arch/x86/boot/setup.elf
>> >  ld.lld: error: section .text.startup file range overlaps with .header
>> >  >>> .text.startup range is [0x200040, 0x2001FE]
>> >  >>> .header range is [0x2001EF, 0x20026B]
>> >
>> >  ld.lld: error: section .header file range overlaps with .bsdata
>> >  >>> .header range is [0x2001EF, 0x20026B]
>> >  >>> .bsdata range is [0x2001FF, 0x200398]
>> >
>> >  ld.lld: error: section .bsdata file range overlaps with .entrytext
>> >  >>> .bsdata range is [0x2001FF, 0x200398]
>> >  >>> .entrytext range is [0x20026C, 0x2002D3]
>> >
>> >  ld.lld: error: section .text.startup virtual address range overlaps
>> >  with .header
>> >  >>> .text.startup range is [0x40, 0x1FE]
>> >  >>> .header range is [0x1EF, 0x26B]
>> >
>> >  ld.lld: error: section .header virtual address range overlaps with
>> >  .bsdata
>> >  >>> .header range is [0x1EF, 0x26B]
>> >  >>> .bsdata range is [0x1FF, 0x398]
>> >
>> >  ld.lld: error: section .bsdata virtual address range overlaps with
>> >  .entrytext
>> >  >>> .bsdata range is [0x1FF, 0x398]
>> >  >>> .entrytext range is [0x26C, 0x2D3]
>> >
>> >  ld.lld: error: section .text.startup load address range overlaps with
>> >  .header
>> >  >>> .text.startup range is [0x40, 0x1FE]
>> >  >>> .header range is [0x1EF, 0x26B]
>> >
>> >  ld.lld: error: section .header load address range overlaps with
>> >  .bsdata
>> >  >>> .header range is [0x1EF, 0x26B]
>> >  >>> .bsdata range is [0x1FF, 0x398]
>> >
>> >  ld.lld: error: section .bsdata load address range overlaps with
>> >  .entrytext
>> >  >>> .bsdata range is [0x1FF, 0x398]
>> >  >>> .entrytext range is [0x26C, 0x2D3]
>> >
>> >Explicitly pull .text.startup into the .text output section to avoid
>> >this.
>> >
>> >[1] https://reviews.llvm.org/D75225
>> >
>> >Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
>> >Reviewed-by: Fangrui Song <maskray@google.com>
>> >---
>> > arch/x86/boot/setup.ld | 2 +-
>> > 1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> >diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
>> >index 24c95522f231..ed60abcdb089 100644
>> >--- a/arch/x86/boot/setup.ld
>> >+++ b/arch/x86/boot/setup.ld
>> >@@ -20,7 +20,7 @@ SECTIONS
>> > 	.initdata	: { *(.initdata) }
>> > 	__end_init = .;
>> >
>> >-	.text		: { *(.text) }
>> >+	.text		: { *(.text.startup) *(.text) }
>> > 	.text32		: { *(.text32) }
>> >
>> > 	. = ALIGN(16);
>> >--
>> >2.26.2
>>
>> Should .text.startup* be used instead? If -ffunction-sections is used,
>>
>> // a.c
>> int main() {}
>>
>> gcc -O2 a.c                     # .text.startup
>> gcc -Os a.c                     # .text.startup
>>
>> gcc -O2 -ffunction-sections a.c # .text.startup.main
>> gcc -Os -ffunction-sections a.c # .text.startup.main
>
>It's probably unlikely we'll use function-sections on the setup code,
>but *(.text.*) might be more future-proof, since gcc/clang might grow
>the ability to stick code into .text.hot or .text.unlikely etc
>automatically.

*(.text.*) looks good to me. When you send PATCH v2, feel free to add

(There is indeed no guarantee that future clang FDO will not place it .text.unknown. :)

Reviewed-by: Fangrui Song <maskray@google.com>

>>
>> -----
>>
>> In case anyone wants to CC a GCC dev for the citation that
>>   main compiles to `.text.startup` in -Os or -O2 mode, I have a small request
>>   that `.text.startup.` probably makes more sense. See
>>
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=95095
>>
>> I made an llvm change recently https://reviews.llvm.org/D79600
