Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B126AC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97DAB20732
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392878AbgDOCMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 22:12:35 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:11703 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392857AbgDOCM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:12:28 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75e966d7c257-5d4cd; Wed, 15 Apr 2020 10:12:12 +0800 (CST)
X-RM-TRANSID: 2ee75e966d7c257-5d4cd
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.21.224] (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95e966d7bbb6-4fa4c;
        Wed, 15 Apr 2020 10:12:12 +0800 (CST)
X-RM-TRANSID: 2ee95e966d7bbb6-4fa4c
Subject: Re: [PATCH 3/3] ipmi:bt-bmc: Fix error handling and status check
To:     minyard@acm.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20200414141423.4968-1-tangbin@cmss.chinamobile.com>
 <20200414201832.GJ3587@minyard.net>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <f5a848ae-d19f-5ab6-7c7d-2d0811fc174b@cmss.chinamobile.com>
Date:   Wed, 15 Apr 2020 10:14:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414201832.GJ3587@minyard.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey:

On 2020/4/15 4:18, Corey Minyard wrote:
> On Tue, Apr 14, 2020 at 10:14:24PM +0800, Tang Bin wrote:
>> If the function platform_get_irq() failed, the negative
>> value returned will not be detected here. So fix error
>> handling in bt_bmc_config_irq(). And if devm_request_irq()
>> failed, 'bt_bmc->irq' is assigned to zero maybe redundant,
>> it may be more suitable for using the correct negative values
>> to make the status check in the function bt_bmc_remove().
> Comments inline..
>
>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>> Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
>> ---
>>   drivers/char/ipmi/bt-bmc.c | 12 +++++-------
>>   1 file changed, 5 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/char/ipmi/bt-bmc.c b/drivers/char/ipmi/bt-bmc.c
>> index 1d4bf5c65..1740c6dc8 100644
>> --- a/drivers/char/ipmi/bt-bmc.c
>> +++ b/drivers/char/ipmi/bt-bmc.c
>> @@ -399,16 +399,14 @@ static int bt_bmc_config_irq(struct bt_bmc *bt_bmc,
>>   	struct device *dev = &pdev->dev;
>>   	int rc;
>>   
>> -	bt_bmc->irq = platform_get_irq(pdev, 0);
>> -	if (!bt_bmc->irq)
>> -		return -ENODEV;
>> +	bt_bmc->irq = platform_get_irq_optional(pdev, 0);
>> +	if (bt_bmc->irq < 0)
>> +		return bt_bmc->irq;
>>   
For us, this part of modification have reached a consensus.
>>   	rc = devm_request_irq(dev, bt_bmc->irq, bt_bmc_irq, IRQF_SHARED,
>>   			      DEVICE_NAME, bt_bmc);
>> -	if (rc < 0) {
>> -		bt_bmc->irq = 0;
>> +	if (rc < 0)
>>   		return rc;
> I don't think this part is correct.  You will want to set bt_bmc->irq to
> rc here to match what is done elsewhere so it's the error if negative.

Nonono, I don't want to set bt_bmc->irq to rc, I think they are irrelevant.

The logic of the previous code will continue to execute even if 
platform_get_irq() failed,which will be brought devm_request_irq() 
failed too. "bt_bmc->irq = 0" here is just for bt_bmc_remove() to 
execute del_timer_sync(). Otherwise the function del_timer_sync() will 
not execute if not set "bt_bmc->irq" to zero, because it's negative 
actually.


>
> Also, I believe this function should no longer return an error.  It
> should just set the irq to the error if one happens.  The driver needs
> to continue to operate even if it can't get its interrupt.
>
> The rest of the changes are correct, I believe.
>
>
>> -	}
>>   
>>   	/*
>>   	 * Configure IRQs on the bmc clearing the H2B and HBUSY bits;
>> @@ -499,7 +497,7 @@ static int bt_bmc_remove(struct platform_device *pdev)
>>   	struct bt_bmc *bt_bmc = dev_get_drvdata(&pdev->dev);
>>   
>>   	misc_deregister(&bt_bmc->miscdev);
>> -	if (!bt_bmc->irq)
>> +	if (bt_bmc->irq < 0)
>>   		del_timer_sync(&bt_bmc->poll_timer);
>>   	return 0;
>>   }

But now, the logic is: if the platform_get_irq_optional() failed, it 
returns immediately, the irq at this point is negative,the 
bt_bmc_probe() continue to operate. But in the function bt_bmc_remove(), 
we need status check in order to execute del_timer_sync(), so change 
"!bt_bmc->irq" to "bt_bmc->irq < 0".

So, when the judgment of "bt_bmc->irq" in the function bt_bmc_remove() 
goes back to  the original negative value, the "bt_bmc->irq = 0" in the 
line 410 become redundant. That's why I remove it.



I am very glad to communicate and discuss with you these days.

Thanks,

Tang Bin


>>
>>
>>


