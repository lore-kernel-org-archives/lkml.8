Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D47CAC4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7656206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFPfivX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgBZFpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 00:45:55 -0500
Received: from mail-il1-f174.google.com ([209.85.166.174]:43925 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgBZFpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:45:55 -0500
Received: by mail-il1-f174.google.com with SMTP id p78so1319403ilb.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 21:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F2mXIFJoxgQSUUlnzFgJOWM8Ot6cZehAmrrcYPGKwpk=;
        b=eFPfivX35DEa4ArNgoHHTzP7dMyc2cYpSne9Apx3ttPgeTCPQUHIoQcD7MO9yDJmCR
         DLyCYE2Wr7DwexlFddtsqsOJ1v5ScT1/63SNORZQrVs7MzhQkI8Mep2qqtnHLQevkXdT
         1Z9fYS5B9s4lEnw7b9A2LLC8GRzMvU0dAGQ6X4sj009sE+xJ0eITKy+6YG7rapARVYCC
         0pbtJdQDC5E0zThq2PjZkKG1oYLVGxxbcbYUoqsunAjXUr73Tj+wKvRPJ09+ELR9eP0Q
         SATPtGsQkMQABwpDRHpJLhUh9Jf9F6c2Yl+h9mhD8+hMs21GrMS9apESwsZfeqCmC0W4
         fPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F2mXIFJoxgQSUUlnzFgJOWM8Ot6cZehAmrrcYPGKwpk=;
        b=AoveIi6y+iGr5zZgn8C4YkKfkhgjLRCecuAYtflJZswQulB4cAhUlKHKtvEui2cTob
         nGgie/UuMm+KDTUhisEYqxtMYwjT4w5khi2W1hoEF+EsrilLWkr6klOrYjipgF4HTdy2
         sKVNgScVz9ccPoVAcem5XOsPON67dWZzld6NEKQdBrGsb1VvkqSK4rtd1kD7/Vuw1NjN
         ySXPy7T/QDCzQyualuIB1rl/iDnD6FtpLtiUBlBrTPWNUjaHBhltJhEvB4bArA1Fq23t
         eYnrHilvWMvwe2RM4h/JFfH8MSty1VqPV0XrTqaTsUfMMeml7YoIsTK8/0lj4Z+bwrDu
         5hRw==
X-Gm-Message-State: APjAAAUo5kJWE9zlRF9MnC8MGQ/i7UpTjoieaiN1f24k+ZGbUm2j1e0Y
        2m2sIBVG6bzaIwf6H3WKeR+/HTZF6q4vGEZuIw==
X-Google-Smtp-Source: APXvYqwHUGXBtIQeQ1HIBpE8HJTP7o0GzMmeqFA/1WF/RveBFpYyMwCMS7vPEA6ezgHGgx+FPVl+/i97wCgvak9eH6Q=
X-Received: by 2002:a92:1d5a:: with SMTP id d87mr2352819ild.27.1582695954468;
 Tue, 25 Feb 2020 21:45:54 -0800 (PST)
MIME-Version: 1.0
References: <20200225224719.950376311@linutronix.de> <20200225231609.000955823@linutronix.de>
In-Reply-To: <20200225231609.000955823@linutronix.de>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 26 Feb 2020 00:45:43 -0500
Message-ID: <CAMzpN2ij8ReOXZH00puhzraCGRdKY8qt+TMipd_14_XWTu8xtg@mail.gmail.com>
Subject: Re: [patch 01/15] x86/irq: Convey vector as argument and not in ptregs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 6:26 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Device interrupts which go through do_IRQ() or the spurious interrupt
> handler have their separate entry code on 64 bit for no good reason.
>
> Both 32 and 64 bit transport the vector number through ORIG_[RE]AX in
> pt_regs. Further the vector number is forced to fit into an u8 and is
> complemented and offset by 0x80 for historical reasons.

The reason for the 0x80 offset is so that the push instruction only
takes two bytes.  This allows each entry stub to be packed into a
fixed 8 bytes.  idt_setup_apic_and_irq_gates() assumes this 8-byte
fixed length for the stubs, so now every odd vector after 0x80 is
broken.

     508:       6a 7f                   pushq  $0x7f
     50a:       e9 f1 08 00 00          jmpq   e00 <common_interrupt>
     50f:       90                      nop
     510:       68 80 00 00 00          pushq  $0x80
     515:       e9 e6 08 00 00          jmpq   e00 <common_interrupt>
     51a:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)
     520:       68 81 00 00 00          pushq  $0x81
     525:       e9 d6 08 00 00          jmpq   e00 <common_interrupt>
     52a:       66 0f 1f 44 00 00       nopw   0x0(%rax,%rax,1)

The 0x81 vector should start at 0x518, not 0x520.

--
Brian Gerst
