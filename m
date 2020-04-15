Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEF5C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 202DD206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441753AbgDOTO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:14:56 -0400
Received: from mail.monom.org ([188.138.9.77]:40386 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgDOTFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:05:18 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id D23AE500699;
        Wed, 15 Apr 2020 21:05:14 +0200 (CEST)
Received: from [192.168.154.205] (b9168f17.cgn.dg-w.de [185.22.143.23])
        by mail.monom.org (Postfix) with ESMTPSA id 91DFF50029E;
        Wed, 15 Apr 2020 21:05:14 +0200 (CEST)
Subject: Re: [PATCH RT] signal: Prevent double-free of user struct
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Matt Fleming <matt@codeblueprint.co.uk>
Cc:     linux-rt@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200407095413.30039-1-matt@codeblueprint.co.uk>
 <20200415164628.2dgrj4ghvtev45sy@linutronix.de>
From:   Daniel Wagner <wagi@monom.org>
Message-ID: <f8152ef5-f71d-b8b6-fe9e-6a8678930775@monom.org>
Date:   Wed, 15 Apr 2020 21:05:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200415164628.2dgrj4ghvtev45sy@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 15.04.20 18:46, Sebastian Andrzej Siewior wrote:
> On 2020-04-07 10:54:13 [+0100], Matt Fleming wrote:
>> The way user struct reference counting works changed significantly with,
>>
>>    fda31c50292a ("signal: avoid double atomic counter increments for user accounting")
>>
>> Now user structs are only freed once the last pending signal is
>> dequeued. Make sigqueue_free_current() follow this new convention to
>> avoid freeing the user struct multiple times and triggering this
>> warning:
>>
>>   refcount_t: underflow; use-after-free.
>>   WARNING: CPU: 0 PID: 6794 at lib/refcount.c:288 refcount_dec_not_one+0x45/0x50
>>   Call Trace:
>>    refcount_dec_and_lock_irqsave+0x16/0x60
>>    free_uid+0x31/0xa0
>>    ? schedule_hrtimeout_range_clock+0x104/0x110
>>    __dequeue_signal+0x17c/0x190
>>    dequeue_signal+0x5a/0x1b0
>>    do_sigtimedwait+0x208/0x250
>>    __x64_sys_rt_sigtimedwait+0x6f/0xd0
>>    do_syscall_64+0x72/0x200
>>    entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> While all this sounds reasonable, may I ask what did you do to trigger
> this?

This can be triggered by running sigwaittest.

  # sigwaittest -t -a -p 98

a few seconds should be enough to get the splat.

> This is v5.6 only, correct?

I've seen this also with a frankstein version of 5.2-rt...v5-4-rt :)

Thanks,
Daniel
