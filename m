Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761DEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570C920656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593456057;
	bh=34RLz4AGlOLv0qThfaZkESlSozovgvdYMlx7twj9dNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oFZoiIGD1Q/8wKzzyNpHFkaCsh9Bu/n4CuVgOMWNxm8YUK5FXq4kAqiW3ibgT2nqn
	 /T2APNcaPedrkUGWM/Df379UJxcd5wdiembyq5IvcVmPQpYY460nbUBk7PLmivrzkp
	 smTHs0PjR6BFAx+Zl493T8OGxPlLZEgp+iP0S5Es=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgF2Skz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:40:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728528AbgF2Skv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:51 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F07123D51;
        Mon, 29 Jun 2020 14:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593439266;
        bh=34RLz4AGlOLv0qThfaZkESlSozovgvdYMlx7twj9dNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=H9hqRgTH3hbbEok3oVOWnPSHA8uX73nPBDevXHnc+9COGNF/WvBBV3bLj1bTeRu56
         HY/l+I/ZhoyZ4BZCC4QisD1Jqi89UZtqqlLdEF+UYbuxaL9FKjK7eC0U/o9YpB4kS0
         3LaZwMu/3b9xCFSjl/q0BfUfzGUiudLaGrBv8J3w=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jpuLJ-007Kfz-4d; Mon, 29 Jun 2020 15:01:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 29 Jun 2020 15:01:05 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wanghaibin.wang@huawei.com, kuhn.chenqun@huawei.com,
        wangjingyi11@huawei.com
Subject: Re: [BUG] irqchip/gic-v4.1: sleeping function called from invalid
 context
In-Reply-To: <1d673e99-0dd2-d287-aedf-65686eed5194@huawei.com>
References: <1d673e99-0dd2-d287-aedf-65686eed5194@huawei.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <c401871295f68391473f2e522b920719@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com, kuhn.chenqun@huawei.com, wangjingyi11@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 2020-06-29 10:39, Zenghui Yu wrote:
> Hi All,
> 
> Booting the latest kernel with DEBUG_ATOMIC_SLEEP=y on a GICv4.1 
> enabled
> box, I get the following kernel splat:
> 
> [    0.053766] BUG: sleeping function called from invalid context at
> mm/slab.h:567
> [    0.053767] in_atomic(): 1, irqs_disabled(): 128, non_block: 0,
> pid: 0, name: swapper/1
> [    0.053769] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.8.0-rc3+ #23
> [    0.053770] Call trace:
> [    0.053774]  dump_backtrace+0x0/0x218
> [    0.053775]  show_stack+0x2c/0x38
> [    0.053777]  dump_stack+0xc4/0x10c
> [    0.053779]  ___might_sleep+0xfc/0x140
> [    0.053780]  __might_sleep+0x58/0x90
> [    0.053782]  slab_pre_alloc_hook+0x7c/0x90
> [    0.053783]  kmem_cache_alloc_trace+0x60/0x2f0
> [    0.053785]  its_cpu_init+0x6f4/0xe40
> [    0.053786]  gic_starting_cpu+0x24/0x38
> [    0.053788]  cpuhp_invoke_callback+0xa0/0x710
> [    0.053789]  notify_cpu_starting+0xcc/0xd8
> [    0.053790]  secondary_start_kernel+0x148/0x200
> 
> # ./scripts/faddr2line vmlinux its_cpu_init+0x6f4/0xe40
> its_cpu_init+0x6f4/0xe40:
> allocate_vpe_l1_table at drivers/irqchip/irq-gic-v3-its.c:2818
> (inlined by) its_cpu_init_lpis at drivers/irqchip/irq-gic-v3-its.c:3138
> (inlined by) its_cpu_init at drivers/irqchip/irq-gic-v3-its.c:5166

Let me guess: a system with more than a single CommonLPIAff group?

> I've tried to replace GFP_KERNEL flag with GFP_ATOMIC to allocate 
> memory
> in this atomic context, and the splat disappears. But after a quick 
> look
> at [*], it seems not a good idea to allocate memory within the CPU
> hotplug notifier. I really don't know much about it, please have a 
> look.
> 
> [*]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=11e37d357f6ba7a9af850a872396082cc0a0001f

The allocation of the cpumask is pretty benign, and could either be
allocated upfront for all RDs (and freed on detecting that we share
the same CommonLPIAff group) or made atomic.

The much bigger issue is the alloc_pages call just after. Allocating 
this
upfront probably is the wrong thing to do, as you are likely to allocate
way too much memory, even if you free it quickly afterwards.

At this stage, I'd rather we turn this into an atomic allocation. A 
notifier
is just another atomic context, and if this fails at such an early 
stage,
then the CPU is unlikely to continue booting...

Would you like to write a patch for this? Given that you have tested
something, it probably already exists. Or do you want me to do it?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
