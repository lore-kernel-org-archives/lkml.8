Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8372C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 00:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA924206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 00:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbgC3AkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 20:40:08 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727612AbgC3AkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 20:40:08 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5CA7052D1E77E03CE8F7;
        Mon, 30 Mar 2020 08:40:05 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.228) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 08:39:57 +0800
Subject: Re: [PATCH] irq/gic-its: gicv4: set VPENDING table as inner-shareable
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
References: <20191130073849.38378-1-guoheyi@huawei.com>
 <20191201180434.1dba3116@why>
 <3de7a72f-1a15-c908-57e6-35eff00b1ca6@huawei.com>
 <40704a28b562167b58992c036bff4f81@kernel.org>
From:   Heyi Guo <guoheyi@huawei.com>
Message-ID: <517af92f-4e15-6b88-fe2e-e76e2db7234e@huawei.com>
Date:   Mon, 30 Mar 2020 08:39:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <40704a28b562167b58992c036bff4f81@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.221.228]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/3/21 17:54, Marc Zyngier wrote:
> Hi Heyi,
>
> On 2020-02-24 02:22, Heyi Guo wrote:
>> Hi Marc,
>>
>> On 2019/12/2 2:04, Marc Zyngier wrote:
>>> On Sat, 30 Nov 2019 15:38:49 +0800
>>> Heyi Guo <guoheyi@huawei.com> wrote:
>>>
>>>> There is no special reason to set virtual LPI pending table as
>>>> non-shareable. If we choose to hard code the shareability without
>>>> probing, inner-shareable will be a better choice, for all the other
>>>> ITS/GICR tables prefer to be inner-shareable.
>>> One of the issues is that we have strictly no idea what the caches are
>>> Inner Shareable with (I've been asking for such clarification for years
>>> without getting anywhere). You can have as many disconnected inner
>>> shareable domains as you want!
>>>
>>> I suspect that in the grand scheme of things, the redistributors
>>> ought to be in the same inner shareable domain, and that with a bit of
>>> luck, the CPUs are there as well. Still, that's a massive guess.
>>>
>>>> What's more, on Hisilicon hip08 it will trigger some kind of bus
>>>> warning when mixing use of different shareabilities.
>>> Do you have more information about what the bus is complaining about?
>>> Is that because the CPUs have these pages mapped as inner shareable?
>>>
>>> I'll give it a go on D05 (HIP07) to find out what changes there.
>>
>> How's your go on D05? Did you see any issues?
>
> Sorry it took so long. I've given it a go on my D05, and didn't notice
> anything bad (or rather, nothing worse than usual, since GICv4 on this
> machine is pretty... funky).
>
> I've now take this into the 5.7 queue.


Thanks,

Heyi


>
> Thanks,
>
>          M.

