Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F29EC34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28B6920718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgBQOlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:41:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:34222 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728817AbgBQOlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:41:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6786EB489;
        Mon, 17 Feb 2020 14:41:12 +0000 (UTC)
Date:   Mon, 17 Feb 2020 15:41:10 +0100
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
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: misc details: Re: [PATCH 2/2] printk: use the lockless ringbuffer
Message-ID: <20200217144110.xiqlzhs6ynoqdpun@pathway.suse.cz>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <20200128161948.8524-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128161948.8524-3-john.ogness@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-01-28 17:25:48, John Ogness wrote:
> Replace the existing ringbuffer usage and implementation with
> lockless ringbuffer usage. Even though the new ringbuffer does not
> require locking, all existing locking is left in place. Therefore,
> this change is purely replacing the underlining ringbuffer.
> 
> - Record meta-data is now stored in a separate array of descriptors.
>   This is an additional 72 * (2 ^ ((CONFIG_LOG_BUF_SHIFT - 6))) bytes
>   for the static array and 72 * (2 ^ ((log_buf_len - 6))) bytes for
>   the dynamic array.

It might help to show some examples. I mean to mention the sizes
when CONFIG_LOG_BUF_SHIFT is 12 or so.


> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -294,30 +295,22 @@ enum con_msg_format_flags {
>  static int console_msg_format = MSG_FORMAT_DEFAULT;
>  
>  /*
> - * The printk log buffer consists of a chain of concatenated variable
> - * length records. Every record starts with a record header, containing
> - * the overall length of the record.
> + * The printk log buffer consists of a sequenced collection of records, each
> + * containing variable length message and dictionary text. Every record
> + * also contains its own meta-data (@info).
>   *
> - * The heads to the first and last entry in the buffer, as well as the
> - * sequence numbers of these entries are maintained when messages are
> - * stored.
> - *
> - * If the heads indicate available messages, the length in the header
> - * tells the start next message. A length == 0 for the next message
> - * indicates a wrap-around to the beginning of the buffer.
> - *
> - * Every record carries the monotonic timestamp in microseconds, as well as
> - * the standard userspace syslog level and syslog facility. The usual
> + * Every record meta-data carries the monotonic timestamp in microseconds, as

I am afraid that we could not guarantee monotonic timestamp because
the writers are not synchronized. I hope that it will not create
real problems and we could just remove the word "monotonic" ;-)


>  /* record buffer */
> -#define LOG_ALIGN __alignof__(struct printk_log)
> +#define LOG_ALIGN __alignof__(unsigned long)
>  #define __LOG_BUF_LEN (1 << CONFIG_LOG_BUF_SHIFT)
>  #define LOG_BUF_LEN_MAX (u32)(1 << 31)
>  static char __log_buf[__LOG_BUF_LEN] __aligned(LOG_ALIGN);
>  static char *log_buf = __log_buf;
>  static u32 log_buf_len = __LOG_BUF_LEN;
>  
> +/*
> + * Define the average message size. This only affects the number of
> + * descriptors that will be available. Underestimating is better than
> + * overestimating (too many available descriptors is better than not enough).
> + * The dictionary buffer will be the same size as the text buffer.
> + */
> +#define PRB_AVGBITS 6

Do I get it correctly that '6' means 2^6 = 64 characters?

Some ugly counting on my test systems shows the average 49 chars:

$> dmesg | cut -d ']' -f 2- | wc -c
30172
$> dmesg | cut -d ']' -f 2- | wc -l
612
$> echo $((30172 / 612))
49

If I get it correctly then lower number is the more safe side.
So, a more safe default should be 5?


> +
> +_DECLARE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
> +		  PRB_AVGBITS, PRB_AVGBITS, &__log_buf[0]);
> +


