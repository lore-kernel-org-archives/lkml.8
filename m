Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959B0C55189
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 01:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C3252084D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 01:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgDWBsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 21:48:01 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:8078 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgDWBsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 21:48:01 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee85ea0f3c1dcb-100bb; Thu, 23 Apr 2020 09:47:46 +0800 (CST)
X-RM-TRANSID: 2ee85ea0f3c1dcb-100bb
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.144.8] (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95ea0f3c0372-2da74;
        Thu, 23 Apr 2020 09:47:46 +0800 (CST)
X-RM-TRANSID: 2ee95ea0f3c0372-2da74
Subject: Re: [PATCH v2] net: ethernet: ixp4xx: Add error handling
 inixp4xx_eth_probe()
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     khalasa@piap.pl, davem@davemloft.net, linus.walleij@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200422010922.17728-1-tangbin@cmss.chinamobile.com>
 <20200422172149.787fdc3c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <348c8e5a-8328-3a14-03a4-c25a67f53c34@cmss.chinamobile.com>
Date:   Thu, 23 Apr 2020 09:49:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200422172149.787fdc3c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jackub:

On 2020/4/23 8:21, Jakub Kicinski wrote:
> On Wed, 22 Apr 2020 09:09:22 +0800 Tang Bin wrote:
>> The function ixp4xx_eth_probe() does not perform sufficient error
>> checking after executing devm_ioremap_resource(), which can result
>> in crashes if a critical error path is encountered.
>>
>> Fixes: f458ac479777 ("ARM/net: ixp4xx: Pass ethernet physical base as resource")
>>
> No extra lines, between the tags, though, please.

Got it, thanks for your guidance, I'll fix it and send v3 for you.

Thanks,

Tang Bin

>
>> Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
>> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>


