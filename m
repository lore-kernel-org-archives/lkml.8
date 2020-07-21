Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C025C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BA7F20729
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="juG+CQsX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3VdtYT2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgGUO5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:57:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40598 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGUO5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:57:19 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595343436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G0hd/HqaHi+sC5Cb/7dGS7Dm/p8jgsSDeWCrD5MiSf4=;
        b=juG+CQsXZv88giGDNbib+yxQ7AH8kThmTUETtnS/AMQXOiZYX3HSdSn2fYZBFcwuYvef6X
        faXflTdSJIBmnO3hCQ8yV5tpRcWctTB4tBaZB8LFwMM8mfFm1Wgwpr0dOnF4A5rrsc8Tnk
        NDkXRXPalGpp7cjP0Uev0oW+rYNr17Ua69V5lH5yY+FgluFWEAUXQgdMVffgWaWMu6kP3M
        4o1hnbqfHm11hfKB8yeOJySZTwpcdr/ku1L3nVZdgBQGG1Qw4tldSqEdRKLX7xnox4zvhK
        GvmtKcPLV2LhtLNlPOcOzHOGC6BqCoWWqJegdEUeBjLNFaCWKVLS2IxqUkcoZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595343436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G0hd/HqaHi+sC5Cb/7dGS7Dm/p8jgsSDeWCrD5MiSf4=;
        b=3VdtYT2N6f8es2zunWzjp7EoGj+vK0PfjSnVPq9/w9hn5A+/lljl6eoSVy9EKWs20R6ySm
        5KA8TAfuhGSYFUDw==
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] printk: store instead of processing cont parts
In-Reply-To: <20200721144220.GE44523@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de> <20200717234818.8622-3-john.ogness@linutronix.de> <20200719143527.GA566@jagdpanzerIV.localdomain> <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com> <20200720015057.GA463@jagdpanzerIV.localdomain> <CAHk-=whqiemoYRE41+qMuwQ_Qw3pn7gy2-Mso=ZDrwxQCVkncg@mail.gmail.com> <20200721144220.GE44523@jagdpanzerIV.localdomain>
Date:   Tue, 21 Jul 2020 17:03:16 +0206
Message-ID: <87ft9kx6er.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-21, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
>> That said, we have traditionally used not just "current process", but
>> also "last irq-level" as the context information, so I do think it
>> would be good to continue to do that.
>
> OK, so basically, extending printk_caller_id() so that for IRQ/NMI
> we will have more info than just "0x80000000 + raw_smp_processor_id()".

If bit31 is set, the upper 8 bits could specify what the lower 24 bits
represent. That would give some freedom for the future.

For example:

0x80 = cpu id (generic context)
0x81 = interrupt number
0x82 = cpu id (nmi context)

Or maybe ascii should be used instead?

0x80 | '\0' = cpu id (generic context)
0x80 | 'i'  = interrupt number
0x80 | 'n'  = cpu id (nmi context)

Just an idea.

John Ogness
