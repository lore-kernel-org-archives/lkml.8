Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72911C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 444C72083E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgETECi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 00:02:38 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46170 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbgETECi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 00:02:38 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B82F6D02038ABE41E2AF;
        Wed, 20 May 2020 12:02:35 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Wed, 20 May 2020
 12:02:26 +0800
Subject: Re: [PATCH v4 0/4] cleaning up the sysctls table (hung_task watchdog)
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <mcgrof@kernel.org>, <keescook@chromium.org>, <yzaikin@google.com>,
        <adobriyan@gmail.com>, <mingo@kernel.org>,
        <gpiccoli@canonical.com>, <rdna@fb.com>, <patrick.bellasi@arm.com>,
        <sfr@canb.auug.org.au>, <mhocko@suse.com>,
        <penguin-kernel@i-love.sakura.ne.jp>, <vbabka@suse.cz>,
        <tglx@linutronix.de>, <peterz@infradead.org>,
        <Jisheng.Zhang@synaptics.com>, <khlebnikov@yandex-team.ru>,
        <bigeasy@linutronix.de>, <pmladek@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <wangle6@huawei.com>, <alex.huangjianhui@huawei.com>
References: <1589859071-25898-1-git-send-email-nixiaoming@huawei.com>
 <20200519203141.f3152a41dce4bc848c5dded7@linux-foundation.org>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <5574b304-e890-76a9-8190-f705eba8082d@huawei.com>
Date:   Wed, 20 May 2020 12:02:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200519203141.f3152a41dce4bc848c5dded7@linux-foundation.org>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/20 11:31, Andrew Morton wrote:
> On Tue, 19 May 2020 11:31:07 +0800 Xiaoming Ni <nixiaoming@huawei.com> wrote:
> 
>> Kernel/sysctl.c
> 
> eek!
> 
>>
>>   fs/proc/proc_sysctl.c        |   2 +-
>>   include/linux/sched/sysctl.h |  14 +--
>>   include/linux/sysctl.h       |  13 ++-
>>   kernel/hung_task.c           |  77 +++++++++++++++-
>>   kernel/sysctl.c              | 214 +++++++------------------------------------
>>   kernel/watchdog.c            | 101 ++++++++++++++++++++
>>   6 files changed, 224 insertions(+), 197 deletions(-)
> 
> Here's what we presently have happening in linux-next's kernel/sysctl.c:
> 
>   sysctl.c | 3109 ++++++++++++++++++++++++++++++---------------------------------
>   1 file changed, 1521 insertions(+), 1588 deletions(-)
> 
> 
> So this is not a good time for your patch!
> 
> Can I suggest that you set the idea aside and take a look after 5.8-rc1
> is released?
> 

ok, I will make v5 patch based on 5.8-rc1 after 5.8-rc1 is released,
And add more sysctl table cleanup.

Thanks
Xiaoming Ni


