Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679C3C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 437912084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgANJO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:14:56 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:48856 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725820AbgANJOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:14:55 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D6098F2C6512CB7BFD62;
        Tue, 14 Jan 2020 17:14:53 +0800 (CST)
Received: from [127.0.0.1] (10.133.217.236) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Tue, 14 Jan 2020
 17:14:47 +0800
Subject: Re: [PATCH] x86/ftrace: usr ftrace_write to simplify code
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <bobo.shaobowang@huawei.com>, <mingo@redhat.com>,
        <tglx@linutronix.de>
References: <20200113073347.22748-1-cj.chengjian@huawei.com>
 <8ab66ffb-614b-063d-7362-2f01906aec51@huawei.com>
 <20200113223406.5a8aeb29@rorschach.local.home>
From:   "chengjian (D)" <cj.chengjian@huawei.com>
Message-ID: <8b1f0027-4ce1-12dd-6b6e-b58c2902f097@huawei.com>
Date:   Tue, 14 Jan 2020 17:14:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200113223406.5a8aeb29@rorschach.local.home>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.133.217.236]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/1/14 11:34, Steven Rostedt wrote:
> On Tue, 14 Jan 2020 09:37:41 +0800
> "chengjian (D)" <cj.chengjian@huawei.com> wrote:
>
>> I am sorry.
>>
>> usr => use in subject.
>>
>> I will resend this patch.
>>
> I already pulled the original patch into my queue, but I did fix the
> typo (and also capitalized the first word to "Use").
>
> It's currently running through my tests.
>
> -- Steve
>
> .


Thank you very much, Steven.


But peter has optimized the logic here, and those patches have been

applied to the tip branch, so my patch may not be needed.


https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=768ae4406a5cab7e8702550f2446dbeb377b798d

https://lkml.org/lkml/2020/1/14/123



-- Cheng Jian


