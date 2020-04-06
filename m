Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C09C2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77847206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgDFIAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 04:00:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726475AbgDFIAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:00:52 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 79FAB66759F3822586F4;
        Mon,  6 Apr 2020 16:00:44 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.205) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Mon, 6 Apr 2020
 16:00:35 +0800
Subject: Re: [PATCH] sched/arm64: store cpu topology before
 notify_cpu_starting
To:     Valentin Schneider <valentin.schneider@arm.com>
CC:     <vpillai@digitalocean.com>, <aaron.lwe@gmail.com>,
        <aubrey.intel@gmail.com>, <aubrey.li@linux.intel.com>,
        <fweisbec@gmail.com>, <jdesfossez@digitalocean.com>,
        <joel@joelfernandes.org>, <joelaf@google.com>,
        <keescook@chromium.org>, <kerrnel@google.com>,
        <linux-kernel@vger.kernel.org>, <mgorman@techsingularity.net>,
        <mingo@kernel.org>, <naravamudan@digitalocean.com>,
        <pauld@redhat.com>, <pawan.kumar.gupta@linux.intel.com>,
        <pbonzini@redhat.com>, <peterz@infradead.org>, <pjt@google.com>,
        <tglx@linutronix.de>, <tim.c.chen@linux.intel.com>,
        <torvalds@linux-foundation.org>, <xiexiuqi@huawei.com>,
        <huawei.libin@huawei.com>, <w.f@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "chengjian (D)" <cj.chengjian@huawei.com>
References: <855831b59e1b3774b11c3e33050eac4cc4639f06.1583332765.git.vpillai@digitalocean.com>
 <20200401114215.36640-1-cj.chengjian@huawei.com> <jhjwo6zjq5m.mognet@arm.com>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <9686e37d-5698-334d-5e23-70a1e2d804ec@huawei.com>
Date:   Mon, 6 Apr 2020 16:00:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <jhjwo6zjq5m.mognet@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.133.217.205]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/4/1 21:23, Valentin Schneider wrote:
> (+LAKML, +Sudeep)
>
> On Wed, Apr 01 2020, Cheng Jian wrote:
>> when SCHED_CORE enabled, sched_cpu_starting() uses thread_sibling as
>> SMT_MASK to initialize rq->core, but only after store_cpu_topology(),
>> the thread_sibling is ready for use.
>>
>>        notify_cpu_starting()
>>            -> sched_cpu_starting()	# use thread_sibling
>>
>>        store_cpu_topology(cpu)
>>            -> update_siblings_masks	# set thread_sibling
>>
>> Fix this by doing notify_cpu_starting later, just like x86 do.
>>
> I haven't been following the sched core stuff closely; can't this
> rq->core assignment be done in sched_cpu_activate() instead? We already
> look at the cpu_smt_mask() in there, and it is valid (we go through the
> entirety of secondary_start_kernel() before getting anywhere near
> CPUHP_AP_ACTIVE).
>
> I don't think this breaks anything, but without this dependency in
> sched_cpu_starting() then there isn't really a reason for this move.

Yes, it is correct to put the rq-> core assignment in sched_cpu_active().

The cpu_smt_mask is already valid here.


I have made such an attempt on my own branch and passed the test.


Thank you.


     -- Cheng Jian


