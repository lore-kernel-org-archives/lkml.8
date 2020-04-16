Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D6DC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40CFD2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504302AbgDPJ5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:57:07 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:47500 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504285AbgDPJ5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:57:05 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65e982ba37b9-8383c; Thu, 16 Apr 2020 17:55:48 +0800 (CST)
X-RM-TRANSID: 2ee65e982ba37b9-8383c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.145.111] (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5e982ba3927-444bb;
        Thu, 16 Apr 2020 17:55:47 +0800 (CST)
X-RM-TRANSID: 2eea5e982ba3927-444bb
Subject: Re: [PATCH] mfd:asic3:Delete redundant variable definition
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200403042020.17452-1-tangbin@cmss.chinamobile.com>
 <20200416070802.GQ2167633@dell>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <211e7521-639d-804c-f332-bfed0cf315df@cmss.chinamobile.com>
Date:   Thu, 16 Apr 2020 17:57:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416070802.GQ2167633@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Lee:

On 2020/4/16 15:08, Lee Jones wrote:
> On Fri, 03 Apr 2020, Tang Bin wrote:
>
>> In this function, 'ret' is always assigned, even if 'pdata->leds'
>> don't carry out,it has already been assigned a value in the above
>> code, including '0',so it's redundant.
> Which line initialises/assigns 'ret' before this one?

     I think it maybe my fault before, because I treat get resource and 
irq succeed. But now I have two questions  to ask you:

     Q1: About asic3_mfd_probe()?

           In the function asic3_mfd_probe(), if get resource or irq 
failed, the value returned just detected and dev_dbg() error message, 
but there were no error return. What I think the modify should be as 
follows:

     mem_sdio = platform_get_resource(pdev, IORESOURCE_MEM, 1);
     if (!mem_sdio) {
         dev_dbg(asic->dev, "no SDIO MEM resource\n");
         ret = -EINVAL;
         goto out;
     }

     irq = platform_get_irq(pdev, 1);
     if (irq < 0) {
         dev_dbg(asic->dev, "no SDIO IRQ resource\n");
         ret = irq;
         goto out;
     }

     If the function do like this, the 'ret = 0' in line 993 maybe 
redundant.


    Q2: About asic3_probe()?

           In the line 995, if the function asic3_irq_probe() failed, it 
will print error message by the internally called function 
platform_get_irq(), so the dev_err() in the line 997 is redundant, 
should be delete.


     I'll wait actively, and submit the corresponding patch according to 
your reply.


Thanks,

Tang Bin




