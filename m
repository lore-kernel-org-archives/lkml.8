Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41F8C2BA83
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 03:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B92D5206DB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 03:00:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgBHDAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 22:00:20 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:48306 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726743AbgBHDAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 22:00:19 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 383721DB7146CE327F82;
        Sat,  8 Feb 2020 11:00:17 +0800 (CST)
Received: from [127.0.0.1] (10.133.219.224) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Sat, 8 Feb 2020
 11:00:16 +0800
Subject: Re: [PATCH] ubi: fix memory leak from ubi->fm_anchor
To:     Richard Weinberger <richard.weinberger@gmail.com>,
        Quanyang Wang <quanyang.wang@windriver.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>
References: <20200114093305.666-1-quanyang.wang@windriver.com>
 <415718c7-4c55-fb5d-0b10-ad5323daa5a0@windriver.com>
 <CAFLxGvw-q3N98RhbtWCE5mGGv6qwrJBDTMTs_yMe9QDY6U4TAQ@mail.gmail.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <a1b8f42b-9076-cc73-a298-4ddba7cfbc32@huawei.com>
Date:   Sat, 8 Feb 2020 11:00:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvw-q3N98RhbtWCE5mGGv6qwrJBDTMTs_yMe9QDY6U4TAQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.219.224]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The same problem has already been fixed by the patch in the following link early:

https://lore.kernel.org/linux-mtd/0000000000006d0a820599366088@google.com/T/#medffabe29b65eb5feb387bff84c6ec7ad235c310

I will send a v2 next week.

Regards,
Tao

On 2020/2/7 23:54, Richard Weinberger wrote:
> On Mon, Feb 3, 2020 at 10:14 AM Quanyang Wang
> <quanyang.wang@windriver.com> wrote:
>>
>> Ping?
>>
>> On 1/14/20 5:33 PM, quanyang.wang@windriver.com wrote:
>>> From: Quanyang Wang <quanyang.wang@windriver.com>
>>>
>>> Some ubi_wl_entry are allocated in erase_aeb() and one of them is
>>> assigned to ubi->fm_anchor in __erase_worker(). And it should be freed
>>> like others which are freed in tree_destroy(). Otherwise, it will
>>> cause a memory leak:
>>>
>>> unreferenced object 0xbc094318 (size 24):
>>>    comm "ubiattach", pid 491, jiffies 4294954015 (age 420.110s)
>>>    hex dump (first 24 bytes):
>>>      30 43 09 bc 00 00 00 00 00 00 00 00 01 00 00 00  0C..............
>>>      02 00 00 00 04 00 00 00                          ........
>>>    backtrace:
>>>      [<6c2d5089>] erase_aeb+0x28/0xc8
>>>      [<a1c68fb1>] ubi_wl_init+0x1d8/0x4a8
>>>      [<d4f408f8>] ubi_attach+0xffc/0x10d0
>>>      [<add3b5d8>] ubi_attach_mtd_dev+0x5b4/0x9fc
>>>      [<d375a11c>] ctrl_cdev_ioctl+0xb8/0x1d8
>>>      [<72b250f2>] vfs_ioctl+0x28/0x3c
>>>      [<b80095d7>] do_vfs_ioctl+0xb0/0x798
>>>      [<bf9ef69e>] ksys_ioctl+0x58/0x74
>>>      [<5355bdbe>] ret_fast_syscall+0x0/0x54
>>>      [<90c6c3ca>] 0x7eadf854
>>>
>>> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
>>> ---
>>>   drivers/mtd/ubi/wl.c | 2 ++
>>>   1 file changed, 2 insertions(+)
> 
> Good catch!
> Fixes: f9c34bb52997 ("ubi: Fix producing anchor PEBs")
> 
> ---
> Thanks,
> //richard
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 
> 

