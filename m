Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE10C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 06:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A1C207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 06:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgGUGR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 02:17:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8338 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725294AbgGUGR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 02:17:58 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CD319428CB13F7977094;
        Tue, 21 Jul 2020 14:17:50 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.16) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Tue, 21 Jul 2020
 14:17:40 +0800
Subject: Re: [PATCH] ipmi/watchdog: add missing newlines when printing
 parameters by sysfs
To:     Joe Perches <joe@perches.com>, <minyard@acm.org>
CC:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <openipmi-developer@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>
References: <1595210605-27888-1-git-send-email-wangxiongfeng2@huawei.com>
 <20200720195234.GC2952@minyard.net>
 <908fcbf2-efbb-b3f4-0666-2da79fbe99c4@huawei.com>
 <b38a439b2bdd1122805aa182da9a1802e673f53e.camel@perches.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <70f4a8b9-1410-a32d-dfaa-4cb5d3cade10@huawei.com>
Date:   Tue, 21 Jul 2020 14:17:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b38a439b2bdd1122805aa182da9a1802e673f53e.camel@perches.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.16]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/7/21 10:00, Joe Perches wrote:
> On Tue, 2020-07-21 at 09:20 +0800, Xiongfeng Wang wrote:
>> On 2020/7/21 3:52, Corey Minyard wrote:
>>> On Mon, Jul 20, 2020 at 10:03:25AM +0800, Xiongfeng Wang wrote:
>>>> When I cat some ipmi_watchdog parameters by sysfs, it displays as
>>>> follows. It's better to add a newline for easy reading.
> []
>>>> diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
> []
>>>> @@ -232,12 +232,16 @@ static int set_param_str(const char *val, const struct kernel_param *kp)
>>>>  static int get_param_str(char *buffer, const struct kernel_param *kp)
>>>>  {
>>>>  	action_fn fn = (action_fn) kp->arg;
>>>> -	int       rv;
>>>> +	int rv, len;
>>>>  
>>>>  	rv = fn(NULL, buffer);
>>>>  	if (rv)
>>>>  		return rv;
>>>> -	return strlen(buffer);
>>>> +
>>>> +	len = strlen(buffer);
>>>> +	len += sprintf(buffer + len, "\n");
>>>
>>> sprintf is kind of overkill to stick a \n on the end of a line.  How
>>> about:
>>>
>>> 	buffer[len++] = '\n';
>>>
>>> Since you are returning the length, you shouldn't need to nil terminate
>>> the string.
> 
> You never quite know for sure so I suggest making
> the string null terminated just in case.
> 
> i.e.:
> 
> 	buffer[len++] = '\n';
> 	buffer[len] = 0;
> 

Thanks for your advice. I will change it in the next version.

Thanks,
Xiongfeng

> 
> 
> .
> 

