Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DA7C35E0E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D1F92176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731648AbgBYULj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:11:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54422 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730794AbgBYULi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 15:11:38 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1j6gYH-00024R-8I; Tue, 25 Feb 2020 21:11:33 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: misc details: Re: [PATCH 2/2] printk: use the lockless ringbuffer
References: <20200128161948.8524-1-john.ogness@linutronix.de>
        <20200128161948.8524-3-john.ogness@linutronix.de>
        <20200217144110.xiqlzhs6ynoqdpun@pathway.suse.cz>
Date:   Tue, 25 Feb 2020 21:11:31 +0100
In-Reply-To: <20200217144110.xiqlzhs6ynoqdpun@pathway.suse.cz> (Petr Mladek's
        message of "Mon, 17 Feb 2020 15:41:10 +0100")
Message-ID: <87h7zeqvf0.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> - Record meta-data is now stored in a separate array of descriptors.
>>   This is an additional 72 * (2 ^ ((CONFIG_LOG_BUF_SHIFT - 6))) bytes
>>   for the static array and 72 * (2 ^ ((log_buf_len - 6))) bytes for
>>   the dynamic array.
>
> It might help to show some examples. I mean to mention the sizes
> when CONFIG_LOG_BUF_SHIFT is 12 or so.

OK.

>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> - * Every record carries the monotonic timestamp in microseconds, as well as
>> - * the standard userspace syslog level and syslog facility. The usual
>> + * Every record meta-data carries the monotonic timestamp in microseconds, as
>
> I am afraid that we could not guarantee monotonic timestamp because
> the writers are not synchronized. I hope that it will not create
> real problems and we could just remove the word "monotonic" ;-)

I removed "monotonic". I hope userspace doesn't require the ringbuffer
to be chronologically sorted. That would explain why the safe buffers
use bogus timestamps. :-/

>> +/*
>> + * Define the average message size. This only affects the number of
>> + * descriptors that will be available. Underestimating is better than
>> + * overestimating (too many available descriptors is better than not enough).
>> + * The dictionary buffer will be the same size as the text buffer.
>> + */
>> +#define PRB_AVGBITS 6
>
> Do I get it correctly that '6' means 2^6 = 64 characters?

Correct.

> Some ugly counting on my test systems shows the average 49 chars:
>
> $> dmesg | cut -d ']' -f 2- | wc -c
> 30172
> $> dmesg | cut -d ']' -f 2- | wc -l
> 612
> $> echo $((30172 / 612))
> 49
>
> If I get it correctly then lower number is the more safe side.
> So, a more safe default should be 5?

For v2 the value will be lowered to 5.

