Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE07C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EE4E20735
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgEDHna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 03:43:30 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:5143 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgEDHn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 03:43:29 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.7]) by rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec5eafc78e469-fd873; Mon, 04 May 2020 15:43:10 +0800 (CST)
X-RM-TRANSID: 2eec5eafc78e469-fd873
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.0.104] (unknown[112.3.182.180])
        by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee45eafc78d502-c2b00;
        Mon, 04 May 2020 15:43:10 +0800 (CST)
X-RM-TRANSID: 2ee45eafc78d502-c2b00
Subject: Re: [PATCH v2] ipmi:bt-bmc: Fix error handling and status check
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     minyard@acm.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20200418080228.19028-1-tangbin@cmss.chinamobile.com>
 <20200418134909.GF6246@minyard.net>
 <cc048630-831d-9765-7f7a-7eaacd3a8199@cmss.chinamobile.com>
Message-ID: <45cddef3-eb69-bcff-3b0f-0d7f8e69f0a4@cmss.chinamobile.com>
Date:   Mon, 4 May 2020 15:43:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cc048630-831d-9765-7f7a-7eaacd3a8199@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Corey:

On 2020/4/19 14:29, Tang Bin wrote:
> Hi, Corey:
>
> On 2020/4/18 21:49, Corey Minyard wrote:
>> On Sat, Apr 18, 2020 at 04:02:29PM +0800, Tang Bin wrote:
>>> If the function platform_get_irq() failed, the negative
>>> value returned will not be detected here. So fix error
>>> handling in bt_bmc_config_irq(). And if devm_request_irq()
>>> failed, 'bt_bmc->irq' is assigned to zero maybe redundant,
>>> it may be more suitable for using the correct negative values
>>> to make the status check in the function bt_bmc_remove().
>> You need to mention changing platform_get_irq to
>> platform_get_irq_optional in the header.
>>
>> Another comment inline below.
>>
>> Otherwise, this looks good.
>
> Got it. The v3 will be as follows：
>
> If the function platform_get_irq() failed, the negative value
>
> returned will not be detected here. So fix error handling in
>
> bt_bmc_config_irq(). And in the function bt_bmc_probe(),
>
> when get irq failed, it will print error message. So use
>
> platform_get_irq_optional() to simplify code. Finally in the
>
> function bt_bmc_remove() should make the right status
>
> check if get irq failed.
>
>>
>> You need to set this to rc.  Otherwise it will remain the interrupt
>> number assigned by platform_get_irq_optional().
>
> Yes, I think you are right. I'm not as considerate as you. Thank you 
> for your instruction.
>
> When get irq failed, the 'bt_bmc->irq' is negative; when request irq 
> failed, the 'bt_bmc->irq = 0' is right.
>
> So 'bt_bmc->irq <= 0' means irq failed.
>
> Now let me rearrange the logic here:
>
>     In bt_bmc_probe():
>
>         bt_bmc_config_irq(bt_bmc, pdev);
>
>         if (bt_bmc->irq > 0) {
>
>         }
>
>
>     In bt_bmc_remove():
>
>         if (bt_bmc->irq <= 0)
>             del_timer_sync(&bt_bmc->poll_timer);
>
>
> If you think this logic is correct, I'll submit v3.
>
>
>
I know you're very busy, and you have handed me a lot before, so I 
should wait for your reply.

But I don't know whether my above logic is correct, so I take the 
liberty to write this email to you. I just wanted to say sorry for 
disturbing you.

Thanks,

Tang Bin








