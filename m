Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D06C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0A1E2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730610AbgDMPnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:43:17 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:8074 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbgDMPnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:43:16 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.1]) by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee85e9488800f3-3c2e1; Mon, 13 Apr 2020 23:42:57 +0800 (CST)
X-RM-TRANSID: 2ee85e9488800f3-3c2e1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.0.102] (unknown[112.1.172.56])
        by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee15e948880e98-3d466;
        Mon, 13 Apr 2020 23:42:57 +0800 (CST)
X-RM-TRANSID: 2ee15e948880e98-3d466
Subject: Re: [PATCH v3]ipmi:bt-bmc:Avoid unnecessary judgement
To:     minyard@acm.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20200408115958.2848-1-tangbin@cmss.chinamobile.com>
 <20200413113225.GB3587@minyard.net>
 <47c06465-9ae5-42c2-ca00-5c666521bbde@cmss.chinamobile.com>
 <20200413142348.GD3587@minyard.net>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <3894dab2-0660-999c-6f4c-4b5b9ff57773@cmss.chinamobile.com>
Date:   Mon, 13 Apr 2020 23:44:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200413142348.GD3587@minyard.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey:

On 2020/4/13 22:23, Corey Minyard wrote:
>> Can I consider that the patch will be applied in 5.8？
> It's in my queue, so that's the plan.
>
>>>    I
>>> changed the title to be "Avoid unnecessary check".
>> You have modified it, which means I don't need to submit a new patch？
> Correct.

Thank you very much, I am waiting for the applied.


Then, I have some questions to ask you:

     I have checked the file bt-bmc.c carefully, and found that there 
are another two problems.Please help me analyze them, if you think it is 
feasible, then I will submit the patch.

     Q1: About Format Problem

            In the 469~471 line, the first letter should be indented, 
please check if the writing here is reasonable?


     Q2: About the function bt_bmc_config_irq()

           1）In the function bt_bmc_probe(), the return value of 
bt_bmc_config_irq() made no judgement, whether it is suitable? （If your 
view is don't need to judge, the following will change.）


           2）According to the kernel interface of platform_get_irq(),the 
return value is negative,

                    if (!bt_bmc->irq)
                         return -ENODEV;

                so the check here is invalid.The standard way to write is:

                      if (bt_bmc->irq < 0)
                           return bt_bmc->irq;

                But consider if failed, "bt_bmc->irq" must be assigned 
to "0"，the easiest way is to delete the        403~404 line, handled 
directly by the function devm_request_irq().


         Q3：About dev_warm()

                 KERN_WARNING is higher than KERN_INFO, the same to 
dev_warn() and dev_info(). When the function bt_bmc_probe() uses 
dev_info() to print error message, the dev_warm() in the line of 409 
should be redundant.


I am waiting for your replay, and thank you for your guidance.

Tang Bin



