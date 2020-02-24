Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44823C38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14D1F20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SBZiUn5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgBXVMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:12:14 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37377 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgBXVMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:12:14 -0500
Received: by mail-pl1-f194.google.com with SMTP id q4so424441pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 13:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dUAjplDFzu3ykSROh7BG5jWZWZQaw9t0lPRoNsXFBrw=;
        b=SBZiUn5x2qPHxXbX7IskwykcwAT9WwDybjt00KJzNaAOKlwi+4Vzhl72YxUHH4yrKC
         7+obNJonOhX6zUTYnq6PA5RuHa94pr/eVaIiUiZrKBUGFi56tiT7g/M0K9O3r2Y719DC
         c88nS05MhdbQ77vKHCDcy1aiAjZPxpYEvEIPbDU5sA9MzhI5C8fYfdiH4ojnr9DzLgAM
         AK8HWXtMoerrGsolOSxCgbHu5U6TCLGhOvEb+yEGvKHFjBl5snNx+uQ1DXPIYGCDupTG
         VclYIaQ47bRvVceNoZKeYaVkAKwePRcXK5mI2GgbosLbWCqQwP6jsuDZM200Xd1psQvP
         1PaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dUAjplDFzu3ykSROh7BG5jWZWZQaw9t0lPRoNsXFBrw=;
        b=g/RBnsgZVtaB8lQv7tkvrduSGYYjprAT885SrlWngBnMj4xCKucfSlz8ediLPfxMDi
         Vq5r/46+AU5/+RXb4rhazco8nwOkyYy3EbRMeMRvwbhM+TnSQqhCgHjOeBxjru753P5t
         GdImSX2YSkUfe8eZfns/laHAzBDaCtCiT8O5OfW6TE+l3CPLzrGNLGN7nLmoJsWxGj81
         TdOS/MnFx57Ah5SCXAJx3ds7gsuFhans1uHmF6NAkXjh/dDbhzhZkdPwoPTTFB74gxoR
         u/UzP0tAUNP8Qddjl4Ine/iW1rMfPN+42rS7IrhC2sns/ii+6NZHH0DiFPDLF61+1LNu
         p43A==
X-Gm-Message-State: APjAAAX/43rywJPXfJaD4mGXiATDQ3A0TbAJt6a2WCpopuQW4us5PxtK
        fkXNXdaVG4kUvcC+HPHSLaNvWA==
X-Google-Smtp-Source: APXvYqyX8KcH3LWzbbHaFS+z+qG6xxTMYHwSh0eZWkdxnm2M7s0NfAvDQa8knTYqKZEeRVtRoBBCUQ==
X-Received: by 2002:a17:90a:d585:: with SMTP id v5mr1164717pju.4.1582578733019;
        Mon, 24 Feb 2020 13:12:13 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id g10sm14267981pfo.166.2020.02.24.13.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 13:12:12 -0800 (PST)
Date:   Mon, 24 Feb 2020 13:12:09 -0800
From:   Fangrui Song <maskray@google.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] arch/x86: Use -fno-asynchronous-unwind-tables to
 suppress .eh_frame sections
Message-ID: <20200224211209.3snqf7atf5h4ywcr@google.com>
References: <20200222235709.GA3786197@rani.riverdale.lan>
 <20200223193715.83729-2-nivedita@alum.mit.edu>
 <CAKwvOdniNba30cUX9QAZdVPg2MhjVETVgrvUUzwaHF70Dr3PrQ@mail.gmail.com>
 <20200224210522.GA409112@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200224210522.GA409112@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-24, Arvind Sankar wrote:
>On Mon, Feb 24, 2020 at 12:33:49PM -0800, Nick Desaulniers wrote:
>> On Sun, Feb 23, 2020 at 11:37 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>> >
>> > While discussing a patch to discard .eh_frame from the compressed
>> > vmlinux using the linker script, Fangrui Song pointed out [1] that these
>> > sections shouldn't exist in the first place because arch/x86/Makefile
>> > uses -fno-asynchronous-unwind-tables.
>>
>> Another benefit is that -fno-asynchronous-unwind-tables may help
>> reduce the size of .text!
>> https://stackoverflow.com/a/26302715/1027966
>
>Hm I don't see any change in .text size.
>> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
>> > index 98a81576213d..a1140c4ee478 100644
>> > --- a/drivers/firmware/efi/libstub/Makefile
>> > +++ b/drivers/firmware/efi/libstub/Makefile
>> > @@ -12,7 +12,8 @@ cflags-$(CONFIG_X86)          += -m$(BITS) -D__KERNEL__ -O2 \
>> >                                    -mno-mmx -mno-sse -fshort-wchar \
>> >                                    -Wno-pointer-sign \
>> >                                    $(call cc-disable-warning, address-of-packed-member) \
>> > -                                  $(call cc-disable-warning, gnu)
>> > +                                  $(call cc-disable-warning, gnu) \
>> > +                                  -fno-asynchronous-unwind-tables
>>
>> I think we want to add this flag a little lower, line 27 has:
>>
>> KBUILD_CFLAGS     := $(cflags-y) -DDISABLE_BRANCH_PROFILING \
>>
>> so the `cflags-y` variable you modify in this hunk will only set
>> -fno-asynchronous-unwind-tables for CONFIG_X86, which I don't think is
>> intentional.  Though when I run
>
>It is intentional -- the other case is that we're building for ARM,
>which only filters out the regular KBUILD_CFLAGS, so adding the flag for
>it should not be necessary. The cflags for ARM are constructed by
>manipulating KBUILD_CFLAGS. Besides it may or may not want unwind
>tables. 32-bit ARM appears to have an option to enable -funwind-tables.

clang (as of today) has not implemented the
-funwind-tables/-fasynchronous-unwind-tables distinction as GCC does..
(probably because not many people care..)

>>
>> $ llvm-readelf -S drivers/firmware/efi/libstub/lib.a | grep eh_frame
>>
>> after doing an x86_64 defconfig, I don't get any hits. Do you observe
>> .eh_frame sections on any of these objects in this dir? (I'm fine
>> adding it to be safe, but I'm curious why I'm not seeing any
>> .eh_frame)
>>
>
>You mean before this patch, right? I see hits on every .o file in there
>(compiling with gcc 9.2.0).
>
>> >
>> >  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
>> >  # disable the stackleak plugin
>> > --
>> > 2.24.1
>> >
