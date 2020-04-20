Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB95C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85D38206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbgDTMfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:35:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbgDTMfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:35:02 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 42114F8280CD990CF8CC;
        Mon, 20 Apr 2020 20:35:01 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.7) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Apr 2020
 20:34:59 +0800
Subject: Re: [PATCH] staging: mt7621-pinctrl: Use correct pointer type
 argument for sizeof
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <gregkh@linuxfoundation.org>, <matthias.bgg@gmail.com>,
        <nishkadg.linux@gmail.com>, <devel@driverdev.osuosl.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200420123755.4353-1-yanaijie@huawei.com>
 <20200420121900.GD2659@kadam>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <c6b155a6-28ae-e0f9-b866-4d17e8a45706@huawei.com>
Date:   Mon, 20 Apr 2020 20:34:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200420121900.GD2659@kadam>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.7]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/4/20 20:19, Dan Carpenter Ð´µÀ:
> On Mon, Apr 20, 2020 at 08:37:55PM +0800, Jason Yan wrote:
>> Fix the following coccicheck warning:
>>
>> drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c:223:14-36: WARNING: Use
>> correct pointer type argument for sizeof
>>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>> ---
>>   drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
>> index d0f06790d38f..8883f2a8ea57 100644
>> --- a/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
>> +++ b/drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c
>> @@ -220,7 +220,7 @@ static int rt2880_pinmux_index(struct rt2880_priv *p)
>>   	/* allocate our function and group mapping index buffers */
>>   	f = p->func = devm_kcalloc(p->dev,
>>   				   p->func_count,
>> -				   sizeof(struct rt2880_pmx_func),
>> +				   sizeof(struct rt2880_pmx_func *),
> 
> Yes.  This fixes a bug.  We were allocating too much data.  But the
> prefered style is:
> 
> 				sizeof(*p->func),
> 
> Please could you resend?
> 

Sure, I will cook a new one.

> regards,
> dan carpenter
> 
> 
> .
> 

