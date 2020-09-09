Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567F7C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0470E21D46
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIIR7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:59:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:35182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgIIR7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 13:59:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5822FAD20;
        Wed,  9 Sep 2020 18:00:02 +0000 (UTC)
Subject: Re: [PATCH v2] mm/vmscan: fix infinite loop in drop_slab_node
To:     zangchunxin@bytedance.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
References: <20200909152047.27905-1-zangchunxin@bytedance.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <16906d44-9e3c-76a1-f1a9-ced61e865467@suse.cz>
Date:   Wed, 9 Sep 2020 19:59:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909152047.27905-1-zangchunxin@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/20 5:20 PM, zangchunxin@bytedance.com wrote:
> From: Chunxin Zang <zangchunxin@bytedance.com>
> 
> On our server, there are about 10k memcg in one machine. They use memory
> very frequently. When I tigger drop caches，the process will infinite loop
> in drop_slab_node.
> 
> There are two reasons:
> 1.We have too many memcgs, even though one object freed in one memcg, the
>   sum of object is bigger than 10.
> 
> 2.We spend a lot of time in traverse memcg once. So, the memcg who
>   traversed at the first have been freed many objects. Traverse memcg next
>   time, the freed count bigger than 10 again.
> 
> We can get the following info through 'ps':
> 
>   root:~# ps -aux | grep drop
>   root  357956 ... R    Aug25 21119854:55 echo 3 > /proc/sys/vm/drop_caches
>   root 1771385 ... R    Aug16 21146421:17 echo 3 > /proc/sys/vm/drop_caches
>   root 1986319 ... R    18:56 117:27 echo 3 > /proc/sys/vm/drop_caches
>   root 2002148 ... R    Aug24 5720:39 echo 3 > /proc/sys/vm/drop_caches
>   root 2564666 ... R    18:59 113:58 echo 3 > /proc/sys/vm/drop_caches
>   root 2639347 ... R    Sep03 2383:39 echo 3 > /proc/sys/vm/drop_caches
>   root 3904747 ... R    03:35 993:31 echo 3 > /proc/sys/vm/drop_caches
>   root 4016780 ... R    Aug21 7882:18 echo 3 > /proc/sys/vm/drop_caches
> 
> Use bpftrace follow 'freed' value in drop_slab_node:
> 
>   root:~# bpftrace -e 'kprobe:drop_slab_node+70 {@ret=hist(reg("bp")); }'
>   Attaching 1 probe...
>   ^B^C
> 
>   @ret:
>   [64, 128)        1 |                                                    |
>   [128, 256)      28 |                                                    |
>   [256, 512)     107 |@                                                   |
>   [512, 1K)      298 |@@@                                                 |
>   [1K, 2K)       613 |@@@@@@@                                             |
>   [2K, 4K)      4435 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
>   [4K, 8K)       442 |@@@@@                                               |
>   [8K, 16K)      299 |@@@                                                 |
>   [16K, 32K)     100 |@                                                   |
>   [32K, 64K)     139 |@                                                   |
>   [64K, 128K)     56 |                                                    |
>   [128K, 256K)    26 |                                                    |
>   [256K, 512K)     2 |                                                    |
> 
> In the while loop, we can check whether the TASK_KILLABLE signal is set,
> if so, we should break the loop.

That's definitely a good change, thanks. I would just maybe consider:
- Test in the memcg iteration loop? If you have 10k memcgs as you mention, this
can still take long until the test happens?
- Exit also on other signals such as SIGABRT, SIGTERM? If I write to drop_caches
and think it's too long, I would prefer to kill it by ctrl-c and not just kill
-9. Dunno if the canonical way of testing for this is if
(signal_pending(current)) or differently.
- IMHO it's still worth to bail out in your scenario even without a signal, e.g.
by the doubling of threshold. But it can be a separate patch.

Thanks!

> Signed-off-by: Chunxin Zang <zangchunxin@bytedance.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> 	changelogs in v2: 
> 	1) Via check TASK_KILLABLE signal break loop.
> 
>  mm/vmscan.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b6d84326bdf2..c3ed8b45d264 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -704,6 +704,9 @@ void drop_slab_node(int nid)
>  	do {
>  		struct mem_cgroup *memcg = NULL;
>  
> +		if (fatal_signal_pending(current))
> +			return;
> +
>  		freed = 0;
>  		memcg = mem_cgroup_iter(NULL, NULL, NULL);
>  		do {
> 

