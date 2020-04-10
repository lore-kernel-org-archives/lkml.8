Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB743C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 13:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DB7520CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 13:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDJNti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 09:49:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49360 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726092AbgDJNth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 09:49:37 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 596B9A9B2A27F0B6AE9F;
        Fri, 10 Apr 2020 21:49:32 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.205) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Fri, 10 Apr 2020
 21:49:21 +0800
Subject: Re: [PATCH] sched/arm64: store cpu topology before
 notify_cpu_starting
To:     Joel Fernandes <joelaf@google.com>
CC:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        <aaron.lwe@gmail.com>, <aubrey.intel@gmail.com>,
        <aubrey.li@linux.intel.com>,
        "Cc: Frederic Weisbecker" <fweisbec@gmail.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <mgorman@techsingularity.net>, Ingo Molnar <mingo@kernel.org>,
        <naravamudan@digitalocean.com>, <pauld@redhat.com>,
        <pawan.kumar.gupta@linux.intel.com>, <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Turner <pjt@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>, <w.f@huawei.com>,
        "chengjian (D)" <cj.chengjian@huawei.com>,
        "wxf.wang@hisilicon.com >> Xuefeng Wang" <wxf.wang@hisilicon.com>
References: <855831b59e1b3774b11c3e33050eac4cc4639f06.1583332765.git.vpillai@digitalocean.com>
 <20200401114215.36640-1-cj.chengjian@huawei.com>
 <CAJWu+ooyRsFFA13=rqMBCFgf_JeHsOr16-ayuECaQ5Xz48mrqQ@mail.gmail.com>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <5cf3996f-0a35-1d98-ec11-9247e95e01e6@huawei.com>
Date:   Fri, 10 Apr 2020 21:49:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJWu+ooyRsFFA13=rqMBCFgf_JeHsOr16-ayuECaQ5Xz48mrqQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.133.217.205]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/4/10 1:54, Joel Fernandes wrote:
> On Wed, Apr 1, 2020 at 7:27 AM Cheng Jian <cj.chengjian@huawei.com> wrote:
>> when SCHED_CORE enabled, sched_cpu_starting() uses thread_sibling as
>> SMT_MASK to initialize rq->core, but only after store_cpu_topology(),
>> the thread_sibling is ready for use.
>>
>>          notify_cpu_starting()
>>              -> sched_cpu_starting()     # use thread_sibling
>>
>>          store_cpu_topology(cpu)
>>              -> update_siblings_masks    # set thread_sibling
>>
>> Fix this by doing notify_cpu_starting later, just like x86 do.
>>
>> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
> Just a high-level question, why does core-scheduling matter on ARM64?
> Is it for HPC workloads?
>
> Thanks,
>
>   - Joel

Hi, Joel

I am analyzing the mainline scheduling patches and find this problem.


ARM has some platforms that support SMT, and provides some emulate

can be used.



Thanks.

--Cheng Jian


