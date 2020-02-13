Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C447DC3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62EF2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729731AbgBMJml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:42:41 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51294 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbgBMJml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:42:41 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1j2B13-0006Ng-1r; Thu, 13 Feb 2020 10:42:37 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] printk: use the lockless ringbuffer
References: <20200128161948.8524-1-john.ogness@linutronix.de>
        <20200128161948.8524-3-john.ogness@linutronix.de>
        <20200213090757.GA36551@google.com>
Date:   Thu, 13 Feb 2020 10:42:35 +0100
In-Reply-To: <20200213090757.GA36551@google.com> (Sergey Senozhatsky's message
        of "Thu, 13 Feb 2020 18:07:57 +0900")
Message-ID: <87v9oarfg4.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-13, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com> wrote:
>> -	while (user->seq == log_next_seq) {
>> +	if (!prb_read_valid(prb, user->seq, r)) {
>>  		if (file->f_flags & O_NONBLOCK) {
>>  			ret = -EAGAIN;
>>  			logbuf_unlock_irq();
>> @@ -890,30 +758,26 @@ static ssize_t devkmsg_read(struct file *file, char __user *buf,
>>  
>>  		logbuf_unlock_irq();
>>  		ret = wait_event_interruptible(log_wait,
>> -					       user->seq != log_next_seq);
>> +					prb_read_valid(prb, user->seq, r));
>>  		if (ret)
>>  			goto out;
>>  		logbuf_lock_irq();
>>  	}
>>  
>> -	if (user->seq < log_first_seq) {
>> -		/* our last seen message is gone, return error and reset */
>> -		user->idx = log_first_idx;
>> -		user->seq = log_first_seq;
>> +	if (user->seq < r->info->seq) {
>> +		/* the expected message is gone, return error and reset */
>> +		user->seq = r->info->seq;
>>  		ret = -EPIPE;
>>  		logbuf_unlock_irq();
>>  		goto out;
>>  	}
>
> Sorry, why doesn't this do something like
>
> 	if (user->seq < prb_first_seq(prb)) {
> 		/* the expected message is gone, return error and reset */
> 		user->seq = prb_first_seq(prb);
> 		ret = -EPIPE;
> 		...
> 	}

Here prb_read_valid() was successful, so a record _was_ read. The
kerneldoc for the prb_read_valid() says:

 * On success, the reader must check r->info.seq to see which record was
 * actually read.

The value will either be the requested user->seq or some higher value
because user->seq is not available.

There are 2 reasons why user->seq is not available (and a later record
_is_ available):

1. The ringbuffer overtook user->seq. In this case, comparing and then
   setting using prb_first_seq() could be appropriate. And r->info->seq
   might even already be what prb_first_seq() would return. (More on
   this below.)

2. The record with user->seq has no data because the writer failed to
   allocate dataring space. In this case, resetting back to
   prb_first_seq() would be incorrect. And since r->info->seq is the
   next valid record, it is appropriate that the next devkmsg_read()
   starts there.

Rather than checking these cases separately, it is enough just to check
for the 2nd case. For the 1st case, prb_first_seq() could be less than
r->info->seq if all the preceeding records have no data. But this just
means the whole set of records with missing data are skipped, which
matches existing behavior. (For example, currently when devkmsg is
behind 10 messages, there are not 10 -EPIPE returns. Instead it
immediately catches up to the next available record.)

Perhaps the new comment should be:

/*
 * The expected message is gone, return error and
 * reset to the next available message.
 */

John Ogness
