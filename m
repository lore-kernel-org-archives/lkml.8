Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D03FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58DDF2088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgGBNbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:31:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:36804 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbgGBNbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:31:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6A47FBC6A;
        Thu,  2 Jul 2020 13:31:50 +0000 (UTC)
Date:   Thu, 2 Jul 2020 15:27:58 +0200
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
Subject: Re: buffer allocation: was: [PATCH v3 3/3] printk: use the lockless
 ringbuffer
Message-ID: <20200702132758.GD14288@alley>
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
 <20200625082838.GF6156@alley>
 <87sgeh3m5j.fsf@jogness.linutronix.de>
 <20200629140445.GK6156@alley>
 <87ftad8rh4.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftad8rh4.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-06-29 23:57:59, John Ogness wrote:
> On 2020-06-29, Petr Mladek <pmladek@suse.com> wrote:
> >> @@ @@ void __init setup_log_buf(int early)
> >> +	prb_init(&printk_rb_dynamic,
> >> +		 new_log_buf, order_base_2(new_log_buf_len),
> >> +		 new_dict_buf, order_base_2(new_log_buf_len),
> >> +		 new_descs, order_base_2(new_descs_count));
> >
> > order_base_2() is safe. But the result might be tat some allocated
> > space is not used.
> >
> > I would prefer to make sure that new_log_buf_len is rounded, e.g.
> > by roundup_pow_of_two(), at the beginning of the function. Then we
> > could use ilog2() here.
> 
> new_log_buf_len can only be set within log_buf_len_update(), and it
> is already doing exactly what you want:
> 
>         if (size)
>                 size = roundup_pow_of_two(size);
>         if (size > log_buf_len)
>                 new_log_buf_len = (unsigned long)size;

I know. I though about repeating this in setup_log_bug() to make it
error proof. But it is not really needed. I do not resist on it.

> I can switch to ilog2() instead of the more conservative order_base_2().

Yes, please change it to ilog2().

Best Regards,
Petr
