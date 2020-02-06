Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE28C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDEE21775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 17:08:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="be/QtGqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgBFRI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 12:08:26 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53011 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727440AbgBFRI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 12:08:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581008905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pCec0r2HvCzdFyVP35CG/1REeLdCQxqtScAYbzgQ6dk=;
        b=be/QtGqgPlpGG6il8UzqGS1FbSNrscE062WL+vGwpmOBWhK+cY25woakMwvJLRkIVRvtIB
        Zh7sy8LbYYr/Fp/maq3ufEUNFfowGvcuzZE5Nfl+VgZCFBx0NE5RUzx7DlPUdJBWDUkkTl
        mJJd5pu33Czf7zK3GbeWAFbDnfzS8uk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-gPMkKhLIPVa9_EpmbaHOBA-1; Thu, 06 Feb 2020 12:08:23 -0500
X-MC-Unique: gPMkKhLIPVa9_EpmbaHOBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 958331857343;
        Thu,  6 Feb 2020 17:08:21 +0000 (UTC)
Received: from llong.remote.csb (ovpn-124-223.rdu2.redhat.com [10.10.124.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 083C760BEC;
        Thu,  6 Feb 2020 17:08:20 +0000 (UTC)
Subject: Re: [PATCH v6 6/6] locking/lockdep: Reuse freed chain_hlocks entries
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20200206152408.24165-1-longman@redhat.com>
 <20200206152408.24165-7-longman@redhat.com>
 <20200206161640.GW14914@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <29fbb4c6-aa8f-f6ce-6115-232db5f2db52@redhat.com>
Date:   Thu, 6 Feb 2020 12:08:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200206161640.GW14914@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/20 11:16 AM, Peter Zijlstra wrote:
> On Thu, Feb 06, 2020 at 10:24:08AM -0500, Waiman Long wrote:
>> +static int alloc_chain_hlocks(int req)
>> +{
>> +	int bucket, curr, size;
>> +
>> +	/*
>> +	 * We rely on the MSB to act as an escape bit to denote freelist
>> +	 * pointers. Make sure this bit isn't set in 'normal' class_idx usage.
>> +	 */
>> +	BUILD_BUG_ON((MAX_LOCKDEP_KEYS-1) & CHAIN_BLK_FLAG);
>> +
>> +	init_data_structures_once();
>> +
>> +	if (nr_free_chain_hlocks < req)
>> +		return -1;
>> +
>> +	/*
>> +	 * We require a minimum of 2 (u16) entries to encode a freelist
>> +	 * 'pointer'.
>> +	 */
>> +	req = max(req, 2);
>> +	bucket = size_to_bucket(req);
>> +	curr = chain_block_buckets[bucket];
>> +
>> +	if (bucket && (curr >= 0)) {
>> +		del_chain_block(bucket, req, chain_block_next(curr));
>> +		return curr;
>> +	} else if (bucket) {
>> +		/* Try bucket 0 */
>> +		curr = chain_block_buckets[0];
>> +	}
> 	if (bucket) {
> 		if (curr >= 0) {
> 			del_chain_block(bucket, req, chain_block_next(curr));
> 			return curr;
> 		}
> 		/* Try bucket 0 */
> 		curr = chain_block_bucket[0];
> 	}
>
> reads much easier IMO.

Yes, that is simpler. I can send out an updated patch if you want, or
you can apply the change when you pull the patch.

Thanks,
Longman

