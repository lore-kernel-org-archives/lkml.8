Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31634C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 034BE20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgBEJAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:00:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34803 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbgBEJAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:00:21 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1izGXg-00061C-83; Wed, 05 Feb 2020 10:00:16 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     lijiang <lijiang@redhat.com>, Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
References: <20200128161948.8524-1-john.ogness@linutronix.de>
        <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
        <20200205044848.GH41358@google.com>
        <20200205050204.GI41358@google.com>
        <88827ae2-7af5-347b-29fb-cffb94350f8f@redhat.com>
        <20200205063640.GJ41358@google.com>
Date:   Wed, 05 Feb 2020 10:00:12 +0100
In-Reply-To: <20200205063640.GJ41358@google.com> (Sergey Senozhatsky's message
        of "Wed, 5 Feb 2020 15:36:40 +0900")
Message-ID: <877e11h0ir.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-05, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>>>> So there is a General protection fault. That's the type of a
>>>> problem that kills the boot for me as well (different backtrace,
>>>> tho).
>>> 
>>> Do you have CONFIG_RELOCATABLE and CONFIG_RANDOMIZE_BASE (KASLR)
>>> enabled?
>> 
>> Yes. These two options are enabled.
>> 
>> CONFIG_RELOCATABLE=y
>> CONFIG_RANDOMIZE_BASE=y
>
> So KASLR kills the boot for me. So does KASAN.

Sergey, thanks for looking into this already!

> John, do you see any of these problems on your test machine?

For x86 I have only been using qemu. (For hardware tests I use arm64-smp
in order to verify memory barriers.) With qemu-x86_64 I am unable to
reproduce the problem.

Lianbo, thanks for the report. Can you share your boot args? Anything
special in there (like log_buf_len=, earlyprintk, etc)?

Also, could you share your CONFIG_LOG_* and CONFIG_PRINTK_* options?

I will move to bare metal x86_64 and hopefully see it as well.

John
