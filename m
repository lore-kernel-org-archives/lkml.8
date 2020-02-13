Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C4FC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5730B2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="gozy+bas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgBMNFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:05:21 -0500
Received: from forwardcorp1j.mail.yandex.net ([5.45.199.163]:41378 "EHLO
        forwardcorp1j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729557AbgBMNFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:05:21 -0500
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net [IPv6:2a02:6b8:0:1619::162])
        by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id D49DE2E14D5;
        Thu, 13 Feb 2020 16:05:18 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
        by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id Hds1iz04gz-5IDauwp8;
        Thu, 13 Feb 2020 16:05:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1581599118; bh=vlY1soaovWElq73pvd6i9YzIPyw/PUzKrWnij6N5dbk=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=gozy+basb5EorvJ2gfiYBU6/FWv7vsFwldBZ+Ec6i4GIzlGceDt04gncLaUPGNmr9
         nVvEgXcQpIyMTxyrcn6rcOJUx7FWVaCN/w4ebVqs4m5dGlxLPTXF7guZIyMAkodImV
         JKqitzDnVvUMZFkLy0nK8+72ddZDlIhMGzREGarA=
Authentication-Results: mxbackcorp1j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:8448:fbcc:1dac:c863])
        by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id lthBqWj1k8-5IWm4Tmu;
        Thu, 13 Feb 2020 16:05:18 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] kernel/watchdog: flush all printk nmi buffers when
 hardlockup detected
To:     Petr Mladek <pmladek@suse.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
References: <158132813726.1980.17382047082627699898.stgit@buzz>
 <e80b3a66-35a3-1386-b35a-94837937956b@virtuozzo.com>
 <c3ce3cee-c757-f76e-8d43-33e9b9ae80ba@yandex-team.ru>
 <20200212145441.ukhvil6tpljsivvl@pathway.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <5b00e7f5-385d-bbc8-886a-d09cc844d07d@yandex-team.ru>
Date:   Thu, 13 Feb 2020 16:05:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200212145441.ukhvil6tpljsivvl@pathway.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/02/2020 17.54, Petr Mladek wrote:
> On Tue 2020-02-11 15:36:02, Konstantin Khlebnikov wrote:
>> On 11/02/2020 11.14, Kirill Tkhai wrote:
>>> Hi, Konstantin,
>>>
>>> On 10.02.2020 12:48, Konstantin Khlebnikov wrote:
>>>> In NMI context printk() could save messages into per-cpu buffers and
>>>> schedule flush by irq_work when IRQ are unblocked. This means message
>>>> about hardlockup appears in kernel log only when/if lockup is gone.
>>>>
>>>> Comment in irq_work_queue_on() states that remote IPI aren't NMI safe
>>>> thus printk() cannot schedule flush work to another cpu.
>>>>
>>>> This patch adds simple atomic counter of detected hardlockups and
>>>> flushes all per-cpu printk buffers in context softlockup watchdog
>>>> at any other cpu when it sees changes of this counter.
>>>>
>>>> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>>>> ---
>>>>    include/linux/nmi.h   |    1 +
>>>>    kernel/watchdog.c     |   22 ++++++++++++++++++++++
>>>>    kernel/watchdog_hld.c |    1 +
>>>>    3 files changed, 24 insertions(+)
>>>>
>>>> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
>>>> index 9003e29cde46..8406df72ae5a 100644
>>>> --- a/include/linux/nmi.h
>>>> +++ b/include/linux/nmi.h
>>>> @@ -84,6 +84,7 @@ static inline void reset_hung_task_detector(void) { }
>>>>    #if defined(CONFIG_HARDLOCKUP_DETECTOR)
>>>>    extern void hardlockup_detector_disable(void);
>>>>    extern unsigned int hardlockup_panic;
>>>> +extern atomic_t hardlockup_detected;
>>>>    #else
>>>>    static inline void hardlockup_detector_disable(void) {}
>>>>    #endif
>>>> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
>>>> index b6b1f54a7837..9f5c68fababe 100644
>>>> --- a/kernel/watchdog.c
>>>> +++ b/kernel/watchdog.c
>>>> @@ -92,6 +92,26 @@ static int __init hardlockup_all_cpu_backtrace_setup(char *str)
>>>>    }
>>>>    __setup("hardlockup_all_cpu_backtrace=", hardlockup_all_cpu_backtrace_setup);
>>>>    # endif /* CONFIG_SMP */
>>>> +
>>>> +atomic_t hardlockup_detected = ATOMIC_INIT(0);
>>>> +
>>>> +static inline void flush_hardlockup_messages(void)
>>>> +{
>>>> +	static atomic_t flushed = ATOMIC_INIT(0);
>>>> +
>>>> +	/* flush messages from hard lockup detector */
>>>> +	if (atomic_read(&hardlockup_detected) != atomic_read(&flushed)) {
>>>> +		atomic_set(&flushed, atomic_read(&hardlockup_detected));
>>>> +		printk_safe_flush();
>>>> +	}
>>>> +}
>>>
>>> Do we really need two variables here? They may come into two different
>>> cache lines, and there will be double cache pollution just because of
>>> this simple check. Why not the below?
>>
>> I don't think anybody could notice read-only access to second variable.
>> This executes once in several seconds.
>>
>> Watchdogs already use same pattern (monotonic counter + snapshot) in
>> couple places. So code looks more clean in this way.
> 
> It is not only about speed. It is also about code complexity
> and correctness. Using two variables is more complex.
> Calling atomic_read(&hardlockup_detected) twice does > not look like a correct pattern.

It guarantees "at least once" which is enough for this case.

> 
> The single variable patter is used for similar things there
> as well, for example, see hard_watchdog_warn,

> hardlockup_allcpu_dumped.

Ouch. This works only once and there is no way to rearm it back.
Now I see why this thing never worked for me recent years =)

Maybe it's better reset sysctl_hardlockup_all_cpu_backtrace
to let user set sysctl back to 1.
Or rearm it back in softlockup watchdog after timeout.

> 
> I would call the variable "hardlockup_dump_flush" and
> use the same logic as for hardlockup_allcpu_dumped.
> 
> Note that simple READ_ONCE(), WRITE_ONCE() are not enough
> because they do not provide smp barriers.

It's hard to imagine arch which actually needs barrires here.
Softlockup timers will eventually see the change.

> 
> Best Regards,
> Petr
> 
