Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B6EC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:52:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1811A20675
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:52:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732568AbgDAMwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:52:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48592 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732166AbgDAMwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:52:36 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 59BA9BD97E6FA23F202D;
        Wed,  1 Apr 2020 20:52:32 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 1 Apr 2020
 20:52:22 +0800
Subject: Re: [PATCH] KVM: arm64: vgic-v3: Clear pending bit in guest memory
 after synchronization
To:     Marc Zyngier <maz@kernel.org>
CC:     <kvmarm@lists.cs.columbia.edu>, <eric.auger@redhat.com>,
        <andre.przywara@arm.com>, <james.morse@arm.com>,
        <julien.thierry.kdev@gmail.com>, <suzuki.poulose@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>
References: <20200331031245.1562-1-yuzenghui@huawei.com>
 <20200331090709.17d2087d@why>
 <fe30a834-fdb0-e1ca-5e4a-0c7863236c5f@huawei.com>
 <20200401112757.6716cbf3@why>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <bb59df5a-be43-1132-e78a-3c6b354694d6@huawei.com>
Date:   Wed, 1 Apr 2020 20:52:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200401112757.6716cbf3@why>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/1 18:27, Marc Zyngier wrote:

>>> And I think there is a similar issue in vgic_v3_lpi_sync_pending_status().
>>> Why sync something back from the pending table when the LPI wasn't
>>> mapped yet?
>>
>> vgic_v3_lpi_sync_pending_status() can be called on the ITE restore path:
>> vgic_its_restore_ite/vgic_add_lpi/vgic_v3_lpi_sync_pending_status.
>> We should rely on it to sync the pending bit from guest memory (which
>> was saved on the source side).
> 
> The fact that we have *two* paths to restore pending bits is pretty
> annoying. There is certainly some scope for simplification here.

One thing need to be clarified first (if we're going to do some 
simplification here) is that if we follow the "ITS Restore Sequence"
rule (in Documentation/virt/kvm/devices/arm-vgic-its.rst, which says
that all redistributors are restored *before* ITS table data), then
the pending bits will *only* be restored on the ITE restore path.

When we're restoring the GICR_CTLR, we invoke vgic_enable_lpis()->
its_sync_lpi_pending_table(). But since no LPI has been restored yet,
we will get an empty lpi_list snapshot from vgic_copy_lpi_list().
No pending table synchronization will happen on this path.

I think this is what we have in the current code.


Thanks,
Zenghui

