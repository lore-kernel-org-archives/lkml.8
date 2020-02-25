Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5085C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B542E20CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbgBYT1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:27:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54360 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731270AbgBYT1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:27:48 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1j6frr-0001Sp-KB; Tue, 25 Feb 2020 20:27:43 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        lijiang <lijiang@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] printk: replace ringbuffer
References: <dc4ca9b5-d2a2-03af-c186-204a3aad2399@redhat.com>
        <20200205044848.GH41358@google.com>
        <20200205050204.GI41358@google.com>
        <88827ae2-7af5-347b-29fb-cffb94350f8f@redhat.com>
        <20200205063640.GJ41358@google.com> <877e11h0ir.fsf@linutronix.de>
        <20200205110522.GA456@jagdpanzerIV.localdomain>
        <87wo919grz.fsf@linutronix.de>
        <20200214155639.m5yp3rd2t3vdzfj7@pathway.suse.cz>
        <87blpxbh62.fsf@linutronix.de>
        <20200217145016.7r6b7i5o6tqkaa2x@pathway.suse.cz>
Date:   Tue, 25 Feb 2020 20:27:40 +0100
In-Reply-To: <20200217145016.7r6b7i5o6tqkaa2x@pathway.suse.cz> (Petr Mladek's
        message of "Mon, 17 Feb 2020 15:50:16 +0100")
Message-ID: <87lfoqqxg3.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-17, Petr Mladek <pmladek@suse.com> wrote:
> Alternative solution would be to get rid of record_print_text()
> and use record_print_text_inline() everywhere. It will have some
> advantages:
>
>   + _inline() variant will get real testing
>   + no code duplication
>   + saving the extra buffer also in console, sysfs, and devkmsg
>     interface.

In preparation for my v2, I implemented this alternate approach. Rather
than introducing record_print_text_inline(), I changed
record_print_text() to work inline and also it will no longer handle the
counting case. The callers of record_print_text() for counting will now
call the new counting functions. IMHO it is a nice cleanup and also
removes the static printk_record structs for console and syslog.

Thanks.

John Ogness
