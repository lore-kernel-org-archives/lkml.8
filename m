Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C898C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D11F2085B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IybZZRdC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgBJWOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:14:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21836 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727254AbgBJWOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:14:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581372881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cspuXgPKY9z/qbhYw72I3wzQ2C44sD+bqIz0DjaH3g4=;
        b=IybZZRdCzsAhHEJJgb9S3O2XsZrHj+sZIu1XA/c2VAMK8/44Xuxm3JrnkRJlzFmTP12jwr
        qA6tIhvuUsGUH3w7E6918s+30ARVGD1ATOmxqh2YNkYEdKgJyZFGFEtcxl4ZUTAhJMW+ue
        HOx2lG2xf4bCRHDPaY8RFAG915HXQVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-wBeXH3gnO7qchhMO3w2POg-1; Mon, 10 Feb 2020 17:14:35 -0500
X-MC-Unique: wBeXH3gnO7qchhMO3w2POg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 208041005510;
        Mon, 10 Feb 2020 22:14:33 +0000 (UTC)
Received: from llong.remote.csb (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9FE315D9CA;
        Mon, 10 Feb 2020 22:14:31 +0000 (UTC)
Subject: Re: [PATCH 3/3] mm/slub: Fix potential deadlock problem in
 slab_attr_store()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20200210204651.21674-1-longman@redhat.com>
 <20200210204651.21674-4-longman@redhat.com>
 <20200210140343.09ac0f5d841a0c9ed5034107@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <0cb70f4a-7fa0-5567-02fc-955e0406a4e7@redhat.com>
Date:   Mon, 10 Feb 2020 17:14:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200210140343.09ac0f5d841a0c9ed5034107@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/20 5:03 PM, Andrew Morton wrote:
> On Mon, 10 Feb 2020 15:46:51 -0500 Waiman Long <longman@redhat.com> wrote:
>
>> In order to fix this circular lock dependency problem, we need to do a
>> mutex_trylock(&slab_mutex) in slab_attr_store() for CPU0 above. A simple
>> trylock, however, is easy to fail causing user dissatisfaction. So the
>> new mutex_timed_lock() function is now used to do a trylock with a
>> 100ms timeout.
>>
>> ...
>>
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -5536,7 +5536,12 @@ static ssize_t slab_attr_store(struct kobject *kobj,
>>  	if (slab_state >= FULL && err >= 0 && is_root_cache(s)) {
>>  		struct kmem_cache *c;
>>  
>> -		mutex_lock(&slab_mutex);
>> +		/*
>> +		 * Timeout after 100ms
>> +		 */
>> +		if (mutex_timed_lock(&slab_mutex, 100) < 0)
>> +			return -EBUSY;
>> +
> Oh dear.  Surely there's a better fix here.  Does slab really need to
> hold slab_mutex while creating that sysfs file?  Why?
>
> If the issue is two threads trying to create the same sysfs file
> (unlikely, given that both will need to have created the same cache)
> then can we add a new mutex specifically for this purpose?
>
> Or something else.
>
Well, the current code iterates all the memory cgroups to set the same
value in all of them. I believe the reason for holding the slab mutex is
to make sure that memcg hierarchy is stable during this iteration
process. Of course, we can argue if the attribute value should be
duplicated in all memcg's.

Cheers,
Longman

