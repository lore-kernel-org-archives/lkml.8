Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAD1C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43DA724656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 19:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hRnFOSqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgANTRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:17:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31858 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726491AbgANTRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 14:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579029423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=azbvDxnc2xgDC9U0cn3dkI+d0+KvXPPR9kPql0yzi6E=;
        b=hRnFOSqxjLnZvo5WK29bYbRzi3YmJ45KmypaNf2X51OoZf52APtqGu+gOhVsdX9FDuYC4M
        LiDRr3UBJzeDNeUbdW4S1aNrY5M/p+EvCk5h6qSeD4ZMig7qYkI+4YmTPc7PVtl2SDu8cT
        FhY0PMI5jn6nuFh9wD3AqktPgO1Ea7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-8IqR9p4SMDejD8I74EWQEA-1; Tue, 14 Jan 2020 14:16:59 -0500
X-MC-Unique: 8IqR9p4SMDejD8I74EWQEA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CA5510D08B4;
        Tue, 14 Jan 2020 19:16:58 +0000 (UTC)
Received: from llong.remote.csb (ovpn-122-218.rdu2.redhat.com [10.10.122.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CD6B1842B8;
        Tue, 14 Jan 2020 19:16:57 +0000 (UTC)
Subject: Re: [PATCH v2 4/6] locking/lockdep: Reuse freed chain_hlocks entries
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
References: <20191216151517.7060-1-longman@redhat.com>
 <20191216151517.7060-5-longman@redhat.com>
 <20200113155823.GY2844@hirez.programming.kicks-ass.net>
 <e282e7f3-6010-ef13-bd07-524445049ef8@redhat.com>
 <20200114094656.GA2844@hirez.programming.kicks-ass.net>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <b19df484-1d82-1014-1edf-a1294b4dcd09@redhat.com>
Date:   Tue, 14 Jan 2020 14:16:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200114094656.GA2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/20 4:46 AM, Peter Zijlstra wrote:
> On Mon, Jan 13, 2020 at 11:24:37AM -0500, Waiman Long wrote:
>> On 1/13/20 10:58 AM, Peter Zijlstra wrote:
>>> That's _two_ allocators :/ And it can trivially fail, even if there's
>>> plenty space available.
>>>
>>> Consider nr_chain_hlocks is exhaused, and @size is empty, but size+1
>>> still has blocks.
>>>
>>> I'm guessing you didn't make it a single allocator because you didn't
>>> want to implement block splitting? why?
>>>
>> In my testing, most of the lock chains tend to be rather short (within
>> the 2-8 range). I don't see a lot of free blocks left in the system
>> after the test. So I don't see a need to implement block splitting for now.
>>
>> If you think this is a feature that needs to be implemented for the
>> patch to be complete, I can certainly add patch to do that. My initial
>> thought is just to split long blocks in the unsized list for allocation
>> request that is no longer than 8 to make thing easier.
> From an engineering POV I'd much prefer a single complete allocator over
> two half ones. We can leave block merger out of the initial allocator I
> suppose and worry about that if/when fragmentation really shows to be a
> problem.
>
> I'm thinking worst-fit might work well for our use-case. Best-fit would
> result in a heap of tiny fragments and we don't have really large
> allocations, which is the Achilles-heel of worst-fit.
I am going to add a patch to split chain block as a last resort in case
we run out of the main buffer.
>
> Also, since you put in a minimal allocation size of 2, but did not
> mandate size is a multiple of 2, there is a weird corner case of size-1
> fragments. The simplest case is to leak those, but put in a counter so
> we can see if they're a problem -- there is a fairly trivial way to
> recover them without going full merge.

There is no size-1 fragment. Are you referring to the those blocks with
a size of 2, but with only one entry used? There are some wasted space
there. I can add a counter to track that.

Cheers,
Longman

>
> Also, there's a bunch of syzcaller reports of running out of
> ENTRIES/CHAIN_HLOCKS, perhaps try some of those workloads to better
> stress the allocator?
>

