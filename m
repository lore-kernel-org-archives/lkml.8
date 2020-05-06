Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2CAC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A3C208D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 14:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729254AbgEFOu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 10:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgEFOu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:50:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA2CC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 07:50:56 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=vostro)
        by Galois.linutronix.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jWLNr-000527-91; Wed, 06 May 2020 16:50:51 +0200
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
Subject: Re: [PATCH v2 3/3] printk: use the lockless ringbuffer
References: <20200501094010.17694-1-john.ogness@linutronix.de>
        <20200501094010.17694-4-john.ogness@linutronix.de>
Date:   Wed, 06 May 2020 16:50:49 +0200
In-Reply-To: <20200501094010.17694-4-john.ogness@linutronix.de> (John Ogness's
        message of "Fri, 1 May 2020 11:46:10 +0206")
Message-ID: <87ftcd86d2.fsf@vostro.fn.ogness.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I discovered a bug while preparing my next series, which also made me
realize I had never tested the extended mode feature of netconsole. :-/
The only other user of extended output is /dev/kmsg, and it is doing it
correctly.

Explanation and patch below.

On 2020-05-01, John Ogness <john.ogness@linutronix.de> wrote:
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 9a9b6156270b..0d74ca748b82 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2395,12 +2443,17 @@ void console_unlock(void)
>  	static char text[LOG_LINE_MAX + PREFIX_MAX];
>  	unsigned long flags;
>  	bool do_cond_resched, retry;
> +	struct printk_info info;
> +	struct printk_record r;
>  
>  	if (console_suspended) {
>  		up_console_sem();
>  		return;
>  	}
>  
> +	prb_rec_init_rd(&r, &info, text, sizeof(text), ext_text,
> +			sizeof(ext_text));
> +

Using @ext_text for the dictionary buffer. But extended mode will need
that buffer for generating extended output!

>  	/*
>  	 * Console drivers are called with interrupts disabled, so
>  	 * @console_may_schedule should be cleared before; however, we may
> @@ -2470,19 +2514,20 @@ void console_unlock(void)
>  			exclusive_console = NULL;
>  		}
>  
> -		len += msg_print_text(msg,
> +		len = record_print_text(&r,
>  				console_msg_format & MSG_FORMAT_SYSLOG,
> -				printk_time, text + len, sizeof(text) - len);
> +				printk_time);
>  		if (nr_ext_console_drivers) {
> -			ext_len = msg_print_ext_header(ext_text,
> +			ext_len = info_print_ext_header(ext_text,
>  						sizeof(ext_text),
> -						msg, console_seq);
> +						r.info);
>  			ext_len += msg_print_ext_body(ext_text + ext_len,
>  						sizeof(ext_text) - ext_len,
> -						log_dict(msg), msg->dict_len,
> -						log_text(msg), msg->text_len);
> +						&r.dict_buf[0],
> +						r.info->dict_len,
> +						&r.text_buf[0],
> +						r.info->text_len);

2 problems here:

First, record_print_text() works by modifying the record text buffer
"in-place". So when msg_print_ext_body() creates the extended output, it
will be using a modified text buffer (i.e. one with prefix added).

Second, info_print_ext_header() and msg_print_ext_body() are clobbering
the dictionary buffer because @ext_text _is_ @r.dict_buf.

This can be resolved by giving the record a separate dictionary buffer
and calling record_print_text() after preparing any extended console
text. Patch below...

John Ogness

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0d74ca748b82..cc79ad67e6e3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2441,6 +2441,7 @@ void console_unlock(void)
 {
 	static char ext_text[CONSOLE_EXT_LOG_MAX];
 	static char text[LOG_LINE_MAX + PREFIX_MAX];
+	static char dict[LOG_LINE_MAX];
 	unsigned long flags;
 	bool do_cond_resched, retry;
 	struct printk_info info;
@@ -2451,8 +2452,7 @@ void console_unlock(void)
 		return;
 	}
 
-	prb_rec_init_rd(&r, &info, text, sizeof(text), ext_text,
-			sizeof(ext_text));
+	prb_rec_init_rd(&r, &info, text, sizeof(text), dict, sizeof(dict));
 
 	/*
 	 * Console drivers are called with interrupts disabled, so
@@ -2514,9 +2514,10 @@ void console_unlock(void)
 			exclusive_console = NULL;
 		}
 
-		len = record_print_text(&r,
-				console_msg_format & MSG_FORMAT_SYSLOG,
-				printk_time);
+		/*
+		 * Handle extended console text first because later
+		 * record_print_text() will modify the record buffer in-place.
+		 */
 		if (nr_ext_console_drivers) {
 			ext_len = info_print_ext_header(ext_text,
 						sizeof(ext_text),
@@ -2528,6 +2529,9 @@ void console_unlock(void)
 						&r.text_buf[0],
 						r.info->text_len);
 		}
+		len = record_print_text(&r,
+				console_msg_format & MSG_FORMAT_SYSLOG,
+				printk_time);
 		console_seq++;
 		raw_spin_unlock(&logbuf_lock);
 
-- 
2.20.1
