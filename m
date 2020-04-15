Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B913C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E24820784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 01:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392560AbgDOB14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 21:27:56 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:4375 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387762AbgDOB1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 21:27:51 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25e9662ea362-5b5de; Wed, 15 Apr 2020 09:27:06 +0800 (CST)
X-RM-TRANSID: 2ee25e9662ea362-5b5de
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.21.224] (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5e9662e65fc-4303a;
        Wed, 15 Apr 2020 09:27:05 +0800 (CST)
X-RM-TRANSID: 2eea5e9662e65fc-4303a
Subject: Re: [PATCH] ipmi:bt-bmc: Delete superfluous dev_warm()
 inbt_bmc_config_irq()
To:     minyard@acm.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
References: <20200414141951.19120-1-tangbin@cmss.chinamobile.com>
 <20200414194455.GH3587@minyard.net>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <feb8858d-9778-dffb-8eb3-6a1efa24bb74@cmss.chinamobile.com>
Date:   Wed, 15 Apr 2020 09:28:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200414194455.GH3587@minyard.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Corey:

On 2020/4/15 3:44, Corey Minyard wrote:
> On Tue, Apr 14, 2020 at 10:19:51PM +0800, Tang Bin wrote:
>> The priority of dev_warm() is higher than dev_info(),so if the
>> function bt_bmc_probe() uses dev_info() to print error message,
>> the dev_warm() is redundant.Thus should be removed.
> Actually, this needs to be left in.  That error is not just a that irqs
> were not configured, that's an error that something else went wrong.

Oh ,It's my fault.

I had read the previous email with you again, and mistook it as that you 
agreed with my point of view. I feel humiliated now.

Thanks,

Tang Bin




