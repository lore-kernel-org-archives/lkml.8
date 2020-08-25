Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B697CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6D720706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgHYJj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:39:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50830 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729580AbgHYJjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:39:54 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5BBD735964E97555A088;
        Tue, 25 Aug 2020 17:39:51 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.157) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 25 Aug 2020
 17:39:44 +0800
Subject: Re: [PATCH] genirq/proc: Show percpu irq affinity
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>,
        Marc Zyngier <maz@kernel.org>
References: <87mu2moqvl.fsf@nanos.tec.linutronix.de>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <9f8b9f2f-b5f9-35c8-ff5e-22b5d0f347bb@huawei.com>
Date:   Tue, 25 Aug 2020 17:39:44 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87mu2moqvl.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.157]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/8/22 19:35, Thomas Gleixner wrote:
> On Sat, Aug 22 2020 at 17:33, Yunfeng Ye wrote:
>> On 2020/8/13 16:27, Thomas Gleixner wrote:
>> For example, the cmdline "irqaffinity=0,1,126,127" on the 128 cores system：
>>
>> [root@localhost ~]# cat /proc/irq/4/smp_affinity_list
>> 0-1,126-127
>>
>> The irq 4 is "arch_timer" interrupt, which is a percpu interrupt.
>>
>> So is it necessary to show the percpu irq affinity correct?
> 
> Yes, it makes sense to do so, but you used the wrong check. The correct
> one is:
> 
> irq_settings_is_per_cpu_devid()
> 
> which will not wreckage the output for other per cpu marked interrupts
> which never set the percpu_affinity pointer with the obvious
> consequences... The pointer would need a NULL check in any case, but it
> might be more straight forward to update affinity when percpu_affinity
> is initialized. Haven't looked in detail though.
> 
ok, I will send the patch v2, thanks.

> Thanks,
> 
>         tglx
> 
> .
> 

