Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948CCC47257
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F50520836
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730171AbgEEPJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:09:41 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:19877 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729712AbgEEPJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:09:40 -0400
Received: from [192.168.42.210] ([93.23.13.215])
        by mwinf5d12 with ME
        id b39d220044ePWwV0339dV3; Tue, 05 May 2020 17:09:39 +0200
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 05 May 2020 17:09:39 +0200
X-ME-IP: 93.23.13.215
Subject: Re: [PATCH 2/4 v2] firmware: stratix10-svc: Unmap some previously
 memremap'ed memory
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     richard.gong@linux.intel.com, atull@kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <cover.1588142343.git.christophe.jaillet@wanadoo.fr>
 <43505dc3a4b405d1c7d4a0fa74c67eda3e8bdb75.1588142343.git.christophe.jaillet@wanadoo.fr>
 <20200505144355.GC838641@kroah.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <5bae5684-6b3e-e94c-7745-046bd24c4f4b@wanadoo.fr>
Date:   Tue, 5 May 2020 17:09:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505144355.GC838641@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 05/05/2020 à 16:43, Greg KH a écrit :
> On Wed, Apr 29, 2020 at 08:52:43AM +0200, Christophe JAILLET wrote:
>> In 'svc_create_memory_pool()' we memremap some memory. This has to be
>> undone in case of error and if the driver is removed.
>>
>> The easiest way to do it is to use 'devm_memremap()'.
>>
>> Fixes: 7ca5ce896524 ("firmware: add Intel Stratix10 service layer driver")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/firmware/stratix10-svc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
>> index 3a176e62754a..de5870f76c5e 100644
>> --- a/drivers/firmware/stratix10-svc.c
>> +++ b/drivers/firmware/stratix10-svc.c
>> @@ -631,7 +631,7 @@ svc_create_memory_pool(struct platform_device *pdev,
>>   	end = rounddown(sh_memory->addr + sh_memory->size, PAGE_SIZE);
>>   	paddr = begin;
>>   	size = end - begin;
>> -	va = memremap(paddr, size, MEMREMAP_WC);
>> +	va = devm_memremap(dev, paddr, size, MEMREMAP_WC);
>>   	if (!va) {
>>   		dev_err(dev, "fail to remap shared memory\n");
>>   		return ERR_PTR(-EINVAL);
> And there was no previous unmap happening when the pool was torn down
> that now needs to be removed?

I don't think so, there is no memunmap call in 'stratix10-svc.c'

CJ

> thanks,
>
> greg k-h
>

