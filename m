Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB6BC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BEA420732
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 12:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgCSMcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 08:32:07 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2580 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726589AbgCSMcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 08:32:07 -0400
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 5CE5D1F424F939804A0C;
        Thu, 19 Mar 2020 12:32:05 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 19 Mar 2020 12:32:04 +0000
Received: from [127.0.0.1] (10.210.167.248) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Thu, 19 Mar
 2020 12:32:04 +0000
Subject: Re: [PATCH v3 0/2] irqchip/gic-v3-its: Balance LPI affinity across
 CPUs
To:     Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     chenxiang <chenxiang66@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        "luojiaxing@huawei.com" <luojiaxing@huawei.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
References: <20200316115433.9017-1-maz@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <9171c554-50d2-142b-96ae-1357952fce52@huawei.com>
Date:   Thu, 19 Mar 2020 12:31:49 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200316115433.9017-1-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.167.248]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2020 11:54, Marc Zyngier wrote:
> When mapping a LPI, the ITS driver picks the first possible
> affinity, which is in most cases CPU0, assuming that if
> that's not suitable, someone will come and set the affinity
> to something more interesting.
> 
> It apparently isn't the case, and people complain of poor
> performance when many interrupts are glued to the same CPU.
> So let's place the interrupts by finding the "least loaded"
> CPU (that is, the one that has the fewer LPIs mapped to it).
> So called 'managed' interrupts are an interesting case where
> the affinity is actually dictated by the kernel itself, and
> we should honor this.
> 
> * From v2:
>    - Split accounting from CPU selection
>    - Track managed and unmanaged interrupts separately
> 
> Marc Zyngier (2):
>    irqchip/gic-v3-its: Track LPI distribution on a per CPU basis
>    irqchip/gic-v3-its: Balance initial LPI affinity across CPUs
> 
>   drivers/irqchip/irq-gic-v3-its.c | 153 +++++++++++++++++++++++++------
>   1 file changed, 127 insertions(+), 26 deletions(-)
> 

Hi Marc,

Initial results look good. We have 3x NVMe drives now, as opposed to 2x 
previously, which is better for this test.

Before: ~1.3M IOPs fio read
After: ~1.8M IOPs fio read

So a ~50% gain in throughput.

We also did try NVMe with nvme.use_threaded_interrupts=1. As you may 
remember, the NVMe interrupt handling can cause lockups, as they handle 
all completions in interrupt context by default.

Before: ~1.2M IOPs fio read
After: ~1.2M IOPs fio read

So they were about the same. I would have hoped for an improvement here, 
considering before we would have all the per-queue threaded handlers 
running on the single CPU handling the hard irq.

But we will retest all this tomorrow, so please consider these 
provisional for now.

Thanks to Luo Jiaxing for testing.

Cheers,
john
