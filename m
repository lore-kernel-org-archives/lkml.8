Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA74DC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 08:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 853F520753
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 08:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgDJIDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 04:03:46 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:22326 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgDJIDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 04:03:46 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee15e9028460d8-00087; Fri, 10 Apr 2020 16:03:18 +0800 (CST)
X-RM-TRANSID: 2ee15e9028460d8-00087
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.21.224] (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45e902845dfb-d74bd;
        Fri, 10 Apr 2020 16:03:18 +0800 (CST)
X-RM-TRANSID: 2ee45e902845dfb-d74bd
Subject: Re: [PATCH] usb: gadget: fsl: Fix a wrong judgment in fsl_udc_probe()
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Li Yang <leoyang.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200410015832.8012-1-tangbin@cmss.chinamobile.com>
 <be8cd229-884a-40e6-3363-7c4680a51b30@web.de>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <0b718268-d330-dfc1-aca3-3dd3203363d7@cmss.chinamobile.com>
Date:   Fri, 10 Apr 2020 16:05:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <be8cd229-884a-40e6-3363-7c4680a51b30@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus

On 2020/4/10 15:33, Markus Elfring wrote:
>> If the function "platform_get_irq()" failed, the negative value
>> returned will not be detected here, including "-EPROBE_DEFER",
> I suggest to adjust this change description.
>
> Wording alternative:
>    The negative return value (which could eventually be “-EPROBE_DEFER”)
>    will not be detected here from a failed call of the function “platform_get_irq”.
Hardware experiments show that the negative return value is not just 
"-EPROBE_DEFER".
>
>> which causes the application to fail to get the correct error message.
> Will another fine-tuning become relevant also for this wording?
Maybe that's not quite accurate.
>
>
>> Thus it must be fixed.
> Wording alternative:
>    Thus adjust the error detection and corresponding exception handling.
Got it.
>
>
>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
>> Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
> How do you think about to add the tags “Fixes”, “Link” and “Reported-by”?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=c0cc271173b2e1c2d8d0ceaef14e4dfa79eefc0d#n584
>
> usb: gadget: fsl_udc_core: Checking for a failed platform_get_irq() call in fsl_udc_probe()
> https://lore.kernel.org/linux-usb/36341bb1-1e00-5eb1-d032-60dcc614ddaf@web.de/
> https://lkml.org/lkml/2020/4/8/442
>
> …
>> +++ b/drivers/usb/gadget/udc/fsl_udc_core.c
>> @@ -2441,8 +2441,8 @@ static int fsl_udc_probe(struct platform_device *pdev)
>>   	udc_controller->max_ep = (dccparams & DCCPARAMS_DEN_MASK) * 2;
>>
>>   	udc_controller->irq = platform_get_irq(pdev, 0);
>> -	if (!udc_controller->irq) {
>> -		ret = -ENODEV;
>> +	if (udc_controller->irq <= 0) {
> Will such a failure predicate need any more clarification?
>
> How does this check fit to the current software documentation?
Maybe my tags are not suitable.
>
>
>> +		ret = udc_controller->irq ? : -ENODEV;
> Will it be clearer to specify values for all cases in such a conditional operator
> (instead of leaving one case empty)?

I don't know what you mean of "instead of leaving one case empty". But 
by experiment, "ret = udc_controller->irq ? : -ENODEV" or "ret = 
udc_controller->irq < 0 ? udc_controller->irq : -ENODEV" should be 
suitable here.


Thank you for your guidance.

Tang Bin



