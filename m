Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F232C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41FF820678
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 11:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgFCL5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 07:57:49 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5781 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725855AbgFCL5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 07:57:48 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8BD64301FB3ED8BC1805;
        Wed,  3 Jun 2020 19:57:45 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.205) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Wed, 3 Jun 2020
 19:57:40 +0800
Subject: Re: [PATCH] cxl: Fix kobject memleak
To:     Andrew Donnellan <ajd@linux.ibm.com>, <fbarrat@linux.ibm.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <mpe@ellerman.id.au>, <imunsie@au1.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
References: <20200602120733.5943-1-wanghai38@huawei.com>
 <72e2df75-b74b-cbd4-4cbe-c0f994d4c4f7@linux.ibm.com>
From:   "wanghai (M)" <wanghai38@huawei.com>
Message-ID: <a9ecd617-c541-aeb1-2e94-93abba475279@huawei.com>
Date:   Wed, 3 Jun 2020 19:57:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <72e2df75-b74b-cbd4-4cbe-c0f994d4c4f7@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.205]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2020/6/3 19:33, Andrew Donnellan 写道:
> On 2/6/20 10:07 pm, Wang Hai wrote:
>> Currently the error return path from kobject_init_and_add() is not
>> followed by a call to kobject_put() - which means we are leaking
>> the kobject.
>>
>> Fix it by adding a call to kobject_put() in the error path of
>> kobject_init_and_add().
>>
>> Fixes: b087e6190ddc ("cxl: Export optional AFU configuration record 
>> in sysfs")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
>
> Thanks for the fix!
>
> I note that the err1 label returns without calling kfree(cr) and I 
> can't see a reason why we do that - so perhaps we should remove the 
> return statement in err1: so it falls through?
>
kfree(cr) can be called when 
kobject_put()-->kobject_release()-->kobject_cleanup()-->kobj_type->release() 
is called.  The kobj_type here is afu_config_record_type


Thanks,

Wang Hai


