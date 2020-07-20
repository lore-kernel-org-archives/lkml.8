Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B82C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 02:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A2B208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 02:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgGTCTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 22:19:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58352 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbgGTCTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 22:19:04 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7516433879410B5B614F;
        Mon, 20 Jul 2020 10:19:03 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.91) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Jul 2020
 10:18:58 +0800
Subject: Re: [PATCH -next] debugobjects: Convert to DEFINE_SHOW_ATTRIBUTE
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marco Elver <elver@google.com>, Qian Cai <cai@lca.pw>,
        <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20200716084747.8034-1-miaoqinglang@huawei.com>
 <87h7u5riq7.fsf@nanos.tec.linutronix.de>
From:   miaoqinglang <miaoqinglang@huawei.com>
Message-ID: <f43d2530-3e21-6bf9-ef68-dae1bb7f173a@huawei.com>
Date:   Mon, 20 Jul 2020 10:18:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87h7u5riq7.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.91]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/7/18 4:26, Thomas Gleixner Ð´µÀ:
> Qinglang Miao <miaoqinglang@huawei.com> writes:
>> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>>
>> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
>> ---
>>   lib/debugobjects.c | 12 +-----------
>>   1 file changed, 1 insertion(+), 11 deletions(-)
>>
>> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
>> index 5d2bbfc55..916a5c492 100644
>> --- a/lib/debugobjects.c
>> +++ b/lib/debugobjects.c
>> @@ -1023,17 +1023,7 @@ static int debug_stats_show(struct seq_file *m, void *v)
>>   	return 0;
>>   }
>>   
>> -static int debug_stats_open(struct inode *inode, struct file *filp)
>> -{
>> -	return single_open(filp, debug_stats_show, NULL);
>> -}
>> -
>> -static const struct file_operations debug_stats_fops = {
>> -	.open		= debug_stats_open,
>> -	.read_iter		= seq_read_iter,
> 
> This does not apply against mainline, so I assume this malformatted
> thing comes from Christophs seq_read_iter changes in -next.
> 
> The seq_read_iter here makes no sense whatsoever if the same thing can
> be achieved by using
> 
>> +DEFINE_SHOW_ATTRIBUTE(debug_stats);
> 
> and fixing it at the generic level.
> 
> Thanks,
> 
>          tglx
> .
> 
Because the swicth from seq_read to seq_read_iter would rather be 
implemented in macro or coccinelle script as you mentioned in another 
mail, I can send a new patch against mainline instead if you don't mind.

Thanks.

Qinglang

.


