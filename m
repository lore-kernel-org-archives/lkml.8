Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBB7C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85627206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XlodeHa2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgAMQEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:04:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26166 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726567AbgAMQEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:04:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578931487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fz88bIcT2xqjQLyvIb0dLOsNkL6wBn9WVCU9Yzf2kH0=;
        b=XlodeHa2wWO2zUbj9cnSN0lkMO1vIus80vCy5pX5taUDkyw1Fo7SLqOMwEjEDmDnveqL2X
        lQkkRNMv8x18WuCLPZ1JlbS8VieGQv6vgWfCoAWojnIrnCudwu/lZBTvXznjqQJxmC1aF8
        X1nVzWWkBFvomH4ISdzO2CJKamHPv4Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-vVrP6LFvNimlWiQX0UTELw-1; Mon, 13 Jan 2020 11:04:43 -0500
X-MC-Unique: vVrP6LFvNimlWiQX0UTELw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB5058024CE;
        Mon, 13 Jan 2020 16:04:42 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 339F660BF4;
        Mon, 13 Jan 2020 16:04:42 +0000 (UTC)
Subject: Re: [PATCH v2 4/6] locking/lockdep: Reuse freed chain_hlocks entries
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20191216151517.7060-1-longman@redhat.com>
 <20191216151517.7060-5-longman@redhat.com>
 <20200113155128.GX2844@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <67ebbdb2-b7db-6945-fa30-22ca2ddb5b32@redhat.com>
Date:   Mon, 13 Jan 2020 11:04:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200113155128.GX2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/20 10:51 AM, Peter Zijlstra wrote:
> On Mon, Dec 16, 2019 at 10:15:15AM -0500, Waiman Long wrote:
>> +#define CHAIN_HLOCKS_MASK	0xffff
>> +static inline void set_chain_block(int offset, int size, int next)
>> +{
>> +	if (unlikely(offset < 0)) {
>> +		chain_block_buckets[0] = next;
>> +		return;
>> +	}
>> +	chain_hlocks[offset] = (next >> 16) | CHAIN_BLK_FLAG;
>> +	chain_hlocks[offset + 1] = next & CHAIN_HLOCKS_MASK;
>> +	if (size > MAX_CHAIN_BUCKETS) {
>> +		chain_hlocks[offset + 2] = size >> 16;
>> +		chain_hlocks[offset + 3] = size & CHAIN_HLOCKS_MASK;
>> +	}
>> +}
> AFAICT HLOCKS_MASK is superfluous. That is, you're assigning to a u16,
> it will truncate automagically.
>
> But if you want to make it more explicit, something like:
>
>   chain_hlocks[offset + 1] = (u16)next;
>
> might be easier to read still.
>
Yes, I am aware that the macro may not be needed. Will make the changes
in the next version.

Thanks,
Longman

