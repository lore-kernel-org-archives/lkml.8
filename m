Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A560C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB11206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 10:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IhbJ0oUw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgDFKgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 06:36:53 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43096 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgDFKgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 06:36:53 -0400
Received: by mail-oi1-f193.google.com with SMTP id k5so12605504oiw.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 03:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YnUc67zZ/CRLBeX19uteUhR1k0R3ljqlsHXrgc36ZpM=;
        b=IhbJ0oUwADR2fgaEWeRMV48PrcMNnHViNOtP1JgRPDQBa9YPacnyR+DsYyzDGxhmPu
         Ap+6eKiQtZ7sciCLyzIlpXBqJU77ClQ4yVwBeiXS48W7BI2wDhiKRp6mOVeyivrhv0JX
         yDtMkr/uNfLm+rotKNnjhheKA9F84+eUuJmGZEDFsG7c4EO8lbULSRTIUUaQvQ/CqyoP
         s/lBySbL07cwsHZU0J6c1zhTMj3edWxmtrvHuzURQIHZQ4rk5Zs/x7zfTWtWN3aOIpZ5
         AACYUMpZ+x6rMqY6GYJ9R2Of++CWq+oO3fC5s4Djxr3GBniWL2MezWmr3NOyfkxsMtTP
         kUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YnUc67zZ/CRLBeX19uteUhR1k0R3ljqlsHXrgc36ZpM=;
        b=uUcwyhauv5yftwiNJ1KKf0O9dke4gJ4h0w3/XWWG1t1tnVH/BhTqsjj8T+59YHBif9
         ulxlUK0nzcybwcQnmPYLZH7UG7JW65mtQs7wY7GXsY4OxJBWz4Ov/RnIC3XBmOHNKoma
         d6zmBRUmqSOgUxXoZgBShnHb4T/c5DDKd4NIh9DAg7cntn1oSDLRABxqR/qJ7eWl1qbu
         wquQHqTNS4xo+XnOBfcJk+iCkGPZr36OTj+zcGGPZyj8KY+3rQrbLehXt1QkBSiYNz7b
         150gaMyIWIcHjF8b9F22kxBnk6pzCVKzxFg1MeAeQ8Q/ZDlmH7yry7vmunI7odbpkiVq
         W09g==
X-Gm-Message-State: AGi0PubLmjC7+DGpiE0NEqKM/Y4L2XOXfP5g2pdZ1gngsyqGuywDJTP5
        CGIonJMXeVZoRqep+lzde7FTnkhjg0goZGzNz4PyOg==
X-Google-Smtp-Source: APiQypIkvAa/Z6iNoR5Ipeze6p/8TgwGtMmW1cKIGCS+3DI3TnGLwPkip6UEEdHQPIB3pNKQE3lCwZ2IBAdcIXfzNDI=
X-Received: by 2002:a05:6808:a08:: with SMTP id n8mr12485794oij.91.1586169412277;
 Mon, 06 Apr 2020 03:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583772574.git.zong.li@sifive.com> <d27d9e68491e1df67dbee6c22df6a72ff95bab18.1583772574.git.zong.li@sifive.com>
 <20200401003233.17fe4b6f7075e5b8f0ed5114@kernel.org> <CANXhq0ra3o+mgenbYLq_q0eZY2KiXNpWmo2V0amD0cFDqCQkXw@mail.gmail.com>
 <20200402101733.1ef240faeaeada6e4d38ae80@kernel.org> <CANXhq0rMbkNxQ3_qqYEKe8DSbL-vfQku6V9a81Hy9cxW4LaW9g@mail.gmail.com>
 <20200404121428.596911ba5653f8b18a80eab2@kernel.org> <CANXhq0rc+6jor7CMaa-zqSn3vNBdJhj3gD5wGxPkXAtVVHDHdQ@mail.gmail.com>
