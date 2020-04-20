Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE0CC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6C3E20857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgDTNix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:38:53 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbgDTNiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:38:51 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 9673631221DD9CA2C719;
        Mon, 20 Apr 2020 21:36:40 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.7) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Apr 2020
 21:36:34 +0800
Subject: Re: [PATCH v2] staging: mt7621-pinctrl: Use correct pointer type
 argument for sizeof
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <matthias.bgg@gmail.com>, <nishkadg.linux@gmail.com>,
        <devel@driverdev.osuosl.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200420124151.4356-1-yanaijie@huawei.com>
 <20200420130715.GA4040736@kroah.com>
From:   Jason Yan <yanaijie@huawei.com>
Message-ID: <6df8fd83-9888-1aab-c5a6-87e5b2f942ca@huawei.com>
Date:   Mon, 20 Apr 2020 21:36:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200420130715.GA4040736@kroah.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.166.213.7]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



ÔÚ 2020/4/20 21:07, Greg KH Ð´µÀ:
> On Mon, Apr 20, 2020 at 08:41:51PM +0800, Jason Yan wrote:
>> Fix the following coccicheck warning:
>>
>> drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c:223:14-36: WARNING: Use
>> correct pointer type argument for sizeof
>>
>> Signed-off-by: Jason Yan <yanaijie@huawei.com>
>> ---
>>   drivers/staging/mt7621-pinctrl/pinctrl-rt2880.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> What changed from v1?  Always put that below the --- line.
> 
> Please fix up and send a v3.
> 

OK.

> thanks,
> 
> greg k-h
> 
> .
> 

