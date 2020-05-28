Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73C5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F8692078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgE1BKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:10:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37124 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbgE1BKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:10:17 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E2ED01509E92DF93ECA2;
        Thu, 28 May 2020 09:10:13 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.154) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 28 May 2020
 09:10:10 +0800
Subject: Re: [PATCH -next] hwmon: (amd_energy) Fix build error
To:     Guenter Roeck <linux@roeck-us.net>, <nchatrad@amd.com>,
        <jdelvare@suse.com>
References: <20200527130241.58468-1-yuehaibing@huawei.com>
 <bfcd6504-c717-8e60-a1ad-d173f3bea02f@roeck-us.net>
CC:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <a0d97556-feb2-ee02-2554-678c4cac2801@huawei.com>
Date:   Thu, 28 May 2020 09:10:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <bfcd6504-c717-8e60-a1ad-d173f3bea02f@roeck-us.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/27 21:22, Guenter Roeck wrote:
> On 5/27/20 6:02 AM, YueHaibing wrote:
>> If CONFIG_NEED_MULTIPLE_NODES is n, building fails:
>>
>> drivers/hwmon/amd_energy.c: In function ‘amd_energy_read’:
>> ./include/asm-generic/topology.h:51:36: error: void value not ignored as it ought to be
>>      #define cpumask_of_node(node) ((void)node, cpu_online_mask)
>> ./include/linux/cpumask.h:618:72: note: in definition of macro ‘cpumask_first_and’
>>  #define cpumask_first_and(src1p, src2p) cpumask_next_and(-1, (src1p), (src2p))
>>                                                                         ^~~~~
>> drivers/hwmon/amd_energy.c:194:6: note: in expansion of macro ‘cpumask_of_node’
>>       cpumask_of_node
>>       ^~~~~~~~~~~~~~~
>> ./include/asm-generic/topology.h:51:46: warning: left-hand operand of comma expression has no effect [-Wunused-value]
>>      #define cpumask_of_node(node) ((void)node, cpu_online_mask)
>>                                               ^
>> ./include/linux/cpumask.h:618:72: note: in definition of macro ‘cpumask_first_and’
>>  #define cpumask_first_and(src1p, src2p) cpumask_next_and(-1, (src1p), (src2p))
>>                                                                         ^~~~~
>> drivers/hwmon/amd_energy.c:194:6: note: in expansion of macro ‘cpumask_of_node’
>>       cpumask_of_node
>>       ^~~~~~~~~~~~~~~
>>
>> Fixes: 8abee9566b7e ("hwmon: Add amd_energy driver to report energy counters")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/hwmon/amd_energy.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwmon/amd_energy.c b/drivers/hwmon/amd_energy.c
>> index bc8b643a37d5..9d5cd3057866 100644
>> --- a/drivers/hwmon/amd_energy.c
>> +++ b/drivers/hwmon/amd_energy.c
>> @@ -192,7 +192,7 @@ static int amd_energy_read(struct device *dev,
>>  	if (channel >= data->nr_cpus) {
>>  		cpu = cpumask_first_and(cpu_online_mask,
>>  					cpumask_of_node
>> -					(channel - data->nr_cpus));
>> +					((channel - data->nr_cpus)));
> 
> Wrong fix. The correct fix is to fix the macro, not its caller.
> A patch to fix the macro has been submitted.
> 
Thanks, missing that.

> Guenter
> 
> 
>>  		amd_add_delta(data, channel, cpu, val, false);
>>  	} else {
>>  		cpu = channel;
>>
> 
> 
> 

