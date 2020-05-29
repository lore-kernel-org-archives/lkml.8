Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FE8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD41206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgE2MJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:09:07 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5393 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbgE2MJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:09:07 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E74388EB0A5E1AEFF5D3;
        Fri, 29 May 2020 20:09:04 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 29 May 2020
 20:09:02 +0800
Subject: Re: [PATCH 11/13] random: simplify sysctl declaration with
 register_sysctl_subdir()
To:     Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     <keescook@chromium.org>, <yzaikin@google.com>,
        <ebiederm@xmission.com>, <axboe@kernel.dk>, <clemens@ladisch.de>,
        <arnd@arndb.de>, <jani.nikula@linux.intel.com>,
        <joonas.lahtinen@linux.intel.com>, <rodrigo.vivi@intel.com>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <benh@kernel.crashing.org>,
        <rdna@fb.com>, <viro@zeniv.linux.org.uk>, <mark@fasheh.com>,
        <jlbec@evilplan.org>, <joseph.qi@linux.alibaba.com>,
        <vbabka@suse.cz>, <sfr@canb.auug.org.au>, <jack@suse.cz>,
        <amir73il@gmail.com>, <rafael@kernel.org>, <tytso@mit.edu>,
        <julia.lawall@lip6.fr>, <akpm@linux-foundation.org>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linuxppc-dev@lists.ozlabs.org>,
        <ocfs2-devel@oss.oracle.com>, <linux-kernel@vger.kernel.org>
References: <20200529074108.16928-1-mcgrof@kernel.org>
 <20200529074108.16928-12-mcgrof@kernel.org>
 <20200529102644.GB1345939@kroah.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <289b2d65-bf28-1246-7f4f-2411e3f27e16@huawei.com>
Date:   Fri, 29 May 2020 20:09:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200529102644.GB1345939@kroah.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/29 18:26, Greg KH wrote:
> On Fri, May 29, 2020 at 07:41:06AM +0000, Luis Chamberlain wrote:
>> From: Xiaoming Ni <nixiaoming@huawei.com>
>>
>> Move random_table sysctl from kernel/sysctl.c to drivers/char/random.c
>> and use register_sysctl_subdir() to help remove the clutter out of
>> kernel/sysctl.c.
>>
>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>> ---
>>   drivers/char/random.c  | 14 ++++++++++++--
>>   include/linux/sysctl.h |  1 -
>>   kernel/sysctl.c        |  5 -----
>>   3 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/char/random.c b/drivers/char/random.c
>> index a7cf6aa65908..73fd4b6e9c18 100644
>> --- a/drivers/char/random.c
>> +++ b/drivers/char/random.c
>> @@ -2101,8 +2101,7 @@ static int proc_do_entropy(struct ctl_table *table, int write,
>>   }
>>   
>>   static int sysctl_poolsize = INPUT_POOL_WORDS * 32;
>> -extern struct ctl_table random_table[];
>> -struct ctl_table random_table[] = {
>> +static struct ctl_table random_table[] = {
>>   	{
>>   		.procname	= "poolsize",
>>   		.data		= &sysctl_poolsize,
>> @@ -2164,6 +2163,17 @@ struct ctl_table random_table[] = {
>>   #endif
>>   	{ }
>>   };
>> +
>> +/*
>> + * rand_initialize() is called before sysctl_init(),
>> + * so we cannot call register_sysctl_init() in rand_initialize()
>> + */
>> +static int __init random_sysctls_init(void)
>> +{
>> +	register_sysctl_subdir("kernel", "random", random_table);
> 
> No error checking?
> 
> :(
It was my mistake, I forgot to add a comment here.
Same as the comment of register_sysctl_init(),
There is almost no failure here during the system initialization phase,
and failure in time does not affect the main function.

Thanks
Xiaoming Ni



