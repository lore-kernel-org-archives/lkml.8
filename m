Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F074CC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7199206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 23:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fEQIKWYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgBKXaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 18:30:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40304 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727933AbgBKXaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 18:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581463822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBhgH/CawSafLaPJGdeLZ+TP7i8CLyhw0xMEZHzBBws=;
        b=fEQIKWYYdLTp6Kt6lJXkNpAzuU7iU66yLvb/IhBJtyXg5gTtosr8TJZLArtjG7viJwUx8b
        7rf73q15sAN9ST/6btxnWCuDf0m+o1+OmQ+CziVyNBmQ+yEtS6qF0H5WDaBHn674IYb7cW
        YKByIlYBsejRJkOW54eiMaQt03rikv4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-jq65soSoMtyYbY6Hh6h7KA-1; Tue, 11 Feb 2020 18:30:18 -0500
X-MC-Unique: jq65soSoMtyYbY6Hh6h7KA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DC288010C4;
        Tue, 11 Feb 2020 23:30:16 +0000 (UTC)
Received: from llong.remote.csb (ovpn-124-198.rdu2.redhat.com [10.10.124.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BBBC1001B00;
        Tue, 11 Feb 2020 23:30:14 +0000 (UTC)
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
 <0cb70f4a-7fa0-5567-02fc-955e0406a4e7@redhat.com>
 <20200210151008.1c1d74c1876e363b729f5b1c@linux-foundation.org>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <54380181-84d6-4611-fc5e-daed82b73743@redhat.com>
Date:   Tue, 11 Feb 2020 18:30:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200210151008.1c1d74c1876e363b729f5b1c@linux-foundation.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/20 6:10 PM, Andrew Morton wrote:
> On Mon, 10 Feb 2020 17:14:31 -0500 Waiman Long <longman@redhat.com> wrote:
>
>>>> --- a/mm/slub.c
>>>> +++ b/mm/slub.c
>>>> @@ -5536,7 +5536,12 @@ static ssize_t slab_attr_store(struct kobject *kobj,
>>>>  	if (slab_state >= FULL && err >= 0 && is_root_cache(s)) {
>>>>  		struct kmem_cache *c;
>>>>  
>>>> -		mutex_lock(&slab_mutex);
>>>> +		/*
>>>> +		 * Timeout after 100ms
>>>> +		 */
>>>> +		if (mutex_timed_lock(&slab_mutex, 100) < 0)
>>>> +			return -EBUSY;
>>>> +
>>> Oh dear.  Surely there's a better fix here.  Does slab really need to
>>> hold slab_mutex while creating that sysfs file?  Why?
>>>
>>> If the issue is two threads trying to create the same sysfs file
>>> (unlikely, given that both will need to have created the same cache)
>>> then can we add a new mutex specifically for this purpose?
>>>
>>> Or something else.
>>>
>> Well, the current code iterates all the memory cgroups to set the same
>> value in all of them. I believe the reason for holding the slab mutex is
>> to make sure that memcg hierarchy is stable during this iteration
>> process.
> But that is unrelated to creation of the sysfs file?
>
OK, I will take a closer look at that.

Cheers,
Longman

