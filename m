Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2B5C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B407206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgEEM7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 08:59:50 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:43218 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgEEM7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:59:49 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35eb16318e0e-0d2cf; Tue, 05 May 2020 20:59:08 +0800 (CST)
X-RM-TRANSID: 2ee35eb16318e0e-0d2cf
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.0.102] (unknown[112.3.208.122])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95eb1631bfc1-6b8d7;
        Tue, 05 May 2020 20:59:07 +0800 (CST)
X-RM-TRANSID: 2ee95eb1631bfc1-6b8d7
Subject: Re: [PATCH v3] ipmi:bt-bmc: Fix error handling and status check
To:     minyard@acm.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
References: <20200505102906.17196-1-tangbin@cmss.chinamobile.com>
 <20200505114907.GK9902@minyard.net>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <3610b0fb-25f5-1bf9-a3c1-1c7ca113a9c8@cmss.chinamobile.com>
Date:   Tue, 5 May 2020 20:59:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505114907.GK9902@minyard.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Corey:

On 2020/5/5 19:49, Corey Minyard wrote:
> On Tue, May 05, 2020 at 06:29:06PM +0800, Tang Bin wrote:
>> If the function platform_get_irq() failed, the negative value
>> returned will not be detected here. So fix error handling in
>> bt_bmc_config_irq(). And in the function bt_bmc_probe(),
>> when get irq failed, it will print error message. So use
>> platform_get_irq_optional() to simplify code. Finally in the
>> function bt_bmc_remove() should make the right status check
>> if get irq failed.
> Ok, this is included in my tree.

I just want to say: thank you very much.

After many days of communication with you, I have learned a lot, your 
patient teaching has inspired me a lot. It's my pleasure to meet you.

Thanks,

Tang Bin

>


