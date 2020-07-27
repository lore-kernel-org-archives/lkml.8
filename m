Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2B1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11D282073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595836683;
	bh=pFZyTgLd3xYYzeu+q0Y9eI/gLqSakkiOd6qEy6AoK6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=o/un1qwdeQfiAriJj1wnf97cnUVqidxp5pn2QXJBjiwSEjtNDLCkWZX7x42R7t/KX
	 wUsXd9LEJm+rKzfZrKlQnTQVGwFtyDsuyRDhebrwptBMvcDV2IRjjbmR+QlYVyFSyo
	 h2Ycj7FOSRt0jWPmO+WhxUH7Cch7zOkfnW5CXEys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbgG0H6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:58:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:43456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgG0H6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:58:01 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80C1420738;
        Mon, 27 Jul 2020 07:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595836680;
        bh=pFZyTgLd3xYYzeu+q0Y9eI/gLqSakkiOd6qEy6AoK6c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UEu83P/HXZHqBR8qjfrTD2iwi1LEuDZFHt9rIx5+1N3VTQT6sGC4Xupm00PFzSWsJ
         nDjzJysoa3s8HauGOOTrX0gIALShEOHsXGV3lvTU1qrC+tsKwaqKMGTUtUat6WF0R8
         /ARAA9sDFnKmKSXw4TVhq9XVBZKJXxJCk5onfYpI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jzy1G-00FE6z-RP; Mon, 27 Jul 2020 08:57:59 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 27 Jul 2020 08:57:58 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, wanghaibin.wang@huawei.com,
        kuhn.chenqun@huawei.com, wangjingyi11@huawei.com
Subject: Re: [PATCH] irqchip/gic-v4.1: Use GFP_ATOMIC flag in
 allocate_vpe_l1_table()
In-Reply-To: <076a3e82-ba21-6e6a-c6cd-937abb063eb9@huawei.com>
References: <20200630133746.816-1-yuzenghui@huawei.com>
 <076a3e82-ba21-6e6a-c6cd-937abb063eb9@huawei.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <9c18d534e3a57aad5f8d4a6f69c7c041@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, wanghaibin.wang@huawei.com, kuhn.chenqun@huawei.com, wangjingyi11@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 2020-07-27 04:50, Zenghui Yu wrote:
> Hi Marc,
> 
> On 2020/6/30 21:37, Zenghui Yu wrote:
>> Booting the latest kernel with DEBUG_ATOMIC_SLEEP=y on a GICv4.1 
>> enabled
>> box, I get the following kernel splat:
>> 
>> [    0.053766] BUG: sleeping function called from invalid context at 
>> mm/slab.h:567
>> [    0.053767] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, 
>> pid: 0, name: swapper/1
>> [    0.053769] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.8.0-rc3+ 
>> #23
>> [    0.053770] Call trace:
>> [    0.053774]  dump_backtrace+0x0/0x218
>> [    0.053775]  show_stack+0x2c/0x38
>> [    0.053777]  dump_stack+0xc4/0x10c
>> [    0.053779]  ___might_sleep+0xfc/0x140
>> [    0.053780]  __might_sleep+0x58/0x90
>> [    0.053782]  slab_pre_alloc_hook+0x7c/0x90
>> [    0.053783]  kmem_cache_alloc_trace+0x60/0x2f0
>> [    0.053785]  its_cpu_init+0x6f4/0xe40
>> [    0.053786]  gic_starting_cpu+0x24/0x38
>> [    0.053788]  cpuhp_invoke_callback+0xa0/0x710
>> [    0.053789]  notify_cpu_starting+0xcc/0xd8
>> [    0.053790]  secondary_start_kernel+0x148/0x200
>> 
>>  # ./scripts/faddr2line vmlinux its_cpu_init+0x6f4/0xe40
>> its_cpu_init+0x6f4/0xe40:
>> allocate_vpe_l1_table at drivers/irqchip/irq-gic-v3-its.c:2818
>> (inlined by) its_cpu_init_lpis at 
>> drivers/irqchip/irq-gic-v3-its.c:3138
>> (inlined by) its_cpu_init at drivers/irqchip/irq-gic-v3-its.c:5166
>> 
>> It turned out that we're allocating memory using GFP_KERNEL (may 
>> sleep)
>> within the CPU hotplug notifier, which is indeed an atomic context. 
>> Bad
>> thing may happen if we're playing on a system with more than a single
>> CommonLPIAff group. Avoid it by turning this into an atomic 
>> allocation.
>> 
>> Fixes: 5e5168461c22 ("irqchip/gic-v4.1: VPE table (aka 
>> GICR_VPROPBASER) allocation")
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
>> b/drivers/irqchip/irq-gic-v3-its.c
>> index 6a5a87fc4601..b66eeca442c4 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -2814,7 +2814,7 @@ static int allocate_vpe_l1_table(void)
>>  	if (val & GICR_VPROPBASER_4_1_VALID)
>>  		goto out;
>>  -	gic_data_rdist()->vpe_table_mask = kzalloc(sizeof(cpumask_t), 
>> GFP_KERNEL);
>> +	gic_data_rdist()->vpe_table_mask = kzalloc(sizeof(cpumask_t), 
>> GFP_ATOMIC);
>>  	if (!gic_data_rdist()->vpe_table_mask)
>>  		return -ENOMEM;
>>  @@ -2881,7 +2881,7 @@ static int allocate_vpe_l1_table(void)
>>   	pr_debug("np = %d, npg = %lld, psz = %d, epp = %d, esz = %d\n",
>>  		 np, npg, psz, epp, esz);
>> -	page = alloc_pages(GFP_KERNEL | __GFP_ZERO, get_order(np * 
>> PAGE_SIZE));
>> +	page = alloc_pages(GFP_ATOMIC | __GFP_ZERO, get_order(np * 
>> PAGE_SIZE));
>>  	if (!page)
>>  		return -ENOMEM;
>> 
> 
> Do you mind taking this patch into v5.9? Or please let me know if you
> still have any concerns on it?

Oops, I seem to have dropped this one on the floor.
I've picked it up now.

Thanks for the heads up,

         M.
-- 
Jazz is not dead. It just smells funny...
