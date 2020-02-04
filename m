Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C340C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 16:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 608D121582
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 16:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2Msm28d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgBDQMV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 11:12:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23721 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727317AbgBDQMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 11:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580832740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sOrQ7w5M+kp5LzSySUhZ3mTMSbQnOjGBnYt8dbqzsv8=;
        b=L2Msm28d3mNzz1Zun2sMVHRmJxbv1kq+zfIix7PbL7iZhB0/iwMhSZ4Ogqcbz1r/cGH8Q/
        eRTitoe993Jj2hiFok9N3dqTLO+tvGtDcpHVPKQo4rP9k8G+wo63vcJwFXEIJf4Ji4XXK+
        OuMHwoDkGeoCFkBUQUDJZ7U/HW15itE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-cwyy0IVcPMOMomfWx25bIw-1; Tue, 04 Feb 2020 11:12:15 -0500
X-MC-Unique: cwyy0IVcPMOMomfWx25bIw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5442ADB62;
        Tue,  4 Feb 2020 16:12:14 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B29AD81213;
        Tue,  4 Feb 2020 16:12:13 +0000 (UTC)
Subject: Re: [PATCH v5 6/7] locking/lockdep: Reuse freed chain_hlocks entries
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20200203164147.17990-1-longman@redhat.com>
 <20200203164147.17990-7-longman@redhat.com>
 <20200204154236.GE14879@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <c1af8458-7269-53c3-59f4-b87c5d51c208@redhat.com>
Date:   Tue, 4 Feb 2020 11:12:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200204154236.GE14879@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/20 10:42 AM, Peter Zijlstra wrote:
> On Mon, Feb 03, 2020 at 11:41:46AM -0500, Waiman Long wrote:
>> +	/*
>> +	 * We require a minimum of 2 (u16) entries to encode a freelist
>> +	 * 'pointer'.
>> +	 */
>> +	req = max(req, 2);
>
> Would something simple like the below not avoid that whole 1 entry
> 'chain' nonsense?
>
> It boots and passes the selftests, so it must be perfect :-)
>
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -3163,7 +3163,7 @@ static int validate_chain(struct task_st
>  	 * (If lookup_chain_cache_add() return with 1 it acquires
>  	 * graph_lock for us)
>  	 */
> -	if (!hlock->trylock && hlock->check &&
> +	if (!chain_head && !hlock->trylock && hlock->check &&
>  	    lookup_chain_cache_add(curr, hlock, chain_key)) {
>  		/*
>  		 * Check whether last held lock:
>
Well, I think that will eliminate the 1-entry chains for the process
context. However, we can still have 1-entry chain in the irq context, I
think, as long as there are process context locks in front of it.

I think this fix is still worthwhile as it will eliminate some of the
1-entry chains.

Cheers,
Longman

