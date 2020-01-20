Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439EEC33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DFA217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgATOkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:40:04 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40841 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729096AbgATOkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:40:04 -0500
Received: by mail-ot1-f65.google.com with SMTP id w21so28825706otj.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 06:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EtTbB0yL/QxXyUG3sjoG7/1Jm2iP9JtCaU4sRh9uy0E=;
        b=Ae41o/pVJ/lkwMbrWQiKYHvqWG3UAhZDWdS03dSUt3Jmuffg9dMTZ15H4iI1VzYPEi
         URjiys+/wS0KByAonqOka/901DHTUErWWHgvK6Cl9eiQjlkHnqJGIZq8FNkXDcs8UMNi
         eAnnLPy1TRjdnLRgw/bRJUFPPJwNKRRp1zItnASZqgVJgUL5XBS6gJyIXZg1i40aJymI
         VmAcb7XkB/e0bgWOAHQuwQYmkFmnxe52N6k9w0t9ww3OUMnkIZMVk1sYXKwIVRdBAOnk
         xOfhiAD5wOO2YEEJ6GqAlAcfs+Ih7I9V107ZSy2Z2EDhCKCgjA1N9P9v3QTvuuXl7J+u
         fnpQ==
X-Gm-Message-State: APjAAAXWTisktLMXvuftJYao11XKk93anHJnBRf18QRbnk20pikgvseQ
        JZLKkp+ZxsMh9HHp8iNUZZRj56LR4+0l5uAszWJpTRhU
X-Google-Smtp-Source: APXvYqwv2q8tQHiLSkICoi5yx7bAUTS6D03HEjKzC60Uvr0dE38NOdUgO9TD4QqbBVPhPVnqaE7zenZ3zAhsuIw4PFQ=
X-Received: by 2002:a9d:8f1:: with SMTP id 104mr15274004otf.107.1579531202876;
 Mon, 20 Jan 2020 06:40:02 -0800 (PST)
MIME-Version: 1.0
References: <20200110215429.30360-1-dave@stgolabs.net>
In-Reply-To: <20200110215429.30360-1-dave@stgolabs.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Jan 2020 15:39:51 +0100
Message-ID: <CAMuHMdXeZvJ0X6Ah2CpLRoQJm+YhxAWBt-rUpxoyfOLTcHp+0g@mail.gmail.com>
Subject: Re: [PATCH] lib/rbtree: avoid pointless rb_node alignment
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Fri, Jan 10, 2020 at 11:02 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
> Now that Linux no longer supports the CRIS architecture,
> we can drop this fishy alignment. Apparently this was
> need to prevent misalignments in struct address_space.
>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

Thanks for your patch!

> --- a/include/linux/rbtree.h
> +++ b/include/linux/rbtree.h
> @@ -25,8 +25,7 @@ struct rb_node {
>         unsigned long  __rb_parent_color;
>         struct rb_node *rb_right;
>         struct rb_node *rb_left;
> -} __attribute__((aligned(sizeof(long))));
> -    /* The alignment might seem pointless, but allegedly CRIS needs it */
> +};

Unfortunately this is also needed on m68k.

