Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A1DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12047207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbgCaLGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 07:06:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57186 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730436AbgCaLGt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 07:06:49 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E8ED3DB02715B946D6D2;
        Tue, 31 Mar 2020 19:06:43 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 31 Mar 2020
 19:06:34 +0800
Subject: Re: [PATCH v4] mtd: clear cache_state to avoid writing to bad blocks
 repeatedly
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangle6@huawei.com>, <zhangweimin12@huawei.com>,
        <yebin10@huawei.com>, <houtao1@huawei.com>
References: <1585618319-119741-1-git-send-email-nixiaoming@huawei.com>
 <20200331100526.GC1204199@kroah.com>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <045c988f-4106-1c5c-f33a-8c2617eddbb1@huawei.com>
Date:   Tue, 31 Mar 2020 19:06:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200331100526.GC1204199@kroah.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/31 18:05, Greg KH wrote:
> On Tue, Mar 31, 2020 at 09:31:59AM +0800, Xiaoming Ni wrote:
>> The function call process is as follows:
>> 	mtd_blktrans_work()
>> 	  while (1)
>> 	    do_blktrans_request()
>> 	      mtdblock_writesect()
>> 	        do_cached_write()
>> 	          write_cached_data() /*if cache_state is STATE_DIRTY*/
>> 	            erase_write()
>>
>> write_cached_data() returns failure without modifying cache_state
>> and cache_offset. So when do_cached_write() is called again,
>> write_cached_data() will be called again to perform erase_write()
>> on the same cache_offset.
>>
>> But if this cache_offset points to a bad block, erase_write() will
>> always return -EIO. Writing to this mtdblk is equivalent to losing
>> the current data, and repeatedly writing to the bad block.
>>
>> Repeatedly writing a bad block has no real benefits,
>> but brings some negative effects:
>> 1 Lost subsequent data
>> 2 Loss of flash device life
>> 3 erase_write() bad blocks are very time-consuming. For example:
>> 	the function do_erase_oneblock() in chips/cfi_cmdset_0020.c or
>> 	chips/cfi_cmdset_0002.c may take more than 20 seconds to return
>>
>> Therefore, when erase_write() returns -EIO in write_cached_data(),
>> clear cache_state to avoid writing to bad blocks repeatedly.
>>
>> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
>> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> ---
>>   drivers/mtd/mtdblock.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> $ ./scripts/get_maintainer.pl --file drivers/mtd/mtdblock.c
> Miquel Raynal <miquel.raynal@bootlin.com> (maintainer:MEMORY TECHNOLOGY DEVICES (MTD))
> Richard Weinberger <richard@nod.at> (maintainer:MEMORY TECHNOLOGY DEVICES (MTD))
> Vignesh Raghavendra <vigneshr@ti.com> (maintainer:MEMORY TECHNOLOGY DEVICES (MTD))
> linux-mtd@lists.infradead.org (open list:MEMORY TECHNOLOGY DEVICES (MTD))
> linux-kernel@vger.kernel.org (open list)
> 
> 
> No where on there is my name/email, so why am I getting these?
> 
> confused,
> 
> greg k-h

At v3, I added Cc: stable@vger.kernel.org and emailed you,
At v4, Cc: stable@vger.kernel.org was deleted, but forgot to remove you 
from the recipient list
I'm very sorry to bother you
Thanks
Xiaoming Ni

