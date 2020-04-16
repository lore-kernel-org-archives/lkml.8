Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA97EC3815B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A791420936
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgDPBS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:18:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2333 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730752AbgDPBSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:18:09 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 35B945A0308DF2F16736;
        Thu, 16 Apr 2020 09:18:04 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Thu, 16 Apr 2020
 09:17:55 +0800
Subject: Re: [PATCH 2/2] KVM: arm64: vgic-its: Fix memory leak on the error
 path of vgic_add_lpi()
To:     <kvmarm@lists.cs.columbia.edu>
CC:     <maz@kernel.org>, <james.morse@arm.com>,
        <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>,
        <wanghaibin.wang@huawei.com>, <yezengruan@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200414030349.625-1-yuzenghui@huawei.com>
 <20200414030349.625-3-yuzenghui@huawei.com>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <610f2195-f85d-4beb-b711-47d63bb393d0@huawei.com>
Date:   Thu, 16 Apr 2020 09:17:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200414030349.625-3-yuzenghui@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/14 11:03, Zenghui Yu wrote:
> If we're going to fail out the vgic_add_lpi(), let's make sure the
> allocated vgic_irq memory is also freed. Though it seems that both
> cases are unlikely to fail.
> 
> Cc: Zengruan Ye <yezengruan@huawei.com>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>   virt/kvm/arm/vgic/vgic-its.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
> index d53d34a33e35..3c3b6a0f2dce 100644
> --- a/virt/kvm/arm/vgic/vgic-its.c
> +++ b/virt/kvm/arm/vgic/vgic-its.c
> @@ -98,12 +98,16 @@ static struct vgic_irq *vgic_add_lpi(struct kvm *kvm, u32 intid,
>   	 * the respective config data from memory here upon mapping the LPI.
>   	 */
>   	ret = update_lpi_config(kvm, irq, NULL, false);
> -	if (ret)
> +	if (ret) {
> +		kfree(irq);
>   		return ERR_PTR(ret);
> +	}
>   
>   	ret = vgic_v3_lpi_sync_pending_status(kvm, irq);
> -	if (ret)
> +	if (ret) {
> +		kfree(irq);
>   		return ERR_PTR(ret);
> +	}

Looking at it again, I realized that this error handling is still not
complete. Maybe we should use a vgic_put_irq() instead so that we can
also properly delete the vgic_irq from lpi_list.

Marc, what do you think? Could you please help to fix it, or I can
resend it.


Thanks,
Zenghui

