Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D75CC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 04:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028932073D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 04:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JxplNAB5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgATEWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 23:22:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39901 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729049AbgATEWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 23:22:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579494166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7H/3OwnH2y72bzLU/aag9n1jdO/BAr0cOUycXDHyrcw=;
        b=JxplNAB52JrQWfONr1O564OEZ/01LI62suN+ZYa51Orrtrw+1ewigxG5h+jRZoNMvWQ/7d
        7gAXKoApudFbgMNeDMYKIXuL0bX4dq7futhJnFPg8gASliWH3S0G7x8swMiJiSq0FUdOIU
        9uhKinZdLeBcloT1TCCnLKoHVfWqkQ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-esCG_ZmhNoSX9TXu69rSVw-1; Sun, 19 Jan 2020 23:22:39 -0500
X-MC-Unique: esCG_ZmhNoSX9TXu69rSVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F7AC100550E;
        Mon, 20 Jan 2020 04:22:36 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-218.rdu2.redhat.com [10.10.120.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0EA2D60BF1;
        Mon, 20 Jan 2020 04:22:35 +0000 (UTC)
Subject: Re: [PATCH v3 6/8] locking/lockdep: Reuse freed chain_hlocks entries
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20200115214313.13253-1-longman@redhat.com>
 <20200115214313.13253-7-longman@redhat.com>
 <20200116211300.GT2827@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <be61dc08-574b-069e-eac3-0fa040014886@redhat.com>
Date:   Sun, 19 Jan 2020 23:22:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200116211300.GT2827@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/20 4:13 PM, Peter Zijlstra wrote:
> On Wed, Jan 15, 2020 at 04:43:11PM -0500, Waiman Long wrote:
>> +static inline int alloc_chain_hlocks_from_buckets(int size)
>> +{
>> +	int prev, curr, next;
>> +
>> +	if (!nr_free_chain_hlocks)
>> +		return -1;
>> +
>> +	if (size <= MAX_CHAIN_BUCKETS) {
>> +		curr = chain_block_buckets[size - 1];
>> +		if (curr < 0)
>> +			return -1;
>> +
>> +		chain_block_buckets[size - 1] = next_chain_block(curr);
>> +		nr_free_chain_hlocks -= size;
>> +		return curr;
>> +	}
>> +
>> +	/*
>> +	 * Look for a free chain block of the given size
>> +	 *
>> +	 * It is rare to have a lock chain with depth > MAX_CHAIN_BUCKETS.
>> +	 * It is also more expensive as we may iterate the whole list
>> +	 * without finding one.
>> +	 */
>> +	for_each_chain_block(0, prev, curr, next) {
>> +		next = next_chain_block(curr);
>> +		if (chain_block_size(curr) == size) {
>> +			set_chain_block(prev, 0, next);
>> +			nr_free_chain_hlocks -= size;
>> +			nr_large_chain_blocks--;
>> +			return curr;
>> +		}
>> +	}
>> +	return -1;
>> +}
>> +static int alloc_chain_hlocks(int size)
>> +{
>> +	int curr;
>> +
>> +	if (size < 2)
>> +		size = 2;
>> +
>> +	curr = alloc_chain_hlocks_from_buckets(size);
>> +	if (curr >= 0)
>> +		return curr;
>> +
>> +	BUILD_BUG_ON((1UL << 24) <= ARRAY_SIZE(chain_hlocks));
>> +	BUILD_BUG_ON((1UL << 6)  <= ARRAY_SIZE(current->held_locks));
>> +	BUILD_BUG_ON((1UL << 8*sizeof(chain_hlocks[0])) <=
>> +		     ARRAY_SIZE(lock_classes));
>> +
>> +	/*
>> +	 * Allocate directly from chain_hlocks.
>> +	 */
>> +	if (likely(nr_chain_hlocks + size <= MAX_LOCKDEP_CHAIN_HLOCKS)) {
>> +		curr = nr_chain_hlocks;
>> +		nr_chain_hlocks += size;
>> +		return curr;
>> +	}
>> +	if (!debug_locks_off_graph_unlock())
>> +		return -1;
>> +
>> +	print_lockdep_off("BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!");
>> +	dump_stack();
>> +	return -1;
>> +}
> Argh, that's still _two_ half allocators.
>
> Here, please try this one, it seems to boot. It compiles with some
> noise, but that is because GCC is stupid and I'm too tired.
>
> ---
>
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -1071,15 +1071,22 @@ static inline void check_data_structures
>  
>  #endif /* CONFIG_DEBUG_LOCKDEP */
>  
> +static void init_chain_block_buckets(void);
> +
>  /*
>   * Initialize the lock_classes[] array elements, the free_lock_classes list
>   * and also the delayed_free structure.
>   */
>  static void init_data_structures_once(void)
>  {
> -	static bool ds_initialized, rcu_head_initialized;
> +	static bool ds_initialized, rcu_head_initialized, chain_block_initialized;
>  	int i;
>  
> +	if (!chain_block_initialized) {
> +		chain_block_initialized = true;
> +		init_chain_block_buckets();
> +	}
> +
>  	if (likely(rcu_head_initialized))
>  		return;

Oh, I was not aware that there is such a init_data_structure_once()
function. I don't think we need a chain_block_initialized. The
ds_initialized should be enough and the init_chain_block_buckets() can
be put to the end of the function.

Other than that, the rests look OK to me so far. I will try it out tomorrow.

Thanks,
Longman

