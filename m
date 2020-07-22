Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C43C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 871C320787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3bRtQXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgGVSFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgGVSFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:05:21 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A320BC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:05:21 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id a12so3495850ion.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 11:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cVSOAr+v/VvKv7oBGJFtEwzmAS9LhwcEPp/HmrDGSwk=;
        b=G3bRtQXhKCdgHIbaTa6lCuh/2pbvz5Gdn9Hn2r8Sg0G1TiUfxSyZmhutHiv7Dl3bdc
         VARKFIW1StT1Z79bk68SnTf6NDKk34qJPcATktcM7ALdR4+OwY7o8q3y+lH2P8QpPCXa
         S/oJ3kYOoEzQkHLwCXRQZ6QGFdNSyTC7NMbNsTWBzr15velMTRIfwiIgFPMS4pC7f4xE
         x8KiLiCFFxYmc1MPJKR3/Baua6x/e/5SSqIyzE0quqz5NQvEson0t3OYGle70l0XBqxb
         x2kI2P9DuE7TfYldFmLe4Ut8G3GhVVctC73jkz1pYVbwEJu8Yiuwby8GoXGfby//XdcO
         VrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cVSOAr+v/VvKv7oBGJFtEwzmAS9LhwcEPp/HmrDGSwk=;
        b=uH+ec1mDcbBkNgALD7+bL2bldN1qpN6BVi4oWKmCiKq9zG3mahG/FMrkfrlzRoCOjl
         bfrPJ++MXEjumDDw3Mk3IIp3dEzhlEUHmG3TaNXSx7KUZaa4U0CgJwLDT+jd6wpFZTTW
         cvtaqCf6nQ3hQxCA0fnkSobUxl01umGoitGlOBwiTLIaCUL0/SU7AN1c3WSmt5CtN3qZ
         7ubkCYU3SA9BAa4s+lbEYMMuFI1VHwDzkFRTR4GWdv+6MxVAYdyotWKkcyfF8j/flwYe
         8uvgxJABMKYoEZoAGjbEkfv+nH/unt1HI4RYtUimAVIH2yuQe2RZXHaCR+DqUcb6Vx8u
         urWQ==
X-Gm-Message-State: AOAM533z35XYFAjd0Zk63xfkCGSpMgTkNanrvv0KPBhT1k6Zr0dlfaGT
        hZ52VdxEgLNnYqtkw/EEQzWB3mh9UQq55tv0f8Q=
X-Google-Smtp-Source: ABdhPJy02q+wzBdts5HVQ/QfSzD9eccXZA7S+3nqlaV8UjBTyZM8P9YVmOLW9Zeqdi1EmHKcDNTCbuZh5mygGOUPeK8=
X-Received: by 2002:a6b:bf85:: with SMTP id p127mr965612iof.37.1595441120963;
 Wed, 22 Jul 2020 11:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <bug-208655-6666@https.bugzilla.kernel.org/> <87h7tz306w.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87h7tz306w.fsf@nanos.tec.linutronix.de>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Wed, 22 Jul 2020 11:04:44 -0700
Message-ID: <CAMe9rOrER7Mg_YvzuqguS-GCyP-bD2hogWeo+OMXm7F6JXQUDQ@mail.gmail.com>
Subject: Re: [PATCH] x86/dumpstack: Dump user space code correctly again
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 10:54 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Subject: x86/dumpstack: Dump user space code correctly again
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Wed, 22 Jul 2020 10:39:54 +0200
>
> H.J. reported that post 5.7 a segfault of a user space task does not longer
> dump the Code bytes when /proc/sys/debug/exception-trace is enabled. It
> prints 'Code: Bad RIP value.' instead.
>
> This was broken by a recent change which made probe_kernel_read() reject
> non-kernel addresses.
>
> Update show_opcodes() so it retrieves user space opcodes via
> copy_from_user_nmi().
>
> Fixes: 98a23609b103 ("maccess: always use strict semantics for probe_kernel_read")
> Reported-by: H.J. Lu <hjl.tools@gmail.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/dumpstack.c |   27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)
>
> --- a/arch/x86/kernel/dumpstack.c
> +++ b/arch/x86/kernel/dumpstack.c
> @@ -71,6 +71,22 @@ static void printk_stack_address(unsigne
>         printk("%s %s%pB\n", log_lvl, reliable ? "" : "? ", (void *)address);
>  }
>
> +static int copy_code(struct pt_regs *regs, u8 *buf, unsigned long src,
> +                    unsigned int nbytes)
> +{
> +       if (!user_mode(regs))
> +               return copy_from_kernel_nofault(buf, (u8 *)src, nbytes);
> +
> +       /*
> +        * Make sure userspace isn't trying to trick us into dumping kernel
> +        * memory by pointing the userspace instruction pointer at it.
> +        */
> +       if (__chk_range_not_ok(src, nbytes, TASK_SIZE_MAX))
> +               return -EINVAL;
> +
> +       return copy_from_user_nmi(buf, (void __user *)src, nbytes);
> +}
> +
>  /*
>   * There are a couple of reasons for the 2/3rd prologue, courtesy of Linus:
>   *
> @@ -97,17 +113,8 @@ void show_opcodes(struct pt_regs *regs,
>  #define OPCODE_BUFSIZE (PROLOGUE_SIZE + 1 + EPILOGUE_SIZE)
>         u8 opcodes[OPCODE_BUFSIZE];
>         unsigned long prologue = regs->ip - PROLOGUE_SIZE;
> -       bool bad_ip;
> -
> -       /*
> -        * Make sure userspace isn't trying to trick us into dumping kernel
> -        * memory by pointing the userspace instruction pointer at it.
> -        */
> -       bad_ip = user_mode(regs) &&
> -               __chk_range_not_ok(prologue, OPCODE_BUFSIZE, TASK_SIZE_MAX);
>
> -       if (bad_ip || copy_from_kernel_nofault(opcodes, (u8 *)prologue,
> -                                       OPCODE_BUFSIZE)) {
> +       if (copy_code(regs, opcodes, prologue, sizeof(opcodes))) {
>                 printk("%sCode: Bad RIP value.\n", loglvl);
>         } else {
>                 printk("%sCode: %" __stringify(PROLOGUE_SIZE) "ph <%02x> %"

Add a kerel self test?

-- 
H.J.
