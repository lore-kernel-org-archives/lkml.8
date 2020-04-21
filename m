Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30628C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 130B52084D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgDUEpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 00:45:04 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:2389 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgDUEpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 00:45:04 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.17]) by rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea5e9e7a3dbe7-e3ee9; Tue, 21 Apr 2020 12:44:47 +0800 (CST)
X-RM-TRANSID: 2eea5e9e7a3dbe7-e3ee9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [172.20.146.166] (unknown[112.25.154.146])
        by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee95e9e7a33b85-2393b;
        Tue, 21 Apr 2020 12:44:46 +0800 (CST)
X-RM-TRANSID: 2ee95e9e7a33b85-2393b
Subject: Re: [PATCH] net: ethernet: ixp4xx: Add error handling
 inixp4xx_eth_probe()
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     khalasa@piap.pl, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
References: <20200412092728.8396-1-tangbin@cmss.chinamobile.com>
 <20200412113538.517669d9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <71697844-cc03-9206-1594-b8af02f38018@cmss.chinamobile.com>
Date:   Tue, 21 Apr 2020 12:46:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200412113538.517669d9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub:

On 2020/4/13 2:35, Jakub Kicinski wrote:
> On Sun, 12 Apr 2020 17:27:28 +0800 Tang Bin wrote:
>> The function ixp4xx_eth_probe() does not perform sufficient error
>> checking after executing devm_ioremap_resource(),which can result
>> in crashes if a critical error path is encountered.
>>
> Please provide an appropriate Fixes: tag.

Thanks for your reply.

I don't know whether the commit message affect this patch's result. If so,

I think the commit message in v2 needs more clarification. As follows:

     The function ixp4xx_eth_probe() does not perform sufficient error 
checking

after executing devm_ioremap_resource(), which can result in crashes if 
a critical

error path is encountered.

     Fixes: f458ac479777 ("ARM/net: ixp4xx: Pass ethernet physical base 
as resource").


I'm waiting for you reply actively.

Thanks,

Tang Bin



