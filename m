Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33CDC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B15BE20675
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 14:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgC3O0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:26:09 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42568 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725268AbgC3O0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 10:26:09 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id EF5D03B0274E1140F657;
        Mon, 30 Mar 2020 22:26:05 +0800 (CST)
Received: from [127.0.0.1] (10.67.102.197) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Mon, 30 Mar 2020
 22:25:56 +0800
Subject: Re: [PATCH v3] mtd:fix cache_state to avoid writing to bad blocks
 repeatedly
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>, <gregkh@linuxfoundation.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangle6@huawei.com>, <zhangweimin12@huawei.com>,
        <yebin10@huawei.com>, <houtao1@huawei.com>, <stable@kernel.org>
References: <1585575925-84017-1-git-send-email-nixiaoming@huawei.com>
 <20200330155222.20359293@xps13>
From:   Xiaoming Ni <nixiaoming@huawei.com>
Message-ID: <5bf71fe1-2dd1-f45a-5858-433f340b167e@huawei.com>
Date:   Mon, 30 Mar 2020 22:25:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200330155222.20359293@xps13>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.197]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/30 21:52, Miquel Raynal wrote:
> Hi Xiaoming,
> 
> Xiaoming Ni <nixiaoming@huawei.com> wrote on Mon, 30 Mar 2020 21:45:25
> +0800:
> 
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
>> Cc: stable@vger.kernel.org
> 
> Still missing:
> * Fixes: tag
> * Wrong title prefix
> 

Fixes: 	1da177e4c3f41524e88 "Linux-2.6.12-rc2"

Is it described like this?

Do I need to go to
https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git
to trace back the older commit records?

Thanks
Xiaoming Ni




