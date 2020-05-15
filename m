Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21FDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 23:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 847D620756
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 23:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgEOXWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 19:22:54 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:14157 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgEOXWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 19:22:54 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75ebf2446435-09b10; Sat, 16 May 2020 07:22:48 +0800 (CST)
X-RM-TRANSID: 2ee75ebf2446435-09b10
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.0.101] (unknown[112.1.172.85])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35ebf244773b-96322;
        Sat, 16 May 2020 07:22:48 +0800 (CST)
X-RM-TRANSID: 2ee35ebf244773b-96322
Subject: Re: [PATCH][next] USB: EHCI: ehci-mv: fix less than zero comparisonof
 an unsigned int
To:     Alan Stern <stern@rowland.harvard.edu>,
        Colin King <colin.king@canonical.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
        linux-usb@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200515165453.104028-1-colin.king@canonical.com>
 <20200515172121.GA5498@rowland.harvard.edu>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <fec1e461-16f3-9d5f-bc23-129c71229b9d@cmss.chinamobile.com>
Date:   Sat, 16 May 2020 07:23:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200515172121.GA5498@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan & Colin：

On 2020/5/16 1:21, Alan Stern wrote:
> On Fri, May 15, 2020 at 05:54:53PM +0100, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The comparison of hcd->irq to less than zero for an error check will
>> never be true because hcd->irq is an unsigned int.  Fix this by
>> assigning the int retval to the return of platform_get_irq and checking
>> this for the -ve error condition and assigning hcd->irq to retval.
>>
>> Addresses-Coverity: ("Unsigned compared against 0")
>> Fixes: c856b4b0fdb5 ("USB: EHCI: ehci-mv: fix error handling in mv_ehci_probe()")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
> Thanks to Coverity for spotting this.  Any reason why it didn't spot
> exactly the same mistake in the ohci-da8xx.c driver?

I just looked at the code and wondered whether it would be more 
appropriate to modify the header file "hcd.h".  Since 'irq' might be an 
negative, why not just modify the variables in the 'struct usb_hcd',  
'unsigned int  irq'--> 'int irq'? After all, it's a public one.

Thanks,

Tang Bin

>
>


