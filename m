Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5AFC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF0E20738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCQSnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:43:15 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2572 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726294AbgCQSnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 14:43:15 -0400
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 5FC839EFDF2C5FC1B4AC;
        Tue, 17 Mar 2020 18:43:13 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 17 Mar 2020 18:43:12 +0000
Received: from [127.0.0.1] (10.47.11.44) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 17 Mar
 2020 18:43:11 +0000
Subject: Re: [PATCH v3 2/2] irqchip/gic-v3-its: Balance initial LPI affinity
 across CPUs
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        chenxiang <chenxiang66@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Cooper <jason@lakedaemon.net>,
        "Thomas Gleixner" <tglx@linutronix.de>, <luojiaxing@huawei.com>
References: <20200316115433.9017-1-maz@kernel.org>
 <20200316115433.9017-3-maz@kernel.org>
 <2c367508-f81b-342e-eb05-8bbd1b056279@huawei.com>
 <9ce0b23455a06d92161c5302ac28152e@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8b141d09-ac11-34ec-0922-c21c22f94f36@huawei.com>
Date:   Tue, 17 Mar 2020 18:43:01 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <9ce0b23455a06d92161c5302ac28152e@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.11.44]
X-ClientProxiedBy: lhreml721-chm.china.huawei.com (10.201.108.72) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>>> +        int this_count = its_read_lpi_count(d, tmp);
>>
>> Not sure if it's intentional, but now there seems to be a subtle
>> difference to what Thomas described for non-managed interrupts - for
>> non-managed interrupts, x86 selects the CPU based on the total
>> interrupt load per CPU (or, more specifically, lowest vector
>> allocation count), and not just the non-managed load. Or maybe I
>> misread it.
> 
> So far, I'm trying to keep the two allocation paths separate, as the
> two systems I have access to have very different behaviours: D05 has
> no managed interrupts to speak of, and my top-secret work machine
> has almost no unmanaged interrupts, so the two sets are almost
> completely disjoint.

Sure, but I'd say that it would be a more common scenario to have a 
mixture of both.

> 
> Also, it all depends on the interrupt allocation order, and whether
> something will rebalance the non-managed interrupts at a later time.
> At least, these two patches make it easy to alter the placement policy
> (the behaviour you describe above is a 2 line change).
> 
>> Anyway, we can test this now for NVMe with its managed interrupts.
> 
> Looking forward to hearing from you!
>

On my D06CS board (128 core), there seems to be something wrong, as the 
q0 affinity mask looks incorrect:

PCI name is 81:00.0: nvme0n1 
 

         irq 322, cpu list 69, effective list 69 
 

         irq 325, cpu list 32-38, effective list 32 
 

         irq 326, cpu list 39-45, effective list 40 
 

         irq 327, cpu list 46-51, effective list 47 
 

         irq 328, cpu list 52-57, effective list 53 
 

         irq 329, cpu list 58-63, effective list 59


And something stranger for my colleague Luo Jiaxing, specifically the 
effective affinity:

PCI name is 85:00.0: nvme2n1
irq 196, cpu list 0-31, effective list 82
irq 377, cpu list 32-38, effective list 32
irq 378, cpu list 39-45, effective list 39
irq 379, cpu list 46-51, effective list 46

But then v5.6-rc5 vanilla also looks to have this issue when I tested on 
my board:

john@ubuntu:~$ more /proc/irq/322/smp_affinity_list 
 

69

My D06ES (96 core) board looks sensible for the affinity in this regard 
(I did not try vanilla v5.6-rc5, but only with your patches on top). 
I'll need to debug this.

Cheers,
John




