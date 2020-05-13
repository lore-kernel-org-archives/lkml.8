Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB11C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8561206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgEMGMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 02:12:37 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37368 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728490AbgEMGMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 02:12:37 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3CD743B0FF3190AF07B8;
        Wed, 13 May 2020 14:12:34 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.100) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Wed, 13 May 2020
 14:12:24 +0800
Subject: Re: [PATCH] nvme/core:disable streams when get stream params failed
To:     Christoph Hellwig <hch@lst.de>
CC:     <kbusch@kernel.org>, <axboe@fb.com>, <sagi@grimberg.me>,
        <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <liuzhiqiang26@huawei.com>, <linfeilong@huawei.com>
References: <1588754221-661597-1-git-send-email-wubo40@huawei.com>
 <20200512160618.GA5403@lst.de>
From:   Wu Bo <wubo40@huawei.com>
Message-ID: <cecc6494-efab-ef38-6461-e6d571cb05ee@huawei.com>
Date:   Wed, 13 May 2020 14:12:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200512160618.GA5403@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.215.100]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/13 0:06, Christoph Hellwig wrote:
> On Wed, May 06, 2020 at 04:37:01PM +0800, Wu Bo wrote:
>> After enable nvme streams, then if get stream params failed,
>> We should disable streams before return error in
>> nvme_configure_directives() function.
>>
>> Signed-off-by: Wu Bo <wubo40@huawei.com>
>> ---
>>   drivers/nvme/host/core.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index f2adea9..afe1f5a 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -552,8 +552,10 @@ static int nvme_configure_directives(struct nvme_ctrl *ctrl)
>>   		return ret;
>>   
>>   	ret = nvme_get_stream_params(ctrl, &s, NVME_NSID_ALL);
>> -	if (ret)
>> +	if (ret) {
>> +		nvme_disable_streams(ctrl);
>>   		return ret;
>> +	}
> 
> Please use a out_disable goto label to not duplicate the error
> handling with the other case that needs it.
> 

OK， I will modify it in the V2 patch.

Thanks,
Wu Bo

> .
> 


