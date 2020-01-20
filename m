Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44FAC33CB6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 02:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C90B20678
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 02:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgATChO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 21:37:14 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:50290 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728874AbgATChO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 21:37:14 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6196DC053B8285566763;
        Mon, 20 Jan 2020 10:37:11 +0800 (CST)
Received: from [127.0.0.1] (10.177.131.64) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Mon, 20 Jan 2020
 10:37:02 +0800
Subject: Re: [PATCH -next] net: hns3: replace snprintf with scnprintf in
 hns3_dbg_cmd_read
To:     tanhuazhong <tanhuazhong@huawei.com>, <yisen.zhuang@huawei.com>,
        <salil.mehta@huawei.com>, <davem@davemloft.net>
References: <20200119124147.30394-1-chenzhou10@huawei.com>
 <2e1ab30a-af35-6bc6-f880-a3051375a6a8@huawei.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Chen Zhou <chenzhou10@huawei.com>
Message-ID: <dbd54fd8-b356-18a2-cb16-ad3aaaa933ca@huawei.com>
Date:   Mon, 20 Jan 2020 10:37:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <2e1ab30a-af35-6bc6-f880-a3051375a6a8@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.131.64]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/1/20 9:28, tanhuazhong wrote:
> 
> 
> On 2020/1/19 20:41, Chen Zhou wrote:
>> The return value of snprintf may be greater than the size of
>> HNS3_DBG_READ_LEN, use scnprintf instead in hns3_dbg_cmd_read.
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>>   drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
>> index 6b328a2..8fad699 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
>> @@ -297,7 +297,7 @@ static ssize_t hns3_dbg_cmd_read(struct file *filp, char __user *buffer,
>>       if (!buf)
>>           return -ENOMEM;
>>   -    len = snprintf(buf, HNS3_DBG_READ_LEN, "%s\n",
>> +    len = scnprintf(buf, HNS3_DBG_READ_LEN, "%s\n",
>>                  "Please echo help to cmd to get help information");
> 
> not align?

Ok, i will fix in next version.

Thanks,
Chen Zhou

> 
>>       uncopy_bytes = copy_to_user(buffer, buf, len);
>>  
> 
> 
> .
> 

