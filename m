Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65564C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA18206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgFJN7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:59:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:33304 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729613AbgFJN7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:59:33 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 95CC8DAAEE057B21A14B;
        Wed, 10 Jun 2020 21:59:28 +0800 (CST)
Received: from [10.173.222.27] (10.173.222.27) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Wed, 10 Jun 2020 21:59:20 +0800
Subject: Re: [PATCH] irqchip/gic-v4.1: Use readx_poll_timeout_atomic() to fix
 sleep in atomic
To:     <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <wanghaibin.wang@huawei.com>,
        <wangjingyi11@huawei.com>
References: <20200605052345.1494-1-yuzenghui@huawei.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <4a9822bd-0362-7ffe-6e56-3f05a7816d9e@huawei.com>
Date:   Wed, 10 Jun 2020 21:59:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200605052345.1494-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

Sorry to ping you in the merge window, but ...

On 2020/6/5 13:23, Zenghui Yu wrote:
> readx_poll_timeout() can sleep if @sleep_us is specified by the caller,
> and is therefore unsafe to be used inside the atomic context, which is
> this case when we use it to poll the GICR_VPENDBASER.Dirty bit in
> irq_set_vcpu_affinity() callback.

this seems like an urgent thing to me. Without this patch, CPUs are
easily to get stuck on my board with GICv4.1 enabled. So it'd be good if
you can have a look and take this as a fix (if it is correct).


Thanks,
Zenghui

> 
> Let's convert to its atomic version instead which helps to get the v4.1
> board back to life!
> 
> Fixes: 96806229ca03 ("irqchip/gic-v4.1: Add support for VPENDBASER's Dirty+Valid signaling")
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>   drivers/irqchip/irq-gic-v3-its.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index cd685f521c77..6a5a87fc4601 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3797,10 +3797,10 @@ static void its_wait_vpt_parse_complete(void)
>   	if (!gic_rdists->has_vpend_valid_dirty)
>   		return;
>   
> -	WARN_ON_ONCE(readq_relaxed_poll_timeout(vlpi_base + GICR_VPENDBASER,
> -						val,
> -						!(val & GICR_VPENDBASER_Dirty),
> -						10, 500));
> +	WARN_ON_ONCE(readq_relaxed_poll_timeout_atomic(vlpi_base + GICR_VPENDBASER,
> +						       val,
> +						       !(val & GICR_VPENDBASER_Dirty),
> +						       10, 500));
>   }
>   
>   static void its_vpe_schedule(struct its_vpe *vpe)
> 
