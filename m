Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515EBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 217B5207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390612AbgFYIQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 04:16:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:34438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390456AbgFYIQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 04:16:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7C008AEFC;
        Thu, 25 Jun 2020 08:16:51 +0000 (UTC)
Date:   Thu, 25 Jun 2020 10:16:50 +0200
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
Subject: truncate dict: was: Re: [PATCH v3 3/3] printk: use the lockless
 ringbuffer
Message-ID: <20200625081650.GE6156@alley>
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
> @@ -594,22 +473,26 @@ static u32 msg_used_size(u16 text_len, u16 dict_len, u32 *pad_len)
>  #define MAX_LOG_TAKE_PART 4
>  static const char trunc_msg[] = "<truncated>";
>  
> -static u32 truncate_msg(u16 *text_len, u16 *trunc_msg_len,
> -			u16 *dict_len, u32 *pad_len)
> +static void truncate_msg(u16 *text_len, u16 *trunc_msg_len, u16 *dict_len)
>  {
>  	/*
>  	 * The message should not take the whole buffer. Otherwise, it might
>  	 * get removed too soon.
>  	 */
>  	u32 max_text_len = log_buf_len / MAX_LOG_TAKE_PART;
> +
>  	if (*text_len > max_text_len)
>  		*text_len = max_text_len;
> -	/* enable the warning message */
> +
> +	/* enable the warning message (if there is room) */
>  	*trunc_msg_len = strlen(trunc_msg);
> +	if (*text_len >= *trunc_msg_len)
> +		*text_len -= *trunc_msg_len;
> +	else
> +		*trunc_msg_len = 0;
> +
>  	/* disable the "dict" completely */
>  	*dict_len = 0;

The dictionary does not longer need to be removed at this point.
It is stored in a separate buffer. It is ignored by prb_reserve()
when there is not enough space for it.

> -	/* compute the size again, count also the warning message */
> -	return msg_used_size(*text_len + *trunc_msg_len, 0, pad_len);
>  }
>  
>  /* insert record into the buffer, discard old ones, update heads */

Best Regards,
Petr

PS: I am still in the middle of review of this patch. I decided to
send the tree comments that I already have separately.
