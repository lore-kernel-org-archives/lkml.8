Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0D5CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 588CA206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pFpBECoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgELPzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgELPzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:55:02 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16588C061A0C;
        Tue, 12 May 2020 08:55:02 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id 79so5317865iou.2;
        Tue, 12 May 2020 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=10/vEoe7VBVk5KEfSmgUPG75Mc6zuT9zb1kXjVA8dKs=;
        b=pFpBECoqEZGZuJmgrImz99Ao2hqlZMHq4Hlqed66WIrR13zPXHciKlFM2dPbemLcov
         yEPHRrojVStub+Ciu68iHgksvz0yeoYP5RtYapE4G341MC9fgx+T/iyA3Hj/j3oj+M2d
         RqDT32ttmrwxaDtFfsliwUU1wxEoeVuC1Frql7PMtMz5MHxy2Ajm3bF1JQc9TluIhuEB
         7jmjN2W6WCW3dLnly2ZvApT7aiPX6o08xZSmEzeK8oSE3UYxwueb5RPMitjiL9UJqnah
         4PXAZytMJbKhj+XK1WnqOK1U43/YAvtd6za3N3LLYmQaRX7s1D+KqkEVe35dcUnH7QBx
         WSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=10/vEoe7VBVk5KEfSmgUPG75Mc6zuT9zb1kXjVA8dKs=;
        b=G5KHet6CbEdboqiS/XtOOtEqooclNdA8bSPGyOOHDjLN+lMzDgIJfMlOfrbR4Gd8U+
         an3pDHqSAubMH7aKHwf+HdVtRvE159GW8ZPpRszTMN/u2poKBWac2FPjsZ8iOjFhGUKQ
         2LvAxecpY/xH7ct5FvHz6ldvhW3F368FnAT+94oU8t9xh5bfSxEsymaM9dXIgnej0AJ1
         6CqklZFKXUbZYkJew9KiHiM5nSa63mKbu44Tb+e5G4m9Urt/yHYvGxKGJVBFGPK7DmL/
         mWl/YOuKE7m25SuaczpZwrNP2Don+RCjVucqKLdwJ0tSBStHWDr1Xj0XRuiNEhT9rpD9
         lvAw==
X-Gm-Message-State: AGi0PuajkYiDXK76wVOlPybCVIVGCtDuNlNzbk3MXtKo4bOm0zPju9Pg
        BDlgzQO7i3rPG2I2e3Ja8pomBaQmm/Cg0Hw41O8=
X-Google-Smtp-Source: APiQypL4tTqanNPS6ku8FraQwgqCby47RTEW4wymxDqadJUYILPr9cb5jt1UJ3GerTcj7eRrgLbPrGP870RtDGs3ocI=
X-Received: by 2002:a5d:88d3:: with SMTP id i19mr21645852iol.194.1589298901363;
 Tue, 12 May 2020 08:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200508092247.132147-1-ubizjak@gmail.com> <158929264101.390.18239205970315804831.tip-bot2@tip-bot2>
 <CAFULd4bZLkME4kn9bmbOBMtd+ZpNnsH-w8a6tPdtmpV57WSHtw@mail.gmail.com> <20200512151522.GB6859@zn.tnic>
In-Reply-To: <20200512151522.GB6859@zn.tnic>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 12 May 2020 17:54:49 +0200
Message-ID: <CAFULd4bP4SPZDafsp-sqH2GP1mWxfBiBRA9wp8UrmkPZnfManQ@mail.gmail.com>
Subject: Re: [tip: x86/cpu] x86/cpu: Use INVPCID mnemonic in invpcid.h
To:     Borislav Petkov <bp@alien8.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 5:15 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Tue, May 12, 2020 at 04:26:37PM +0200, Uros Bizjak wrote:
> > Actually, the order was correct for AT&T syntax in the original patch.
> >
> > The insn template for AT&T syntax goes:
> >
> > insn arg2, arg1, arg0
> >
> > where rightmost arguments are output operands.
> >
> > The operands in asm template go
> >
> > asm ("insn template" : output0, output1 : input0, input1 : clobbers)
> >
> > so, in effect:
> >
> > asm ("insn template" : arg0, arg1 : arg2, arg3: clobbers)
> >
> > As you can see, the operand order in insn tempate is reversed for AT&T
> > syntax. I didn't notice the reversal of operands in your improvement.
>
> Your version had:
>
> +       asm volatile ("invpcid %1, %0"
> +                     : : "r" (type), "m" (desc) : "memory");
>
> with "type" being the 0th operand and "desc" being the 1st operand in
> the input operands list.

Correct.

> The order of the operands after the "invpcid" mnemonic are the other way
> around though: you first have %1 which is "desc" and then %0 which is
> the type.

Also correct. Because AT&T has right-to-left operand order, while asm
statement has left-to-right operand order.

> I simply swapped the arguments order in the input operands list, after
> the second ':'
>
> +       asm volatile("invpcid %[desc], %[type]"
> +                    :: [desc] "m" (desc), [type] "r" (type) : "memory");
>
> so that "desc" comes first and "type" second when reading from
> left-to-right in both

But this is not correct, AT&T insn template should have right-to-left order.

> 1. *after* the "invpcid" mnemonic and
> 2. in the input operands list, after the second ':'.

This is not the case throughout the kernel source. Please see for
example sync_bitops, where:

    asm volatile("lock; " __ASM_SIZE(bts) " %1,%0"
             : "+m" (ADDR)
             : "Ir" (nr)
             : "memory");

(to support my claim, I tried to find instruction with two input
operands; there are some in KVM, but these were also written by
myself).

> And since I'm using the symbolic operand names, then the order just
> works because looking at a before-and-after thing doesn't show any
> opcode differences:

Symbolic operands are agnostic to the position in the asm clause, so
it really doesn't matter much. It just doesn't feel right, when other
cases follow different order.

> $ diff -suprN /tmp/before /tmp/after
> Files /tmp/before and /tmp/after are identical

Sure, otherwise assembler would complain.

> Makes sense?

Well, I don't want to bikeshed around this anymore, so any way is good.

Uros.
