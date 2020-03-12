Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE60C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A86206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 16:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgCLQ2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 12:28:01 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2556 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726677AbgCLQ2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 12:28:00 -0400
Received: from lhreml709-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id F0506ED24CB68D91FBC5;
        Thu, 12 Mar 2020 16:27:58 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml709-cah.china.huawei.com (10.201.108.32) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 12 Mar 2020 16:27:58 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 12 Mar
 2020 16:27:58 +0000
Subject: Re: [PATCH v2] irqchip/gic-v3-its: Balance initial LPI affinity
 across CPUs
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ming Lei <ming.lei@redhat.com>,
        chenxiang <chenxiang66@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
References: <20200312115552.29185-1-maz@kernel.org>
 <d23436b5-a207-91e9-be11-f5d0e44b6e12@huawei.com>
 <33bc00d1ba25d5fd53de2413c831d723@kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ae9e3708-fdba-319f-c968-1c0ae960e0ad@huawei.com>
Date:   Thu, 12 Mar 2020 16:27:57 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <33bc00d1ba25d5fd53de2413c831d723@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml722-chm.china.huawei.com (10.201.108.73) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

>>> When mapping a LPI, the ITS driver picks the first possible
>>> affinity, which is in most cases CPU0, assuming that if
>>> that's not suitable, someone will come and set the affinity
>>> to something more interesting.
>>>
>>> It apparently isn't the case, and people complain of poor
>>> performance when many interrupts are glued to the same CPU.
>>> So let's place the interrupts by finding the "least loaded"
>>> CPU (that is, the one that has the fewer LPIs mapped to it).
>>> So called 'managed' interrupts are an interesting case where
>>> the affinity is actually dictated by the kernel itself, and
>>> we should honor this.
>>>
>>> Reported-by: John Garry <john.garry@huawei.com>
>>> Link: 
>>> https://lore.kernel.org/r/1575642904-58295-1-git-send-email-john.garry@huawei.com 
>>>
>>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>>> Cc: John Garry <john.garry@huawei.com>
>>> Cc: Ming Lei <ming.lei@redhat.com>
>>> ---
>>> Reviving this at John's request.
>>
>> Thanks very much. I may request a colleague test this due to possible
>> precautionary office closure.
> 
> Huh. Not great... :-(
> 
>>
>>  The major change is that the
>>> affinity follows the x86 model, as described by Thomas.
>>
>> There seems to be a subtle difference between this implementation and
>> what Thomas described for managed interrupts handling on x86. That
>> being, managed interrupt loading is counted separately to total
>> interrupts per CPU for x86. That seems quite important so that we
>> spread managed interrupts evenly.
> 
> Hmmm. Yes. That'd require a separate per-CPU counter. Nothing too invasive
> though. I'll roll that in soon. I still wonder about interaction of 
> collocated
> managed and non-managed interrupts, but we can cross that bridge later.

Great. And I think I may have mentioned this before (or I did and it was 
not a good idea), it now seems that we may be able to just leverage the 
generic matrix irq code here.

Cheers,
John
