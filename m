Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A69EC2D0ED
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E7E82071B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727636AbgC0Rr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:47:26 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2611 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726275AbgC0Rr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:47:26 -0400
Received: from LHREML711-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 804B7F671D65EA02507B;
        Fri, 27 Mar 2020 17:47:24 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML711-CAH.china.huawei.com (10.201.108.34) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 27 Mar 2020 17:47:24 +0000
Received: from [127.0.0.1] (10.47.10.23) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Fri, 27 Mar
 2020 17:47:23 +0000
Subject: Re: [PATCH v3 0/2] irqchip/gic-v3-its: Balance LPI affinity across
 CPUs
From:   John Garry <john.garry@huawei.com>
To:     Marc Zyngier <maz@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Jason Cooper <jason@lakedaemon.net>,
        chenxiang <chenxiang66@hisilicon.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "luojiaxing@huawei.com" <luojiaxing@huawei.com>,
        Ming Lei <ming.lei@redhat.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>
References: <20200316115433.9017-1-maz@kernel.org>
 <9171c554-50d2-142b-96ae-1357952fce52@huawei.com>
Message-ID: <80b673a7-1097-c5fa-82c0-1056baa5309d@huawei.com>
Date:   Fri, 27 Mar 2020 17:47:08 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <9171c554-50d2-142b-96ae-1357952fce52@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.10.23]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Before: ~1.2M IOPs fio read
> After: ~1.2M IOPs fio read
> 
> So they were about the same. I would have hoped for an improvement here, 
> considering before we would have all the per-queue threaded handlers 
> running on the single CPU handling the hard irq.
> 
> But we will retest all this tomorrow, so please consider these 
> provisional for now.
> 
> Thanks to Luo Jiaxing for testing.

Hi Marc,

Just to let you know that we're still looking at this. It turns out that 
we're not getting the results as hoped, and the previous results were 
incorrect due to a test booboo ..

I also think that the SMMU may even be creating a performance ceiling. I 
need to check this more, as I can't seem to get the throughput above a 
certain level.

I realise that we're so late in the cycle that there is now no immediate 
rush.

But I would also like to report some other unexpected behaviour for 
managed interrupts in this series - I'll reply directly to the specific 
patch for that.

Much appreciated,
John


