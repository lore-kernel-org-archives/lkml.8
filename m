Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3518C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7F3E206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 07:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgCIHBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 03:01:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57874 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgCIHBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 03:01:40 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jBCPX-00016e-Pp; Mon, 09 Mar 2020 08:01:11 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 4E0DF10408A; Mon,  9 Mar 2020 08:01:11 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>
Subject: Re: [patch part-III V2 05/23] x86/entry/32: Provide macro to emit IDT entry stubs
In-Reply-To: <CAMzpN2itqrztb+wA1k-KDwYMyQw3nZaMjzkHCu4GLr=t10ug=w@mail.gmail.com>
References: <20200308231410.905396057@linutronix.de> <20200308231718.931465601@linutronix.de> <CAMzpN2itqrztb+wA1k-KDwYMyQw3nZaMjzkHCu4GLr=t10ug=w@mail.gmail.com>
Date:   Mon, 09 Mar 2020 08:01:11 +0100
Message-ID: <874kuy811k.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <brgerst@gmail.com> writes:
> On Sun, Mar 8, 2020 at 7:24 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> +#ifdef CONFIG_X86_INVD_BUG
>> +.macro idtentry_push_func vector cfunc
>> +       .if \vector == X86_TRAP_XF
>> +               /* AMD 486 bug: invd from userspace calls exception 19 instead of #GP */
>> +               ALTERNATIVE "pushl      $do_general_protection",        \
>> +                           "pushl      $do_simd_coprocessor_error",    \
>> +                           X86_FEATURE_XMM
>> +       .else
>> +               pushl $\cfunc
>> +       .endif
>> +.endm
>> +#else
>> +.macro idtentry_push_func vector cfunc
>> +       pushl $\cfunc
>> +.endm
>> +#endif
>
> IMHO it would be better to push this to the C code and not make the
> asm more complicated.  Something like:
>
> dotraplinkage void
> do_simd_coprocessor_error(struct pt_regs *regs, long error_code)
> {
> #ifdef CONFIG_X86_INVD_BUG
>         /* AMD 486 bug: invd from userspace calls exception 19 instead of #GP */
>         if (!static_cpu_has(X86_FEATURE_XMM)) {
>                 do_general_protection(regs, error_code);
>                 return;
>         }
> #endif
>         RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
>         math_error(regs, error_code, X86_TRAP_XF);
> }

That's too obvious :)

Thanks for catching that!

       tglx
