Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10E7C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99847214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="idIW/aiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgBFRHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:07:01 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26560 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727060AbgBFRHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:07:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581008819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3pKJNNr147NV4iBcZUmPbcoeGNCKnZBNXgxrFA4/6SA=;
        b=idIW/aiN062IxZK5IiJ9+BbxSI+hgmMr+TBFjJpfNsqXN1FuSFdYNRH28d/YfNixYHGADE
        HjVShBArsWT6EcoJIApSl2nzOy88vSS2YXKNVzPa0pCgjVebVSK+Z1G/8CHX4tPmJRFDMS
        UPQSRI4F2V9pwJKJ4AhPeRblktiZXFo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-90rAmeq-ML2Yb_pWyG-hcw-1; Thu, 06 Feb 2020 12:06:49 -0500
X-MC-Unique: 90rAmeq-ML2Yb_pWyG-hcw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06B6F800EB2;
        Thu,  6 Feb 2020 17:06:46 +0000 (UTC)
Received: from llong.remote.csb (ovpn-124-223.rdu2.redhat.com [10.10.124.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6925519C69;
        Thu,  6 Feb 2020 17:06:45 +0000 (UTC)
Subject: Re: [PATCH v6 6/6] locking/lockdep: Reuse freed chain_hlocks entries
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20200206152408.24165-1-longman@redhat.com>
 <20200206152408.24165-7-longman@redhat.com>
 <20200206160334.GV14914@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <951c86c9-9340-c4af-35e6-8ac205d702ab@redhat.com>
Date:   Thu, 6 Feb 2020 12:06:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200206160334.GV14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/20 11:03 AM, Peter Zijlstra wrote:
> On Thu, Feb 06, 2020 at 10:24:08AM -0500, Waiman Long wrote:
>> +#define for_each_chain_block(bucket, prev, curr)		\
>> +	for ((prev) = -1, (curr) = chain_block_buckets[bucket];	\
>> +	     (curr) >= 0;					\
>> +	     (prev) = (curr), (curr) = chain_block_next(curr))
>> +static inline void add_chain_block(int offset, int size)
>> +{
>> +	int bucket = size_to_bucket(size);
>> +	int next = chain_block_buckets[bucket];
>> +	int prev, curr;
>> +
>> +	if (unlikely(size < 2)) {
>> +		/*
>> +		 * We can't store single entries on the freelist. Leak them.
>> +		 *
>> +		 * One possible way out would be to uniquely mark them, other
>> +		 * than with CHAIN_BLK_FLAG, such that we can recover them when
>> +		 * the block before it is re-added.
>> +		 */
>> +		if (size)
>> +			nr_lost_chain_hlocks++;
>> +		return;
>> +	}
>> +
>> +	nr_free_chain_hlocks += size;
>> +	if (!bucket) {
>> +		nr_large_chain_blocks++;
>> +
>> +		if (unlikely(next >= 0)) {
> I was surprised by this condition..

Yes, this condition is optional and the code will still work as expected
without that. I added that so that for the common case where there is
only 1 chain block in block 0 and it gets deleted and added
repetitively, it will go to the simpler code path instead of the more
complicated one.

Cheers,
Longman

