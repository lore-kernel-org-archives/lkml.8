Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5363DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D74620714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LRurrVu3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbgCWRzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:55:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40566 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgCWRzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:55:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id f3so18228236wrw.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 10:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+XjXArON/nteRXhEm+avg+BQR0G/+8Zsnf7Y6LGWsQw=;
        b=LRurrVu3FEJrjddH9Dp7x6EbblzfnT1KxjLAvNlZhOC/xTqU1Ow8u7Dl5F8H1x+wCc
         dUDgrllLRf4HfPHH5q4tSb1tyd4vk2uR2DFjPa0SAxNTrOxtkHQ4HfY3Anzy3cUVBl+l
         Y7MMZ5nADcEIY1taSc9wDaV9zTlh+9sRomE7ZfuZdQ3aYFKS627GU9nAo4cZP/Hyz8YM
         RUPfV3wz0cqgN/SmqpdSu4AGSzE9af5zZmBOTg3Yf93WoSsU09odZzqwLUbJFasFjNV5
         FSTAule32F4o17HEMxIsw+KiT6utAOgfMK5VQfd0Z6542bNo4pEyVSlrqWDdV28FEiCe
         UV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+XjXArON/nteRXhEm+avg+BQR0G/+8Zsnf7Y6LGWsQw=;
        b=X7K+tZBZZFrHlQskPrkWvN8abFzdg2VZFZ1APYV5RHJ+eLWnX9Mu3skbe+zLEayFiI
         XqnR8Iyz/kXx8pXvuqCCxwjpSttQq3BMX12C57KPqrGuFVx9pOo99nYb1bMEtdL8bGRl
         7f3z93OC8Bgo1CPwYtR4CJL0QlSBDegCTlLOV25qh1Zcwm7SR18rnlRf16Xl49H7M1NT
         /BkRHF8mJGV5xQtjmMACNgVpS+fF/HvhHBXPGYWaCj81hVckSqFRsaW8Giyg+8nCgRcI
         70n1ijG4wEXxc+hGNJ6L27eJsfcReqznwtMib4601Q1//N5Vyq4IonHU7mGERjdHv6D4
         4u/w==
X-Gm-Message-State: ANhLgQ195IclCsDMungQDhjPHIoGJd/A/0adRT8TzWpQE8t6U2DOL30E
        aSrh1gbJl4fgRNVkA45SiglkBDWjx6Un7cM7vMGIWQ==
X-Google-Smtp-Source: ADFU+vv6lG8KfkaUa1MoJIlV06SZfWqvD81WQ22YMnvn2jyWH0lQ6LIgWyIOBTjrW0uX1mhiNl0iXHt6y0nVmAu5m2g=
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr29680460wrx.382.1584986118163;
 Mon, 23 Mar 2020 10:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000277a0405a16bd5c9@google.com> <CACT4Y+b1WFT87pWQaXD3CWjyjoQaP1jcycHdHF+rtxoR5xW1ww@mail.gmail.com>
 <5058aabe-f32d-b8ef-57ed-f9c0206304c5@redhat.com> <CAG_fn=WYtSoyi63ACaz-ya=Dbi+BFU-_mADDpL6gQvDimQscmw@mail.gmail.com>
 <20200323163925.GP28711@linux.intel.com> <CAKwvOdkE8OAu=Gj4MKWwpctka6==6EtrbF3e1tvF=jS2hBB3Ow@mail.gmail.com>
 <CAKwvOdkXi1MN2Yqqoa6ghw14tQ25WYgyJkSv35-+1KRb=cmhZw@mail.gmail.com>
In-Reply-To: <CAKwvOdkXi1MN2Yqqoa6ghw14tQ25WYgyJkSv35-+1KRb=cmhZw@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 23 Mar 2020 18:55:07 +0100
Message-ID: <CAG_fn=WE0BmuHSxUoBJWQ9dnZ4X5ZpBqcT9rQaDE_6HAfTYKQA@mail.gmail.com>
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

I've reduced the faulty test case to the following code:

=================================
a;
long b;
register unsigned long current_stack_pointer asm("rsp");
handle_external_interrupt_irqoff() {
  asm("and $0xfffffffffffffff0, %%rsp\n\tpush $%c[ss]\n\tpush "
      "%[sp]\n\tpushf\n\tpushq $%c[cs]\n\tcall *%[thunk_target]\n"
      : [ sp ] "=&r"(b), "+r" (current_stack_pointer)
      : [ thunk_target ] "rm"(a), [ ss ] "i"(3 * 8), [ cs ] "i"(2 * 8) );
}
=================================
(in fact creduce even throws away current_stack_pointer, but we
probably want to keep it to prove the point).

Clang generates the following code for it:

$ clang vmx.i -O2 -c -w -o vmx.o
$ objdump -d vmx.o
...
0000000000000000 <handle_external_interrupt_irqoff>:
   0: 8b 05 00 00 00 00    mov    0x0(%rip),%eax        # 6
<handle_external_interrupt_irqoff+0x6>
   6: 89 44 24 fc          mov    %eax,-0x4(%rsp)
   a: 48 83 e4 f0          and    $0xfffffffffffffff0,%rsp
   e: 6a 18                pushq  $0x18
  10: 50                    push   %rax
  11: 9c                    pushfq
  12: 6a 10                pushq  $0x10
  14: ff 54 24 fc          callq  *-0x4(%rsp)
  18: 48 89 05 00 00 00 00 mov    %rax,0x0(%rip)        # 1f
<handle_external_interrupt_irqoff+0x1f>
  1f: c3                    retq

The question is whether using current_stack_pointer as an output is
actually a valid way to tell the compiler it should not clobber RSP.
Intuitively it is, but explicitly adding RSP to the clobber list
sounds a bit more bulletproof.
