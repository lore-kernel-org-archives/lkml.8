Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A2DC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B8120848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="C7xXwWup"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgBKLBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:01:47 -0500
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:42640 "EHLO
        forwardcorp1p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727561AbgBKLBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:01:46 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 1CA8C2E1509;
        Tue, 11 Feb 2020 14:01:43 +0300 (MSK)
Received: from vla1-5a8b76e65344.qloud-c.yandex.net (vla1-5a8b76e65344.qloud-c.yandex.net [2a02:6b8:c0d:3183:0:640:5a8b:76e6])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id uuNmbJRWHZ-1fwah6J4;
        Tue, 11 Feb 2020 14:01:43 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1581418903; bh=2Xbc/G4HLuNS66czzvGe9shTtQ4Wgx5bZ9iyl5Ggh7E=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=C7xXwWupWc/juaQwdGehGusghyJxCb1/TQFkVxvl8ZiHKdk7lfVLeXyQqny7PLoOB
         Ux3pCZG89KuHkOOQWW8JzdpWRStVBqBWOIvCAXMGDiDnoWka8gFyBKgT0wcFZy2mu5
         5HWG1CYSP+gYR8NhWVjxJ/aBpp0MaqQMz3TeLxFM=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by vla1-5a8b76e65344.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id S3AaTnpdnZ-1fXebOWm;
        Tue, 11 Feb 2020 14:01:41 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] kernel/watchdog: flush all printk nmi buffers when
 hardlockup detected
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
References: <158132813726.1980.17382047082627699898.stgit@buzz>
 <20200210145118.1d80e248c9206aeafd5baae6@linux-foundation.org>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <d1edeed5-9247-4ec7-d4b8-a6b5bea354d8@yandex-team.ru>
Date:   Tue, 11 Feb 2020 14:01:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200210145118.1d80e248c9206aeafd5baae6@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2020 01.51, Andrew Morton wrote:
> On Mon, 10 Feb 2020 12:48:57 +0300 Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:
> 
>> In NMI context printk() could save messages into per-cpu buffers and
>> schedule flush by irq_work when IRQ are unblocked. This means message
>> about hardlockup appears in kernel log only when/if lockup is gone.
> 
> I think I understand what this means.  The hard lockup detector runs at
> NMI time but if it detects a lockup within IRQ context it cannot call
> printk, because it's within NMI context, where synchronous printk
> doesn't work.  Yes?

Yes. Printing from hardlockup watchdog is only special case.
Without it irq-work will flush per-cpu buffer right after enabling irq.

> 
>> Comment in irq_work_queue_on() states that remote IPI aren't NMI safe
>> thus printk() cannot schedule flush work to another cpu.
>>
>> This patch adds simple atomic counter of detected hardlockups and
>> flushes all per-cpu printk buffers in context softlockup watchdog
>> at any other cpu when it sees changes of this counter.
> 
> And I think this works because the softlockup detector runs within irq
> context?

Yes. Softlockuo watchdog is a timer. It could use normal printk and
flush per-cpu buffers. Any periodically executed code could do that
but softlockup is most logical place for that.

There is forward signal from softlockup to hardlockup wathdogs in
per-cpu counter hrtimer_interrupts (increment means cpu in't in
hardlockup). This patch adds backward signal from hardlockup to
softlocup detector that some cpus are in hardlockup.

> 
>>
>> ...
>>
>> --- a/kernel/watchdog.c
>> +++ b/kernel/watchdog.c
>> @@ -92,6 +92,26 @@ static int __init hardlockup_all_cpu_backtrace_setup(char *str)
>>   }
>>   __setup("hardlockup_all_cpu_backtrace=", hardlockup_all_cpu_backtrace_setup);
>>   # endif /* CONFIG_SMP */
>> +
>> +atomic_t hardlockup_detected = ATOMIC_INIT(0);
>> +
>> +static inline void flush_hardlockup_messages(void)
> 
> I don't think this needs to be inlined?
> 
>> +{
>> +	static atomic_t flushed = ATOMIC_INIT(0);
>> +
>> +	/* flush messages from hard lockup detector */
>> +	if (atomic_read(&hardlockup_detected) != atomic_read(&flushed)) {
>> +		atomic_set(&flushed, atomic_read(&hardlockup_detected));
>> +		printk_safe_flush();
>> +	}
>> +}
> 
> Could we add some explanatory comments here?  Explain to the reader why
> this code exists, what purpose it serves?  Basically a micro version of
> the above changelog.

Hmm. This seems obvious from names of variables and called function.
Both watchdogs use same patterns: monotonic counter and side variable
with snapshot to detect changes or stalls.

> 
>>
>> ...
>>
