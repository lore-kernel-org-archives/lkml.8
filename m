Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB4AC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 18:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27A252084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 18:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2AUYCRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbgBDSCf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 13:02:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53050 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727355AbgBDSCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 13:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580839353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LGryG4ZsTtUfBbko/RblThw9g52nQf5Sd+iysNke/p4=;
        b=E2AUYCRnbn3np7DhpSTbRquHgY4ySvRJB4aFoH8E4cjmjhKakbXt7kF94ZwEITrxEailgR
        kP8X8uHiMToUJD/pYdFgG4a/aZ3+x87i0OKiZ/fovpm5xxxcWtHIST4HO+/c8iNDc1T1mB
        H4LDt6D7pX77HxjXNLZaLrQWrvEvJHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-UWrXDWIkNeCEyNlmDlTijg-1; Tue, 04 Feb 2020 13:02:31 -0500
X-MC-Unique: UWrXDWIkNeCEyNlmDlTijg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E73771084456;
        Tue,  4 Feb 2020 18:02:29 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55F9C5C296;
        Tue,  4 Feb 2020 18:02:29 +0000 (UTC)
Subject: Re: [PATCH v5 7/7] locking/lockdep: Add a fast path for chain_hlocks
 allocation
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20200203164147.17990-1-longman@redhat.com>
 <20200203164147.17990-8-longman@redhat.com>
 <20200204131813.GQ14914@hirez.programming.kicks-ass.net>
 <20200204134446.GQ14946@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <ed63dc8f-747d-4b92-78f1-58563177a1dd@redhat.com>
Date:   Tue, 4 Feb 2020 13:02:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200204134446.GQ14946@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/20 8:44 AM, Peter Zijlstra wrote:
> On Tue, Feb 04, 2020 at 02:18:13PM +0100, Peter Zijlstra wrote:
>> On Mon, Feb 03, 2020 at 11:41:47AM -0500, Waiman Long wrote:
>>
>>> @@ -2809,6 +2813,18 @@ static int alloc_chain_hlocks(int req)
>>>  			return curr;
>>>  		}
>>>  
>>> +		/*
>>> +		 * Fast path: splitting out a sub-block at the end of the
>>> +		 * primordial chain block.
>>> +		 */
>>> +		if (likely((size > MAX_LOCK_DEPTH) &&
>>> +			   (size - req > MAX_CHAIN_BUCKETS))) {
>>> +			size -= req;
>>> +			nr_free_chain_hlocks -= req;
>>> +			init_chain_block_size(curr, size);
>>> +			return curr + size;
>>> +		}
>>> +
>>>  		if (size > max_size) {
>>>  			max_prev = prev;
>>>  			max_curr = curr;
>> A less horrible hack might be to keep the freelist sorted on size (large
>> -> small)
>>
>> That moves the linear-search from alloc_chain_hlocks() into
>> add_chain_block().  But the thing is that it would amortize to O(1)
>> because this initial chunk is pretty much 'always' the largest.
>>
>> Only once we've exhausted the initial block will we hit that search, but
>> then the hope is that we mostly live off of the buckets, not the
>> variable freelist.
> Completely untested something like so

I will integrate that into patch 6. I won't push for this patch for now.
It can be for a later discussion.

Thanks,
Longman