In-Reply-To: <CANXhq0rc+6jor7CMaa-zqSn3vNBdJhj3gD5wGxPkXAtVVHDHdQ@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 6 Apr 2020 18:36:42 +0800
Message-ID: <CANXhq0psUB4OaFuoTu-VuQNdaVOBs2UCv5kjx1Oad6rwajA1_Q@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] riscv: introduce interfaces to patch kernel code
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 4, 2020 at 8:12 PM Zong Li <zong.li@sifive.com> wrote:
>
> On Sat, Apr 4, 2020 at 11:14 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hi Zong,
> >
> > On Fri, 3 Apr 2020 17:04:51 +0800
> > Zong Li <zong.li@sifive.com> wrote:
> >
> > > > > > > +{
> > > > > > > +     void *waddr = addr;
> > > > > > > +     bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
> > > > > > > +     unsigned long flags = 0;
> > > > > > > +     int ret;
> > > > > > > +
> > > > > > > +     raw_spin_lock_irqsave(&patch_lock, flags);
> > > > > >
> > > > > > This looks a bit odd since stop_machine() is protected by its own mutex,
> > > > > > and also the irq is already disabled here.
> > > > >
> > > > > We need it because we don't always enter the riscv_patch_text_nosync()
> > > > > through stop_machine mechanism. If we call the
> > > > > riscv_patch_text_nosync() directly, we need a lock to protect the
> > > > > page.
> > > >
> > > > Oh, OK, but it leads another question. Is that safe to patch the
> > > > text without sync? Would you use it for UP system?
> > > > I think it is better to clarify "in what case user can call _nosync()"
> > > > and add a comment on it.
> > >
> > > The ftrace is one of the cases, as documentation of ftrace said, when
> > > dynamic ftrace is initialized, it calls kstop_machine to make the
> > > machine act like a uniprocessor so that it can freely modify code
> > > without worrying about other processors executing that same code. So
> > > the ftrace called the _nosync interface here directly.
> >
> > Hmm, even though, since it already running under kstop_machine(), no
> > other thread will run.
> > Could you consider to use text_mutex instead of that? The text_mutex
> > is already widely used in x86 and kernel/kprobes.c etc.
> >
> > (Hmm, it seems except for x86, alternative code don't care about
> >  racing...)
> >

The mutex_lock doesn't seem to work in ftrace context, I think it
might be the reason why other architectures didn't use text_mutex in
somewhere.

# echo function > current_tracer
[   28.198070] BUG: sleeping function called from invalid context at
kernel/locking/mutex.c:281
[   28.198663] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid:
11, name: migration/0
[   28.199491] CPU: 0 PID: 11 Comm: migration/0 Not tainted
5.6.0-00012-gd6f56a7a4be2-dirty #10
[   28.200330] Call Trace:
[   28.200798] [<ffffffe00060319a>] walk_stackframe+0x0/0xcc
[   28.201395] [<ffffffe000603442>] show_stack+0x3c/0x46
[   28.200798] [<ffffffe00060319a>] walk_stackframe+0x0/0xcc
[   28.201395] [<ffffffe000603442>] show_stack+0x3c/0x46
[   28.201898] [<ffffffe000d498b0>] dump_stack+0x76/0x90
[   28.202329] [<ffffffe00062c3f0>] ___might_sleep+0x100/0x10e
[   28.202720] [<ffffffe00062c448>] __might_sleep+0x4a/0x78
[   28.203033] [<ffffffe000d61622>] mutex_lock+0x2c/0x54
[   28.203397] [<ffffffe00060393e>] patch_insn_write+0x32/0xd8
[   28.203780] [<ffffffe000603a94>] patch_text_nosync+0x10/0x32
[   28.204139] [<ffffffe0006051b0>] __ftrace_modify_call+0x5c/0x6c
[   28.204497] [<ffffffe0006052c6>] ftrace_update_ftrace_func+0x20/0x4a
[   28.204919] [<ffffffe000697742>] ftrace_modify_all_code+0xa0/0x148
[   28.205378] [<ffffffe0006977fc>] __ftrace_modify_code+0x12/0x1c
[   28.205793] [<ffffffe0006924b6>] multi_cpu_stop+0xa2/0x158
[   28.206147] [<ffffffe0006921b0>] cpu_stopper_thread+0xa4/0x13a
[   28.206510] [<ffffffe000629f38>] smpboot_thread_fn+0xf8/0x1da
[   28.206868] [<ffffffe000625f36>] kthread+0xfa/0x12a
[   28.207201] [<ffffffe0006017e2>] ret_from_exception+0x0/0xc

>
> Yes, text_mutex seems to be great. I'll change to use text_mutex in
> the next version if it works fine after testing. Thanks.
>
> > Thank you,
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>
