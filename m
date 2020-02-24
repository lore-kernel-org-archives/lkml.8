Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDB7C38BE2
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71900218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 20:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OczUm8C+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbgBXUtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 15:49:17 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34021 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbgBXUtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 15:49:16 -0500
Received: by mail-pf1-f193.google.com with SMTP id i6so5967285pfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 12:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Knih+VN2aCDc/a1HoFO7myAtDlhjV/MlW8P0R3Lsz6k=;
        b=OczUm8C+dyhkoniILj5vfVY4thaCbz21wL2o4W1iPYLN9C4renHakPjsF0wN0R7/PK
         ROPGME4HFALbizqzw1uzuow6v90oO21JNpQ0Hr7lrx+A0wR64NqvDttBrP4paCpdWnJb
         lOLBYJKGbEys0X6LmeU5FRf/32pR3JtoRkOVvDP57MCLKY9KimfY+2nzfYJEmKoNRBYJ
         /h6lqh0bL7uHCyZcI/GWe7et69cavIHc2Z8/zf1f2QCxsl5E4QCUwqtxu2quIDIDBgfQ
         nUtI6hXUyfh3TWoZCpwPyFAfAnEo+DBDvtiD0vepaVwWYKW+1vr6W6KOI+b1XU/sur8P
         TwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Knih+VN2aCDc/a1HoFO7myAtDlhjV/MlW8P0R3Lsz6k=;
        b=tYi6YsJjZ+BNp/+ZggdaGIl2MobmtOZvXlVNyMUnLKLKqexp3gAusyt8H8UaQj/0o9
         ZmJuaWhp84m+N+Qm9ZZVqY2RKz8/2bk1ufdI52ffNNIbDs0yACrmI/AAez1pvp6vL1H0
         iKN1qw8+Z6bP18q1teg4C0+Yu2wX693U6rEOYae7wiiWrexavZICIBpwGRxTV3ETv++k
         NPgDcrWnSoHmceqiHAReoeKZN4I7C1mduCPHw6fmTyDLHRCYF0Vjxcfg7IW7tgunE6E8
         MklDeiND7CMcVV9eHnHiDTB/rDbNOayVHO3KdAs3ehz4lHvD4hQoO8ZGQ7GtawbjfPRK
         kRBw==
X-Gm-Message-State: APjAAAWV7RqmbuHvKZHhqHnxyqLt5WgOGslsQQfl/eYFEOyPaJwshMQI
        BKhUdyumAKHQOhapcPqn4el9T4MTUzCYDZnuRii5bg==
X-Google-Smtp-Source: APXvYqw/5xtBB4M8e/Uzl06X/DNHHJ4sVpSAPy5BInZBQUvOdUmCLpLw5WP2Xnfzc1QQidBPvN+2ZD6FIeRUpJsUdTc=
X-Received: by 2002:a63:4453:: with SMTP id t19mr17312657pgk.381.1582577354652;
 Mon, 24 Feb 2020 12:49:14 -0800 (PST)
MIME-Version: 1.0
References: <20200222235709.GA3786197@rani.riverdale.lan> <20200223193715.83729-1-nivedita@alum.mit.edu>
In-Reply-To: <20200223193715.83729-1-nivedita@alum.mit.edu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 24 Feb 2020 12:49:03 -0800
Message-ID: <CAKwvOd=qVmb7UEzUSQ5-MUhpRA9Jpu3fMmmMLGdmydLoJV-kkQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Stop generating .eh_frame sections
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Borislav Petkov <bp@alien8.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 11:37 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> In three places in the x86 kernel we are currently generating .eh_frame
> sections only to discard them later via linker script. This is in the
> boot code (setup.elf), the realmode trampoline (realmode.elf) and the
> compressed kernel.
>
> Implement Fangrui and Nick's suggestion [1] to fix KBUILD_CFLAGS by
> adding -fno-asynchronous-unwind-tables to avoid generating .eh_frame
> sections in the first place, rather than discarding it in the linker
> script.
>
> Arvind Sankar (2):
>   arch/x86: Use -fno-asynchronous-unwind-tables to suppress .eh_frame sections
>   arch/x86: Drop unneeded linker script discard of .eh_frame

Thanks for the series! I've left some feedback for a v2. Would you
mind please including a revert of ("x86/boot/compressed: Remove
unnecessary sections from bzImage") in a v2 series?  Our CI being red
through the weekend is no bueno.

>
>  arch/x86/boot/Makefile                | 1 +
>  arch/x86/boot/compressed/Makefile     | 1 +
>  arch/x86/boot/setup.ld                | 1 -
>  arch/x86/kernel/vmlinux.lds.S         | 3 ---
>  arch/x86/realmode/rm/Makefile         | 1 +
>  arch/x86/realmode/rm/realmode.lds.S   | 1 -
>  drivers/firmware/efi/libstub/Makefile | 3 ++-
>  7 files changed, 5 insertions(+), 6 deletions(-)
>
> --
> 2.24.1
>


-- 
Thanks,
~Nick Desaulniers
