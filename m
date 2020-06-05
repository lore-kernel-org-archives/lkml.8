Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7A3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A58BD20772
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgFEKnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:43:07 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42684 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726669AbgFEKnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:43:06 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 2F6A4C1D64892B82114F;
        Fri,  5 Jun 2020 18:43:04 +0800 (CST)
Received: from [127.0.0.1] (10.166.212.204) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Fri, 5 Jun 2020
 18:42:58 +0800
Subject: Re: [RFC PATCH] panic: fix deadlock in panic()
To:     Petr Mladek <pmladek@suse.com>
CC:     <linux-kernel@vger.kernel.org>, <chenwandun@huawei.com>,
        <xiexiuqi@huawei.com>, <bobo.shaobowang@huawei.com>,
        <huawei.libin@huawei.com>, <sergey.senozhatsky@gmail.com>,
        <rostedt@goodmis.org>, "chengjian (D)" <cj.chengjian@huawei.com>
References: <20200603141915.38739-1-cj.chengjian@huawei.com>
 <20200604082947.GB22497@linux-b0ei>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <7b6f8522-f9b2-29e8-2dde-3bbfac19335b@huawei.com>
Date:   Fri, 5 Jun 2020 18:42:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200604082947.GB22497@linux-b0ei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.166.212.204]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Petr

On 2020/6/4 16:29, Petr Mladek wrote:

> It might cause double unlock (deadlock) on architectures that did not
> use NMI to stop the CPUs.
>
> I have created a conservative fix for this problem for SLES, see
> https://github.com/openSUSE/kernel-source/blob/SLE15-SP2-UPDATE/patches.suse/printk-panic-Avoid-deadlock-in-printk-after-stopping-CPUs-by-NMI.patch
> It solves the problem only on x86 architecture.
>
> There are many hacks that try to solve various scenarios but it
> is getting too complicated and does not solve all problems.

I have read your conservative fix and I have some question,

1-- does the console_sem need to be reinitialized ?

2-- Other architectures without NMI, is there no such problem ?

> The only real solution is lockless printk(). First piece is a lockless
> ringbuffer. See the last version at
> https://lore.kernel.org/r/20200501094010.17694-1-john.ogness@linutronix.de
>
> We prefer to work on the lockless solution instead of adding more
> complicated workarounds. This is why I even did not try to upstream
> the patch for SLES.
>
> In the meantime, you might also consider removing the offending
> message from the panic notifier if it is not really important.
>
> Best Regards,
> Petr
>
> .

Thank you.

     Cheng Jian


