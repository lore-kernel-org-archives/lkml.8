Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE40BC47255
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 02:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F89D208DB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 02:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7oClmbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbgEJCpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 22:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEJCpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 22:45:04 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D901EC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 19:45:03 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id c18so5202104ile.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 19:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z9b6QdNxrGr1UsENVQ+afssf0s3mZK5j49G+nAroih8=;
        b=D7oClmbuzlC7T4M3UTeQ9XF+MH8JS41MG0EOL+oGtWzgohDOf59BEeNSdH6AHe31Rp
         96myKKfJIruAAZN7RVIlQbKplal+dDnhw7y+/yeZ1z6H/n6tvW+d97wD2d2y+TITaUBQ
         6/SVTC/1J/Ue/zumhLkZXeQYxSqNj3Kei0c3b4Bwdyr9npYhuVpyC4hWbKo7sb3cWWbV
         04h4l2oI/bunmakN/N9iLJTB1aK7R223UUqJHiX8WalXK4OlSvoTnGzCYr3LkiE/9S96
         7dc8Yhe7HgWdPyxEcBtHplKv9zXKNcJ3epsNcO3Z0WO2JEBaNgmqmh2yE3YGvBDyzE0n
         dhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z9b6QdNxrGr1UsENVQ+afssf0s3mZK5j49G+nAroih8=;
        b=a+hxQOy5h3Vqu0ExM+J4DsKdt+3V44LJ2+kBx6oxiBaogtG9XeDyV3XnnEpAXXUDl3
         NqU/ohkUdlv8rOc2e975qY3YtCoyJTEF9OZ3QvJ7UrCtSKPztz7awMxfOo1w9EGmeBKS
         D5+nBnV/p6pTSzREjypU3juOC9nu9FEAOjQk62EKgGLgIh0r7uJVgwuAhbVxA0w6lzEs
         q+kHwGq1vk3fx70qubK3+lLZ9/8yV/6xUNvywtKx3LHX9/a1oDU3y9Oaa9O6J+q+5cRH
         MOmmpB1t35C3S9cSMNP1EuRJlrnfWEjoR6lkDCznzuq5Zas43e/jouvk3+s3UZ8Kh9b0
         nyYA==
X-Gm-Message-State: AGi0PuaYGc/eqbahWxQf4drxp2672vte4Xfiup37kF8Bgb75MTyh3Lxo
        YQMl0JIGFxQQSkPuZ6MGb6xbijhvVoaTe9a0UsA=
X-Google-Smtp-Source: APiQypLo0o8/X5d8OEqCT9zOruxXbONHdrtRyw9EzoxaUf18ak4rdmeSYllOzlCZ3icNmXjv2Gs6MhWxZcYscu6kFYg=
X-Received: by 2002:a92:5b05:: with SMTP id p5mr9586880ilb.94.1589078703172;
 Sat, 09 May 2020 19:45:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200505135341.730586321@linutronix.de> <20200505135829.384803459@linutronix.de>
In-Reply-To: <20200505135829.384803459@linutronix.de>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Sun, 10 May 2020 10:44:52 +0800
Message-ID: <CAJhGHyCgGxia1hzTWVF+-s5AXnUM9SnvxdfJK5PsZQCDbWfKNw@mail.gmail.com>
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

On Tue, May 5, 2020 at 10:23 PM Thomas Gleixner <tglx@linutronix.de> wrote:

> +/*
> + * ASM code to emit the common vector entry stubs where each stub is
> + * packed into 8 bytes.
> + *
> + * Note, that the 'pushq imm8' is emitted via '.byte 0x6a, vector' because
> + * GCC treats the local vector variable as unsigned int and would expand
> + * all vectors above 0x7F to a 5 byte push. The original code did an
> + * adjustment of the vector number to be in the signed byte range to avoid
> + * this. While clever it's mindboggling counterintuitive and requires the
> + * odd conversion back to a real vector number in the C entry points. Using
> + * .byte achieves the same thing and the only fixup needed in the C entry
> + * point is to mask off the bits above bit 7 because the push is sign
> + * extending.
> + */
> +       .align 8
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

Hello, tglx

Using ".byte   0x6a, vector" is somewhat ugly.

I hope it should be " pushq $(s8_to_s64(vector))", which can also
help to reduce bunches of comments about ".byte   0x6a, vector".

However, I don't know how to implement s8_to_s64() here. But at
least the following code works (generates the same two-byte machine
code as ".byte   0x6a, vector" does):

        .if vector < 128
        pushq $(vector)
        .else
        pushq $(0xffffffffffffff00+vector)
        .endif

Thanks,
Lai