>> -	if (log_make_free_space(size)) {
>> +	if (!prb_reserve(&e, prb, &r)) {
>>  		/* truncate the message if it is too long for empty buffer */
>> -		size = truncate_msg(&text_len, &trunc_msg_len,
>> -				    &dict_len, &pad_len);
>> +		truncate_msg(&text_len, &trunc_msg_len, &dict_len);
>> +		r.text_buf_size = text_len + trunc_msg_len;

Note that the additional space for the trunc_msg_len is being reserved.

>> +		r.dict_buf_size = dict_len;
>>  		/* survive when the log buffer is too small for trunc_msg */
>> -		if (log_make_free_space(size))
>> +		if (!prb_reserve(&e, prb, &r))
>>  			return 0;
>>  	}
>>  
>> -	if (log_next_idx + size + sizeof(struct printk_log) > log_buf_len) {
>> -		/*
>> -		 * This message + an additional empty header does not fit
>> -		 * at the end of the buffer. Add an empty header with len == 0
>> -		 * to signify a wrap around.
>> -		 */
>> -		memset(log_buf + log_next_idx, 0, sizeof(struct printk_log));
>> -		log_next_idx = 0;
>> -	}
>> -
>>  	/* fill message */
>> -	msg = (struct printk_log *)(log_buf + log_next_idx);
>> -	memcpy(log_text(msg), text, text_len);
>> -	msg->text_len = text_len;
>> -	if (trunc_msg_len) {
>> -		memcpy(log_text(msg) + text_len, trunc_msg, trunc_msg_len);
>> -		msg->text_len += trunc_msg_len;
>
> Note that the old code updates msg->text_len.

msg->text_len is equivalent to r.info->text_len, which was already set
by the prb_reserve() (and already includes the trunc_msg_len).

>> -	}
>> -	memcpy(log_dict(msg), dict, dict_len);
>> -	msg->dict_len = dict_len;
>> -	msg->facility = facility;
>> -	msg->level = level & 7;
>> -	msg->flags = flags & 0x1f;
>> +	memcpy(&r.text_buf[0], text, text_len);
>> +	if (trunc_msg_len)
>> +		memcpy(&r.text_buf[text_len], trunc_msg, trunc_msg_len);
>
> The new one just appends the string.

That is all it needs to do here.

>> +	if (r.dict_buf)
>> +		memcpy(&r.dict_buf[0], dict, dict_len);
>> +	r.info->facility = facility;
>> +	r.info->level = level & 7;
>> +	r.info->flags = flags & 0x1f;
>>  	if (ts_nsec > 0)
>> -		msg->ts_nsec = ts_nsec;
>> +		r.info->ts_nsec = ts_nsec;
>>  	else
>> -		msg->ts_nsec = local_clock();
>> -#ifdef CONFIG_PRINTK_CALLER
>> -	msg->caller_id = caller_id;
>> -#endif
>> -	memset(log_dict(msg) + dict_len, 0, pad_len);
>> -	msg->len = size;
>> +		r.info->ts_nsec = local_clock();
>> +	r.info->caller_id = caller_id;
>>  
>>  	/* insert message */
>> -	log_next_idx += msg->len;
>> -	log_next_seq++;
>> +	prb_commit(&e);
>>  
>> -	return msg->text_len;
>> +	return text_len;
>
> So, this should be text_len + trunc_msg_len.

Good catch! Yes. Fixed for v2. Thank you.

(Note that simply returning r.info->text_len is not allowed because the
writer must not access that data after calling prb_commit()).

>> @@ -1974,9 +1966,9 @@ asmlinkage int vprintk_emit(int facility, int level,
>>  
>>  	/* This stops the holder of console_sem just where we want him */
>>  	logbuf_lock_irqsave(flags);
>> -	curr_log_seq = log_next_seq;
>> +	pending_output = !prb_read_valid(prb, console_seq, NULL);
>>  	printed_len = vprintk_store(facility, level, dict, dictlen, fmt, args);
>> -	pending_output = (curr_log_seq != log_next_seq);
>> +	pending_output &= prb_read_valid(prb, console_seq, NULL);
>
> The original code checked whether vprintk_store() stored the text
> into the main log buffer or only into the cont buffer.
>
> The new code checks whether console is behind which is something
> different.

I would argue that they are the same thing in this context. Keep in mind
that we are under the logbuf_lock. If there was previously nothing
pending and now there is, this context is the only one that could have
added it.

This logic will change significantly when we remove the locks (and it
will disappear once we go to kthreads). But we aren't that far at this
stage and I'd like to keep the general logic somewhat close to the
current mainline implementation for now.

> I prefer to call wake_up_klogd() directly from log_output() or
> log_store() instead. It might later be used to wake up
> printk kthreads as well.
>
> It was done this way because consoles were historically  preferred
> over userspace loggers. But the difference will be lower when
> consoles are handled by kthread.

Agreed, but that is something I would like to save for a later
series. Right now I only want to replace the ringbuffer without
rearranging priorities.

>> -skip:
>> -		if (console_seq == log_next_seq)
>> -			break;
>> +		console_seq = console_record.info->seq;
>
> This code suggests that it might be possible to get
> console_seq > console_record.info->seq and we just
> ignore it. I prefer to make it clear by:
>
> 		if (console_seq != console_record.info->seq) {

OK.

Thanks for your help.

John Ogness
