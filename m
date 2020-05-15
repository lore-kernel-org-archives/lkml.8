Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8FEBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D495B20657
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 18:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgEOSKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 14:10:15 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2216 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbgEOSKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 14:10:14 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 669A4E797090C6838CB5;
        Fri, 15 May 2020 19:10:12 +0100 (IST)
Received: from [127.0.0.1] (10.47.1.24) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Fri, 15 May
 2020 19:10:11 +0100
Subject: Re: [PATCH v4 0/2] irqchip/gic-v3-its: Balance LPI affinity across
 CPUs
To:     Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     chenxiang <chenxiang66@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>, <kernel-team@android.com>
References: <20200515165752.121296-1-maz@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f87f34fa-a512-7f73-2f53-85333257dd8e@huawei.com>
Date:   Fri, 15 May 2020 19:09:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200515165752.121296-1-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.1.24]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2020 17:57, Marc Zyngier wrote:
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

Cheers Marc, I ran these again and the figures look good:
NVMe with nvme.use_threaded_interrupts=1/0
Before: 1000K/1100K IOPS
After: 1100K/1400K IOPS

For some reason v5.7-rc5 looks more stable than rc4 (which I tested 
previously).

Tested-by: John Garry <john.garry@huawei.com>

> * From v3:
>    - Always pre-decrement/post-increment affinity to avoid useless
>      changes of affinity (John)
>    - Don't use the node mask as a superset of the proposed affinity
>      as the ACPI tables can't really describe this (John)
>    - Rebased on v5.7-rc5
> 
> * From v2:
>    - Split accounting from CPU selection
>    - Track managed and unmanaged interrupts separately
> 
> Marc Zyngier (2):
>    irqchip/gic-v3-its: Track LPI distribution on a per CPU basis
>    irqchip/gic-v3-its: Balance initial LPI affinity across CPUs
> 
>   drivers/irqchip/irq-gic-v3-its.c | 170 ++++++++++++++++++++++++++-----
>   1 file changed, 143 insertions(+), 27 deletions(-)
> 

