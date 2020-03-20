Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8B0C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 03:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BE620722
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 03:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgCTDxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 23:53:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12168 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726944AbgCTDxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 23:53:23 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1046441C18B5189ACC3F;
        Fri, 20 Mar 2020 11:53:20 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Fri, 20 Mar 2020
 11:53:12 +0800
Subject: Re: [PATCH v5 20/23] KVM: arm64: GICv4.1: Plumb SGI implementation
 selection in the distributor
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
References: <20200304203330.4967-1-maz@kernel.org>
 <20200304203330.4967-21-maz@kernel.org>
 <72832f51-bbde-8502-3e03-189ac20a0143@huawei.com>
 <4a06fae9c93e10351276d173747d17f4@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <1c9fdfc8-bdb2-88b6-4bdc-2b9254dfa55c@huawei.com>
Date:   Fri, 20 Mar 2020 11:53:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <4a06fae9c93e10351276d173747d17f4@kernel.org>
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

On 2020/3/19 20:10, Marc Zyngier wrote:
>> But I wonder that should we use nassgireq to *only* keep track what
>> the guest had written into the GICD_CTLR.nASSGIreq.  If not, we may
>> lose the guest-request bit after migration among hosts with different
>> has_gicv4_1 settings.
> 
> I'm unsure of what you're suggesting here. If userspace tries to set
> GICD_CTLR.nASSGIreq on a non-4.1 host, this bit will not latch.

This is exactly what I *was* concerning about.

> Userspace can check that at restore time. Or we could fail the
> userspace write, which is a bit odd (the bit is otherwise RES0).
> 
> Could you clarify your proposal?

Let's assume two hosts below. 'has_gicv4_1' is true on host-A while
it is false on host-B because of lack of HW support or the kernel
parameter "kvm-arm.vgic_v4_enable=0".

If we migrate guest through A->B->A, we may end-up lose the initial
guest-request "nASSGIreq=1" and don't use direct vSGI delivery for
this guest when it's migrated back to host-A.

This can be "fixed" by keep track of what guest had written into
nASSGIreq. And we need to evaluate the need for using direct vSGI
for a specified guest by 'has_gicv4_1 && nassgireq'.

But if it's expected that "if userspace tries to set nASSGIreq on
a non-4.1 host, this bit will not latch", then this shouldn't be
a problem at all.

Anyway this is not a big deal to me and I won't complain about it
in the future ;-) Either way, for this patch:

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>


Thanks

