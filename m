Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F52EC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24A972073E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgD2Ly3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 07:54:29 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:48045 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726519AbgD2Ly1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:54:27 -0400
X-IronPort-AV: E=Sophos;i="5.73,331,1583164800"; 
   d="scan'208";a="90776572"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Apr 2020 19:54:25 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 822844BCC88B;
        Wed, 29 Apr 2020 19:54:18 +0800 (CST)
Received: from [10.167.220.69] (10.167.220.69) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Wed, 29 Apr 2020 19:54:18 +0800
Message-ID: <5EA96AE8.6000707@cn.fujitsu.com>
Date:   Wed, 29 Apr 2020 19:54:16 +0800
From:   Xiao Yang <yangx.jy@cn.fujitsu.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.2; zh-CN; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] kernel/trace: Stop and wait for kthread on preempt irq
 module unload
References: <20200424223630.224895-1-joel@joelfernandes.org>    <5EA80319.7080005@cn.fujitsu.com>       <20200428104409.0995ceb0@gandalf.local.home> <20200428104543.3926eaaf@gandalf.local.home>
In-Reply-To: <20200428104543.3926eaaf@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.220.69]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 822844BCC88B.AAFA2
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: yangx.jy@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/28 22:45, Steven Rostedt wrote:
> diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c
>>  index 1c28ca20e30b..6d9131ae7e8c 100644
>>  --- a/kernel/trace/preemptirq_delay_test.c
>>  +++ b/kernel/trace/preemptirq_delay_test.c
>>  @@ -113,15 +113,27 @@ static int preemptirq_delay_run(void *data)
>>
>>    	for (i = 0; i<  s; i++)
>>    		(testfuncs[i])(i);
>>  +
>>  +	while (!kthread_should_stop()) {
>>  +		schedule();
>>  +		set_current_state(TASK_INTERRUPTIBLE);
>>  +	}
>>  +
>>  +	__set_current_state(TASK_RUNNING);
>>  +
>>    	return 0;
>>    }
>>
Hi Steven,

Thanks for your patch.

I also used the following steps to do test and didn't get any 
warning/panic after applying your patch.
---------------------------------
for i in $(seq 1 100); do modprobe preemptirq_delay_test test_mode=irq 
delay=500000; rmmod preemptirq_delay_test; done
for i in $(seq 1 100); do modprobe preemptirq_delay_test 
test_mode=preempt delay=500000; rmmod preemptirq_delay_test; done
---------------------------------

But I am not sure which fix(from you and Joel) is better.

Thanks,
Xiao Yang



