Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385B2C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07430206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHGfYaj4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgAPPuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:50:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:42926 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726151AbgAPPuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:50:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579189807;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9qjdRJbXc7GDehFGTSd1qtPQmmHm0+Hz7gzM1IadAGI=;
        b=CHGfYaj4MmdQRfVGFeuDFs9PB/10xamvyNlmLsPI/oKsi1TB22zJ4GoyXxtcWBGZiFba0u
        bRjLp7TdsgP6E5YCuibm9fIJwDgPgNfR93lGJLFAxcM523cl4VCQFQ9LNSRN4zxpV6oY27
        QZpr7ABRzHng3r5mu6245FrD6++lpt4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-268-8plXZkKpPvyxONbv4ebxHQ-1; Thu, 16 Jan 2020 10:50:03 -0500
X-MC-Unique: 8plXZkKpPvyxONbv4ebxHQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 885C9107ACC9;
        Thu, 16 Jan 2020 15:50:02 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E902F60C84;
        Thu, 16 Jan 2020 15:50:01 +0000 (UTC)
Subject: Re: [PATCH v3 1/8] locking/lockdep: Decrement irq context counters
 when removing lock chain
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20200115214313.13253-1-longman@redhat.com>
 <20200115214313.13253-2-longman@redhat.com>
 <20200116153212.GS2827@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <feb17dde-7017-ef15-5097-412adf8a9cde@redhat.com>
Date:   Thu, 16 Jan 2020 10:50:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200116153212.GS2827@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/20 10:32 AM, Peter Zijlstra wrote:
> On Wed, Jan 15, 2020 at 04:43:06PM -0500, Waiman Long wrote:
>> There are currently three counters to track the irq context of a lock
>> chain - nr_hardirq_chains, nr_softirq_chains and nr_process_chains.
>> They are incremented when a new lock chain is added, but they are
>> not decremented when a lock chain is removed. That causes some of the
>> statistic counts reported by /proc/lockdep_stats to be incorrect.
>>
>> Fix that by decrementing the right counter when a lock chain is removed.
>>
>> Fixes: a0b0fd53e1e6 ("locking/lockdep: Free lock classes that are no longer in use")
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  kernel/locking/lockdep.c           | 36 +++++++++++++++++++++---------
>>  kernel/locking/lockdep_internals.h |  6 +++++
>>  2 files changed, 32 insertions(+), 10 deletions(-)
>>
>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>> index 32282e7112d3..b20fa6236b2a 100644
>> --- a/kernel/locking/lockdep.c
>> +++ b/kernel/locking/lockdep.c
>> @@ -2299,16 +2299,24 @@ static int check_irq_usage(struct task_struct *curr, struct held_lock *prev,
>>  	return 0;
>>  }
>>  
>> -static void inc_chains(void)
>> +static void inc_chains(int irq_context)
>>  {
>> -	if (current->hardirq_context)
>> +	if (irq_context & LOCK_CHAIN_HARDIRQ_CONTEXT)
>>  		nr_hardirq_chains++;
>> -	else {
>> -		if (current->softirq_context)
>> -			nr_softirq_chains++;
>> -		else
>> -			nr_process_chains++;
>> -	}
>> +	else if (irq_context & LOCK_CHAIN_SOFTIRQ_CONTEXT)
>> +		nr_softirq_chains++;
>> +	else
>> +		nr_process_chains++;
>> +}
>> +
>> +static void dec_chains(int irq_context)
>> +{
>> +	if (irq_context & LOCK_CHAIN_HARDIRQ_CONTEXT)
>> +		nr_hardirq_chains--;
>> +	else if (irq_context & LOCK_CHAIN_SOFTIRQ_CONTEXT)
>> +		nr_softirq_chains--;
>> +	else
>> +		nr_process_chains--;
>>  }
>>  
>>  #else
>> @@ -2324,6 +2332,10 @@ static inline void inc_chains(void)
>>  	nr_process_chains++;
>>  }
>>  
>> +static void dec_chains(int irq_context)
>> +{
>> +	nr_process_chains--;
>> +}
>>  #endif /* CONFIG_TRACE_IRQFLAGS */
>>  
> Is there really need for two versions of those functions? Would the
> @irq_context argument not always be 0 in the CONFIG_TRACE_IRQFLAGS=n
> case?
>
You are right. I changed the code so that inc_chains() won't look at
{hard|soft}irq_context directly. So I could take it out of
CONFIG_TRACE_IRQFLAGS as a single version.

I will make the change in the next version.

Cheers,
Longman

