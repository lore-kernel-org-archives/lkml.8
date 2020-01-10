Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BC3C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A37D120721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 14:13:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QGnPG3vB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgAJONh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 09:13:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50694 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727181AbgAJONh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 09:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578665615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aRsoIfqjhyi1wmmmFGcOZTpjMordIYLuyu6LbigTBdM=;
        b=QGnPG3vBlMer7/Q83ehrVXbZYUffoerkmM2Y1cqDr7s3AqH+T83IZtpsJwnjgrxCA0mzto
        BrKfjFqosIsAJM688K1BTQANUxMx1MRpkz3IvWN4UH8ApvfP/mfMlDMsC/GapRtUOs/u7Z
        YPFpnbTDCm682nvBgE4fBQ0uzXe/jv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-242-_gMP_xHfP_-q-q9nqsShmA-1; Fri, 10 Jan 2020 09:13:32 -0500
X-MC-Unique: _gMP_xHfP_-q-q9nqsShmA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22A0EA89A3F;
        Fri, 10 Jan 2020 14:13:31 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F24DB28D02;
        Fri, 10 Jan 2020 14:13:26 +0000 (UTC)
Subject: Re: [PATCH] locking/osq: Use more optimized spinning for arm64
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org
References: <20200109153831.29993-1-longman@redhat.com>
 <20200110100612.GC2827@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <c85eff71-2fcd-48e2-851f-96b4cd5a3f24@redhat.com>
Date:   Fri, 10 Jan 2020 09:13:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200110100612.GC2827@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/20 5:06 AM, Peter Zijlstra wrote:
> On Thu, Jan 09, 2020 at 10:38:31AM -0500, Waiman Long wrote:
>
>> --- a/kernel/locking/osq_lock.c
>> +++ b/kernel/locking/osq_lock.c
>> @@ -134,6 +134,27 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>>  	 * cmpxchg in an attempt to undo our queueing.
>>  	 */
>>  
>> +	/*
>> +	 * If vcpu_is_preempted is not defined, we can skip the check
>> +	 * and use smp_cond_load_relaxed() instead. For arm64, this
>> +	 * could lead to the use of the more optimized wfe instruction.
>> +	 * As need_sched() is set by interrupt handler, it will break
>> +	 * out and do the unqueue in a timely manner.
>> +	 *
>> +	 * TODO: We may need to add a static_key like vcpu_is_preemptible
>> +	 *	 as vcpu_is_preempted() will always return false with
>> +	 *	 bare metal even if it is defined.
>> +	 */
>> +#ifndef vcpu_is_preempted
>> +	{
>> +		int locked = smp_cond_load_relaxed(&node->locked,
>> +						   VAL || need_resched());
>> +		if (!locked)
>> +			goto unqueue;
>> +		return true;
>> +	}
>> +#endif
> Much yuck :-/
>
> With ARM64 being the only arch that currently makes use of this; another
> approach is doing something like:
>
> That is also rather yuck, and definitely needs a few comments sprinked
> on it, but it should just work for everyone.
>
> It basically relies on an arch having a spinning *cond_load*()
> implementation if it has vcpu_is_preempted(), which is true today.
>
> ---
> diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
> index 6ef600aa0f47..6e00d7c077ba 100644
> --- a/kernel/locking/osq_lock.c
> +++ b/kernel/locking/osq_lock.c
> @@ -133,18 +133,10 @@ bool osq_lock(struct optimistic_spin_queue *lock)
>  	 * guaranteed their existence -- this allows us to apply
>  	 * cmpxchg in an attempt to undo our queueing.
>  	 */
> +	if (!smp_cond_load_relaxed(&node->locked, VAL || need_resched() ||
> +						  vcpu_is_preempetd(node_cpu(node->prev))))
> +		goto unqueue;
>  
> -	while (!READ_ONCE(node->locked)) {
> -		/*
> -		 * If we need to reschedule bail... so we can block.
> -		 * Use vcpu_is_preempted() to avoid waiting for a preempted
> -		 * lock holder:
> -		 */
> -		if (need_resched() || vcpu_is_preempted(node_cpu(node->prev)))
> -			goto unqueue;
> -
> -		cpu_relax();
> -	}
>  	return true;
>  
>  unqueue:
>
Yes, that will work for now. We do need to document that in where
smp_cond_load_relaxed() is defined.

In the future, if vcpu_is_preempted() is defined for ARM64, it will
break. How about defining a variant like smp_cond_load_vcpu_relaxed(p,
cond, vcpu)? With that, we can make sure that the code will be properly
updated when vcpu_is_preempted() is defined for ARM64. I know it is
still kind of ugly, but it is a safer approach.

Cheers,
Longman

