Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACD6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E8C2067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHQMD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:03:29 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3064 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbgHQMDZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:03:25 -0400
Received: from dggeme755-chm.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id ADE95C4E4428103920DA;
        Mon, 17 Aug 2020 20:03:21 +0800 (CST)
Received: from [10.174.186.8] (10.174.186.8) by dggeme755-chm.china.huawei.com
 (10.3.19.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1913.5; Mon, 17
 Aug 2020 20:03:21 +0800
Subject: Re: [RFC][PATCH 0/4] arm64:kvm: teach guest sched that VCPUs can be
 preempted
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "will@kernel.org" <will@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>
References: <20200721041742.197354-1-sergey.senozhatsky@gmail.com>
 <20200817020310.GA1210848@jagdpanzerIV.localdomain>
CC:     <joelaf@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <suleiman@google.com>,
        "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Wanghaibin (D)" <wanghaibin.wang@huawei.com>,
        <yezengruan@huawei.com>
From:   yezengruan <yezengruan@huawei.com>
Message-ID: <fe72592c-c721-bece-1469-95eebf931299@huawei.com>
Date:   Mon, 17 Aug 2020 20:03:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200817020310.GA1210848@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.186.8]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggeme755-chm.china.huawei.com (10.3.19.101)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/17 10:03, Sergey Senozhatsky wrote:
> On (20/07/21 13:17), Sergey Senozhatsky wrote:
>> Hello,
>>
>> 	RFC
>>
>> 	We noticed that in a number of cases when we wake_up_process()
>> on arm64 guest we end up enqueuing that task on a preempted VCPU. The culprit
>> appears to be the fact that arm64 guests are not aware of VCPU preemption
>> as such, so when sched picks up an idle VCPU it always assumes that VCPU
>> is available:
>>
>>       wake_up_process()
>>        try_to_wake_up()
>>         select_task_rq_fair()
>>          available_idle_cpu()
>>           vcpu_is_preempted()    // return false;
>>
>> Which is, obviously, not the case.
>>
>> This RFC patch set adds a simple vcpu_is_preempted() implementation so
>> that scheduler can make better decisions when it search for the idle
>> (v)CPU.
> Hi,
>
> A gentle ping.
>
> 	-ss
> _______________________________________________
> kvmarm mailing list
> kvmarm@lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> .

Hi Sergey,

I have a set of patches similar to yours.

https://lore.kernel.org/lkml/20191226135833.1052-1-yezengruan@huawei.com/

