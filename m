Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9E1C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1EE520719
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 13:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388631AbgDBN2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 09:28:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:40290 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388274AbgDBN2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 09:28:02 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1FE8C294CC790EBC8BF1;
        Thu,  2 Apr 2020 21:28:00 +0800 (CST)
Received: from [127.0.0.1] (10.173.223.234) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 2 Apr 2020
 21:27:56 +0800
Subject: Re: [PATCH -next] virtio-balloon: Make virtballoon_free_page_report
 static
To:     "Michael S. Tsirkin" <mst@redhat.com>
References: <20200402024302.35192-1-yuehaibing@huawei.com>
 <20200402090550-mutt-send-email-mst@kernel.org>
CC:     <jasowang@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <d1f5d775-17b6-7953-f54a-3adfcea79cfa@huawei.com>
Date:   Thu, 2 Apr 2020 21:27:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20200402090550-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.223.234]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/4/2 21:06, Michael S. Tsirkin wrote:
> On Thu, Apr 02, 2020 at 10:43:02AM +0800, YueHaibing wrote:
>> Fix sparse warning:
>>
>> drivers/virtio/virtio_balloon.c:168:5: warning:
>>  symbol 'virtballoon_free_page_report' was not declared. Should it be static?
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> This is for the mm tree right? You need to tag the subject
> appropriately and copy the relevant lists.

Oh, I should have noticed this, sorry for noise.

> 
>> ---
>>  drivers/virtio/virtio_balloon.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
>> index 0ef16566c3f3..bc10f94718e3 100644
>> --- a/drivers/virtio/virtio_balloon.c
>> +++ b/drivers/virtio/virtio_balloon.c
>> @@ -165,8 +165,9 @@ static void tell_host(struct virtio_balloon *vb, struct virtqueue *vq)
>>  
>>  }
>>  
>> +static
>>  int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_info,
>> -				   struct scatterlist *sg, unsigned int nents)
>> +				 struct scatterlist *sg, unsigned int nents)
>>  {
>>  	struct virtio_balloon *vb =
>>  		container_of(pr_dev_info, struct virtio_balloon, pr_dev_info);
>> -- 
>> 2.17.1
>>
> 
> 
> 