> @@ -606,60 +488,42 @@ static int log_store(u32 caller_id, int facility, int level,
>  		     const char *dict, u16 dict_len,
>  		     const char *text, u16 text_len)
>  {
> -	struct printk_log *msg;
> -	u32 size, pad_len;
> +	struct prb_reserved_entry e;
> +	struct printk_record r;
>  	u16 trunc_msg_len = 0;
>  
> -	/* number of '\0' padding bytes to next message */
> -	size = msg_used_size(text_len, dict_len, &pad_len);
> +	r.text_buf_size = text_len;
> +	r.dict_buf_size = dict_len;
>  
> -	if (log_make_free_space(size)) {
> +	if (!prb_reserve(&e, prb, &r)) {
>  		/* truncate the message if it is too long for empty buffer */
> -		size = truncate_msg(&text_len, &trunc_msg_len,
> -				    &dict_len, &pad_len);
> +		truncate_msg(&text_len, &trunc_msg_len, &dict_len);
> +		r.text_buf_size = text_len + trunc_msg_len;
> +		r.dict_buf_size = dict_len;
>  		/* survive when the log buffer is too small for trunc_msg */
> -		if (log_make_free_space(size))
> +		if (!prb_reserve(&e, prb, &r))
>  			return 0;
>  	}
>  
> -	if (log_next_idx + size + sizeof(struct printk_log) > log_buf_len) {
> -		/*
> -		 * This message + an additional empty header does not fit
> -		 * at the end of the buffer. Add an empty header with len == 0
> -		 * to signify a wrap around.
> -		 */
> -		memset(log_buf + log_next_idx, 0, sizeof(struct printk_log));
> -		log_next_idx = 0;
> -	}
> -
>  	/* fill message */
> -	msg = (struct printk_log *)(log_buf + log_next_idx);
> -	memcpy(log_text(msg), text, text_len);
> -	msg->text_len = text_len;
> -	if (trunc_msg_len) {
> -		memcpy(log_text(msg) + text_len, trunc_msg, trunc_msg_len);
> -		msg->text_len += trunc_msg_len;

Note that the old code updates msg->text_len.


> -	}
> -	memcpy(log_dict(msg), dict, dict_len);
> -	msg->dict_len = dict_len;
> -	msg->facility = facility;
> -	msg->level = level & 7;
> -	msg->flags = flags & 0x1f;
> +	memcpy(&r.text_buf[0], text, text_len);
> +	if (trunc_msg_len)
> +		memcpy(&r.text_buf[text_len], trunc_msg, trunc_msg_len);

The new one just appends the string.


> +	if (r.dict_buf)
> +		memcpy(&r.dict_buf[0], dict, dict_len);
> +	r.info->facility = facility;
> +	r.info->level = level & 7;
> +	r.info->flags = flags & 0x1f;
>  	if (ts_nsec > 0)
> -		msg->ts_nsec = ts_nsec;
> +		r.info->ts_nsec = ts_nsec;
>  	else
> -		msg->ts_nsec = local_clock();
> -#ifdef CONFIG_PRINTK_CALLER
> -	msg->caller_id = caller_id;
> -#endif
> -	memset(log_dict(msg) + dict_len, 0, pad_len);
> -	msg->len = size;
> +		r.info->ts_nsec = local_clock();
> +	r.info->caller_id = caller_id;
>  
>  	/* insert message */
> -	log_next_idx += msg->len;
> -	log_next_seq++;
> +	prb_commit(&e);
>  
> -	return msg->text_len;
> +	return text_len;

So, this should be text_len + trunc_msg_len.


>  }
>  
>  int dmesg_restrict = IS_ENABLED(CONFIG_SECURITY_DMESG_RESTRICT);
> @@ -1974,9 +1966,9 @@ asmlinkage int vprintk_emit(int facility, int level,
>  
>  	/* This stops the holder of console_sem just where we want him */
>  	logbuf_lock_irqsave(flags);
> -	curr_log_seq = log_next_seq;
> +	pending_output = !prb_read_valid(prb, console_seq, NULL);
>  	printed_len = vprintk_store(facility, level, dict, dictlen, fmt, args);
> -	pending_output = (curr_log_seq != log_next_seq);
> +	pending_output &= prb_read_valid(prb, console_seq, NULL);

The original code checked whether vprintk_store() stored the text
into the main log buffer or only into the cont buffer.

The new code checks whether console is behind which is something
different.

I prefer to call wake_up_klogd() directly from log_output() or
log_store() instead. It might later be used to wake up
printk kthreads as well.

It was done this way because consoles were historically  preferred
over userspace loggers. But the difference will be lower when
consoles are handled by kthread.


>  	logbuf_unlock_irqrestore(flags);
>  
>  	/* If called from the scheduler, we can not call up(). */
> @@ -2406,35 +2405,28 @@ void console_unlock(void)
>  	}
>  
>  	for (;;) {
> -		struct printk_log *msg;
>  		size_t ext_len = 0;
> -		size_t len;
> +		size_t len = 0;
>  
>  		printk_safe_enter_irqsave(flags);
>  		raw_spin_lock(&logbuf_lock);
> -		if (console_seq < log_first_seq) {
> +skip:
> +		if (!prb_read_valid(prb, console_seq, &console_record))
> +			break;
> +
> +		if (console_seq < console_record.info->seq) {
>  			len = sprintf(text,
>  				      "** %llu printk messages dropped **\n",
> -				      log_first_seq - console_seq);
> -
> -			/* messages are gone, move to first one */
> -			console_seq = log_first_seq;
> -			console_idx = log_first_idx;
> -		} else {
> -			len = 0;
> +				      console_record.info->seq - console_seq);
>  		}
> -skip:
> -		if (console_seq == log_next_seq)
> -			break;
> +		console_seq = console_record.info->seq;

This code suggests that it might be possible to get
console_seq > console_record.info->seq and we just
ignore it. I prefer to make it clear by:

		if (console_seq != console_record.info->seq) {
			len = sprintf(text,
				      "** %llu printk messages dropped **\n",
				      log_first_seq - console_seq);
			console_seq = console_record.info->seq;
		}





> -		msg = log_from_idx(console_idx);
> -		if (suppress_message_printing(msg->level)) {
> +		if (suppress_message_printing(console_record.info->level)) {
>  			/*
>  			 * Skip record we have buffered and already printed
>  			 * directly to the console when we received it, and
>  			 * record that has level above the console loglevel.
>  			 */
> -			console_idx = log_next(console_idx);
>  			console_seq++;
>  			goto skip;
>  		}

Otherwise, it looks reasonable.

Best Regards,
Petr

PS: I still have to look at the VMCORE interface, do some testing,
and looks at changes in the 1st patch against the previous version.
