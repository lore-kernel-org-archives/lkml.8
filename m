Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF45C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 595D0214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgBGJOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:14:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10165 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726573AbgBGJOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:14:32 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 78A428ABC3D3EF65C7AD;
        Fri,  7 Feb 2020 17:14:26 +0800 (CST)
Received: from [127.0.0.1] (10.184.217.114) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Fri, 7 Feb 2020
 17:14:15 +0800
Subject: Re: [PATCH] add lock proctect to __handle_sysrq in
 write_sysrq_trigger
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <jslaby@suse.com>, <linux-kernel@vger.kernel.org>,
        <hushiyuan@huawei.com>, <linfeilong@huawei.com>
References: <1581062166-27284-1-git-send-email-shenkai8@huawei.com>
 <20200207081006.GB309560@kroah.com>
From:   shenkai <shenkai8@huawei.com>
Message-ID: <ed0edfc4-2614-9fba-de85-b970bb0adb61@huawei.com>
Date:   Fri, 7 Feb 2020 17:13:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200207081006.GB309560@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.184.217.114]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/2/7 16:10, Greg KH wrote:
> On Fri, Feb 07, 2020 at 07:56:06AM +0000, Shen Kai wrote:
>> From: Feilong Lin <linfeilong@huawei.com>
>>
>> Add lock protect to __handle_sysrq to avoid race condition.
>> __handle_sysrq will change console_loglevel without lock protect
>> which can lead to console_loglevel to be set as an unexpected value.
>>
>> Problem may occur when "echo t > /proc/sysrq-trigger" is called on
>> multiple cpus concurrently.
>>
>> In this case in __handle_sysrq, console_loglevel is set to 7 to print
>> some head info to the console then restore it. But without lock protect
>> in parallel execution situation, restoring may go wrong. The new
>> loglevel may be taken as the previous loglevel incorrectly.
>> Console_loglevel can be 7 at last, which causes the terminal to output
>> info in most log levels.
>>
>> This bug was found on linux 4.19
>>
>> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
>> Reported-by: Kai Shen <shenkai8@huawei.com>
>> ---
>>   drivers/tty/sysrq.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
>> index f724962..cbb48a9 100644
>> --- a/drivers/tty/sysrq.c
>> +++ b/drivers/tty/sysrq.c
>> @@ -1087,6 +1087,8 @@ EXPORT_SYMBOL(unregister_sysrq_key);
>>   /*
>>    * writing 'C' to /proc/sysrq-trigger is like sysrq-C
>>    */
>> +static DEFINE_MUTEX(sysrq_mutex);
>> +
>>   static ssize_t write_sysrq_trigger(struct file *file, const char __user *buf,
>>   				   size_t count, loff_t *ppos)
>>   {
>> @@ -1095,7 +1097,9 @@ static ssize_t write_sysrq_trigger(struct file *file, const char __user *buf,
>>   
>>   		if (get_user(c, buf))
>>   			return -EFAULT;
>> +		mutex_lock(&sysrq_mutex);
>>   		__handle_sysrq(c, false);
>> +		mutex_unlock(&sysrq_mutex);
> 
> What exactly are you protecting here?  What other task is doing this at
> the same exact time?
> 
> You mention different tasks hitting this sysrq-trigger at the same time,
> but really, "just do not do that" should be the real answer, as even
> with this lock, you don't know what the end result will be as the "last"
> one in will have the last word, right?
> 
> thanks,
> 
> greg k-h
> 
> .
> 

Here we want to protect the global variable console_loglevel 
(console_printk[0]).

Problem may occur when run shell programs like:

echo t > /proc/sysrq-trigger &
echo t > /proc/sysrq-trigger &
echo t > /proc/sysrq-trigger &
..

After above operations are done, console_loglevel may be 7 instead of 
the original log level. I doubt this is what we expect though those 
operations may not be meaningful.

In this case, much info may be output to the terminal for stack info of 
all threads is a lot to print which may cause soft lockup on a 
non-preempt kernel.

Best regards
Kai



