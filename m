Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC08C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69E9A2076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UcYHX0iq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgHRTMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:12:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37242 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726632AbgHRTMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597777952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FrkRbCQkgSp3Ii7GT5sFQHM/1w0xlNAEg5ZSV7ZGgc4=;
        b=UcYHX0iqdQtPa2KTxbEiczCzmWRQqjueEk22xm+ZORe5oWPQ4TesctNsPY9M2XrrLO1UuD
        JOgQ119jZLDouuqYCWWxh2p8WjKuTrLmf7t/ybAgexdBdiuM6nUBnp30oij8onSZmKgQUi
        0MvfIhrjXqCdrcZYbPDyhIRZNiGA5V4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-CRxXt4FSMkydQdNbwy1VUQ-1; Tue, 18 Aug 2020 15:12:30 -0400
X-MC-Unique: CRxXt4FSMkydQdNbwy1VUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD35A18686D7;
        Tue, 18 Aug 2020 19:12:27 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-51.rdu2.redhat.com [10.10.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D4B405C1BB;
        Tue, 18 Aug 2020 19:12:22 +0000 (UTC)
Subject: Re: [RFC PATCH 1/8] memcg: Enable fine-grained control of over
 memory.high action
To:     Chris Down <chris@chrisdown.name>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200817140831.30260-2-longman@redhat.com>
 <CALvZod5V3N3K9-tDoaq=JgkeuAK=0TkRf97Vua0khXL+Lxw+Pg@mail.gmail.com>
 <20200817165608.GA58383@chrisdown.name>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <d55bc1b8-da20-0366-8a54-d7dc6e2cc21d@redhat.com>
Date:   Tue, 18 Aug 2020 15:12:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200817165608.GA58383@chrisdown.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/20 12:56 PM, Chris Down wrote:
> Shakeel Butt writes:
>>> Sometimes, memory reclaim may not be able to recover memory in a rate
>>> that can catch up to the physical memory allocation rate especially
>>> when rotating disks are used for swapping or writing dirty pages. In
>>> this case, the physical memory consumption will keep on increasing.
>>
>> Isn't this the real underlying issue? Why not make the guarantees of
>> memory.high more strict instead of adding more interfaces and
>> complexity?
>
> Oh, thanks Shakeel for bringing this up. I missed this in the original 
> changelog and I'm surprised that it's mentioned, since we do have 
> protections against that.
>
> Waiman, we already added artificial throttling if memory reclaim is 
> not sufficiently achieved in 0e4b01df8659 ("mm, memcg: throttle 
> allocators when failing reclaim over memory.high"), which has been 
> present since v5.4. This should significantly inhibit physical memory 
> consumption from increasing. What problems are you having with that? :-)
>
Oh, I think I overlooked your patch. You are right. There are already 
throttling in place. So I need to re-examine my patch to see if it is 
still necessary or reduce the scope of the patch.

Thanks,
Longman

