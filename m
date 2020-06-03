Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B61AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 01:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 666C8206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 01:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgFCBms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 21:42:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49994 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726894AbgFCBms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 21:42:48 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 607BF51E75753D39F3C8;
        Wed,  3 Jun 2020 09:42:46 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.205) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Wed, 3 Jun 2020
 09:42:42 +0800
Subject: Re: [PATCH] cxl: Fix kobject memory leak in cxl_sysfs_afu_new_cr()
To:     Markus Elfring <Markus.Elfring@web.de>,
        <linuxppc-dev@lists.ozlabs.org>
CC:     Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ian Munsie <imunsie@au1.ibm.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <b9791ff3-8397-f6e9-ca88-59c9bbe8c78f@web.de>
From:   "wanghai (M)" <wanghai38@huawei.com>
Message-ID: <25ad528b-beaf-820f-9738-ea304dcbc0d7@huawei.com>
Date:   Wed, 3 Jun 2020 09:42:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b9791ff3-8397-f6e9-ca88-59c9bbe8c78f@web.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.205]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/6/3 1:20, Markus Elfring 写道:
>> Fix it by adding a call to kobject_put() in the error path of
>> kobject_init_and_add().
> Thanks for another completion of the exception handling.
>
> Would an other patch subject be a bit nicer?
Thanks for the guidance, I will perfect this description and send a v2
>
> …
>> +++ b/drivers/misc/cxl/sysfs.c
>> @@ -624,7 +624,7 @@ static struct afu_config_record *cxl_sysfs_afu_new_cr(struct cxl_afu *afu, int c
>>   	rc = kobject_init_and_add(&cr->kobj, &afu_config_record_type,
>>   				  &afu->dev.kobj, "cr%i", cr->cr);
>>   	if (rc)
>> -		goto err;
>> +		goto err1;
> …
>
> Can an other label be more reasonable here?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst?id=f359287765c04711ff54fbd11645271d8e5ff763#n465
I just used the original author's label, should I replace all his labels 
like'err','err1' with reasonable one.

