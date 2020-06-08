Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FA53C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3DD8206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbgFHQkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:40:06 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:47042 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730333AbgFHQkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:40:05 -0400
Received: by mail-ot1-f67.google.com with SMTP id g7so13084971oti.13
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 09:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DoIk7M+/dfkd1qsEjTLJ/qJxq8wwgYvyA9updsNoufY=;
        b=glChjZY7wYCodDDola73n/Pe7woFyACC1rdtowOSD7+/wNKYr+uPnlMja7s0pPUbX0
         Jt1ViZcj+vySe4vKU5KxzldfGjnt8yEX5gWA6Q1DMO6h8BAF49suOvBJ+ZujMRyTngYG
         655mFGHv+TEla/kOTvj7MkvkAJY56ddoAcVCX4MHo0vZq0llxKaIcy2c3cWaHDzyOyP7
         cloXH1pW5rUHW8vEJKljKHZkHDiu8DiYdDnZ9+gFJZL+wd3RiiM9L+XahK5jqY+NSRoH
         B6P3cSSl9T0u1y+FAl52LruU343iax9vs/AfnKMMJi0+ydLPsmdbWRdA5O6q1/ggWr5v
         5oLg==
X-Gm-Message-State: AOAM532sGUlVD20P4XHFHwno0KUtsVsUawJ+SiKdvh71/2Bh7Q9ycYFv
        ubyFe7KEajqR9EzVvJzI0exK/NVz0Xnfpu0vwTk=
X-Google-Smtp-Source: ABdhPJwpAOtHYCQlGPkYngs01Go5RWpOkkicySbl5mgtKtQPMEl0xr+Ij/5M9xtKtgFgG9RDyq2RJu3F8l8v9kjNI98=
X-Received: by 2002:a9d:c29:: with SMTP id 38mr17145170otr.107.1591634404626;
 Mon, 08 Jun 2020 09:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp> <20200528065603.3596-1-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20200528065603.3596-1-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Jun 2020 18:39:53 +0200
Message-ID: <CAMuHMdWOjCtV9W7GtHrhKCJwJ6wNSpd_RQTBaoG7sVrb4oYSDA@mail.gmail.com>
Subject: Re: [PATCH v2] twist: allow converting pr_devel()/pr_debug() into snprintf()
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tetsuo,

On Thu, May 28, 2020 at 8:57 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> syzbot found a NULL pointer dereference bug inside mptcp_recvmsg() due to
> ssock == NULL, but this bug manifested inside selinux_socket_recvmsg()
> because pr_debug() was no-op [1].
>
>   pr_debug("fallback-read subflow=%p",
>            mptcp_subflow_ctx(ssock->sk));
>   copied = sock_recvmsg(ssock, msg, flags);
>
> Thus, let's allow fuzzers to always evaluate pr_devel()/pr_debug()
> messages, by redirecting no-op pr_devel()/pr_debug() calls to snprintf().
>
> [1] https://syzkaller.appspot.com/bug?id=12be9aa373be9d8727cdd172f190de39528a413a
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Thanks for your patch!

> --- a/lib/Kconfig.twist
> +++ b/lib/Kconfig.twist
> @@ -12,10 +12,22 @@ if TWIST_KERNEL_BEHAVIOR
>
>  config TWIST_FOR_SYZKALLER_TESTING
>         bool "Select all twist options suitable for syzkaller testing"
> +       select TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS
>         select TWIST_DISABLE_KBD_K_SPEC_HANDLER
>         help
>          Say N unless you are building kernels for syzkaller's testing.
>
> +config TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS
> +       bool "Always evaluate printk() arguments"
> +       help
> +        Currently, only format string of printk() arguments is checked
> +        by compiler if pr_devel()/pr_debug() are disabled. Therefore,
> +        fuzz testing cannot catch runtime bugs (e.g. NULL pointer
> +        dereference, use-after-free/out-of-bounds/uninitialized read)
> +        in disabled printk() calls. This option redirects disabled
> +        printk(...) to snprintf(NULL, 0, ...) in order to evaluate
> +        arguments without printing.
> +
>  config TWIST_DISABLE_KBD_K_SPEC_HANDLER
>         bool "Disable k_spec() function in drivers/tty/vt/keyboard.c"
>         help

Can't you just enable CONFIG_DYNAMIC_DEBUG in your fuzzer
config instead?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
