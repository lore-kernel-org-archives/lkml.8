Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D81BC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4424F20736
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJTcVQrg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730368AbgEKPL4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729439AbgEKPLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:11:55 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11133C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:11:55 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id k18so1022917ion.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 08:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5AwyrPvA3Ww23WwD/ecqGKqCatnslIQLQmzYWK6xUDQ=;
        b=bJTcVQrg2kn2NyqNxsmzk1xu6PQogygnXPZGousMw9W2p9jUqM7TnUKz58aFCSDQSX
         esNiQLFIm7O9COwUFMuLYYxq3zrHFMyekg3ko2GxiK5NaLjA8bs81IURmUAH5H1DAt1g
         RUjSAuA5RIeFT3m+3OTKlzizg80ttHJ2i3tjXAq1U23iqOGQGGvTX5YOi55kVYAp3liA
         JNtJmgmsxs8v9MACnftEKbazF/4/icnOj0SBEOkKguQAFrOT4KK7PJn0JpYXzJcPsu91
         b2mwXBjsiW+qiU92UTd8Kj2+UrjvWkEM28d1V0eCdUFi+IKJ2qanJo1tJ2td6fUuwd+a
         7vtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5AwyrPvA3Ww23WwD/ecqGKqCatnslIQLQmzYWK6xUDQ=;
        b=h+GTiUDf8G2zLy+VCAlchrM+LP/rVNVrNGFMbP/5/bIU2gCytjyOdZWp/zqtSKX8yO
         o+7sfHvCIAHvJ3m7dYKeGywl6lOZEwcQKCIcAtg4bH3op4pVU2JzpAQ48T6LA0nx7vps
         dR/buD+HWF0A1st84jPrzQm1B35FUI1x7eq8c0aANMstYBIoq/bn7nfZbGYS6vkqvmDq
         tPjRGetwnlmRcJYhrLJDbqtjSv1lRQikK/tc3fei6VkyUYThEdDefSmWHRmWCoIPVPVe
         nPhOnTxA9KZRiM+8zSnK/mq6gB47tTNFwuOZKL9ls6zm8L9Vg8RunkhNavP8PXOhy4Rp
         cIsg==
X-Gm-Message-State: AGi0PuaVzO8NMs92sBamqoZPZyuiQ9Q9QRqwEF4VAPdpA75NmvjqtfeQ
        Rjn4ouyvAqUIymbhuFoZZX4bcJAZBlmHUgo8I1c=
X-Google-Smtp-Source: APiQypLYkIwp2zwYR0/XHVuSRpG/Ze8NBJQYJ44O/eFUSnH1CdPwPmHX9VYEMhBvcYuvufq4ZjvssJb/60oFkGM3d3w=
X-Received: by 2002:a05:6602:34c:: with SMTP id w12mr15448536iou.56.1589209914364;
 Mon, 11 May 2020 08:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200505135341.730586321@linutronix.de> <20200505135829.384803459@linutronix.de>
 <CAJhGHyCgGxia1hzTWVF+-s5AXnUM9SnvxdfJK5PsZQCDbWfKNw@mail.gmail.com> <87v9l25yk7.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87v9l25yk7.fsf@nanos.tec.linutronix.de>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Mon, 11 May 2020 23:11:43 +0800
Message-ID: <CAJhGHyCePEuXjN91pSu=-yqUnafb2E5Hn8-e2UCUg0RYM0DZKA@mail.gmail.com>
Subject: Re: [patch V4 part 5 13/31] x86/irq: Convey vector as argument and
 not in ptregs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
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
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On Mon, May 11, 2020 at 10:35 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Lai,
>
> Lai Jiangshan <jiangshanlai+lkml@gmail.com> writes:
> > On Tue, May 5, 2020 at 10:23 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >> +SYM_CODE_START(irq_entries_start)
> >> +    vector=FIRST_EXTERNAL_VECTOR
> >> +    .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
> >> +       UNWIND_HINT_IRET_REGS
> >> +       .byte   0x6a, vector
> >> +       jmp     common_interrupt
> >> +       .align  8
> >> +    vector=vector+1
> >> +    .endr
> >> +SYM_CODE_END(irq_entries_start)
> >
> > Using ".byte   0x6a, vector" is somewhat ugly.
> >
> > I hope it should be " pushq $(s8_to_s64(vector))", which can also
> > help to reduce bunches of comments about ".byte   0x6a, vector".
> >
> > However, I don't know how to implement s8_to_s64() here.
>
> Neither do I.
>
> > But at least the following code works (generates the same two-byte
> > machine code as ".byte 0x6a, vector" does):
> >
> >         .if vector < 128
> >         pushq $(vector)
> >         .else
> >         pushq $(0xffffffffffffff00+vector)
> >         .endif
>
> Only slightly less ugly and needs as much commentry as the above.

Agree.

Just FYI, I tried this later, it can work.

#define S8_TO_S64(vector) ((vector>>7)*0xffffffffffffff00+vector)

Thanks
Lai
