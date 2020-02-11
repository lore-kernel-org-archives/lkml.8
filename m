Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025F8C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 08:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C6820714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 08:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgBKIPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 03:15:12 -0500
Received: from relay.sw.ru ([185.231.240.75]:48194 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727688AbgBKIPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 03:15:11 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j1Qgz-0006ZW-Rk; Tue, 11 Feb 2020 11:14:49 +0300
Subject: Re: [PATCH] kernel/watchdog: flush all printk nmi buffers when
 hardlockup detected
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
References: <158132813726.1980.17382047082627699898.stgit@buzz>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <e80b3a66-35a3-1386-b35a-94837937956b@virtuozzo.com>
Date:   Tue, 11 Feb 2020 11:14:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <158132813726.1980.17382047082627699898.stgit@buzz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Konstantin,

On 10.02.2020 12:48, Konstantin Khlebnikov wrote:
> In NMI context printk() could save messages into per-cpu buffers and
> schedule flush by irq_work when IRQ are unblocked. This means message
> about hardlockup appears in kernel log only when/if lockup is gone.
> 
> Comment in irq_work_queue_on() states that remote IPI aren't NMI safe
> thus printk() cannot schedule flush work to another cpu.
> 
> This patch adds simple atomic counter of detected hardlockups and
> flushes all per-cpu printk buffers in context softlockup watchdog
> at any other cpu when it sees changes of this counter.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  include/linux/nmi.h   |    1 +
>  kernel/watchdog.c     |   22 ++++++++++++++++++++++
>  kernel/watchdog_hld.c |    1 +
>  3 files changed, 24 insertions(+)
> 
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 9003e29cde46..8406df72ae5a 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -84,6 +84,7 @@ static inline void reset_hung_task_detector(void) { }
>  #if defined(CONFIG_HARDLOCKUP_DETECTOR)
>  extern void hardlockup_detector_disable(void);
>  extern unsigned int hardlockup_panic;
> +extern atomic_t hardlockup_detected;
>  #else
>  static inline void hardlockup_detector_disable(void) {}
>  #endif
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index b6b1f54a7837..9f5c68fababe 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -92,6 +92,26 @@ static int __init hardlockup_all_cpu_backtrace_setup(char *str)
>  }
>  __setup("hardlockup_all_cpu_backtrace=", hardlockup_all_cpu_backtrace_setup);
>  # endif /* CONFIG_SMP */
> +
> +atomic_t hardlockup_detected = ATOMIC_INIT(0);
> +
> +static inline void flush_hardlockup_messages(void)
> +{
> +	static atomic_t flushed = ATOMIC_INIT(0);
> +
> +	/* flush messages from hard lockup detector */
> +	if (atomic_read(&hardlockup_detected) != atomic_read(&flushed)) {
> +		atomic_set(&flushed, atomic_read(&hardlockup_detected));
> +		printk_safe_flush();
> +	}
> +}

Do we really need two variables here? They may come into two different
cache lines, and there will be double cache pollution just because of
this simple check. Why not the below?

	if (atomic_read(&hardlockup_detected)) {
		atomic_set(&hardlockup_detected, 0);
		printk_safe_flush();
	}

Or even, since atomic is not needed here, as it does not give any ordering guarantees.
static inline void flush_hardlockup_messages(void)
{
	if (READ_ONCE(&hardlockup_detected)) {
		WRITE_ONCE(&hardlockup_detected, 0);
		printk_safe_flush();
	}
}

watchdog_timer_fn()
{
	...
	WRITE_ONCE(&hardlockup_detected, 1);
	...
}

Kirill