This is now commit 2d39da80d43693a2 ("include/linux/rbtree.h: avoid
pointless rb_node alignment") in linux-next, where Jason Donenfeld
reported the following crash:

> [    3.200000] Unable to handle kernel access at virtual address 6b7cdccf
> [    3.200000] Oops: 00000000
> [    3.200000] PC: [<00237454>] rb_erase+0x1c/0x346
> [    3.200000] SR: 2710  SP: c48c162a  a2: 0fcc5280
> [    3.200000] d0: 00000001    d1: 0fe6a000    d2: 0fd82000    d3: 00000000
> [    3.200000] d4: 00000000    d5: 00000377    a0: 002b28f6    a1: 002b28f6
> [    3.200000] Process ping (pid: 73, task=1e7eecd7)
> [    3.200000] Frame format=7 eff addr=46e60008 ssw=0505 faddr=46e60008
> [    3.200000] wb 1 stat/addr/data: 0000 00000000 00000000
> [    3.200000] wb 2 stat/addr/data: 0000 00000000 00000000
> [    3.200000] wb 3 stat/addr/data: 0000 46e60008 00000000
> [    3.200000] push data: 00000000 00000000 00000000 00000000
> [    3.200000] Stack from 0fe6bf00:
> [    3.200000]         0fd82000 00000000 0fd846e6 002b290a 002b28d0 0fe6bfb0 0023f77c 0fd846e6
> [    3.200000]         002b290a 0fd846e6 002b28f6 00045058 002b290a 0fd846e6 0fd82000 00000000
> [    3.200000]         0fd846e6 0fe6a000 0000fd00 00045956 0fd846e6 002b28f6 00000000 00000001
> [    3.200000]         0fd846e6 000458f4 00045972 0fd846e6 000000ff 0fcc5280 00015e76 0fd846e6
> [    3.200000]         00000000 00000000 00000000 00000377 c49ba615 00000000 80001510 00000000
> [    3.200000]         0000fd00 00000002 00000000 00000000 80009ff8 0001675a 00000000 8000b6c5
> [    3.200000] Call Trace: [<0023f77c>] timerqueue_del+0x20/0x8a
> [    3.200000]  [<00045058>] __remove_hrtimer+0x30/0xaa
> [    3.200000]  [<0000fd00>] unf_e1_exc+0x20/0x48
> [    3.200000]  [<00045956>] hrtimer_try_to_cancel+0x62/0x6c
> [    3.200000]  [<000458f4>] hrtimer_try_to_cancel+0x0/0x6c
> [    3.200000]  [<00045972>] hrtimer_cancel+0x12/0x20
> [    3.200000]  [<00015e76>] do_exit+0x8c/0x91e
> [    3.200000]  [<0000fd00>] unf_e1_exc+0x20/0x48
> [    3.200000]  [<0001675a>] do_group_exit+0x24/0x9c
> [    3.200000]  [<000167e6>] __wake_up_parent+0x0/0x20
> [    3.200000]  [<00002774>] syscall+0x8/0xc
> [    3.200000]  [<0004c002>] timecounter_read+0x16/0xcc
> [    3.200000] Code: 2a6c 0008 4a8d 6700 0202 4a8b 6700 0244 <206b>
> 0008 200b 4a88 6700 0166 224b 2028 0008 670a 2248 2040 2028 0008 66f6 2c68
> [    3.200000] Disabling lock debugging due to kernel taint
> [    3.200000] Fixing recursive fault but reboot is needed!
>
> Seems to happen if a process exits with an hrtimer?

I could easily reproduce it by just booting next-2020120 on ARAnyM:

Unable to handle kernel access at virtual address 7c05a009
Oops: 00000000
Modules linked in:
PC: [<002eb772>] rb_erase+0x1c8/0x25a
SR: 2704  SP: c286c837  a2: 10aab020
d0: 10a7ae67    d1: 00000000    d2: 00000000    d3: 00024000
d4: 00000008    d5: 270011de    a0: fab01081    a1: 00000000
Process sh (pid: 428, task=09f84a54)
Frame format=7 eff addr=fab01084 ssw=0525 faddr=fab01084
wb 1 stat/addr/data: 0000 00000000 00000000
wb 2 stat/addr/data: 0000 00000000 00000000
wb 3 stat/addr/data: 0000 fab01084 00000001
push data: 00000000 00000000 00000000 00000000
Stack from 10ab3ca0:
        00000000 1081bab0 003eb88a 003eb876 003eb876 002f1cc6 1081bab0 003eb88a
        003eb850 1081bab0 0004b0f2 003eb88a 1081bab0 00000000 00024000 1081bab0
        003eb880 003eb870 0004b4d0 1081bab0 003eb876 00000000 00000000 00002700
        0000000d 00000008 270011de 00043c1c 00000001 10803140 003e6408 10ab3dc4
        00024000 003eb88a 003eb874 0004b6dc 00000008 270011de 00002700 0000000f
        00000000 00000005 0004454a 0004ab1c 0004ab4e 10aab020 00000000 00002604
Call Trace: [<002f1cc6>] timerqueue_del+0x58/0x6a
 [<0004b0f2>] __remove_hrtimer+0x2a/0x9c

timerqueue_del() uses rbtree, and

    #define rb_parent(r)   ((struct rb_node *)((r)->__rb_parent_color & ~3))

relies on all objects being 4-byte aligned.  But your patch broke that
assumption on m68k, where the default alignment is 2-byte.

Andrew: please drop this patch.

Thanks!

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
