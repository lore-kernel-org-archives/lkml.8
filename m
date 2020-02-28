Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A36C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE182469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582915631;
	bh=kskxhZvQ39ItP8wb+LeaJo3d5PU60DJHeaW+XT0a0Vw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=G7XnYjlit9MlwVnsbr3v/r1auMNgXpQDMUaDkK7+4jmqC4oeeMWk1XuxwcLwE4vde
	 EopOVZkW4YWbstr/RgmbJqOHLiPenMANCVF9JzwtLuEw1LKBXEhctSj6Br6I68xPXK
	 g6Nhk56L95pdh7TGOMw/+4oASKwFAFFxs1a7HJXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgB1SrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:47:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:41360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725730AbgB1SrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 13:47:09 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCC882469F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 18:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582915629;
        bh=kskxhZvQ39ItP8wb+LeaJo3d5PU60DJHeaW+XT0a0Vw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b57hkR+y2RHTVdMrS19zE2t13g1EmPGZ+DoDcprpL26Hvg5tGy/Y00tCGUkc+gWZ/
         7IZKUIzl7r9VWDN2qRazoXozaLFXLG5Ehu6D1IEzs3tuTOvit5VJdcMZEjNsxiuGwo
         PgOPgp2zQ/3/hONG0BiO6qa3wMH6SavNMbzWdjKo=
Received: by mail-wr1-f45.google.com with SMTP id l5so4167150wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 10:47:08 -0800 (PST)
X-Gm-Message-State: APjAAAX3qPsDHuibVlrR7ZKgBltKVd2CezJXmJQU9KTVISWanwMbKELt
        LGv8ydtQV/H1/6gFJnSgjw3h8b6szg5DJv1edqL1lA==
X-Google-Smtp-Source: APXvYqwgfrlpKF7mQR7lpP15+7uYz1zSgrSceDJy2L2D9fY9Mgg+cjOixSCbQ8YPWL+uxrC6lh1AWU3fT1BJAnNZunc=
X-Received: by 2002:adf:ea85:: with SMTP id s5mr5927227wrm.75.1582915627219;
 Fri, 28 Feb 2020 10:47:07 -0800 (PST)
MIME-Version: 1.0
References: <20200227132826.195669-1-brgerst@gmail.com> <20200227132826.195669-6-brgerst@gmail.com>
In-Reply-To: <20200227132826.195669-6-brgerst@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 28 Feb 2020 10:46:55 -0800
X-Gmail-Original-Message-ID: <CALCETrXyYd=pqThrXQgbz5cqQTr8SKHZey4FGq5aV2_=CS4p9Q@mail.gmail.com>
Message-ID: <CALCETrXyYd=pqThrXQgbz5cqQTr8SKHZey4FGq5aV2_=CS4p9Q@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] x86: Move 32-bit compat syscalls to common location
To:     Brian Gerst <brgerst@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 5:28 AM Brian Gerst <brgerst@gmail.com> wrote:
>
> Move the 32-bit wrappers for syscalls that take 64-bit arguments (loff_t)
> to a common location so that native 32-bit can use them in preparation for
> enabling pt_regs-based syscalls.

Can you clarify the purpose?  Even having read the series up to this
point, I have no idea what this has to do with pt_regs.

I think some renaming is in order.  Consider:

>
> -COMPAT_SYSCALL_DEFINE3(x86_ftruncate64, unsigned int, fd,
> -                      unsigned long, offset_low, unsigned long, offset_high)

It used to be at least a little bit clear what was going on.  There's
this compat-only mess that changes arguments for ftruncate64.  But
now:

> +SYSCALL_DEFINE3(x86_ftruncate64, unsigned int, fd,
> +               unsigned long, offset_low, unsigned long, offset_high)
>  {
>         return ksys_ftruncate(fd, ((loff_t) offset_high << 32) | offset_low);
>  }

What is this "x86" ftruncate64 thing?

Maybe call it ia32_ftructate?  Or at least do something to indicate
that this is for a specific ABI.

> diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
> index 9649b5ad2ca2..d5520e92f89d 100644
> --- a/arch/x86/um/sys_call_table_32.c
> +++ b/arch/x86/um/sys_call_table_32.c
> @@ -26,6 +26,16 @@
>
>  #define old_mmap sys_old_mmap
>
> +#define sys_x86_pread sys_pread64
> +#define sys_x86_pwrite sys_pwrite64
> +#define sys_x86_truncate64 sys_truncate64
> +#define sys_x86_ftruncate64 sys_ftruncate64
> +#define sys_x86_readahead sys_readahead
> +#define sys_x86_fadvise64 sys_fadvise64
> +#define sys_x86_fadvise64_64 sys_fadvise64_64
> +#define sys_x86_sync_file_range sys_sync_file_range
> +#define sys_x86_fallocate sys_fallocate

Can this not be killed by changing the table itself instead of adding
a bunch of defines?
