Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBADC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 07:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F2F21D91
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 07:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgDRHWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 03:22:20 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:3510 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgDRHWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 03:22:19 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee55e9aaa940fd-ab33e; Sat, 18 Apr 2020 15:21:57 +0800 (CST)
X-RM-TRANSID: 2ee55e9aaa940fd-ab33e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.0.105] (unknown[112.1.172.61])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85e9aaa9429f-6fef4;
        Sat, 18 Apr 2020 15:21:57 +0800 (CST)
X-RM-TRANSID: 2ee85e9aaa9429f-6fef4
Subject: Re: [PATCH 3/3] ipmi:bt-bmc: Fix error handling and status check
To:     minyard@acm.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20200414141423.4968-1-tangbin@cmss.chinamobile.com>
 <20200414201832.GJ3587@minyard.net>
 <f5a848ae-d19f-5ab6-7c7d-2d0811fc174b@cmss.chinamobile.com>
 <20200418021441.GC6246@minyard.net>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <ab537b68-3116-747a-0e68-bbc5b3540d83@cmss.chinamobile.com>
Date:   Sat, 18 Apr 2020 15:23:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200418021441.GC6246@minyard.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey:

On 2020/4/18 10:14, Corey Minyard wrote:
> Sorry for the delay, I have had a lot of distractions.

No no no,  it's greatly appreciated  for your instruction. Thanks.

>
> The trouble is that the handling of bt_bmc->irq needs to be consistent.
> Either it needs to be negative if the irq allocation fails, or it needs
> to be zero if the irq allocation fails.  I think it needs to be negative
> because zero is a valid interrupt in some cases.
>
> Consider the following code:
>
>         bt_bmc_config_irq(bt_bmc, pdev);
>
>          if (bt_bmc->irq) {
>                  dev_info(dev, "Using IRQ %d\n", bt_bmc->irq);
>          } else {
>                  dev_info(dev, "No IRQ; using timer\n");
>                  timer_setup(&bt_bmc->poll_timer, poll_timer, 0);
>
> If bt_bmc->irq is negative (if platform_get_irq_optional() fails), it
> will say it's using the irq and won't start a timer and the driver won't
> work.  Then later (in your change below) it will try to stop the timer
> even though it's not running.
>
> If devm_request_irq() fails, then the interrupt is not set, but since
> bt_bmc->irq is most likely not zero, it will not start the timer and the
> driver won't work.
>
> You really need to set bt_bmc->irq negative if it fails.  And fix the
> check above to be if (bt_bmc->irq >= 0).

Got it. You are right, I am lacking in consideration here.


Thank you very much, I will send the v2.

Tang Bin

>
>
>


