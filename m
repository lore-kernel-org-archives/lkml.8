Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90699C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6248B2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589919606;
	bh=lnPdg3xOComkw/mtgCYuLekVm2wdX5+Kj/vqF2VGxAc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Tt74BbnVAXZ29zoQOwVfOQLdjBKTTQMvfD+krXNkSGzychTs/tK53CQMRjP4xvgcm
	 LWbnKDr1xlUt+tsdkW/6lrNlpMxW0fVbkaWQERgXseFsdQraSdzQ1vQiel/9yCGp4c
	 vpknpdKV38T63+h/0K9EIDER00E4CBOv6rsWfbSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgESUUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbgESUUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:20:05 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 343E7207FB
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589919604;
        bh=lnPdg3xOComkw/mtgCYuLekVm2wdX5+Kj/vqF2VGxAc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VbacoLCoiqhSf79KI7ZbBXnp4Mpj/29gH6gvsWst/phxyQePGR7NmsMyZAbDlaiZB
         nn9gtoue2bt3HE8XCXcRyYGe8ZFqGT7miwplEqYGYFUHnAMhB/PY8j1LKRRinarX9U
         K493lqIQsByqXF5iL/dSTrPZhty+DOJMxa+s2Zuw=
Received: by mail-wm1-f48.google.com with SMTP id h4so520864wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:20:04 -0700 (PDT)
X-Gm-Message-State: AOAM532rJ02+7U3R/EqQ/D+0E+jMWOIGFok6jybKpERhXGFunYxjKQAq
        DPiQlcEK+xXmNHTKsxLWanUTj8PJp3Vuz2dUtqhqHA==
X-Google-Smtp-Source: ABdhPJw+skrkQiO6Sndokvav+tG/l20x7oZ3l+6UMbbS3U/mvaexLCsdH/RkdoFbspOMYC5+0PP9KbuJVdaRvTZXJIs=
X-Received: by 2002:a1c:8141:: with SMTP id c62mr1109261wmd.21.1589919602647;
 Tue, 19 May 2020 13:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235126.317328545@linutronix.de>
In-Reply-To: <20200515235126.317328545@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 13:19:51 -0700
X-Gmail-Original-Message-ID: <CALCETrWjT+A_AAuv=zZ52vJhR2ZADktB3XZnO8n_qu09S0P0vQ@mail.gmail.com>
Message-ID: <CALCETrWjT+A_AAuv=zZ52vJhR2ZADktB3XZnO8n_qu09S0P0vQ@mail.gmail.com>
Subject: Re: [patch V6 19/37] x86/irq: Convey vector as argument and not in ptregs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>
> Device interrupts which go through do_IRQ() or the spurious interrupt
> handler have their separate entry code on 64 bit for no good reason.
>
> Both 32 and 64 bit transport the vector number through ORIG_[RE]AX in
> pt_regs. Further the vector number is forced to fit into an u8 and is
> complemented and offset by 0x80 so it's in the signed character
> range. Otherwise GAS would expand the pushq to a 5 byte instruction for any
> vector > 0x7F.
>
> Treat the vector number like an error code and hand it to the C function as
> argument. This allows to get rid of the extra entry code in a later step.
>
> Simplify the error code push magic by implementing the pushq imm8 via a
> '.byte 0x6a, vector' sequence so GAS is not able to screw it up. As the
> pushq imm8 is sign extending the resulting error code needs to be truncated
> to 8 bits in C code.


Acked-by: Andy Lutomirski <luto@kernel.org>

although you may be giving me more credit than deserved :)

 +       .align 8
> +SYM_CODE_START(irq_entries_start)
> +    vector=FIRST_EXTERNAL_VECTOR
> +    .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
> +       UNWIND_HINT_IRET_REGS
> +       .byte   0x6a, vector
> +       jmp     common_interrupt
> +       .align  8
> +    vector=vector+1
> +    .endr
> +SYM_CODE_END(irq_entries_start)

Having battled code like this in the past (for early exceptions), I
prefer the variant like:

pos = .;
.rept blah blah blah
  .byte whatever
  jmp whatever
  . = pos + 8;
 vector = vector + 1
.endr

or maybe:

.rept blah blah blah
  .byte whatever
  jmp whatever;
  . = irq_entries_start + 8 * vector;
  vector = vector + 1
.endr

The reason is that these variants will fail to assemble if something
goes wrong and the code expands to more than 8 bytes, whereas using
.align will cause gas to happily emit 16 bytes and result in
hard-to-debug mayhem.
