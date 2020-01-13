Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A35AC33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 205A0214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CI7frn+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgAMQYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:24:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29349 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728871AbgAMQYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578932683;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ixW7JQtSvj+gusuiXmdphjnX8Xf32o1d+txjLiFEcpw=;
        b=CI7frn+vjq0OB+qGdOFHDwlAqfHsvAJUlnSrlMvuYsn4nbtoXedvoGle+BfDR2f3AbEdJT
        FaE2N7p/pyUFyzJ+T//usnS3vlsPJUJjcWhevXqwDUP23tF0ae5T2ecENxlzy5x5L4E46g
        4/2vi8GJ/eR2cNx1KMNmZx+efT82LnQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-FbPGoYA2Mk6shQDnz384gA-1; Mon, 13 Jan 2020 11:24:40 -0500
X-MC-Unique: FbPGoYA2Mk6shQDnz384gA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC829801E78;
        Mon, 13 Jan 2020 16:24:38 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48E7119C5B;
        Mon, 13 Jan 2020 16:24:38 +0000 (UTC)
Subject: Re: [PATCH v2 4/6] locking/lockdep: Reuse freed chain_hlocks entries
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20191216151517.7060-1-longman@redhat.com>
 <20191216151517.7060-5-longman@redhat.com>
 <20200113155823.GY2844@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <e282e7f3-6010-ef13-bd07-524445049ef8@redhat.com>
Date:   Mon, 13 Jan 2020 11:24:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200113155823.GY2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/20 10:58 AM, Peter Zijlstra wrote:
> On Mon, Dec 16, 2019 at 10:15:15AM -0500, Waiman Long wrote:
>> +/*
>> + * Return offset of a chain block of the right size or -1 if not found.
>> + */
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
>> +	prev = -1;
>> +	curr = chain_block_buckets[0];
>> +	while (curr >= 0) {
>> +		next = next_chain_block(curr);
>> +		if (chain_block_size(curr) == size) {
>> +			set_chain_block(prev, 0, next);
>> +			nr_free_chain_hlocks -= size;
>> +			nr_large_chain_blocks--;
>> +			return curr;
>> +		}
>> +		prev = curr;
>> +		curr = next;
>> +	}
>> +	return -1;
>> +}
>> +/*
>> + * The graph lock must be held before calling this function.
>> + *
>> + * Return: an offset to chain_hlocks if successful, or
>> + *	   -1 with graph lock released
>> + */
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
> *groan*....
>
> That's _two_ allocators :/ And it can trivially fail, even if there's
> plenty space available.
>
> Consider nr_chain_hlocks is exhaused, and @size is empty, but size+1
> still has blocks.
>
> I'm guessing you didn't make it a single allocator because you didn't
> want to implement block splitting? why?
>
In my testing, most of the lock chains tend to be rather short (within
the 2-8 range). I don't see a lot of free blocks left in the system
after the test. So I don't see a need to implement block splitting for now.

If you think this is a feature that needs to be implemented for the
patch to be complete, I can certainly add patch to do that. My initial
thought is just to split long blocks in the unsized list for allocation
request that is no longer than 8 to make thing easier.

Cheers,
Longman

