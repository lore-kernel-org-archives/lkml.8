Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE44C35280
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 04:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C18206B9
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 04:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyySpe7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgEJEdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 00:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgEJEdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 00:33:45 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37D5C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 21:33:44 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id f3so6009197ioj.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 21:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VHU93qiCPeuKDnq7RwKToMUB9ruaa8FUAZfnco9Uuh4=;
        b=UyySpe7h+t1MmeLX9Ib6eUz6JK/AbVAl/xfHj0D8mS0+UrQbx2AWHWFB8FoEF7Y4Wq
         VH8nG/hUn9+GUeMxQLOkDCENzlGWIcycyztQJDu7he7SuPHFslCUCdjhrwu6YmlHwv+T
         xoARenh06jHpvKMTjBS836zW3HDIyFDfGmiwLouEKv2Km4gfe0nkxqH2GwFpmMfSN7sM
         z0xsKKtlTSbvY2Sil/s5sSruAExQbYEhdx8QBiMBk3ksv0Vae4djSPmBsHAob3JM1n0c
         Ye3eT+p63+YnH91hK8sVgq9kdVvI/ctMzSywwVPpLZ/56wqLBJF6l2HYYQEKj2Bo3to5
         EFrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VHU93qiCPeuKDnq7RwKToMUB9ruaa8FUAZfnco9Uuh4=;
        b=duSoNNQ5ZvvUDvc6bwJHnvqhJHTkrZ3PsoTnw4hiqKAk7t0ENzykrNw2/tTGlCmPYT
         ef7CWlcdk96wV3oYLZ5eUvwZ7vlVCh18y3mQcq7/Qj2txVRVJXo5NUz+xbWKM9LJyxDW
         B/lhx1ffdk5tCumBdOTyA9hG9zubiNf8B1iIPUY7JNpmjTdSWKN+Bmfvhmf0PvsDZwuv
         1ozgqDJf5HODjj9JnSF/Ofpijgp1T4KWXbI0tsQeR7Z342MQiLKNu6sV9zmvYUEkf8Mq
         Pt/fP5aR96pPM8LNuldSVuzBMYgaLLlCaAccYKKGxbUIWTYFV4o+x/bVEHjHAxMznCZ+
         ux2w==
X-Gm-Message-State: AGi0PubmU6qEz1wuDfw810OR6e2W2i6dRFKxX+KYATP99LmE287Y+2ug
        m+tYtdbCqlbRpBTaOL7p6v4Uf2f9FYU3UB2Qsus=
X-Google-Smtp-Source: APiQypIftV4hHyi8x96un9huRW28lvR6ChZCyNllKXz8QEM59GyK6yu9dtAa6y3zTjxFTEttPVx+e+8vK+cgyPRTByE=
X-Received: by 2002:a05:6602:384:: with SMTP id f4mr9538350iov.207.1589085224208;
 Sat, 09 May 2020 21:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200505135341.730586321@linutronix.de> <20200505135828.316937774@linutronix.de>
In-Reply-To: <20200505135828.316937774@linutronix.de>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Sun, 10 May 2020 12:33:33 +0800
Message-ID: <CAJhGHyCGOfD6pQQ58CysfjyvqPLc9dc54WpqE2wSuVvyEK-9jw@mail.gmail.com>
Subject: Re: [patch V4 part 5 02/31] x86/entry: Provide helpers for execute on irqstack
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

On Tue, May 5, 2020 at 10:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Device interrupt handlers and system vector handlers are executed on the
> interrupt stack. The stack switch happens in the low level assembly entry
> code. This conflicts with the efforts to consolidate the exit code in C to
> ensure correctness vs. RCU and tracing.
>
> As there is no way to move #DB away from IST due to the MOV SS issue, the
> requirements vs. #DB and NMI for switching to the interrupt stack do not
> exist anymore. The only requirement is that interrupts are disabled.

Hi, tglx and Andy Lutomirski,

Is there any information about "no way to move #DB away from IST
due to the MOV SS issue"? IST-based #DB results to ist_shift(for
nested #DB) and debug_idt(for #NMI vs. #DB) which are somewhat
ugly. If IST-less #DB should work, debug stack should be switched
in software manner like interrupt stack.

There was a "POP/MOV SS" CVE/issue about #BP which lead to
moving #BP to IST-less by d8ba61ba58c8
(x86/entry/64: Don't use IST entry for #BP stack)

#DB #BP are considered as #NMI due to their super-interrupt
ability. But the kernel has much more control over #DB and #BP
which can be disabled by putting the code snip into non-instrument
sections like __entry noinstr etc.

Is it possible to implement IST-less #DB?

Thanks,
Lai
