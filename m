Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D08C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE50E20781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 15:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405700AbgFYPRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 11:17:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:38988 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405545AbgFYPRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 11:17:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 240A1AF49;
        Thu, 25 Jun 2020 15:17:42 +0000 (UTC)
Date:   Thu, 25 Jun 2020 17:17:41 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: pending output optimization: was: [PATCH v3 3/3] printk: use the
 lockless ringbuffer
Message-ID: <20200625151741.GH8444@alley>
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618144919.9806-4-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-06-18 16:55:19, John Ogness wrote:
> Replace the existing ringbuffer usage and implementation with
> lockless ringbuffer usage. Even though the new ringbuffer does not
> require locking, all existing locking is left in place. Therefore,
> this change is purely replacing the underlining ringbuffer.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2009,9 +2056,9 @@ asmlinkage int vprintk_emit(int facility, int level,
>  
>  	/* This stops the holder of console_sem just where we want him */
>  	logbuf_lock_irqsave(flags);
> -	curr_log_seq = log_next_seq;
> +	pending_output = !prb_read_valid(prb, console_seq, NULL);
>  	printed_len = vprintk_store(facility, level, dict, dictlen, fmt, args);
> -	pending_output = (curr_log_seq != log_next_seq);
> +	pending_output &= prb_read_valid(prb, console_seq, NULL);

This will stop working after we remove the locks. Consoles will be
able to handle messages while the new one is being added. There will
be no gurantee that someone is still hadling the previously pending output.

Please, always handle consoles when printed_len is not zero!!!

The pending output was just an optimization added recently. Nobody
requested it. It was just an idea that made sense.

This new code is a ticking bomb. It is far from obvious that it _must_
get removed after we remove the lock. And it will be hard to debug
why the consoles are sometimes not handled.


>  	logbuf_unlock_irqrestore(flags);
>  
>  	/* If called from the scheduler, we can not call up(). */

Best Regards,
Petr
