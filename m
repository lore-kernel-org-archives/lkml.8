Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBAFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63F95206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgFBLLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:11:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5332 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbgFBLLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:11:38 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5220A24BEFBA87BEF44D;
        Tue,  2 Jun 2020 19:11:35 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.18) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Tue, 2 Jun 2020
 19:11:26 +0800
Subject: Re: [PATCH] ubi: fastmap: Don't produce the initial anchor PEB when
 fastmap is disabled
To:     Sascha Hauer <s.hauer@pengutronix.de>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <richard@nod.at>, <yi.zhang@huawei.com>
References: <20200601091134.3794265-1-chengzhihao1@huawei.com>
 <20200602092346.GK11869@pengutronix.de>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <e7a9e993-8878-60c8-49c4-9471421f6e11@huawei.com>
Date:   Tue, 2 Jun 2020 19:11:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200602092346.GK11869@pengutronix.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.18]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ÔÚ 2020/6/2 17:23, Sascha Hauer Ð´µÀ:
> Hi,
>
> On Mon, Jun 01, 2020 at 05:11:34PM +0800, Zhihao Cheng wrote:
>> Following process triggers a memleak caused by forgetting to release the
>> initial anchor PEB (CONFIG_MTD_UBI_FASTMAP is disabled):
>> 1. attach -> __erase_worker -> produce the initial anchor PEB
>> 2. detach -> ubi_fastmap_close (Do nothing, it should have released the
>>     initial anchor PEB)
>>
>> Don't produce the initial anchor PEB in __erase_worker() when fastmap
>> is disabled.
>>
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
>> Fixes: f9c34bb529975fe ("ubi: Fix producing anchor PEBs")
>> Reported-by: syzbot+d9aab50b1154e3d163f5@syzkaller.appspotmail.com
>> ---
>>   drivers/mtd/ubi/wl.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
>> index 5146cce5fe32..5ebe1084a8e7 100644
>> --- a/drivers/mtd/ubi/wl.c
>> +++ b/drivers/mtd/ubi/wl.c
>> @@ -1079,13 +1079,19 @@ static int __erase_worker(struct ubi_device *ubi, struct ubi_work *wl_wrk)
>>   	if (!err) {
>>   		spin_lock(&ubi->wl_lock);
>>   
>> -		if (!ubi->fm_anchor && e->pnum < UBI_FM_MAX_START) {
>> +#ifdef CONFIG_MTD_UBI_FASTMAP
>> +		if (!ubi->fm_disabled && !ubi->fm_anchor &&
>> +		    e->pnum < UBI_FM_MAX_START) {
> Rather than introducing another #ifdef you could do a
>
> 		if (IS_ENABLED(CONFIG_MTD_UBI_FASTMAP) &&
> 		    !ubi->fm_disabled && !ubi->fm_anchor &&
> 		    e->pnum < UBI_FM_MAX_START)
>
> And I am not sure if the IS_ENABLED(CONFIG_MTD_UBI_FASTMAP) is necessary
> at all because we do a ubi->fm_disabled = 1 when fastmap is disabled.
>
> Regards,
>   Sascha
>
Agree.


