Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4247EC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 175BD206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgIAOe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:34:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:48842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727996AbgIAOdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:33:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B7455B16B;
        Tue,  1 Sep 2020 14:33:07 +0000 (UTC)
Date:   Tue, 1 Sep 2020 16:33:06 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v3 5/8] printk: ringbuffer: clear initial reserved
 fields
Message-ID: <20200901143306.GQ4928@alley>
References: <20200831011058.6286-1-john.ogness@linutronix.de>
 <20200831011058.6286-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831011058.6286-6-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-08-31 03:16:55, John Ogness wrote:
> prb_reserve() will set some meta data values and leave others
> uninitialized (or rather, containing the values of the previous
> wrap). Simplify the API by always clearing out all the fields.
> Only the sequence number is filled in. The caller is now
> responsible for filling in the rest of the meta data fields.
> In particular, for correctly filling in text and dict lengths.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
>
> ---
>  kernel/printk/printk.c            |  7 ++++++-
>  kernel/printk/printk_ringbuffer.c | 29 +++++++++++++++++++----------
>  2 files changed, 25 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ad8d1dfe5fbe..7e7d596c8878 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -520,8 +520,11 @@ static int log_store(u32 caller_id, int facility, int level,
>  	memcpy(&r.text_buf[0], text, text_len);
>  	if (trunc_msg_len)
>  		memcpy(&r.text_buf[text_len], trunc_msg, trunc_msg_len);
> -	if (r.dict_buf)
> +	r.info->text_len = text_len + trunc_msg_len;
> +	if (r.dict_buf) {
>  		memcpy(&r.dict_buf[0], dict, dict_len);
> +		r.info->dict_len = dict_len;
> +	}
>  	r.info->facility = facility;
>  	r.info->level = level & 7;
>  	r.info->flags = flags & 0x1f;
> @@ -1078,9 +1081,11 @@ static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
>  		return 0;
>  
>  	memcpy(&dest_r.text_buf[0], &r->text_buf[0], dest_r.text_buf_size);
> +	dest_r.info->text_len = r->info->text_len;

It looks a bit non-consistent that memcpy() copies text_buf_size but valid data
are defined by text_len.

I would prefer to be on the safe size and copy only text_len.

I could imagine some later optimization that will make buf_size bigger
by alignment or something like that. The reason might be preparation
for continuous lines or so. Then the size of the original buffer and
the destination one might differ.

It is unrelated to this patch. I would solve it by a preparation
or followup one.


>  	if (dest_r.dict_buf) {

>  		memcpy(&dest_r.dict_buf[0], &r->dict_buf[0],
>  		       dest_r.dict_buf_size);
> +		dest_r.info->dict_len = r->info->dict_len;

Same here.

>  	}
>  	dest_r.info->facility = r->info->facility;
>  	dest_r.info->level = r->info->level;
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index d66718e74aae..da54d4fadf96 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -1159,6 +1162,18 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
>  
>  	d = to_desc(desc_ring, id);
>  
> +	/*
> +	 * Clear all @info fields except for @seq, which is used to determine
> +	 * the new sequence number. The writer must fill in new values.
> +	 */
> +	d->info.ts_nsec = 0;
> +	d->info.text_len = 0;
> +	d->info.dict_len = 0;
> +	d->info.facility = 0;
> +	d->info.flags = 0;
> +	d->info.level = 0;
> +	d->info.caller_id = 0;

This will be easy to miss when a new field is added in the future.

I would prefer to store @seq into temporary variable and clear
the entire structure by memset(). The new sequence number is
calculated few lines below anyway.


Otherwise, it looks good to me.

Best Regards,
Petr
