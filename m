Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A783C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E67221569
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIqGK+EP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgAMNoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:44:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51612 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726934AbgAMNoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:44:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578923045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AqBRApPWTS4UYgbRglBP86D95EvSqTw+5TZoVneRKdM=;
        b=FIqGK+EP8Q1qAUP00AsWGNB5sn5iIhWZyp+cgRNM1eqtLHfVaEXwU4S0GMW36mcwDUYMqW
        ilwwGZf2kmRkPIqA7+IY1zFwQDk+cODKlMsXgL09FkSKwniKD5cs0gIxpoJNOLa46Z2hfP
        gB0qygL0vB/tmMO1Dc569gpmzCWr2Ek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-4hpGEeUuMIueudT7ttaOyg-1; Mon, 13 Jan 2020 08:44:02 -0500
X-MC-Unique: 4hpGEeUuMIueudT7ttaOyg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 766961007310;
        Mon, 13 Jan 2020 13:44:00 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48EF960BF4;
        Mon, 13 Jan 2020 13:43:59 +0000 (UTC)
Subject: Re: [PATCH v2] locking/osq: Use optimized spinning loop for arm64
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org
References: <20200112235854.32089-1-longman@redhat.com>
 <20200113115715.GA3260@willie-the-truck>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <a4233fec-89e7-08e2-01a6-35a2ffb289b1@redhat.com>
Date:   Mon, 13 Jan 2020 08:43:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200113115715.GA3260@willie-the-truck>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/20 6:57 AM, Will Deacon wrote:
> [+Marc]
>
> On Sun, Jan 12, 2020 at 06:58:54PM -0500, Waiman Long wrote:
>> Arm64 has a more optimized spinning loop (atomic_cond_read_acquire)
>> for spinlock that can boost performance of sibling threads by putting
>> the current cpu to a shallow sleep state that is woken up only when
>> the monitored variable changes or an external event happens.
>>
>> OSQ has a more complicated spinning loop. Besides the lock value, it
>> also checks for need_resched() and vcpu_is_preempted(). The check for
>> need_resched() is not a problem as it is only set by the tick interrupt
>> handler. That will be detected by the spinning cpu right after iret.
>>
>> The vcpu_is_preempted() check, however, is a problem as changes to the
>> preempt state of of previous node will not affect the sleep state. For
>> ARM64, vcpu_is_preempted is not defined and so is a no-op. To guard
>> against future addition of vcpu_is_preempted() to arm64, code is added
>> to cause build error when vcpu_is_preempted becomes defined in arm64
>> without the corresponding changes in the OSQ spinning code.
>>
>> On a 2-socket 56-core 224-thread ARM64 system, a kernel mutex locking
>> microbenchmark was run for 10s with and without the patch. The
>> performance numbers before patch were:
>>
>> Running locktest with mutex [runtime = 10s, load = 1]
>> Threads = 224, Min/Mean/Max = 316/123,143/2,121,269
>> Threads = 224, Total Rate = 2,757 kop/s; Percpu Rate = 12 kop/s
>>
>> After patch, the numbers were:
>>
>> Running locktest with mutex [runtime = 10s, load = 1]
>> Threads = 224, Min/Mean/Max = 334/147,836/1,304,787
>> Threads = 224, Total Rate = 3,311 kop/s; Percpu Rate = 15 kop/s
>>
>> So there was about 20% performance improvement.
>>
>> Signed-off-by: Waiman Long <longman@redhat.com>
>> ---
>>  arch/arm64/include/asm/barrier.h | 10 ++++++++++
>>  kernel/locking/osq_lock.c        | 25 ++++++++++++-------------
>>  2 files changed, 22 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
>> index 7d9cc5ec4971..8eb5f1239885 100644
>> --- a/arch/arm64/include/asm/barrier.h
>> +++ b/arch/arm64/include/asm/barrier.h
>> @@ -152,6 +152,16 @@ do {									\
>>  	VAL;								\
>>  })
>>  
>> +/*
>> + * In osq_lock(), smp_cond_load_relaxed() is called with a condition
>> + * that includes vcpu_is_preempted(). For arm64, vcpu_is_preempted is not
>> + * currently defined. So it is a no-op. If vcpu_is_preempted is defined in
>> + * the future, smp_cond_load_relaxed() will not response to changes in the
>> + * preempt state in a timely manner. So code changes will have to be made
>> + * to address this deficiency.
>> + */
>> +#define vcpu_is_preempted_not_used
>> +
>>  #define smp_cond_load_acquire(ptr, cond_expr)				\
>>  ({									\
>>  	typeof(ptr) __PTR = (ptr);					\
>> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
>> index 6ef600aa0f47..69ec5161c3cc 100644
>> --- a/kernel/locking/osq_lock.c
>> +++ b/kernel/locking/osq_lock.c
>> @@ -13,6 +13,14 @@
>>   */
>>  static DEFINE_PER_CPU_SHARED_ALIGNED(struct optimistic_spin_node, osq_node);
>>  
>> +/*
>> + * The optimized smp_cond_load_relaxed() spin loop should not be used with
>> + * vcpu_is_preempted defined.
>> + */
>> +#if defined(vcpu_is_preempted) && defined(vcpu_is_preempted_not_used)
>> +#error "vcpu_is_preempted() inside smp_cond_load_relaxed() may not work!"
>> +#endif
> Although I appreciate you going the extra mile for arm64 (thanks!), I think
> this is probably a bit overkill given that I don't plan to merge the series
> from Zengruan any time soon. Instead, how about just defining
> vcpu_is_preempted in arch/arm64/include/asm/spinlock.h with a comment:
>
>
> 	/*
> 	 * Changing this will break osq_lock() thanks to the call inside
> 	 * smp_cond_load_relaxed().
> 	 *
> 	 * See:
> 	 * https://lore.kernel.org/lkml/20200110100612.GC2827@hirez.programming.kicks-ass.net
> 	 */
> 	#define vcpu_is_preempted(cpu)	false
>
>
> So we'll notice that when somebody tries to change it.

Yes, that works for me. I just want to make sure that if any changes to
add vcpu_is_preempted to arm64 in the future will get caught.

Cheers,
Longman

