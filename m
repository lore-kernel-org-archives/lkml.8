Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0D9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6578A2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 01:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgGUBUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 21:20:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7799 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726016AbgGUBUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 21:20:31 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CDA83C04CAAF79530EFA;
        Tue, 21 Jul 2020 09:20:27 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.16) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Tue, 21 Jul 2020
 09:20:17 +0800
Subject: Re: [PATCH] ipmi/watchdog: add missing newlines when printing
 parameters by sysfs
To:     <minyard@acm.org>
CC:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>
References: <1595210605-27888-1-git-send-email-wangxiongfeng2@huawei.com>
 <20200720195234.GC2952@minyard.net>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <908fcbf2-efbb-b3f4-0666-2da79fbe99c4@huawei.com>
Date:   Tue, 21 Jul 2020 09:20:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200720195234.GC2952@minyard.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.16]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey,

Thanks for your reply !

On 2020/7/21 3:52, Corey Minyard wrote:
> On Mon, Jul 20, 2020 at 10:03:25AM +0800, Xiongfeng Wang wrote:
>> When I cat some ipmi_watchdog parameters by sysfs, it displays as
>> follows. It's better to add a newline for easy reading.
>>
>> root@(none):/# cat /sys/module/ipmi_watchdog/parameters/action
>> resetroot@(none):/# cat /sys/module/ipmi_watchdog/parameters/preaction
>> pre_noneroot@(none):/# cat /sys/module/ipmi_watchdog/parameters/preop
>> preop_noneroot@(none):/#
> 
> Yeah, that's not consistent with other things displayed in the kernel.
> 
>>
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
>> ---
>>  drivers/char/ipmi/ipmi_watchdog.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
>> index 55986e1..3e05a1d 100644
>> --- a/drivers/char/ipmi/ipmi_watchdog.c
>> +++ b/drivers/char/ipmi/ipmi_watchdog.c
>> @@ -232,12 +232,16 @@ static int set_param_str(const char *val, const struct kernel_param *kp)
>>  static int get_param_str(char *buffer, const struct kernel_param *kp)
>>  {
>>  	action_fn fn = (action_fn) kp->arg;
>> -	int       rv;
>> +	int rv, len;
>>  
>>  	rv = fn(NULL, buffer);
>>  	if (rv)
>>  		return rv;
>> -	return strlen(buffer);
>> +
>> +	len = strlen(buffer);
>> +	len += sprintf(buffer + len, "\n");
> 
> sprintf is kind of overkill to stick a \n on the end of a line.  How
> about:
> 
> 	buffer[len++] = '\n';
> 
> Since you are returning the length, you shouldn't need to nil terminate
> the string.

Thanks for your advice. I will change it in the next version.

> 
> An unrelated question: Are you using any of the special functions of the
> IPMI watchdog, like the pretimeout?

I am not using any special functions of the IPMI watchdog. It's just that I cat
the parameters below 'ipmi_watchdog' and find we can add a newline here.

Thanks,
Xiongfeng

> 
> -corey
> 
>> +
>> +	return len;
>>  }
>>  
>>  
>> -- 
>> 1.7.12.4
>>
> 
> .
> 

