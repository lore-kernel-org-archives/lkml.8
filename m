Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E09C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454A92080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWziM6BR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbgAMQNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:13:14 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35371 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgAMQNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:13:13 -0500
Received: by mail-qt1-f195.google.com with SMTP id e12so9556399qto.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 08:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Clzqp1lYCmby8RirhKJ3Zrql52eAYFS0ZrEwzMN4oik=;
        b=PWziM6BR0n/WTn6Gm6JVdqTvpvicF/gPbMppkPcZLclUymy3YLhSe6kLQI/dQbPCBt
         DFkXpvqPYd7XyA8zKcy8TaEak/C1C7FmFbY5CdyVS2ZcvI0uqFW87TDSz/LSq25FITUB
         KlZKu538luJFMOAspGgpOnqbue1DAoJ7dl49DJC0/pQAfuvo1lXmkGHEkuQCG6NROV2L
         E8HygBKOV1T30/EIuZsoxg3DbQfuBT6bfaxr2IgvGPlEDmPwHP6G9dD6sn9eaveRlfUQ
         7LF70Wl2wROJwNuI5pM0v9AWn38DnQka2jcxaWhmQjaNURuCFWJbAGCAWmDIxgsVg0IR
         4LIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Clzqp1lYCmby8RirhKJ3Zrql52eAYFS0ZrEwzMN4oik=;
        b=PtFW2LY6usfHwoIvPyrYsNp5nKOzHu6Ky6COXUSvmZjgsEneyX1bTcSqUISPZj+1Y3
         NNluayO1bTrMP9RbjIwdKd2+GyDFrNknsgewUXdEzTJ1gY9HZCWPUeAahgRKo5Q5c/AV
         fAJhhZpIA0sFk8TNtdzqDAHrwoXIin4wIrtjSfwml0mwWuoAup9gQdvgJ8LEHCPOwa0B
         yiiprKtSp2QoORAkL/nRKVHS5cHMzqh2IAgzC9C7jaTUuhjSL6bVq4B3tTC6Xt27fOuG
         C9FUBmC8KBuGlP+NbMYC9uGGm02YEoRiCSuCdST7lphNrbuPtr0kyVk2jMUzzCMOo06N
         JMsQ==
X-Gm-Message-State: APjAAAWMGfeCmEjkZ2IkUSiJuBcCbFVsBeGul0OLR4gu1WQI3E0HLkBY
        QF42DQzmD49oqN4cy2tHSOA=
X-Google-Smtp-Source: APXvYqwPzPRrVNNFDFE5oq+znlAYrnvCA+QipZNRSlykQ7+6Q4HG4kULl6LUXyiyQX9Pa+dqaQBqFw==
X-Received: by 2002:ac8:6f0b:: with SMTP id g11mr14749371qtv.308.1578931992497;
        Mon, 13 Jan 2020 08:13:12 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id s26sm6061167qtc.43.2020.01.13.08.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 08:13:12 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 13 Jan 2020 11:13:10 -0500
To:     Borislav Petkov <bp@alien8.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Michael Matz <matz@suse.de>
Subject: Re: [PATCH] x86/tools/relocs: Add _etext and __end_of_kernel_reserve
 to S_REL
Message-ID: <20200113161310.GA191743@rani.riverdale.lan>
References: <20200110202349.1881840-1-nivedita@alum.mit.edu>
 <20200110203828.GK19453@zn.tnic>
 <20200110205028.GA2012059@rani.riverdale.lan>
 <20200111130243.GA23583@zn.tnic>
 <20200111172047.GA2688392@rani.riverdale.lan>
 <20200113134306.GF13310@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200113134306.GF13310@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 02:43:06PM +0100, Borislav Petkov wrote:
> On Sat, Jan 11, 2020 at 12:20:48PM -0500, Arvind Sankar wrote:
> > I'm not sure if that's the same issue. The root cause for the one I
> > reported is described in more detail in [1], and the change that makes
> > these symbols no longer absolute is commit d2667025dd30 in binutils-gdb
> > (sourceware.org seems to be taking too long to respond from here so I
> > don't have the web link).
> 
> My binutils guy says that the proper fix should be to make those two
> symbols section-relative, i.e., move _etext at the end of the .text
> section and so on.
> 
> Please check whether this fixes the build issue too because if it does,
> it would be The RightThing(tm).

According to Kees in [1] commit 392bef709659 ("x86/build: Move _etext to
actual end of .text"), keeping _etext inside the .text section was
incorrect in some situations with clang. That commit was later reverted
because it broke old toolchains, and the new commit that did the same
thing commit b907693883fd ("x86/vmlinux: Actually use _etext for the end
of the text segment") does not mention that rationale.

Kees, is it still required to keep _etext out of .text, or can it be
moved back in? If it has to remain outside, 
	_etext = _stext + SIZEOF(.text);
seems to leave _etext as a relative symbol, even though from the
binutils documentation I'd have expected SIZEOF(.text), as a number, to
be treated as an absolute expression outside an output section. Could
you check if that would work for your case?

The __end_of_kernel_reserve can be made relative by just assigning it
__bss_stop instead of the location counter.

I will note that the purpose of S_REL in relocs.c was originally to
handle exactly this case of symbols defined outside output sections:

/*
 * These symbols are known to be relative, even if the linker marks them
 * as absolute (typically defined outside any section in the linker script.)
 */
        [S_REL] =

> 
> > I'm running gentoo, but building the kernel using binutils-2.21.1
> > compiled from the GNU source tarball, and gcc-4.6.4 again compiled from
> > source. (It's not something I normally need but I was investigating
> > something else to see what exactly happens with older toolchains.)
> > 
> > I used the below to compile the kernel (I added in
> > readelf/objdump/objcopy just now, and it does build until the relocs
> > error). The config is x86-64 defconfig with CONFIG_RETPOLINE overridden
> > to n (since gcc 4.6.4 doesn't support retpoline).
> > 
> > make O=~/kernel64 -j LD=~/old/bin/ld AS=~/old/bin/as READELF=~/old/bin/readelf \
> > 	OBJDUMP=~/old/bin/objdump OBJCOPY=~/old/bin/objcopy GCC=~/old/bin/gcc
> 
> Make this all part of your commit message because it explains in detail
> how exactly you've triggered it so that anyone else reading this can
> reproduce her/himself.

How to reproduce is just "build with old binutils". I don't see it's
reasonable to include a tutorial on how to build the kernel with a
toolchain that's not installed in the default PATH, as part of the commit
message.

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

[1] x86/build: Move _etext to actual end of .text

When building x86 with Clang LTO and CFI, CFI jump regions are
automatically added to the end of the .text section late in linking. As a
result, the _etext position was being labelled before the appended jump
regions, causing confusion about where the boundaries of the executable
region actually are in the running kernel, and broke at least the fault
injection code. This moves the _etext mark to outside (and immediately
after) the .text area, as it already the case on other architectures
(e.g. arm64, arm).
