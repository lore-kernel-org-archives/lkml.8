Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A74FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 126A32075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bQZrn8st"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgHRTaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:30:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23332 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726632AbgHRTaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597779011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TzOEgoxnjJc+44XQtv3kAPBEJXFL3VlSz++wwm59Khc=;
        b=bQZrn8stH9h3pMfBCJVUXeTQnSdzdkfWOcXZo73QR9MsSPF5UZfMBOxXC6dGXZ/4wuPKx5
        ipUUwtKSgh5JJ5u0aPZn85IohTCf9cOI2LNktbTLgO+fM97MsgDzDThMVczURFaQ8RYMHB
        KnAPmWo9VUV1025q6meM9xnQ7kH5dbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-Y-bE-SXNM8Om9V_jtabrsA-1; Tue, 18 Aug 2020 15:30:09 -0400
X-MC-Unique: Y-bE-SXNM8Om9V_jtabrsA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6DCDC18686D7;
        Tue, 18 Aug 2020 19:30:07 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-51.rdu2.redhat.com [10.10.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 046407DFD4;
        Tue, 18 Aug 2020 19:30:02 +0000 (UTC)
Subject: Re: [RFC PATCH 0/8] memcg: Enable fine-grained per process memory
 control
To:     Chris Down <chris@chrisdown.name>, peterz@infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
References: <20200817140831.30260-1-longman@redhat.com>
 <20200818091453.GL2674@hirez.programming.kicks-ass.net>
 <20200818092737.GA148695@chrisdown.name>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <b11ce701-e824-793c-cc7f-4c3bbe08cf80@redhat.com>
Date:   Tue, 18 Aug 2020 15:30:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200818092737.GA148695@chrisdown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/20 5:27 AM, Chris Down wrote:
> peterz@infradead.org writes:
>> On Mon, Aug 17, 2020 at 10:08:23AM -0400, Waiman Long wrote:
>>> Memory controller can be used to control and limit the amount of
>>> physical memory used by a task. When a limit is set in "memory.high" in
>>> a v2 non-root memory cgroup, the memory controller will try to reclaim
>>> memory if the limit has been exceeded. Normally, that will be enough
>>> to keep the physical memory consumption of tasks in the memory cgroup
>>> to be around or below the "memory.high" limit.
>>>
>>> Sometimes, memory reclaim may not be able to recover memory in a rate
>>> that can catch up to the physical memory allocation rate. In this case,
>>> the physical memory consumption will keep on increasing.
>>
>> Then slow down the allocator? That's what we do for dirty pages too, we
>> slow down the dirtier when we run against the limits.
>
> We already do that since v5.4. I'm wondering whether Waiman's customer 
> is just running with a too-old kernel without 0e4b01df865 ("mm, memcg: 
> throttle allocators when failing reclaim over memory.high") backported.
>
The fact is that we don't have that in RHEL8 yet and cgroup v2 is still 
not the default at the moment.

I am planning to backport the throttling patches to RHEL and hopefully 
can switch to use cgroup v2 soon.

Cheers,
Longman

