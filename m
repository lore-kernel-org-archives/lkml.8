Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CB9C2BC11
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B502145D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e9tOmp79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbgIHSZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726660AbgIHSZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599589502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c4gcp/bZU9lgZw1R6KxJ0Pc2FZGgn2nf/f7K9pgTFxk=;
        b=e9tOmp79VNZYasogx0gTaeVP1fnyO8K0hUA6absDu1o//DmzC5fRsPgFR6NxQGDFR+ixYN
        iOQ+wywUndXQ/lssdiwUh6jbelfulkjxgAtkr82+KUgJAhpVIx5vdZpsC7w+o2xowYMVfb
        yVgej6LY6w1ArKqH3hBoKA5VC/8vuFY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-143-9H-jqZILNf6yTEMqn5ySgw-1; Tue, 08 Sep 2020 14:23:36 -0400
X-MC-Unique: 9H-jqZILNf6yTEMqn5ySgw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C191718B9EC4;
        Tue,  8 Sep 2020 18:23:34 +0000 (UTC)
Received: from llong.remote.csb (ovpn-118-102.rdu2.redhat.com [10.10.118.102])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 252CD83560;
        Tue,  8 Sep 2020 18:23:34 +0000 (UTC)
Subject: Re: [PATCH v3] debugobjects: install CPU hotplug callback
To:     qiang.zhang@windriver.com, tglx@linutronix.de, mingo@kernel.org,
        elver@google.com
Cc:     linux-kernel@vger.kernel.org
References: <20200908062709.11441-1-qiang.zhang@windriver.com>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <3bcdacd0-10c4-78c0-6e63-a73811a0ced6@redhat.com>
Date:   Tue, 8 Sep 2020 14:23:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200908062709.11441-1-qiang.zhang@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 2:27 AM, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
>
> Due to CPU hotplug, it may never be online after it's offline,
> some objects in percpu pool is never free. in order to avoid
> this happening, install CPU hotplug callback, call this callback
> func to free objects in percpu pool when CPU going offline.
>
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>   v1->v2:
>   Modify submission information.
>
>   v2->v3:
>   In CPU hotplug callback func, add clear percpu pool "obj_free" operation.
>   capitalize 'CPU', and use shorter preprocessor sequence.
>
>   include/linux/cpuhotplug.h |  1 +
>   lib/debugobjects.c         | 24 ++++++++++++++++++++++++
>   2 files changed, 25 insertions(+)
>
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 3215023d4852..0c39d57e5342 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -36,6 +36,7 @@ enum cpuhp_state {
>   	CPUHP_X86_MCE_DEAD,
>   	CPUHP_VIRT_NET_DEAD,
>   	CPUHP_SLUB_DEAD,
> +	CPUHP_DEBUG_OBJ_DEAD,
>   	CPUHP_MM_WRITEBACK_DEAD,
>   	CPUHP_MM_VMSTAT_DEAD,
>   	CPUHP_SOFTIRQ_DEAD,
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index fe4557955d97..bb69a02c3e7b 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -19,6 +19,7 @@
>   #include <linux/slab.h>
>   #include <linux/hash.h>
>   #include <linux/kmemleak.h>
> +#include <linux/cpu.h>
>   
>   #define ODEBUG_HASH_BITS	14
>   #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
> @@ -433,6 +434,24 @@ static void free_object(struct debug_obj *obj)
>   	}
>   }
>   
> +#ifdef CONFIG_HOTPLUG_CPU
> +static int object_cpu_offline(unsigned int cpu)
> +{
> +	struct debug_percpu_free *percpu_pool;
> +	struct hlist_node *tmp;
> +	struct debug_obj *obj;
> +
> +	percpu_pool = per_cpu_ptr(&percpu_obj_pool, cpu);
> +	hlist_for_each_entry_safe(obj, tmp, &percpu_pool->free_objs, node) {
> +		hlist_del(&obj->node);
> +		kmem_cache_free(obj_cache, obj);
> +	}
> +	percpu_pool->obj_free = 0;

For pointer, it is better to use NULL for clarity.

Cheers,
Longman

> +
> +	return 0;
> +}
> +#endif
> +
>   /*
>    * We run out of memory. That means we probably have tons of objects
>    * allocated.
> @@ -1367,6 +1386,11 @@ void __init debug_objects_mem_init(void)
>   	} else
>   		debug_objects_selftest();
>   
> +#ifdef CONFIG_HOTPLUG_CPU
> +	cpuhp_setup_state_nocalls(CPUHP_DEBUG_OBJ_DEAD, "object:offline", NULL,
> +					object_cpu_offline);
> +#endif
> +
>   	/*
>   	 * Increase the thresholds for allocating and freeing objects
>   	 * according to the number of possible CPUs available in the system.


