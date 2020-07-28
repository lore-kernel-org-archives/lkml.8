Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE84C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D993C20672
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 02:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6Q65jzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgG1CXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 22:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgG1CXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 22:23:02 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA4FC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 19:23:02 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id f9so4513624pju.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 19:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bmpjZY3DS+knka6HwVXGoRUInVOpnqRy9fgTe+9ox3o=;
        b=A6Q65jzY2cfoaTXJphioBYwzUZ+be9yKf0+IeSTMnXUN/l1RxIvIRCe9/LQZBBLDdp
         heAnKx5XcgEA28i6r52O8AXSsofuVQpw0tkEXqfnj4rR34bc0q5NdPDF+0WRhWnYJzLq
         jsX4NQItW4WQzrUiEiu9TSVbvO3Z5BecCXbA+9klSWOO127jwaJk7DUsKGF5Twi2orVm
         mJIazyPyfHUS/91rV8QOmESVm4V1ntZ/3fP72BU/bu4ipr1GnBL1fy64uxY+hoBSG9Fg
         W+Tci1LwLzwf+XBKoHkqfJeEaruOj3mt3ijECXDKTrLKR5+EaXVzRC/w5QCj0BIk8sD6
         rrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bmpjZY3DS+knka6HwVXGoRUInVOpnqRy9fgTe+9ox3o=;
        b=fnfd6jA5tAABsUtaF9ZY9qLXs7phU8bBMzKEXo+FG2cMThjUOJ/rKzdCMpt1lQdprK
         hzzeLrS1glyquOk96IarHtvwE9PXjITkMYbilCt3XMrAnfJPFUby45szIN9tH9lUvraV
         DfxtHhOvBPb/Mnvqcp34EAocdJdYimrGtcL4QHXq7tauYJyrfikNuNEgUdY4vrqOQVdq
         i6Xtg9n4N+EJdboWxGk3NAKARcy6rgCH6Xm16kpM85+ZEB6xSoxMU8jNhWYELcKkcM1b
         7MjsmOwV4bekBCDCZHRSAB0xwIWyXoMwgwR1MouyzQAstdn2lKHH3+HjB7qB/S4aRnGA
         2cGw==
X-Gm-Message-State: AOAM530NMfBbpCaS/wSrM+ObiyOpd6tm4/3JU1sT8mKwDQzIU08I4RyP
        bAYi95sBoQbtY27U5Oer1dc=
X-Google-Smtp-Source: ABdhPJzxWDQfGtw5RifGpYsRUAm837l7chrN68fAWAesyFsc00ENC6VjY8ddewTmH4BV8BYzmQdVCw==
X-Received: by 2002:a17:902:ed14:: with SMTP id b20mr22338790pld.25.1595902981696;
        Mon, 27 Jul 2020 19:23:01 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id g28sm16076428pfr.70.2020.07.27.19.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 19:23:00 -0700 (PDT)
Date:   Tue, 28 Jul 2020 11:22:59 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] printk: store instead of processing cont parts
Message-ID: <20200728022259.GB1286082@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <20200717234818.8622-3-john.ogness@linutronix.de>
 <20200719143527.GA566@jagdpanzerIV.localdomain>
 <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com>
 <20200720015057.GA463@jagdpanzerIV.localdomain>
 <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com>
 <20200721144220.GE44523@jagdpanzerIV.localdomain>
 <CAHk-=wibPWj9m1jQWeJUq+iPMG9tHaLANY-UaruakHuezFHr4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wibPWj9m1jQWeJUq+iPMG9tHaLANY-UaruakHuezFHr4w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/21 08:40), Linus Torvalds wrote:
> On Tue, Jul 21, 2020 at 7:42 AM Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> >
> > OK, so basically, extending printk_caller_id() so that for IRQ/NMI
> > we will have more info than just "0x80000000 + raw_smp_processor_id()".
> 
> I think it's really preempt_count() that we want to have there.
> 
> That has the softirq/hardirq/NMI information in it.
> 
> So the "context" identifier of an incomplete write would be { task,
> cpu, preempt_count() } of the writer. If a new KERN_CONT writer comes
> in, it would have to match in that context to actually combine.
> 
> You can probably play "hide the bits" tricks to not *ac tually* use
> three words for it. The task structure in particular tends to be very
> aligned, you could hide bits in the low bits there. The CPU number
> would fit in there, for example.

The purpose of callerid has changed. We used to keep it _only_ in
struct printk_log and never used it for anything but

	if (cont.owner == current && (lflags & LOG_CONT))
		...

so it was easy to use task_struct pointers - we only cared if cont.owner
matches current and never dereferenced the cont.owner pointer.

But we do show caller id to users now (CONFIG_PRINTK_CALLER), so it
makes sense to keep there something more or less human readable, it
helps syzkaller/fuzzer people. That's why we keep PID in [30,0] bits
of callerid if the printk was called in_task(), and CPU_ID otherwise.

Replacing easy to understand PID/CPU_ID with some magic hex, e.g.
hash(current) >> shift or hash(smp_processor_id()) >> shift, will
make things less convenient, so I think it is reasonable to preserve
the existing scheme.

I like what John suggests:

- if printk was called from in_task(), then we keep PID in [30,0] bits
- otherwise we keep smp_processor_id() in [27,0] bits and in the upper
  bits we keep the IRQ/NMI/etc flags.

It may make sense to "promote" u32 callerid to u64, just in case if
someone sometime in the future will have boxes with more than several
billion PIDs.

	-ss
