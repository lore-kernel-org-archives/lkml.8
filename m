Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DA5C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FBF424954
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 14:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgEHO2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 10:28:13 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:4391 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbgEHO2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:28:13 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25eb56c5a887-5ad8b; Fri, 08 May 2020 22:27:39 +0800 (CST)
X-RM-TRANSID: 2ee25eb56c5a887-5ad8b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.43.52] (unknown[223.104.148.118])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45eb56c5a857-5b418;
        Fri, 08 May 2020 22:27:39 +0800 (CST)
X-RM-TRANSID: 2ee45eb56c5a857-5b418
Subject: Re: [PATCH] USB: host: ehci: Use the defined variable to simplifycode
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
References: <Pine.LNX.4.44L0.2005080952130.19653-100000@netrider.rowland.org>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <e335e5c7-bf7e-22d8-4dbf-15b0477d8d5d@cmss.chinamobile.com>
Date:   Fri, 8 May 2020 22:28:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.2005080952130.19653-100000@netrider.rowland.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/5/8 21:56, Alan Stern wrote:
> On Fri, 8 May 2020, Tang Bin wrote:
>
>> Use the defined variable "dev" to make the code cleaner. And
>> delete an extra blank line.
> Again, the Subject: line should say "ehci-mxc".
Got it.
>
>> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>> ---
>>   drivers/usb/host/ehci-mxc.c | 9 ++++-----
>>   1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
>> index c9f91e6c7..a1eb5ee77 100644
>> --- a/drivers/usb/host/ehci-mxc.c
>> +++ b/drivers/usb/host/ehci-mxc.c
>> @@ -56,7 +56,7 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>>   		return -ENOMEM;
>>   
>>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	hcd->regs = devm_ioremap_resource(&pdev->dev, res);
>> +	hcd->regs = devm_ioremap_resource(dev, res);
> As long as you're making these changes, why not also move the
> definition of dev up before the definition of pdata?  Then you could
> change the definition of pdata to:
>
> 	struct mxc_usbh_platform_data *pdata = dev_get_platdata(dev);
>
Got it.

Thanks



