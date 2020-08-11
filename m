Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DF7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07EFC206DC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="MJIb+yGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgHKBSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 21:18:46 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5773 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgHKBSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:18:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f31f18c0000>; Mon, 10 Aug 2020 18:17:00 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 10 Aug 2020 18:18:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 10 Aug 2020 18:18:45 -0700
Received: from [10.19.100.79] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Aug
 2020 01:18:37 +0000
Subject: Re: [PATCH] usb: gadget: tegra-xudc: Avoid GFP_ATOMIC where it is not
 needed
To:     Thierry Reding <thierry.reding@gmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Nagarjuna Kristam <nkristam@nvidia.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <jonathanh@nvidia.com>, <yuehaibing@huawei.com>,
        <heikki.krogerus@linux.intel.com>, <linux-usb@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20200809072948.743269-1-christophe.jaillet@wanadoo.fr>
 <20200810140035.GA808811@ulmo>
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <f29c7d35-72a9-b8d1-98dc-427c6fa3cc31@nvidia.com>
Date:   Tue, 11 Aug 2020 09:18:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810140035.GA808811@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597108620; bh=oNvf5Jr6+BIXlO9OnHSXX/LgXK2peo1IqhoZRRSw3uw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=MJIb+yGcZqL5KRNXFTviF0T3MMTcSFWeHLGYCF7gG+1oFfuK4SFV+Re8MWBthmMwp
         ystfAnCzyrMDes6lCY8J6lKtOkVwph79o5HvjbUbjIP+QDYByA/Yy4imfKncySSW2b
         9LG156rCoTe+jAE9H5PKazoXadJd3WAd6oPHL8O3p9inHe7m1uOY1lqLEbx6vu1uX9
         bVylzomZ2eqVe6MqQasDT8y2CaJF+S34NSAtxlJuyLfSwxEhrXS5jliaYftVENy5S9
         D/2O5oYekoOPWSJITVbdQsPZW7fCi22hg2y0w+sF/CJLSd4vLQQNay1vJFWDJcOTHL
         5eeCOTpRRjt1w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.

Reviewed-by: JC Kuo <jckuo@nvidia.com>

On 8/10/20 10:00 PM, Thierry Reding wrote:
> On Sun, Aug 09, 2020 at 09:29:48AM +0200, Christophe JAILLET wrote:
>> There is no need to use GFP_ATOMIC here. It is a probe function, no
>> spinlock is taken.
>>
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>>  drivers/usb/gadget/udc/tegra-xudc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> Looks good to me. I can't think of any reason why this would have to be
> an atomic allocation. Nagarjuna, please shout if this is really needed,
> otherwise:
>
> Acked-by: Thierry Reding <treding@nvidia.com>

