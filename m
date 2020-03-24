Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2FDC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 02:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BF120637
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 02:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCXCnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 22:43:32 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46740 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727047AbgCXCnc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 22:43:32 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 89E47BFAA9A5134BBF4F;
        Tue, 24 Mar 2020 10:43:20 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 24 Mar 2020
 10:43:10 +0800
Subject: Re: [PATCH v6 14/23] irqchip/gic-v4.1: Add VSGI allocation/teardown
To:     Marc Zyngier <maz@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20200320182406.23465-1-maz@kernel.org>
 <20200320182406.23465-15-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <f778d757-0312-5412-668c-db9aee889cf0@huawei.com>
Date:   Tue, 24 Mar 2020 10:43:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200320182406.23465-15-maz@kernel.org>
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

On 2020/3/21 2:23, Marc Zyngier wrote:
> Allocate per-VPE SGIs when initializing the GIC-specific part of the
> VPE data structure.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
> Link: https://lore.kernel.org/r/20200304203330.4967-15-maz@kernel.org
> ---
>   drivers/irqchip/irq-gic-v3-its.c   |  2 +-
>   drivers/irqchip/irq-gic-v4.c       | 68 +++++++++++++++++++++++++++++-
>   include/linux/irqchip/arm-gic-v4.h |  4 +-
>   3 files changed, 71 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 15250faa9ef7..7ad46ff5f0b9 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -4053,7 +4053,7 @@ static int its_sgi_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
>   	struct its_cmd_info *info = vcpu_info;
>   
>   	switch (info->cmd_type) {
> -	case PROP_UPDATE_SGI:
> +	case PROP_UPDATE_VSGI:
>   		vpe->sgi_config[d->hwirq].priority = info->priority;
>   		vpe->sgi_config[d->hwirq].group = info->group;
>   		its_configure_sgi(d, false);

[...]

> @@ -103,7 +105,7 @@ enum its_vcpu_info_cmd_type {
>   	SCHEDULE_VPE,
>   	DESCHEDULE_VPE,
>   	INVALL_VPE,
> -	PROP_UPDATE_SGI,
> +	PROP_UPDATE_VSGI,
>   };
>   
>   struct its_cmd_info {

As Eric pointed out, this belongs to patch #12.


Thanks,
Zenghui

