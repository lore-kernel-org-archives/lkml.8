Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911E9C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD022051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 10:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730733AbgCPKuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 06:50:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11650 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730478AbgCPKuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 06:50:06 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1798D6017481BD96D1A2;
        Mon, 16 Mar 2020 18:50:02 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Mon, 16 Mar 2020
 18:49:53 +0800
Subject: Re: [PATCH] KVM: arm64: Use the correct timer for accessing CNT
To:     KarimAllah Ahmed <karahmed@amazon.de>,
        <linux-kernel@vger.kernel.org>
CC:     Marc Zyngier <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>
References: <1584351546-5018-1-git-send-email-karahmed@amazon.de>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <7ed91b9b-e968-770c-28f9-0ca479359657@huawei.com>
Date:   Mon, 16 Mar 2020 18:49:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1584351546-5018-1-git-send-email-karahmed@amazon.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020/3/16 17:39, KarimAllah Ahmed wrote:
> Use the physical timer object when reading the physical timer counter
> instead of using the virtual timer object. This is only visible when
> reading it from user-space as kvm_arm_timer_get_reg() is only executed on
> the get register patch from user-space.

s/patch/path/

I think the physical counter hasn't yet been accessed by the current
userspace, wrong?

> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

And this might also deserve:

Fixes: 84135d3d18da ("KVM: arm/arm64: consolidate arch timer trap handlers")


Thanks.

> ---
>   virt/kvm/arm/arch_timer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> index 0d9438e..93bd59b 100644
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -788,7 +788,7 @@ u64 kvm_arm_timer_get_reg(struct kvm_vcpu *vcpu, u64 regid)
>   					  vcpu_ptimer(vcpu), TIMER_REG_CTL);
>   	case KVM_REG_ARM_PTIMER_CNT:
>   		return kvm_arm_timer_read(vcpu,
> -					  vcpu_vtimer(vcpu), TIMER_REG_CNT);
> +					  vcpu_ptimer(vcpu), TIMER_REG_CNT);
>   	case KVM_REG_ARM_PTIMER_CVAL:
>   		return kvm_arm_timer_read(vcpu,
>   					  vcpu_ptimer(vcpu), TIMER_REG_CVAL);
> 

