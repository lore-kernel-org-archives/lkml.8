Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941AEC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C9A2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581375082;
	bh=m0i9+cW/1wLxE5qG+SUHyTwKPJKk1xBCyUzRtHTL5vg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=DOV5eYUKHzzAYyCbjbDg+GmZ2/ymBJnynQE1lh9SWHmtg9EWu3vB5ZK8SJpZT8rMq
	 zyT4hYs3nlzgLZjq5lwBoKq1RQtu7EA1t/GezWUqt3g3yo9AsaeuY0fD4Qxf/ghmvA
	 paYYNCR43KCge9ibBgDPF2LSHz7wLIEUuMLtRcwU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgBJWvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:51:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgBJWvV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:51:21 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EAAC2051A;
        Mon, 10 Feb 2020 22:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581375079;
        bh=m0i9+cW/1wLxE5qG+SUHyTwKPJKk1xBCyUzRtHTL5vg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DCEG/6mT6t0QBg8IK9C4cPHKgSwml5ZJ1DPx72Nl60zWrCsaRguNRs8YJDkJUS4tj
         JEQF1apO5SnlCMyKCn/8KlKbu9Aa9J68rXRPQQttvQl73dhnupjt1FHWViFS1MFCuB
         R3c2271AnjrCCUFLSx7Si9BKDsvVQwihXtu9pFEo=
Date:   Mon, 10 Feb 2020 14:51:18 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: Re: [PATCH] kernel/watchdog: flush all printk nmi buffers when
 hardlockup detected
Message-Id: <20200210145118.1d80e248c9206aeafd5baae6@linux-foundation.org>
In-Reply-To: <158132813726.1980.17382047082627699898.stgit@buzz>
References: <158132813726.1980.17382047082627699898.stgit@buzz>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 12:48:57 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:

> In NMI context printk() could save messages into per-cpu buffers and
> schedule flush by irq_work when IRQ are unblocked. This means message
> about hardlockup appears in kernel log only when/if lockup is gone.

I think I understand what this means.  The hard lockup detector runs at
NMI time but if it detects a lockup within IRQ context it cannot call
printk, because it's within NMI context, where synchronous printk
doesn't work.  Yes?

> Comment in irq_work_queue_on() states that remote IPI aren't NMI safe
> thus printk() cannot schedule flush work to another cpu.
> 
> This patch adds simple atomic counter of detected hardlockups and
> flushes all per-cpu printk buffers in context softlockup watchdog
> at any other cpu when it sees changes of this counter.

And I think this works because the softlockup detector runs within irq
context?

>
> ...
>
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

I don't think this needs to be inlined?

> +{
> +	static atomic_t flushed = ATOMIC_INIT(0);
> +
> +	/* flush messages from hard lockup detector */
> +	if (atomic_read(&hardlockup_detected) != atomic_read(&flushed)) {
> +		atomic_set(&flushed, atomic_read(&hardlockup_detected));
> +		printk_safe_flush();
> +	}
> +}

Could we add some explanatory comments here?  Explain to the reader why
this code exists, what purpose it serves?  Basically a micro version of
the above changelog.

>
> ...
>
