Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA973C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B995208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592326155;
	bh=whW+Qp7psTNhFHe4d6nxYaOM9+Zl8IRIDVXsPpfaoOY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kjO3rKIcvMmPHQfXB+ZnUUrl1Lu9gX4rqAd9YG5Ry1XDbDWskEdEkTpDNG29FVg9p
	 YoFhRUKkoU760x+Pe/bzNitLyKVsi2X/8ntAACS1C4xYQauQc+Esr7sHHHz88+eOfO
	 wjNFcqOXbkP42ggmjTYhKfScUvB8zKHgLyVis8Qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730412AbgFPQtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:46496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbgFPQtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:49:13 -0400
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA170208D5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 16:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592326153;
        bh=whW+Qp7psTNhFHe4d6nxYaOM9+Zl8IRIDVXsPpfaoOY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TIEcIC6S9EGonIcQYyZObnTpBsagbEo+fKRAfxY0mAxs9n6qi+pGHeev+Lz9tX9up
         cx/IoEKuJ88SAlyYBg9x/W52IQQMXy/9X32/mfUJ/FK8aeF4pwKr87w5i26EigbcBp
         qc/qTh2wgMDrHf5g8odoMcP/xNcvO8XhUB1CpsDI=
Received: by mail-wm1-f51.google.com with SMTP id r9so3529109wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:49:12 -0700 (PDT)
X-Gm-Message-State: AOAM532q1GlIjFVvE5uR4WpqgHJdN0XMTDDOWMursAov1qu0E708ev2W
        uOuXZwBQofGJ+N9Epkcbfo5+KfDkyb1upyuIDjGdfQ==
X-Google-Smtp-Source: ABdhPJwF3137Cohdj89nY1g4SCtdj3sUmePOn0NO8Ijm3zn0jOOIFWDxXHVIfD1ze3Xt0hT15EP7nwVuhekIeHxPOKs=
X-Received: by 2002:a05:600c:22da:: with SMTP id 26mr4143349wmg.176.1592326151499;
 Tue, 16 Jun 2020 09:49:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200616142315.375918-1-brgerst@gmail.com> <20200616142315.375918-2-brgerst@gmail.com>
In-Reply-To: <20200616142315.375918-2-brgerst@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 16 Jun 2020 09:49:00 -0700
X-Gmail-Original-Message-ID: <CALCETrXUjM9g2e5v7chFXWoadvUO_7cqhGvuFn2s7YVpyff__Q@mail.gmail.com>
Message-ID: <CALCETrXUjM9g2e5v7chFXWoadvUO_7cqhGvuFn2s7YVpyff__Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/x32: Use __x64 prefix for X32 compat syscalls
To:     Brian Gerst <brgerst@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 7:23 AM Brian Gerst <brgerst@gmail.com> wrote:
>
> The ABI prefix for syscalls specifies the argument register mapping, so
> there is no specific reason to continue using the __x32 prefix for the
> compat syscalls.  This change will allow using native syscalls in the X32
> specific portion of the syscall table.

Okay, I realize that the x86 syscall machinery is held together by
duct tape and a lot of luck, but:

>
> Signed-off-by: Brian Gerst <brgerst@gmail.com>
> ---
>  arch/x86/entry/syscall_x32.c           |  8 +++-----
>  arch/x86/include/asm/syscall_wrapper.h | 10 +++++-----
>  2 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
> index 3d8d70d3896c..f993e6254043 100644
> --- a/arch/x86/entry/syscall_x32.c
> +++ b/arch/x86/entry/syscall_x32.c
> @@ -9,15 +9,13 @@
>  #include <asm/syscall.h>
>
>  #define __SYSCALL_64(nr, sym)
> +#define __SYSCALL_COMMON(nr, sym) __SYSCALL_X32(nr, sym)
>
> -#define __SYSCALL_X32(nr, sym) extern long __x32_##sym(const struct pt_regs *);
> -#define __SYSCALL_COMMON(nr, sym) extern long __x64_##sym(const struct pt_regs *);
> +#define __SYSCALL_X32(nr, sym) extern long __x64_##sym(const struct pt_regs *);
>  #include <asm/syscalls_64.h>
>  #undef __SYSCALL_X32
> -#undef __SYSCALL_COMMON
>
> -#define __SYSCALL_X32(nr, sym) [nr] = __x32_##sym,
> -#define __SYSCALL_COMMON(nr, sym) [nr] = __x64_##sym,
> +#define __SYSCALL_X32(nr, sym) [nr] = __x64_##sym,
>
>  asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_x32_syscall_max+1] = {
>         /*
> diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
> index a84333adeef2..267fae9904ff 100644
> --- a/arch/x86/include/asm/syscall_wrapper.h
> +++ b/arch/x86/include/asm/syscall_wrapper.h
> @@ -17,7 +17,7 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
>   * __x64_sys_*()         - 64-bit native syscall
>   * __ia32_sys_*()        - 32-bit native syscall or common compat syscall
>   * __ia32_compat_sys_*() - 32-bit compat syscall

On a 64-bit kernel, an "ia32" compat syscall is __ia32_compat_sys_*, but...

> - * __x32_compat_sys_*()  - 64-bit X32 compat syscall
> + * __x64_compat_sys_*()  - 64-bit X32 compat syscall

Now an x32 compat syscall is __x64_compat?  This seems nonsensical.
I'm also a bit confused as to how this is even necessary for your
other patch.
