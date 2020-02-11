Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30298C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA112082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="BAngbQdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgBKMgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:36:09 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:45284 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728569AbgBKMgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:36:08 -0500
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 95ECF2E1571;
        Tue, 11 Feb 2020 15:36:05 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id 3X5JnAeaY3-a2SSqjcG;
        Tue, 11 Feb 2020 15:36:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1581424565; bh=q176fyOTHeCFZPwNhYi62BgfveAU8A5u2bcO5LHzBwk=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=BAngbQdLiuYRw5IQMumFj5q/9+g6/v5o4Jcc3xp1GJdXUa8P59HI76GcHQzSoeH8X
         at+V/KvDEb88lcyZTA8G4MsgqVWg0wqQS/hFnxGa7Oo7k1V0VClVA/oEgWy6CofH5v
         QnDPf5t7FOL6rJXVrOvnNw9PalshFBQ/BsmsxjNg=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id mevy9sDSpZ-a2WObhD5;
        Tue, 11 Feb 2020 15:36:02 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] kernel/watchdog: flush all printk nmi buffers when
 hardlockup detected
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
References: <158132813726.1980.17382047082627699898.stgit@buzz>
 <e80b3a66-35a3-1386-b35a-94837937956b@virtuozzo.com>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <c3ce3cee-c757-f76e-8d43-33e9b9ae80ba@yandex-team.ru>
Date:   Tue, 11 Feb 2020 15:36:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e80b3a66-35a3-1386-b35a-94837937956b@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2020 11.14, Kirill Tkhai wrote:
> Hi, Konstantin,
> 
> On 10.02.2020 12:48, Konstantin Khlebnikov wrote:
>> In NMI context printk() could save messages into per-cpu buffers and
>> schedule flush by irq_work when IRQ are unblocked. This means message
>> about hardlockup appears in kernel log only when/if lockup is gone.
>>
>> Comment in irq_work_queue_on() states that remote IPI aren't NMI safe
>> thus printk() cannot schedule flush work to another cpu.
>>
>> This patch adds simple atomic counter of detected hardlockups and
>> flushes all per-cpu printk buffers in context softlockup watchdog
>> at any other cpu when it sees changes of this counter.
>>
>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> ---
>>   include/linux/nmi.h   |    1 +
>>   kernel/watchdog.c     |   22 ++++++++++++++++++++++
>>   kernel/watchdog_hld.c |    1 +
>>   3 files changed, 24 insertions(+)
>>
>> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
>> index 9003e29cde46..8406df72ae5a 100644
>> --- a/include/linux/nmi.h
>> +++ b/include/linux/nmi.h
>> @@ -84,6 +84,7 @@ static inline void reset_hung_task_detector(void) { }
>>   #if defined(CONFIG_HARDLOCKUP_DETECTOR)
>>   extern void hardlockup_detector_disable(void);
>>   extern unsigned int hardlockup_panic;
>> +extern atomic_t hardlockup_detected;
>>   #else
>>   static inline void hardlockup_detector_disable(void) {}
>>   #endif
>> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
>> index b6b1f54a7837..9f5c68fababe 100644
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
> Do we really need two variables here? They may come into two different
> cache lines, and there will be double cache pollution just because of
> this simple check. Why not the below?

I don't think anybody could notice read-only access to second variable.
This executes once in several seconds.

Watchdogs already use same pattern (monotonic counter + snapshot) in
couple places. So code looks more clean in this way.

> 
> 	if (atomic_read(&hardlockup_detected)) {
> 		atomic_set(&hardlockup_detected, 0);
> 		printk_safe_flush();
> 	}
> 
> Or even, since atomic is not needed here, as it does not give any ordering guarantees.
> static inline void flush_hardlockup_messages(void)
> {
> 	if (READ_ONCE(&hardlockup_detected)) {
> 		WRITE_ONCE(&hardlockup_detected, 0);
> 		printk_safe_flush();
> 	}
> }
> 
> watchdog_timer_fn()
> {
> 	...
> 	WRITE_ONCE(&hardlockup_detected, 1);
> 	...
> }
> 
> Kirill
> 
