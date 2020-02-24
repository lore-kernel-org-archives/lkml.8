Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0C2C38BE6
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18EC52176D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrMS23gO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgBXVF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:05:26 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:44718 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgBXVF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:05:26 -0500
Received: by mail-qv1-f65.google.com with SMTP id n8so4748846qvg.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 13:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cSmpO0UrVcE+2EXGicwP6bV9bb5FnRrk6s8yuew8veA=;
        b=WrMS23gOBdcq4tHWEAeYjC97mxBP5x7c3tu2iiQPlG7Znem5mWDxJ3diVV6PnlGdUk
         Dbd+LcBBuy2AMoX4PbRHc0GbZellmQMlq/YLjrcg/wYL7aY3nyhnebbr8FZNcZ7rMd9v
         VoTbCYjY3SHRmCnDJIkdemladqulgCk/I2eZnDuc6MNbt5iM7CW4d/25GCOJES9cCXfv
         QARANAyaSXXnW/IdhSTPBOq037LlTSpvBbCzuA33aX8Nj1ROODS5dSXWFcS7Wy5N/TkC
         8ZwNrkNoiissoz1vlkpLP1Ex7966jUQ+hpm3TWzQvWzmACNaSROP5D5+UlagR83lxR35
         GloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cSmpO0UrVcE+2EXGicwP6bV9bb5FnRrk6s8yuew8veA=;
        b=rQ79a7+bYPlW074q6w+j5pdj3a+jOyXnAoMc9XI4r0JnphVCNixzSiApc2unLQaTLB
         RP9Kp+DHBK6CmQN9yGxN4HbhIqcRJOQ6KItsrFiAGyyN7aoX075zdKf/lFT6YzRw1ptx
         Npqge5nMaMAjWMzMa705Wl2iUmL4CS4gMwAsj77n1hgBlR9VeTYhQJXt8kYI98kBd/DM
         Hm2AveB131EH6D8GttHryE9HXBJAU1gI/0pw1P7oZsjOkbajS9GhAFoaEf19p1vFezh5
         Q8UPDjAcLyUAi/JqlABSCRMXEcH1gpHtmHkFry7lmYlN7Pa9Toi2llVHYeljLNpCgtY+
         C+UA==
X-Gm-Message-State: APjAAAWNU5FMFCn27v86uFCDZrdxCHpJ6aYq0eWjGjRlZ7Hxb4UM3vF4
        Ke1FM5/kInaQlL+TOcdvMzs=
X-Google-Smtp-Source: APXvYqwlXcwbG9vgLfXHk8Soi8TEEyPIL0Py2+dyXKiQkCPkTJzjfgewjaqlmC02S2lLj/p31axZGA==
X-Received: by 2002:a0c:9d4f:: with SMTP id n15mr47503323qvf.194.1582578324649;
        Mon, 24 Feb 2020 13:05:24 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a141sm6489195qkb.50.2020.02.24.13.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 13:05:24 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 24 Feb 2020 16:05:22 -0500
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 1/2] arch/x86: Use -fno-asynchronous-unwind-tables to
 suppress .eh_frame sections
Message-ID: <20200224210522.GA409112@rani.riverdale.lan>
References: <20200222235709.GA3786197@rani.riverdale.lan>
 <20200223193715.83729-2-nivedita@alum.mit.edu>
 <CAKwvOdniNba30cUX9QAZdVPg2MhjVETVgrvUUzwaHF70Dr3PrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdniNba30cUX9QAZdVPg2MhjVETVgrvUUzwaHF70Dr3PrQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 12:33:49PM -0800, Nick Desaulniers wrote:
> On Sun, Feb 23, 2020 at 11:37 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > While discussing a patch to discard .eh_frame from the compressed
> > vmlinux using the linker script, Fangrui Song pointed out [1] that these
> > sections shouldn't exist in the first place because arch/x86/Makefile
> > uses -fno-asynchronous-unwind-tables.
> 
> Another benefit is that -fno-asynchronous-unwind-tables may help
> reduce the size of .text!
> https://stackoverflow.com/a/26302715/1027966

Hm I don't see any change in .text size.
> > diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> > index 98a81576213d..a1140c4ee478 100644
> > --- a/drivers/firmware/efi/libstub/Makefile
> > +++ b/drivers/firmware/efi/libstub/Makefile
> > @@ -12,7 +12,8 @@ cflags-$(CONFIG_X86)          += -m$(BITS) -D__KERNEL__ -O2 \
> >                                    -mno-mmx -mno-sse -fshort-wchar \
> >                                    -Wno-pointer-sign \
> >                                    $(call cc-disable-warning, address-of-packed-member) \
> > -                                  $(call cc-disable-warning, gnu)
> > +                                  $(call cc-disable-warning, gnu) \
> > +                                  -fno-asynchronous-unwind-tables
> 
> I think we want to add this flag a little lower, line 27 has:
> 
> KBUILD_CFLAGS     := $(cflags-y) -DDISABLE_BRANCH_PROFILING \
> 
> so the `cflags-y` variable you modify in this hunk will only set
> -fno-asynchronous-unwind-tables for CONFIG_X86, which I don't think is
> intentional.  Though when I run

It is intentional -- the other case is that we're building for ARM,
which only filters out the regular KBUILD_CFLAGS, so adding the flag for
it should not be necessary. The cflags for ARM are constructed by
manipulating KBUILD_CFLAGS. Besides it may or may not want unwind
tables. 32-bit ARM appears to have an option to enable -funwind-tables.

> 
> $ llvm-readelf -S drivers/firmware/efi/libstub/lib.a | grep eh_frame
> 
> after doing an x86_64 defconfig, I don't get any hits. Do you observe
> .eh_frame sections on any of these objects in this dir? (I'm fine
> adding it to be safe, but I'm curious why I'm not seeing any
> .eh_frame)
> 

You mean before this patch, right? I see hits on every .o file in there
(compiling with gcc 9.2.0).

> >
> >  # arm64 uses the full KBUILD_CFLAGS so it's necessary to explicitly
> >  # disable the stackleak plugin
> > --
> > 2.24.1
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
