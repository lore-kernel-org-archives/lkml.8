Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118BDC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2EA421D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Us/bEkXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgIJCvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:51:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44595 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730068AbgIJCuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599706234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QJQOTeTVHeQk2Lc8CRwNu9NdRVyDZ7qS/l1V2jelAI8=;
        b=Us/bEkXqNKvmHsSj7u57ZoxJyLU6clnWgPZx6BCPjyUHA2c+kW5YLf/au4NpxwEcfans3+
        ofqkPkFyLTHf35LpxQUvRYa1R5G4jlZMOiZZuwBvwet4Yvu1XXH0yhpIsUTWZrA1cjzujJ
        dQk2l0heUpOdNRPuG4DtCL/wMUjDxUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-IKKAOBSFMvKLG1cL0f7GMw-1; Wed, 09 Sep 2020 22:50:30 -0400
X-MC-Unique: IKKAOBSFMvKLG1cL0f7GMw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80EAD1007464;
        Thu, 10 Sep 2020 02:50:29 +0000 (UTC)
Received: from llong.remote.csb (unknown [10.10.115.252])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D7797E175;
        Thu, 10 Sep 2020 02:50:28 +0000 (UTC)
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYzXSBkZWJ1Z29iamVjdHM6IGluc3Rh?=
 =?UTF-8?Q?ll_CPU_hotplug_callback?=
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "elver@google.com" <elver@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200908062709.11441-1-qiang.zhang@windriver.com>
 <3bcdacd0-10c4-78c0-6e63-a73811a0ced6@redhat.com>
 <BYAPR11MB26324FE54B890DD73417F6B8FF270@BYAPR11MB2632.namprd11.prod.outlook.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <fc7702c8-6d85-66ee-3220-8c1a3e9acf0b@redhat.com>
Date:   Wed, 9 Sep 2020 22:50:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB26324FE54B890DD73417F6B8FF270@BYAPR11MB2632.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/20 9:48 PM, Zhang, Qiang wrote:
>
> ________________________________________
> 发件人: Waiman Long <longman@redhat.com>
> 发送时间: 2020年9月9日 2:23
> 收件人: Zhang, Qiang; tglx@linutronix.de; mingo@kernel.org; elver@google.com
> 抄送: linux-kernel@vger.kernel.org
> 主题: Re: [PATCH v3] debugobjects: install CPU hotplug callback
>
> On 9/8/20 2:27 AM, qiang.zhang@windriver.com wrote:
>> From: Zqiang <qiang.zhang@windriver.com>
>>
>> Due to CPU hotplug, it may never be online after it's offline,
>> some objects in percpu pool is never free. in order to avoid
>> this happening, install CPU hotplug callback, call this callback
>> func to free objects in percpu pool when CPU going offline.
>>
>> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
>> ---
>>    v1->v2:
>>    Modify submission information.
>>
>>    v2->v3:
>>    In CPU hotplug callback func, add clear percpu pool "obj_free" operation.
>>    capitalize 'CPU', and use shorter preprocessor sequence.
>>
>>    include/linux/cpuhotplug.h |  1 +
>>    lib/debugobjects.c         | 24 ++++++++++++++++++++++++
>>    2 files changed, 25 insertions(+)
>>
>> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
>> index 3215023d4852..0c39d57e5342 100644
>> --- a/include/linux/cpuhotplug.h
>> +++ b/include/linux/cpuhotplug.h
>> @@ -36,6 +36,7 @@ enum cpuhp_state {
>>        CPUHP_X86_MCE_DEAD,
>>        CPUHP_VIRT_NET_DEAD,
>>        CPUHP_SLUB_DEAD,
>> +     CPUHP_DEBUG_OBJ_DEAD,
>>        CPUHP_MM_WRITEBACK_DEAD,
>>        CPUHP_MM_VMSTAT_DEAD,
>>        CPUHP_SOFTIRQ_DEAD,
>> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
>> index fe4557955d97..bb69a02c3e7b 100644
>> --- a/lib/debugobjects.c
>> +++ b/lib/debugobjects.c
>> @@ -19,6 +19,7 @@
>>    #include <linux/slab.h>
>>    #include <linux/hash.h>
>>    #include <linux/kmemleak.h>
>> +#include <linux/cpu.h>
>>
>>    #define ODEBUG_HASH_BITS    14
>>    #define ODEBUG_HASH_SIZE    (1 << ODEBUG_HASH_BITS)
>> @@ -433,6 +434,24 @@ static void free_object(struct debug_obj *obj)
>>        }
>>    }
>>
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +static int object_cpu_offline(unsigned int cpu)
>> +{
>> +     struct debug_percpu_free *percpu_pool;
>> +     struct hlist_node *tmp;
>> +     struct debug_obj *obj;
>> +
>> +     percpu_pool = per_cpu_ptr(&percpu_obj_pool, cpu);
>> +     hlist_for_each_entry_safe(obj, tmp, &percpu_pool->free_objs, node) {
>> +             hlist_del(&obj->node);
>> +             kmem_cache_free(obj_cache, obj);
>> +     }
>> +     percpu_pool->obj_free = 0;
>>> For pointer, it is better to use NULL for clarity.
>>> Cheers,
>>> Longman
> Do you mean "->obj_free" variable ?   this represents the number of free objects in  percpu_pool .
>
You are right. I got confused. Sorry for the noise.

Cheers,
Longman

