Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D9DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 01:24:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9FD920760
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 01:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgF3BY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 21:24:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6785 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726481AbgF3BY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 21:24:27 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6F1F59EDBB19400A6D26;
        Mon, 29 Jun 2020 17:39:11 +0800 (CST)
Received: from [10.174.185.226] (10.174.185.226) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 29 Jun 2020 17:39:00 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Jason Cooper" <jason@lakedaemon.net>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <wanghaibin.wang@huawei.com>, <kuhn.chenqun@huawei.com>,
        <wangjingyi11@huawei.com>
Subject: [BUG] irqchip/gic-v4.1: sleeping function called from invalid context
Message-ID: <1d673e99-0dd2-d287-aedf-65686eed5194@huawei.com>
Date:   Mon, 29 Jun 2020 17:39:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Booting the latest kernel with DEBUG_ATOMIC_SLEEP=y on a GICv4.1 enabled
box, I get the following kernel splat:

[    0.053766] BUG: sleeping function called from invalid context at 
mm/slab.h:567
[    0.053767] in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 
0, name: swapper/1
[    0.053769] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.8.0-rc3+ #23
[    0.053770] Call trace:
[    0.053774]  dump_backtrace+0x0/0x218
[    0.053775]  show_stack+0x2c/0x38
[    0.053777]  dump_stack+0xc4/0x10c
[    0.053779]  ___might_sleep+0xfc/0x140
[    0.053780]  __might_sleep+0x58/0x90
[    0.053782]  slab_pre_alloc_hook+0x7c/0x90
[    0.053783]  kmem_cache_alloc_trace+0x60/0x2f0
[    0.053785]  its_cpu_init+0x6f4/0xe40
[    0.053786]  gic_starting_cpu+0x24/0x38
[    0.053788]  cpuhp_invoke_callback+0xa0/0x710
[    0.053789]  notify_cpu_starting+0xcc/0xd8
[    0.053790]  secondary_start_kernel+0x148/0x200

# ./scripts/faddr2line vmlinux its_cpu_init+0x6f4/0xe40
its_cpu_init+0x6f4/0xe40:
allocate_vpe_l1_table at drivers/irqchip/irq-gic-v3-its.c:2818
(inlined by) its_cpu_init_lpis at drivers/irqchip/irq-gic-v3-its.c:3138
(inlined by) its_cpu_init at drivers/irqchip/irq-gic-v3-its.c:5166

I've tried to replace GFP_KERNEL flag with GFP_ATOMIC to allocate memory
in this atomic context, and the splat disappears. But after a quick look
at [*], it seems not a good idea to allocate memory within the CPU
hotplug notifier. I really don't know much about it, please have a look.

[*] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=11e37d357f6ba7a9af850a872396082cc0a0001f


Thanks,
Zenghui
