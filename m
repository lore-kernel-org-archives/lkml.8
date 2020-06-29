Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BFCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 438AF2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388978AbgF2UfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:35:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:59512 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732207AbgF2TVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:21:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 63211ADB5;
        Mon, 29 Jun 2020 14:04:46 +0000 (UTC)
Date:   Mon, 29 Jun 2020 16:04:45 +0200
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
Message-ID: <20200629140445.GK6156@alley>
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-4-john.ogness@linutronix.de>
 <20200625082838.GF6156@alley>
 <87sgeh3m5j.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgeh3m5j.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-06-26 17:02:48, John Ogness wrote:
> On 2020-06-25, Petr Mladek <pmladek@suse.com> wrote:
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> +	free = __LOG_BUF_LEN;
> >> +	prb_for_each_record(0, &printk_rb_static, seq, &r)
> >> +		free -= add_to_rb(&printk_rb_dynamic, &r);
> >> +
> >> +	prb = &printk_rb_dynamic;
> >
> > This might deserve a comment that this is safe (no lost message)
> > because it is called early enough when everything is still running
> > on the boot CPU.
> 
> I will add a comment and an extra check to make sure.
> 
> Once everything is lockless, new messages could appear (for example, due
> to NMI messages). The simple check should probably change to a loop. But
> let us not worry about that at this point.

Yup.

> Below is a new version of the relevant patch snippets against mainline
> just to show you how I plan to make it look for the next version.
> 
> John Ogness
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ @@
> +#define PRB_AVGBITS 5	/* 32 character average length */
> +
> +#if CONFIG_LOG_BUF_SHIFT <= PRB_AVGBITS
> +#error CONFIG_LOG_BUF_SHIFT value too small.
> +#endif
> +_DEFINE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
> +		 PRB_AVGBITS, PRB_AVGBITS, &__log_buf[0]);
> +
> @@ @@
>  void __init setup_log_buf(int early)
>  {
> +	unsigned int new_descs_count;
> +	struct prb_desc *new_descs;
> +	struct printk_info info;
> +	struct printk_record r;
> +	size_t new_descs_size;
>  	unsigned long flags;
> +	char *new_dict_buf;
>  	char *new_log_buf;
>  	unsigned int free;
> +	u64 seq;
>  
>  	/*
>  	 * Some archs call setup_log_buf() multiple times - first is very
> @@ @@ void __init setup_log_buf(int early)
>  	if (!new_log_buf_len)
>  		return;
>  
> +	new_descs_count = new_log_buf_len >> PRB_AVGBITS;
> +	if (new_descs_count == 0) {
> +		pr_err("new_log_buf_len: %lu too small\n", new_log_buf_len);
> +		return;
> +	}
> +
>  	new_log_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
>  	if (unlikely(!new_log_buf)) {
> -		pr_err("log_buf_len: %lu bytes not available\n",
> -			new_log_buf_len);
> +		pr_err("log_buf_len: %lu text bytes not available\n",
> +		       new_log_buf_len);
> +		return;
> +	}
> +
> +	new_dict_buf = memblock_alloc(new_log_buf_len, LOG_ALIGN);
> +	if (unlikely(!new_dict_buf)) {
> +		pr_err("log_buf_len: %lu dict bytes not available\n",
> +		       new_log_buf_len);
> +		memblock_free(__pa(new_log_buf), new_log_buf_len);
>  		return;
>  	}
>  
> +	new_descs_size = new_descs_count * sizeof(struct prb_desc);
> +	new_descs = memblock_alloc(new_descs_size, LOG_ALIGN);
> +	if (unlikely(!new_descs)) {
> +		pr_err("log_buf_len: %lu desc bytes not available\n",
> +		       new_descs_size);
> +		memblock_free(__pa(new_dict_buf), new_log_buf_len);
> +		memblock_free(__pa(new_log_buf), new_log_buf_len);
> +		return;
> +	}
> +
> +	prb_rec_init_rd(&r, &info,
> +			&setup_text_buf[0], sizeof(setup_text_buf),
> +			&setup_dict_buf[0], sizeof(setup_dict_buf));
> +
> +	prb_init(&printk_rb_dynamic,
> +		 new_log_buf, order_base_2(new_log_buf_len),
> +		 new_dict_buf, order_base_2(new_log_buf_len),
> +		 new_descs, order_base_2(new_descs_count));

order_base_2() is safe. But the result might be tat some allocated
space is not used.

I would prefer to make sure that new_log_buf_len is rounded, e.g.
by roundup_pow_of_two(), at the beginning of the function. Then we
could use ilog2() here.

Otherwise, it looks fine to me.

Best Regards,
Petr
