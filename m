Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FD9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AEAB20776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgE2L7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:59:16 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45124 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726282AbgE2L7Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:59:16 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 9A782686155B6A948EA5;
        Fri, 29 May 2020 19:59:12 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 29 May 2020
 19:59:08 +0800
Subject: Re: [PATCH 09/13] firmware_loader: simplify sysctl declaration with
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
 <20200529074108.16928-10-mcgrof@kernel.org>
 <20200529102613.GA1345939@kroah.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <066dcdb1-c1db-e154-8697-f3a8907a538c@huawei.com>
Date:   Fri, 29 May 2020 19:59:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200529102613.GA1345939@kroah.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/29 18:26, Greg KH wrote:
> On Fri, May 29, 2020 at 07:41:04AM +0000, Luis Chamberlain wrote:
>> From: Xiaoming Ni <nixiaoming@huawei.com>
>>
>> Move the firmware config sysctl table to fallback_table.c and use the
>> new register_sysctl_subdir() helper. This removes the clutter from
>> kernel/sysctl.c.
>>
>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>> ---
>>   drivers/base/firmware_loader/fallback.c       |  4 ++++
>>   drivers/base/firmware_loader/fallback.h       | 11 ++++++++++
>>   drivers/base/firmware_loader/fallback_table.c | 22 +++++++++++++++++--
>>   include/linux/sysctl.h                        |  1 -
>>   kernel/sysctl.c                               |  7 ------
>>   5 files changed, 35 insertions(+), 10 deletions(-)
> 
> So it now takes more lines than the old stuff?  :(
> 
CONFIG_FW_LOADER = m
Before cleaning, no matter whether ko is loaded or not, the sysctl
interface will be created, but now we need to add register and
unregister interfaces, so the number of lines of code has increased

>>
>> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
>> index d9ac7296205e..8190653ae9a3 100644
>> --- a/drivers/base/firmware_loader/fallback.c
>> +++ b/drivers/base/firmware_loader/fallback.c
>> @@ -200,12 +200,16 @@ static struct class firmware_class = {
>>   
>>   int register_sysfs_loader(void)
>>   {
>> +	int ret = register_firmware_config_sysctl();
>> +	if (ret != 0)
>> +		return ret;
> 
> checkpatch :(
This is my fault,  thanks for your guidance

> 
>>   	return class_register(&firmware_class);
> 
> And if that fails?
> 
Yes, it is better to call register_firmware_config_sysctl() after 
class_register().
thanks for your guidance.


>>   }
>>   
>>   void unregister_sysfs_loader(void)
>>   {
>>   	class_unregister(&firmware_class);
>> +	unregister_firmware_config_sysctl();
>>   }
>>   
>>   static ssize_t firmware_loading_show(struct device *dev,
>> diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firmware_loader/fallback.h
>> index 06f4577733a8..7d2cb5f6ceb8 100644
>> --- a/drivers/base/firmware_loader/fallback.h
>> +++ b/drivers/base/firmware_loader/fallback.h
>> @@ -42,6 +42,17 @@ void fw_fallback_set_default_timeout(void);
>>   
>>   int register_sysfs_loader(void);
>>   void unregister_sysfs_loader(void);
>> +#ifdef CONFIG_SYSCTL
>> +extern int register_firmware_config_sysctl(void);
>> +extern void unregister_firmware_config_sysctl(void);
>> +#else
>> +static inline int register_firmware_config_sysctl(void)
>> +{
>> +	return 0;
>> +}
>> +static inline void unregister_firmware_config_sysctl(void) { }
>> +#endif /* CONFIG_SYSCTL */
>> +
>>   #else /* CONFIG_FW_LOADER_USER_HELPER */
>>   static inline int firmware_fallback_sysfs(struct firmware *fw, const char *name,
>>   					  struct device *device,
>> diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
>> index 46a731dede6f..4234aa5ee5df 100644
>> --- a/drivers/base/firmware_loader/fallback_table.c
>> +++ b/drivers/base/firmware_loader/fallback_table.c
>> @@ -24,7 +24,7 @@ struct firmware_fallback_config fw_fallback_config = {
>>   EXPORT_SYMBOL_NS_GPL(fw_fallback_config, FIRMWARE_LOADER_PRIVATE);
>>   
>>   #ifdef CONFIG_SYSCTL
>> -struct ctl_table firmware_config_table[] = {
>> +static struct ctl_table firmware_config_table[] = {
>>   	{
>>   		.procname	= "force_sysfs_fallback",
>>   		.data		= &fw_fallback_config.force_sysfs_fallback,
>> @@ -45,4 +45,22 @@ struct ctl_table firmware_config_table[] = {
>>   	},
>>   	{ }
>>   };
>> -#endif
>> +
>> +static struct ctl_table_header *hdr;
>> +int register_firmware_config_sysctl(void)
>> +{
>> +	if (hdr)
>> +		return -EEXIST;
> 
> How can hdr be set?
> 
It's my mistake, register_firmware_config_sysctl() is not exported,
there will be no repeated calls.
thanks for your guidance.

>> +	hdr = register_sysctl_subdir("kernel", "firmware_config",
>> +				     firmware_config_table);
>> +	if (!hdr)
>> +		return -ENOMEM;
>> +	return 0;
>> +}
>> +
>> +void unregister_firmware_config_sysctl(void)
>> +{
>> +	if (hdr)
>> +		unregister_sysctl_table(hdr);
> 
> Why can't unregister_sysctl_table() take a null pointer value?
Sorry, I didn't notice that the unregister_sysctl_table() already checks
the input parameters.
thanks for your guidance.


> And what sets 'hdr' (worst name for a static variable) to NULL so that
> it knows not to be unregistered again as it looks like
> register_firmware_config_sysctl() could be called multiple times.

How about renaming hdr to firmware_config_sysct_table_header?

+ if (hdr)
+ 	return -EEXIST;
After deleting this code in register_firmware_config_sysctl(), and 
considering register_firmware_config_sysctl() and 
unregister_firmware_config_sysctl() are not exported, whether there is
no need to add  "hdr = NULL;" ?

Thanks
Xiaoming Ni




