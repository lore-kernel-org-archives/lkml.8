Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6FEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB09E207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgESXVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 19:21:13 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:46225 "EHLO
        cmccmta1.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgESXVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 19:21:12 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.15]) by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee35ec469d7797-56eb0; Wed, 20 May 2020 07:20:57 +0800 (CST)
X-RM-TRANSID: 2ee35ec469d7797-56eb0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.0.104] (unknown[112.3.208.171])
        by rmsmtp-syy-appsvr08-12008 (RichMail) with SMTP id 2ee85ec469d7770-24acd;
        Wed, 20 May 2020 07:20:56 +0800 (CST)
X-RM-TRANSID: 2ee85ec469d7770-24acd
Subject: Re: [PATCH] net/amd: Remove the extra blank lines
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200519111529.12016-1-tangbin@cmss.chinamobile.com>
 <20200519.154202.2088276192882746951.davem@davemloft.net>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <82c34fac-b62d-0317-535e-6e0bc37fa1ac@cmss.chinamobile.com>
Date:   Wed, 20 May 2020 07:21:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519.154202.2088276192882746951.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David:

On 2020/5/20 6:42, David Miller wrote:
> Please put these patches into a proper, numbered, patch series with
> an appropriate header posting.
Whether you mean the patches should be like this: [PATCH 0/5].........?
>
> Some of these patches do not apply cleanly to the net-next tree, which
> is where these changes should be targetted.  Please respin.

Can you tell me which one is useless, I will drop and not put it in the 
patches set.

Thanks,

Tang Bin



