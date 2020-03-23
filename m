Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAB5C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B46D2072E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:06:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nTKGbJ64"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgCWSGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:06:51 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37272 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbgCWSGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:06:51 -0400
Received: by mail-wr1-f66.google.com with SMTP id w10so18316022wrm.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 11:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hPUm/HhpONACSgj8NcmzE9a98krdtrzc27JDL5LBNKQ=;
        b=nTKGbJ64Trr4thrThDxbIV2WGfup7R/kt56W8gtCc0GJQFu62G5jb8ufTMvwPcS3H+
         uy7vPLpawyjtkoXkUf9FhUHOQSNUUYAIWgHq6iw+CMOWL1fO92pCVR5dCbzjvoYRKtA9
         n4NXerLYtcyV4+0h4gfi0brs+dFhYIEGDuxe9OBqtVflmCd+trcADnuBg7/jnAxfxlFW
         0D22pmxbRULBKGFWKFWB+f1u9iD6uIBGt3QYoiaTLyxDxZC9LUD0o+Oy5uP6AtG0zFuc
         qjKSW+Pry3/I6djMz2hqTEnQM4ymDQ3HIYyI0HVI+xZfLvbOEFB9LjGrB9AA7kX8GclZ
         eVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hPUm/HhpONACSgj8NcmzE9a98krdtrzc27JDL5LBNKQ=;
        b=iy+ZZsJWTXPqQuXn1GuSd7E+aM6av6h2ff8Mir/uD1eG3aKOPtl73dAM+EL7ed+wd5
         gS9UW4FCCuwLzU8uRGS1usu08QXkOnZ83MdmvQTWERrf+d8uN6wOuLsy1tGJcz1hx+Zv
         NeoqiDYnLsCfQGGUvJ76krksQBeuKdTrKKQx1ileFhHIvthT7Q2MvFqo1VJ6eOcyWPtI
         43QjQJUVe4KZ0ab7iGLr6V3g4/xcoy259UsjnGgfj//HHxyFkvZ65a6LVSH2iFMIMPG8
         AnItXecDTqZ2lX8Fs54ucrxhoya044hWjFlZ+9LNvbP9Zr5O2WbxnpzsfvMcuCtD3okm
         ILKA==
X-Gm-Message-State: ANhLgQ1M290OnCNFtKXLITs9e8GheHwRnistiUmmu3v/UrnU5nsJL4V6
        MJROLe1NxLWzxLbjf+e1jvmyF01gI+da8aHzXApT5w==
X-Google-Smtp-Source: ADFU+vv8LJRvApnLoC3YWQlOBxqsAybTAfaFiTIPOB4Kp6JDPrX3l9J3X/09U0KYtYXyDnl9ZV9/u7pRaZJBUlCvwCA=
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr29739901wrx.382.1584986808806;
 Mon, 23 Mar 2020 11:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000277a0405a16bd5c9@google.com> <CACT4Y+b1WFT87pWQaXD3CWjyjoQaP1jcycHdHF+rtxoR5xW1ww@mail.gmail.com>
 <5058aabe-f32d-b8ef-57ed-f9c0206304c5@redhat.com> <CAG_fn=WYtSoyi63ACaz-ya=Dbi+BFU-_mADDpL6gQvDimQscmw@mail.gmail.com>
 <20200323163925.GP28711@linux.intel.com> <CAKwvOdkE8OAu=Gj4MKWwpctka6==6EtrbF3e1tvF=jS2hBB3Ow@mail.gmail.com>
 <CAKwvOdkXi1MN2Yqqoa6ghw14tQ25WYgyJkSv35-+1KRb=cmhZw@mail.gmail.com> <CAG_fn=WE0BmuHSxUoBJWQ9dnZ4X5ZpBqcT9rQaDE_6HAfTYKQA@mail.gmail.com>
In-Reply-To: <CAG_fn=WE0BmuHSxUoBJWQ9dnZ4X5ZpBqcT9rQaDE_6HAfTYKQA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 23 Mar 2020 19:06:37 +0100
Message-ID: <CAG_fn=Uf2dDo4K9X==wE=eL8HQMc1an8m8H18tvWd9Mkyhpskg@mail.gmail.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in handle_external_interrupt_irqoff
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        syzbot <syzbot+3f29ca2efb056a761e38@syzkaller.appspotmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, KVM list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 6:55 PM Alexander Potapenko <glider@google.com> wrote:
>
> I've reduced the faulty test case to the following code:
>
> =================================
> a;
> long b;
> register unsigned long current_stack_pointer asm("rsp");
> handle_external_interrupt_irqoff() {
>   asm("and $0xfffffffffffffff0, %%rsp\n\tpush $%c[ss]\n\tpush "
>       "%[sp]\n\tpushf\n\tpushq $%c[cs]\n\tcall *%[thunk_target]\n"
>       : [ sp ] "=&r"(b), "+r" (current_stack_pointer)
>       : [ thunk_target ] "rm"(a), [ ss ] "i"(3 * 8), [ cs ] "i"(2 * 8) );
> }
> =================================
> (in fact creduce even throws away current_stack_pointer, but we
> probably want to keep it to prove the point).
>
> Clang generates the following code for it:
>
> $ clang vmx.i -O2 -c -w -o vmx.o
> $ objdump -d vmx.o
> ...
> 0000000000000000 <handle_external_interrupt_irqoff>:
>    0: 8b 05 00 00 00 00    mov    0x0(%rip),%eax        # 6
> <handle_external_interrupt_irqoff+0x6>
>    6: 89 44 24 fc          mov    %eax,-0x4(%rsp)
>    a: 48 83 e4 f0          and    $0xfffffffffffffff0,%rsp
>    e: 6a 18                pushq  $0x18
>   10: 50                    push   %rax
>   11: 9c                    pushfq
>   12: 6a 10                pushq  $0x10
>   14: ff 54 24 fc          callq  *-0x4(%rsp)
>   18: 48 89 05 00 00 00 00 mov    %rax,0x0(%rip)        # 1f
> <handle_external_interrupt_irqoff+0x1f>
>   1f: c3                    retq
>
> The question is whether using current_stack_pointer as an output is
> actually a valid way to tell the compiler it should not clobber RSP.
> Intuitively it is, but explicitly adding RSP to the clobber list
> sounds a bit more bulletproof.

Ok, I am wrong: according to
https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html it's incorrect to
list RSP in the clobber list.
