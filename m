Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664E3C5ACC4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 03:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A68F21D56
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 03:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgBTDZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 22:25:53 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:34362 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727208AbgBTDZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 22:25:52 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 51068A1533B41914DC60;
        Thu, 20 Feb 2020 11:25:49 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Thu, 20 Feb 2020
 11:25:43 +0800
Subject: Re: [PATCH v4 06/20] irqchip/gic-v4.1: Add initial SGI configuration
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        "Robert Richter" <rrichter@marvell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric Auger" <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        "Julien Thierry" <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20200214145736.18550-1-maz@kernel.org>
 <20200214145736.18550-7-maz@kernel.org>
 <e47baffb-83a5-57d7-1721-eaee28aaaabf@huawei.com>
 <4a64bf17c015cb10e62d9c1a1ff64db5@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <5d511c78-2339-2aea-8bfc-e13ed464af11@huawei.com>
Date:   Thu, 20 Feb 2020 11:25:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <4a64bf17c015cb10e62d9c1a1ff64db5@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2020/2/18 17:46, Marc Zyngier wrote:
> Hi Zenghui,
> 
> On 2020-02-18 07:25, Zenghui Yu wrote:
>> Hi Marc,
> 
> [...]
> 
>>>     static void its_sgi_irq_domain_deactivate(struct irq_domain *domain,
>>>                         struct irq_data *d)
>>>   {
>>> -    /* Nothing to do */
>>> +    struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
>>> +
>>> +    vpe->sgi_config[d->hwirq].enabled = false;
>>> +    its_configure_sgi(d, true);
>>
>> The spec says, when C==1, VSGI clears the pending state of the vSGI,
>> leaving the configuration unchanged.  So should we first clear the
>> pending state and then disable vSGI (let E==0)?
> 
> Right you are again. We need two commands, not just one (the pseudocode is
> pretty explicit).

With that change,

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>


Thanks

