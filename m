Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1389C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E8520674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 14:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUghaWHc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgBDOyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 09:54:14 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22587 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727275AbgBDOyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 09:54:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580828053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2qQyleQc5KYdg877BecMkLyuGsClAwP2BlAgs7JXjpw=;
        b=NUghaWHcub4XNwwFX/obBSVj0r+EKP3sFWmCwrrL4pr50qtHB4hUg/0p/a1xJQr+culW6Y
        oNzk6FwVsbkKqJcUY1MF022p6FSkmNHclYIHzyzzNyYFkxpZocxssby/d2sMmimWRD4VUs
        SLK/BL8nKqNFxUohXiLrAZftY8CulMI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-lG1XKNoaNeSNoy-91Ue2xQ-1; Tue, 04 Feb 2020 09:54:08 -0500
X-MC-Unique: lG1XKNoaNeSNoy-91Ue2xQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E8FA1137843;
        Tue,  4 Feb 2020 14:54:07 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA2F310018FF;
        Tue,  4 Feb 2020 14:54:06 +0000 (UTC)
Subject: Re: [PATCH v5 6/7] locking/lockdep: Reuse freed chain_hlocks entries
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20200203164147.17990-1-longman@redhat.com>
 <20200203164147.17990-7-longman@redhat.com>
 <20200204123629.GO14914@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <596279b6-8146-5e1c-17d8-9a592cf71b4e@redhat.com>
Date:   Tue, 4 Feb 2020 09:54:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200204123629.GO14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/20 7:36 AM, Peter Zijlstra wrote:
> On Mon, Feb 03, 2020 at 11:41:46AM -0500, Waiman Long wrote:
>> +	if (unlikely(size < 2))
>> +		return; // XXX leak!
> Stuck this on top...
>
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2631,7 +2631,8 @@ struct lock_chain lock_chains[MAX_LOCKDE
>  static DECLARE_BITMAP(lock_chains_in_use, MAX_LOCKDEP_CHAINS);
>  static u16 chain_hlocks[MAX_LOCKDEP_CHAIN_HLOCKS];
>  unsigned long nr_zapped_lock_chains;
> -unsigned int nr_free_chain_hlocks;	/* Free cfhain_hlocks in buckets */
> +unsigned int nr_free_chain_hlocks;	/* Free chain_hlocks in buckets */
> +unsigned int nr_lost_chain_hlocks;	/* Lost chain_hlocks */
>  unsigned int nr_large_chain_blocks;	/* size > MAX_CHAIN_BUCKETS */
>  
>  /*
> @@ -2718,8 +2719,17 @@ static inline void add_chain_block(int o
>  	int bucket = size_to_bucket(size);
>  	int next = chain_block_buckets[bucket];
>  
> -	if (unlikely(size < 2))
> -		return; // XXX leak!
> +	if (unlikely(size < 2)) {
> +		/*
> +		 * We can't store single entries on the freelist. Leak them.
> +		 *
> +		 * One possible way out would be to uniquely mark them, other
> +		 * than with CHAIN_BLK_FLAG, such that we can recover them when
> +		 * the block before it is re-added.
> +		 */
> +		nr_lost_chain_hlocks++;
> +		return;
> +	}
>  
>  	init_chain_block(offset, next, bucket, size);
>  	chain_block_buckets[bucket] = offset;
> @@ -2798,8 +2808,8 @@ static int alloc_chain_hlocks(int req)
>  
>  search:
>  	/*
> -	 * linear search in the 'dump' bucket; look for an exact match or the
> -	 * largest block.
> +	 * linear search of the variable sized freelist; look for an exact
> +	 * match or the largest block.
>  	 */
>  	for_each_chain_block(0, prev, curr, next) {
>  		size = chain_block_size(curr);
> --- a/kernel/locking/lockdep_internals.h
> +++ b/kernel/locking/lockdep_internals.h
> @@ -141,6 +141,7 @@ extern unsigned int nr_hardirq_chains;
>  extern unsigned int nr_softirq_chains;
>  extern unsigned int nr_process_chains;
>  extern unsigned int nr_free_chain_hlocks;
> +extern unsigned int nr_lost_chain_hlocks;
>  extern unsigned int nr_large_chain_blocks;
>  
>  extern unsigned int max_lockdep_depth;
> --- a/kernel/locking/lockdep_proc.c
> +++ b/kernel/locking/lockdep_proc.c
> @@ -278,9 +278,11 @@ static int lockdep_stats_show(struct seq
>  #ifdef CONFIG_PROVE_LOCKING
>  	seq_printf(m, " dependency chains:             %11lu [max: %lu]\n",
>  			lock_chain_count(), MAX_LOCKDEP_CHAINS);
> -	seq_printf(m, " dependency chain hlocks:       %11lu [max: %lu]\n",
> -			MAX_LOCKDEP_CHAIN_HLOCKS - nr_free_chain_hlocks,
> +	seq_printf(m, " dependency chain hlocks used:  %11lu [max: %lu]\n",
> +			MAX_LOCKDEP_CHAIN_HLOCKS - (nr_free_chain_hlocks - nr_lost_chain_hlocks),
>  			MAX_LOCKDEP_CHAIN_HLOCKS);
> +	seq_printf(m, " dependency chain hlocks free:  %11lu\n", nr_free_chain_hlocks);
> +	seq_printf(m, " dependency chain hlocks lost:  %11lu\n", nr_lost_chain_hlocks);
>  #endif
>  
>  #ifdef CONFIG_TRACE_IRQFLAGS
>
Sure. Will do that.

Thanks for the suggestion.

Cheers,
Longman

