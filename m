Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01A5C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0A3220738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbgHTKQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:16:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:36728 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730374AbgHTKQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:16:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0BCDCAD19;
        Thu, 20 Aug 2020 10:16:53 +0000 (UTC)
Date:   Thu, 20 Aug 2020 12:16:25 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] printk: implement pr_cont_t
Message-ID: <20200820101625.GE4353@alley>
References: <20200819232632.13418-1-john.ogness@linutronix.de>
 <20200819232632.13418-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819232632.13418-2-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-08-20 01:32:28, John Ogness wrote:
> Implement a new buffering mechanism for pr_cont messages.
> 
> Old mechanism syntax:
> 
>     printk(KERN_INFO "text");
>     printk(KERN_CONT " continued");
>     printk(KERN_CONT "\n");
> 
> New mechanism syntax:
> 
>     pr_cont_t c;
> 
>     pr_cont_begin(&c, KERN_INFO "text");
>     pr_cont_append(&c, " continued");
>     pr_cont_end(&c);
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  include/linux/printk.h |  19 ++++++
>  kernel/printk/printk.c | 137 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 156 insertions(+)
> 
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 34c1a7be3e01..4d9ce18e4afa 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -380,6 +380,25 @@ extern int kptr_restrict;
>  #define pr_cont(fmt, ...) \
>  	printk(KERN_CONT fmt, ##__VA_ARGS__)
>  
> +/* opaque handle for continuous printk messages */
> +typedef struct {
> +	u8	index;
> +	u8	loglevel;
> +	u16	text_len;
> +} pr_cont_t;
> +
> +/* initialize handle, provide loglevel and initial message text */
> +int pr_cont_begin(pr_cont_t *c, const char *fmt, ...);
> +
> +/* append message text */
> +int pr_cont_append(pr_cont_t *c, const char *fmt, ...);
> +
> +/* flush message to kernel buffer */
> +void pr_cont_flush(pr_cont_t *c);
> +
> +/* flush message to kernel buffer, cleanup handle */
> +void pr_cont_end(pr_cont_t *c);
> +
>  /**
>   * pr_devel - Print a debug-level message conditionally
>   * @fmt: format string
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index ad8d1dfe5fbe..10113e7ea350 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3495,3 +3495,140 @@ void kmsg_dump_rewind(struct kmsg_dumper *dumper)
>  EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
>  
>  #endif
> +
> +#define CONT_LINE_MAX LOG_LINE_MAX
> +#define CONT_BUF_COUNT 10
> +static char cont_buf[CONT_BUF_COUNT][CONT_LINE_MAX];
> +static DECLARE_BITMAP(cont_buf_map, CONT_BUF_COUNT);
> +
> +static int get_cont_buf(void)
> +{
> +	int bit;
> +
> +	do {
> +		bit = find_first_zero_bit(cont_buf_map, CONT_BUF_COUNT);
> +		if (bit == CONT_BUF_COUNT)
> +			break;
> +	} while (test_and_set_bit(bit, cont_buf_map));
> +
> +	return bit;
> +}

My big problem with this solution is a forgotten pr_cont_end(). It
will cause:

   + the message will never get printed

   + several calls into such a broken code will exhaust the pool of
     cont buffers and it will stop working for the entire system

The above might be solved with some fallback mechanism (timer,
watchdog) but then it needs some synchronization.

Why is it so bad?

   + it will happen like other bugs

   + it is hard to notice; it is easier to notice hard-lockup than
     a missing message


Now that I think about it. This is the biggest problem with any temporary buffer
for pr_cont() lines. I am more and more convinced that we should just
_keep the current behavior_. It is not ideal. But sometimes mixed
messages are always better than lost ones.


That said, some printk() API using local buffer would be still
valuable for pieces of code where people really want to avoid
mixed lines. But it should be optional and people should be
aware of the risks.

Best Regards,
Petr
