Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA22C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 913F4206B8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgEHPJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:09:10 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:10924 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgEHPJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:09:10 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee95eb5748fa8f-5ad2c; Fri, 08 May 2020 23:02:41 +0800 (CST)
X-RM-TRANSID: 2ee95eb5748fa8f-5ad2c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.43.52] (unknown[223.104.148.118])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75eb574902e0-a19d8;
        Fri, 08 May 2020 23:02:41 +0800 (CST)
X-RM-TRANSID: 2ee75eb574902e0-a19d8
Subject: Re: [PATCH] USB: host: ehci: Add error handlinginehci_mxc_drv_probe()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stern@rowland.harvard.edu, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
References: <20200508114453.15436-1-tangbin@cmss.chinamobile.com>
 <20200508114858.GA4085349@kroah.com>
 <fb147bdf-faaa-8919-407e-89b4fe1337a6@cmss.chinamobile.com>
 <20200508143110.GA447591@kroah.com>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <107353c0-09f2-858d-2a87-498e2d8584c6@cmss.chinamobile.com>
Date:   Fri, 8 May 2020 23:03:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200508143110.GA447591@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/5/8 22:31, Greg KH wrote:
> On Fri, May 08, 2020 at 09:55:53PM +0800, Tang Bin wrote:
>> Hi, Greg:
>>
>> On 2020/5/8 19:48, Greg KH wrote:
>>> On Fri, May 08, 2020 at 07:44:53PM +0800, Tang Bin wrote:
>>>> The function ehci_mxc_drv_probe() does not perform sufficient error
>>>> checking after executing platform_get_irq(), thus fix it.
>>>>
>>>> Fixes: 7e8d5cd93fa ("USB: Add EHCI support for MX27 and MX31 based boards")
>>>> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
>>>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>>>> ---
>>>>    drivers/usb/host/ehci-mxc.c | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
>>>> index a1eb5ee77..a0b42ba59 100644
>>>> --- a/drivers/usb/host/ehci-mxc.c
>>>> +++ b/drivers/usb/host/ehci-mxc.c
>>>> @@ -50,6 +50,8 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>>>>    	}
>>>>    	irq = platform_get_irq(pdev, 0);
>>>> +	if (irq < 0)
>>>> +		return irq;
>>> <= ?
>> In the file 'drivers/base/platform.c'， the function platform_get_irq() is
>> explained and used as follows:
>>
>>       * Gets an IRQ for a platform device and prints an error message if
>> finding the
>>       * IRQ fails. Device drivers should check the return value for errors so
>> as to
>>       * not pass a negative integer value to the request_irq() APIs.
>>       *
>>       * Example:
>>       *        int irq = platform_get_irq(pdev, 0);
>>       *        if (irq < 0)
>>       *            return irq;
>>       *
>>       * Return: IRQ number on success, negative error number on failure.
>>
>> And in my hardware experiment, even if I set the irq failed deliberately in
>> the DTS, the returned value is negative instead of zero.
> Please read the thread at
> 	https://lore.kernel.org/r/20200501224042.141366-1-helgaas%40kernel.org
> for more details about this.
>
Great, It looks beautiful, finally someone took a knife to the file 
'platform.c'.

I have been studied this place for a long time, and don't know what 
platform can return 0, which made me curious.

So the example should be:

      *        int irq = platform_get_irq(pdev, 0);
      *        if (irq <= 0)
      *            return irq;

Thanks,

Tang Bin



