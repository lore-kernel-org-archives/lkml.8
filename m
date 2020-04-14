Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1AFC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57BEF2064A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:58:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438053AbgDNJ6S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:58:18 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:3089 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438040AbgDNJ6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:58:14 -0400
Received: from wangqing-virtual-machine.localdomain (unknown [157.0.31.122])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id ED667262F71;
        Tue, 14 Apr 2020 17:47:25 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: Re: [PATCH 1/2] [V2 1/2]sched:add task_running_oncpu
Date:   Tue, 14 Apr 2020 17:47:12 +0800
Message-Id: <1586857633-2747-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586779466-4439-2-git-send-email-wangqing@vivo.com>
References: <1586779466-4439-2-git-send-email-wangqing@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSlVDS01LS0tKSkhPQ0xJT1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mz46SCo4ITgwAgoVDzgaAjc2
        HEsKCgxVSlVKTkNNQ05MTU9NSkxNVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZSk5M
        VUtVSEpVSklJWVdZCAFZQUhLSUk3Bg++
X-HM-Tid: 0a71781618279375kuwsed667262f71
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Mon, 13 Apr 2020 at 14:04, Wang Qing <wangqing@vivo.com> wrote:
>>
>> We have no interface whether the task is running,
>> so we need to add an interface and distinguish CONFIG_SMP.
>>
>> Signed-off-by: Wang Qing <wangqing@vivo.com>
>> ---
>>  include/linux/sched.h | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 4418f5c..13cc8f5 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1843,6 +1843,11 @@ static inline unsigned int task_cpu(const struct task_struct *p)
>>
>>  extern void set_task_cpu(struct task_struct *p, unsigned int cpu);
>>
>> +static inline int task_running_oncpu(const struct task_struct *p)
>
>This function name is too close from task_running_on_cpu() and can be
>misleading as the difference is only "_"
>Also, how task_running_oncpu() is different from task_running() ?

I think task_running() should be renamed to task_running_on_rq(), this is what
it originally mean. And the task_running_oncpu I added should be called 
task_running(). This solves the confusing naming problem that already exists.

Thanks,
Wang Qing.

>
>> +{
>> +       return p->on_cpu;
>> +}
>> +
>>  #else
>>
>>  static inline unsigned int task_cpu(const struct task_struct *p)
>> @@ -1854,6 +1859,11 @@ static inline void set_task_cpu(struct task_struct *p, unsigned int cpu)
>>  {
>>  }
>>
>> +static inline int task_running_oncpu(const struct task_struct *p)
>> +{
>> +       return p == current;
>> +}
>> +
>>  #endif /* CONFIG_SMP */
>>
>>  /*
>> --
>> 2.7.4
>>
