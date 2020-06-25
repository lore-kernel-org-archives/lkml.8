Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56E4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4E392081A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404451AbgFYMJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:09:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:49128 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404222AbgFYMJt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:09:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24A05ACAE;
        Thu, 25 Jun 2020 12:09:47 +0000 (UTC)
Date:   Thu, 25 Jun 2020 14:09:46 +0200
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
Subject: record_printk_text tricks: was: [PATCH v3 3/3] printk: use the
 lockless ringbuffer
Message-ID: <20200625120946.GG6156@alley>
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

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1344,72 +1304,150 @@ static size_t print_prefix(const struct printk_log *msg, bool syslog,
>  	return len;
>  }
>  
> -static size_t msg_print_text(const struct printk_log *msg, bool syslog,
> -			     bool time, char *buf, size_t size)
> +static size_t record_print_text(struct printk_record *r, bool syslog,
> +				bool time)
>  {
> -	const char *text = log_text(msg);
> -	size_t text_size = msg->text_len;
> -	size_t len = 0;
> +	size_t text_len = r->info->text_len;
> +	size_t buf_size = r->text_buf_size;
> +	char *text = r->text_buf;
>  	char prefix[PREFIX_MAX];
> -	const size_t prefix_len = print_prefix(msg, syslog, time, prefix);
> +	bool truncated = false;
> +	size_t prefix_len;
> +	size_t line_len;
> +	size_t len = 0;
> +	char *next;
>  
> -	do {
> -		const char *next = memchr(text, '\n', text_size);
> -		size_t text_len;
> +	prefix_len = info_print_prefix(r->info, syslog, time, prefix);
>  
> +	/*
> +	 * Add the prefix for each line by shifting the rest of the text to
> +	 * make room for each prefix. If the buffer is not large enough for
> +	 * all the prefixes, then drop the trailing text and report the
> +	 * largest length that includes full lines with their prefixes.

This should go up as the function description.

Sigh, this function does (already did) many subltle decisions. We
should mention them in the description. My current understanding is
the following:

/*
 * Prepare the record for printing. The text is shifted in the given
 * buffer to avoid a need for another one. The following operations
 * are done:
 *
 *   - Add prefix for each line.
 *   - Add the trailing newline that has been removed in vprintk_store().
 *   - Drop truncated lines that do not longer fit into the buffer.
 *
 * Return: The length of the updated text, including the added
 * prefixes, newline. The dropped line(s) are not counted.
 */

> +	 *
> +	 * @text_len: bytes of unprocessed text
> +	 * @line_len: bytes of current line (newline _not_ included)
> +	 * @text:     pointer to beginning of current line
> +	 * @len:      number of bytes processed (size of r->text_buf done)

Please, move this to the variable declaration.

> +	 */
> +	for (;;) {
> +		next = memchr(text, '\n', text_len);
>  		if (next) {
> -			text_len = next - text;
> -			next++;
> -			text_size -= next - text;
> +			line_len = next - text;
>  		} else {
> -			text_len = text_size;
> +			/*
> +			 * No newline. If the text was previously truncated,
> +			 * assume this line was truncated and do not include
> +			 * it.
> +			 */

The word "assume" is confusing. The last line _must_ have been truncated when
"truncated" is set. I would write:

			/* Drop incomplete truncated lines. */

> +			if (truncated)
> +				break;
> +			line_len = text_len;
>  		}
>  
> -		if (buf) {
> -			if (prefix_len + text_len + 1 >= size - len)
> +		/*
> +		 * Ensure there is enough buffer available to shift this line
> +		 * (and add a newline at the end).
> +		 */
> +		if (len + prefix_len + line_len + 1 > buf_size)
> +			break;
> +
> +		/*
> +		 * Ensure there is enough buffer available to shift all
> +		 * remaining text (and add a newline at the end). If this
> +		 * test fails, then there must be a newline (i.e.
> +		 * text_len > line_len because the previous test succeeded).
> +		 */
> +		if (len + prefix_len + text_len + 1 > buf_size) {
> +			/*
> +			 * Truncate @text_len so that there is enough space
> +			 * for a prefix. A newline will not be added because
> +			 * the last line of the text is now truncated and
> +			 * will not be included.
> +			 */
> +			text_len = (buf_size - len) - prefix_len;

This is confusing. The check requires that one more character gets truncated.
And it should be perfectly fine to truncate '\n' from the previous
line. The final '\n' is always added.

There are more problems with this branch. See below for alternative code.

> +
> +			/*
> +			 * Ensure there is still a newline. Otherwise this
> +			 * line may have been truncated and will not be
> +			 * included.
> +			 */
> +			if (memchr(text, '\n', text_len) == NULL)
 >  				break;

This looks superfluous. We do this check only when the first check of "line_len"
passed. It means that at least one line is printable.

I would personally replace this part of the code by:

		/*
		 * Truncate the remaining text when it does not longer
		 * fit into the buffer.
		 *
		 * Note that this check could fail only when
		 * text_len > line_len because the previous check
		 * passed.
		 */
		if (len + prefix_len + text_len + 1 > buf_size) {
			text_len = buf_size - len - prefix_len - 1;
			truncated = 1;
		}

Or we could actually switch the two checks and do:

		/*
		 * Truncate the text if it would not longer fit into
		 * the given buffer.
		 */
		if (len + prefix_len + text_len + 1 > buf_size) {
			text_len = buf_size - len - prefix_len - 1;
			truncated = 1;
		}

		/* Drop even the current line when truncated */
		if (line_len > text_len)
			break;
 

> -			memcpy(buf + len, prefix, prefix_len);
> -			len += prefix_len;
> -			memcpy(buf + len, text, text_len);
> -			len += text_len;
> -			buf[len++] = '\n';
> -		} else {
> -			/* SYSLOG_ACTION_* buffer size only calculation */
> -			len += prefix_len + text_len + 1;
> +			/* Note that the last line will not be included. */
> +			truncated = true;
>  		}
>  
> -		text = next;
> -	} while (text);
> +		memmove(text + prefix_len, text, text_len);
> +		memcpy(text, prefix, prefix_len);
> +
> +		/* Advance beyond the newly added prefix and existing line. */
> +		text += prefix_len + line_len;
> +
> +		/* The remaining text has only decreased by the line. */
> +		text_len -= line_len;
> +
> +		len += prefix_len + line_len + 1;
> +
> +		if (text_len) {
> +			/* Advance past the newline. */
> +			text++;
> +			text_len--;

"text_len" might be zero at this point when the stored string ended
with newline.

It might happen already now when the original text ended by "\n\n".
Only the very last '\n' gets removed in vprintk_store().

It actually looks reasonable to do the extra cycle and printk
the (requested) empty line.

Except that we might end here also when the text was truncated right
before the newline marker. Well, this is a corner case, the string
is truncated anyway, so we could do whatever is easier in this case.


Well, it will need another update after we remove logbuf_lock. I think that
we will need to store the final '\n'. Or at least we would need to
reserve a space for it.

Anyway, it might deserve some comment somewhere. See below for
alternative code.


> +		} else {
> +			/* The final line, add a newline. */
> +			*text = '\n';
> +			break;
> +		}

I do not have strong opinion. The code does things by small steps that
might be checked easily. But it has many steps and it might hide some
subtle catches like the one commented right above.

I wonder if the following would be easier:

		len += prefix_len + line_len + 1;

		/* Add the trailing newline removed in vprintk_store(). */
		if (text_len == line_len) {
			text[prefix_len + line_len] = '\n';
			break;
		}

		/* Advance beyond the added prefix and the related line */
		text += prefix_len + line_len + 1;

		/*
		 * The remaining text has only decreased by the line.
		 *
		 * Special case is when text_len becomes zero. It
		 * happens when the original string ended with "\n\n".
		 * The cycle is correctly repeated and the empty line
		 * with a prefix printed.
		 */
		text_len -= (line_len + 1);
> +	}
>  
>  	return len;
>  }
>  
> +static size_t get_record_text_size(struct printk_info *info,
> +				   unsigned int line_count,
> +				   bool syslog, bool time)
> +{
> +	char prefix[PREFIX_MAX];
> +	size_t prefix_len;
> +
> +	prefix_len = info_print_prefix(info, syslog, time, prefix);
> +
> +	/*
> +	 * Each line will be preceded with a prefix. The intermediate
> +	 * newlines are already within the text, but a final trailing
> +	 * newline will be added.
> +	 */
> +	return ((prefix_len * line_count) + info->text_len + 1);

Note: This might need an update when lockbuf_lock gets removed and the
trailing newline is not longer removed. We will need to explicitly
add it when it was missing.

We might need to check LOG_NEWLINE flag here. Or come with even better
solution.

> +}

Best Regards,
Petr
