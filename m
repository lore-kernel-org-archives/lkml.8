Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB58C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90CB42067C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 05:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599198648;
	bh=Ajqcu18lUc5/3zhqgtBOnvQIuy7JVp5O+i+71TtQrrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i/B+jZqo1LzxPg5LLIbVg6vuKy+WerOS9+E0tGUjwn2+EK/f6ZLsloHZuR2NHnaKf
	 LyxSVAli+DnkPl8XJUKnALMzOV+D9WgImXKU+RLiEBDa+zkBL1+bjbNKzJJBQcKJ6e
	 IQ36LPZlyt9RyL9yrrN5Ftgrxn/W6eOjPjNMcRMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgIDFuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 01:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgIDFuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 01:50:46 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84BD0C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 22:50:45 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a15so6929457ejf.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 22:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=biVXHXRw4uWtZLcJO28Ygo157d0CnQIl9rGveo0PLXI=;
        b=YV4ocw3j7HVUjpTqO4V9Fp9SItzHcTUFM8dzwT7wTGzWizKHPD5an/DqDzYX8/5H4t
         R2GHMaeJnEd/9XIM5YTrHlJ5y+PCmLdrzos6WY8yW2nn58L428STT6ZOrDx7j9J1rJeo
         O/xtOq810BVwAxpMFhP5kowKbyHf74rw6g+59+Bc1X7oAe3NGYg3Tn5qqBqYS2CVFlei
         hsJDTwNr4lczcLazJjDNserSwxs0UcgvmBw7knOssNCE/ZH32+VgmSsi4jejqIZei+tR
         9ZOkjGsuUxUZ0ZOiGvTPmxSMp0O7PwIOAx7FFw9axvrPfnddTq1a3m+R9RDUXvsbbPPx
         AW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=biVXHXRw4uWtZLcJO28Ygo157d0CnQIl9rGveo0PLXI=;
        b=oGI2lfFA65KRab+StbD6c7WqgB+tZhNoDrzrP6WsjgMh2/fIdl38V2wTXj0Kzg5Lnu
         brVgv2LrQ7fQRtfKIoD2ES8xEEpnCkNuXX18NGwJ8c5BFN8e5xfCJMP7+vHLrdA4YOEl
         YsXA8ts6U4jSWKeF/SZksq3slkpGCvf1QAdXb39iXWB6vvYNHh8Sd2uAXKsnPw4d4+nk
         kZDLYEx2StzKzXGyIUmzu2TUzh5xtRXleIusan7X9dF5p1VoGIx+4KJUfNzrDUJRgfBJ
         /uh9/NwvpXJoau1ChqWqVB65DWaOxZrLKnxk+c/DeJrWE7Lybv9h7TTDpjNQSPaoB8A3
         l1Gw==
X-Gm-Message-State: AOAM533ZcAevPE0VW9Ih5aNMYz3NWcHrieguGTWLXCVYW+YU1I+sz/kK
        JAMxfZiceI7eJi0hIndmkj8=
X-Google-Smtp-Source: ABdhPJwunjWLbCmYl5XW81XJa0Q7HoLOjMBE0bkoA/6XClwTleLcDzVHZWXZBDAbZ8m8AkFHzk252g==
X-Received: by 2002:a17:906:c108:: with SMTP id do8mr6001529ejc.88.1599198643758;
        Thu, 03 Sep 2020 22:50:43 -0700 (PDT)
Received: from gmail.com (563BA415.dsl.pool.telekom.hu. [86.59.164.21])
        by smtp.gmail.com with ESMTPSA id g5sm5100479ejk.52.2020.09.03.22.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 22:50:42 -0700 (PDT)
Date:   Fri, 4 Sep 2020 07:50:40 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "elver@google.com" <elver@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH v2] debugobjects:
 install cpu hotplug callback
Message-ID: <20200904055040.GA2765622@gmail.com>
References: <20200827050614.15100-1-qiang.zhang@windriver.com>
 <BYAPR11MB2632C578C5863019114EE572FF2D0@BYAPR11MB2632.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BYAPR11MB2632C578C5863019114EE572FF2D0@BYAPR11MB2632.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Zhang, Qiang <Qiang.Zhang@windriver.com> wrote:

> tglx please review.
> 
> Thanks
> Qiang
> ________________________________________
> 发件人: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> 代表 qiang.zhang@windriver.com <qiang.zhang@windriver.com>
> 发送时间: 2020年8月27日 13:06
> 收件人: tglx@linutronix.de; longman@redhat.com; elver@google.com
> 抄送: linux-kernel@vger.kernel.org
> 主题: [PATCH v2] debugobjects: install cpu hotplug callback
> 
> From: Zqiang <qiang.zhang@windriver.com>
> 
> Due to cpu hotplug, it may never be online after it's offline,
> some objects in percpu pool is never free, in order to avoid
> this happening, install cpu hotplug callback, call this callback
> func to free objects in percpu pool when cpu going offline.

We capitalize 'CPU'. Also, please split this in at least two sentences.

> 
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>
> ---
>  v1->v2:
>  Modify submission information.
> 
>  include/linux/cpuhotplug.h |  1 +
>  lib/debugobjects.c         | 23 +++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index a2710e654b64..2e77db655cfa 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -36,6 +36,7 @@ enum cpuhp_state {
>         CPUHP_X86_MCE_DEAD,
>         CPUHP_VIRT_NET_DEAD,
>         CPUHP_SLUB_DEAD,
> +       CPUHP_DEBUG_OBJ_DEAD,
>         CPUHP_MM_WRITEBACK_DEAD,
>         CPUHP_MM_VMSTAT_DEAD,
>         CPUHP_SOFTIRQ_DEAD,
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index fe4557955d97..50e21ed0519e 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -19,6 +19,7 @@
>  #include <linux/slab.h>
>  #include <linux/hash.h>
>  #include <linux/kmemleak.h>
> +#include <linux/cpu.h>
> 
>  #define ODEBUG_HASH_BITS       14
>  #define ODEBUG_HASH_SIZE       (1 << ODEBUG_HASH_BITS)
> @@ -433,6 +434,23 @@ static void free_object(struct debug_obj *obj)
>         }
>  }
> 
> +#if defined(CONFIG_HOTPLUG_CPU)
> +static int object_cpu_offline(unsigned int cpu)
> +{
> +       struct debug_percpu_free *percpu_pool;
> +       struct hlist_node *tmp;
> +       struct debug_obj *obj;
> +
> +       percpu_pool = per_cpu_ptr(&percpu_obj_pool, cpu);
> +       hlist_for_each_entry_safe(obj, tmp, &percpu_pool->free_objs, node) {
> +               hlist_del(&obj->node);
> +               kmem_cache_free(obj_cache, obj);
> +       }
> +
> +       return 0;
> +}
> +#endif

What happens to ->obj_free, if the CPU is brought back online? Won't it be 
out of sync at that point?

> +#if defined(CONFIG_HOTPLUG_CPU)

There's a shorter preprocessor sequence for that pattern.

Thanks,

	Ingo
