Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABB6C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E406B20575
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 20:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgD1UNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:13:34 -0400
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:37938 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgD1UNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 16:13:33 -0400
Received: from [192.168.1.41] ([92.148.159.11])
        by mwinf5d23 with ME
        id YLDV220080F2omL03LDVBg; Tue, 28 Apr 2020 22:13:31 +0200
X-ME-Helo: [192.168.1.41]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 28 Apr 2020 22:13:31 +0200
X-ME-IP: 92.148.159.11
Subject: Re: [PATCH] firmware: stratix10-svc: Fix some error handling paths in
 'stratix10_svc_drv_probe()'
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     richard.gong@linux.intel.com, gregkh@linuxfoundation.org,
        atull@kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200426190307.40840-1-christophe.jaillet@wanadoo.fr>
 <20200428115510.GA2014@kadam>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <f812994a-3de7-00d7-5f06-2e819d8be3f3@wanadoo.fr>
Date:   Tue, 28 Apr 2020 22:13:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428115510.GA2014@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 28/04/2020 à 13:55, Dan Carpenter a écrit :
> On Sun, Apr 26, 2020 at 09:03:07PM +0200, Christophe JAILLET wrote:
>> If an error occurs after calling 'kfifo_alloc()', the allocated memory
>> should be freed with 'kfifo_free()', as already done in the remove
>> function.
>>
>> Fixes: b5dc75c915cd ("firmware: stratix10-svc: extend svc to support new RSU features")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>   drivers/firmware/stratix10-svc.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
>> index d5f0769f3761..cc9df9589195 100644
>> --- a/drivers/firmware/stratix10-svc.c
>> +++ b/drivers/firmware/stratix10-svc.c
>> @@ -1043,24 +1043,31 @@ static int stratix10_svc_drv_probe(struct platform_device *pdev)
>>   
>>   	/* add svc client device(s) */
>>   	svc = devm_kzalloc(dev, sizeof(*svc), GFP_KERNEL);
>> -	if (!svc)
>> -		return -ENOMEM;
>> +	if (!svc) {
>> +		ret = -ENOMEM;
>> +		goto err_free_kfifo;
>> +	}
>>   
>>   	svc->stratix10_svc_rsu = platform_device_alloc(STRATIX10_RSU, 0);
>>   	if (!svc->stratix10_svc_rsu) {
>>   		dev_err(dev, "failed to allocate %s device\n", STRATIX10_RSU);
>> -		return -ENOMEM;
>> +		ret = -ENOMEM;
>> +		goto err_free_kfifo;
>>   	}
>>   
>>   	ret = platform_device_add(svc->stratix10_svc_rsu);
>>   	if (ret) {
>>   		platform_device_put(svc->stratix10_svc_rsu);
> Why not move this to the unwind code as well and do "goto put_platform;"?

Sure, I'll send a V2.

CJ


> regards,
> dan carpenter
>
>> -		return ret;
>> +		goto err_free_kfifo;
>>   	}
>>   	dev_set_drvdata(dev, svc);
>>   
>>   	pr_info("Intel Service Layer Driver Initialized\n");
>>   
>> +	return 0;
>> +
>> +err_free_kfifo:
>> +	kfifo_free(&controller->svc_fifo);
>>   	return ret;
>>   }
>

