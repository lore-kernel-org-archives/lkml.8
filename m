Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC80C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 290412469C
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 20:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TrVi1Vls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgFTUsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 16:48:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47191 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728807AbgFTUsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 16:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592686089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kcnVcw2BsdiV3cf0d7OYXHmXnlCa3e+D0j3FNWSgmpE=;
        b=TrVi1Vls9pHsaiXdMQCdwvQNvQkpntLhBdwMNSoWdzfMm4+llsTHYJazjzwlblF0VHuJW2
        fbpAWXjSeCsQKOJPtKj1Twtgc430LPJ31E7cpU/KNqTuMtLjbiCvRWu6PJbVBT+2pS1UTj
        5q+XIX8a8ut0PgubKANiq5IEh5ZLTww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-AaOvkQczOQy-BgVUM84z4Q-1; Sat, 20 Jun 2020 16:48:07 -0400
X-MC-Unique: AaOvkQczOQy-BgVUM84z4Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1BDA107ACCA;
        Sat, 20 Jun 2020 20:48:04 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-81.rdu2.redhat.com [10.10.112.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D2455BAE0;
        Sat, 20 Jun 2020 20:48:02 +0000 (UTC)
Subject: Re: [PATCH] mm, slab: Fix sign conversion problem in
 memcg_uncharge_slab()
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200620184719.10994-1-longman@redhat.com>
 <20200620195905.GA286724@carbon.DHCP.thefacebook.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <7711a89c-340c-c95b-5857-83baa502322d@redhat.com>
Date:   Sat, 20 Jun 2020 16:48:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200620195905.GA286724@carbon.DHCP.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/20/20 3:59 PM, Roman Gushchin wrote:
> On Sat, Jun 20, 2020 at 02:47:19PM -0400, Waiman Long wrote:
>> It was found that running the LTP test on a PowerPC system could produce
>> erroneous values in /proc/meminfo, like:
>>
>>    MemTotal:       531915072 kB
>>    MemFree:        507962176 kB
>>    MemAvailable:   1100020596352 kB
>>
>> Using bisection, the problem is tracked down to commit 9c315e4d7d8c
>> ("mm: memcg/slab: cache page number in memcg_(un)charge_slab()").
>>
>> In memcg_uncharge_slab() with a "int order" argument:
>>
>>    unsigned int nr_pages = 1 << order;
>>      :
>>    mod_lruvec_state(lruvec, cache_vmstat_idx(s), -nr_pages);
>>
>> The mod_lruvec_state() function will eventually call the
>> __mod_zone_page_state() which accepts a long argument.  Depending on
>> the compiler and how inlining is done, "-nr_pages" may be treated as
>> a negative number or a very large positive number. Apparently, it was
>> treated as a large positive number in that PowerPC system leading to
>> incorrect stat counts. This problem hasn't been seen in x86-64 yet,
>> perhaps the gcc compiler there has some slight difference in behavior.
>>
>> It is fixed by making nr_pages a signed value. For consistency, a
>> similar change is applied to memcg_charge_slab() as well.
>>
>> Fixes: 9c315e4d7d8c ("mm: memcg/slab: cache page number in memcg_(un)charge_slab()").
>> Signed-off-by: Waiman Long <longman@redhat.com>
> Good catch!
>
> Interesting that I haven't seen it on x86-64, but it's reproducible on Power.
>
> Acked-by: Roman Gushchin <guro@fb.com>
>
I think it is probably related to the level of inlining that are being 
done. Besides, the interpretation of -nr_pages is ambiguous if nr_pages 
is an unsigned value and different compilers may handle it differently 
when sign extension is needed.

Cheers,
Longman


