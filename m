Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A78DC5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C0820768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgCRQAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:00:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57744 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgCRQAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:00:48 -0400
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jEb7G-0007Tj-3p; Wed, 18 Mar 2020 17:00:22 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Eugeniu Rosca <roscaeugeniu@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [RFC PATCH 2/3] printk: add console_verbose_{start,end}
References: <20200315170903.17393-1-erosca@de.adit-jv.com>
        <20200315170903.17393-3-erosca@de.adit-jv.com>
Date:   Wed, 18 Mar 2020 17:00:20 +0100
In-Reply-To: <20200315170903.17393-3-erosca@de.adit-jv.com> (Eugeniu Rosca's
        message of "Sun, 15 Mar 2020 18:09:02 +0100")
Message-ID: <87o8stmz57.fsf@linutronix.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-15, Eugeniu Rosca <roscaeugeniu@gmail.com> wrote:
> diff --git a/include/linux/printk.h b/include/linux/printk.h
> index 1e6108b8d15f..14755ef7b017 100644
> --- a/include/linux/printk.h
> +++ b/include/linux/printk.h
> @@ -3,6 +3,7 @@
>  #define __KERNEL_PRINTK__
>  
>  #include <stdarg.h>
> +#include <linux/atomic.h>
>  #include <linux/init.h>
>  #include <linux/kern_levels.h>
>  #include <linux/linkage.h>
> @@ -77,6 +78,15 @@ static inline void console_verbose(void)
>  		console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
>  }
>  
> +#ifdef CONFIG_PRINTK
> +extern atomic_t ignore_loglevel;
> +static inline void console_verbose_start(void) { atomic_inc(&ignore_loglevel); }
> +static inline void console_verbose_end(void) { atomic_dec(&ignore_loglevel); }

To be compatible with console_verbose() semantics, this should also
respect console_loglevel=0. Perhaps by updating
suppress_message_printing() to be something like:

static bool suppress_message_printing(int level)
{
        return (!console_loglevel ||
                (level >= console_loglevel && !ignore_loglevel));
}

John Ogness
