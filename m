Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F723C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ED71208C7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgIGIpq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:45:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56906 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgIGIpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:45:45 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kFCmR-00058E-PM; Mon, 07 Sep 2020 08:45:43 +0000
Date:   Mon, 7 Sep 2020 10:45:38 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        linux-mm.kvack.org@wittgenstein
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        mingo@kernel.org, peterz@infradead.org, ebiederm@xmission.com,
        esyr@redhat.com, tglx@linutronix.de, christian@kellner.me,
        areber@redhat.com, shakeelb@google.com, cyphar@cyphar.com,
        psodagud@codeaurora.org, pratikp@codeaurora.org
Subject: Re: [RFC PATCH] fork: Free per-cpu cached vmalloc'ed thread stacks
 with
Message-ID: <20200907084538.qz5g4mikznwxr67g@wittgenstein>
References: <010101745b9b7825-f4d1db4b-83fb-450e-9391-82aad77a1bd6-000000@us-west-2.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <010101745b9b7825-f4d1db4b-83fb-450e-9391-82aad77a1bd6-000000@us-west-2.amazonses.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 05, 2020 at 12:12:29AM +0000, Isaac J. Manjarres wrote:
> The per-cpu cached vmalloc'ed stacks are currently freed in the
> CPU hotplug teardown path by the free_vm_stack_cache() callback,
> which invokes vfree(), which may result in purging the list of
> lazily freed vmap areas.
> 
> Purging all of the lazily freed vmap areas can take a long time
> when the list of vmap areas is large. This is problematic, as
> free_vm_stack_cache() is invoked prior to the offline CPU's timers
> being migrated. This is not desirable as it can lead to timer
> migration delays in the CPU hotplug teardown path, and timer callbacks
> will be invoked long after the timer has expired.
> 
> For example, on a system that has only one online CPU (CPU 1) that is
> running a heavy workload, and another CPU that is being offlined,
> the online CPU will invoke free_vm_stack_cache() to free the cached
> vmalloc'ed stacks for the CPU being offlined. When there are 2702
> vmap areas that total to 13498 pages, free_vm_stack_cache() takes
> over 2 seconds to execute:
> 
> [001]   399.335808: cpuhp_enter: cpu: 0005 target:   0 step:  67 (free_vm_stack_cache)
> 
> /* The first vmap area to be freed */
> [001]   399.337157: __purge_vmap_area_lazy: [0:2702] 0xffffffc033da8000 - 0xffffffc033dad000 (5 : 13498)
> 
> /* After two seconds */
> [001]   401.528010: __purge_vmap_area_lazy: [1563:2702] 0xffffffc02fe10000 - 0xffffffc02fe15000 (5 : 5765)
> 
> Instead of freeing the per-cpu cached vmalloc'ed stacks synchronously
> with respect to the CPU hotplug teardown state machine, free them
> asynchronously to help move along the CPU hotplug teardown state machine
> quickly.
> 
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> ---

This needs reviews and acks from the good folks over at mm/.

>  kernel/fork.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 4d32190..68346a0 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -202,7 +202,7 @@ static int free_vm_stack_cache(unsigned int cpu)
>  		if (!vm_stack)
>  			continue;
>  
> -		vfree(vm_stack->addr);
> +		vfree_atomic(vm_stack->addr);
>  		cached_vm_stacks[i] = NULL;
>  	}
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
