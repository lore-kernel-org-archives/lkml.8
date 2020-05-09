Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B77C54E49
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 20:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A3EF21473
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 20:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgEIUcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 16:32:08 -0400
Received: from smtp13.smtpout.orange.fr ([80.12.242.135]:57360 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725960AbgEIUcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 16:32:08 -0400
Received: from [192.168.42.210] ([93.23.15.202])
        by mwinf5d70 with ME
        id ckXz220064MaNxZ03kXzm4; Sat, 09 May 2020 22:32:06 +0200
X-ME-Helo: [192.168.42.210]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 09 May 2020 22:32:06 +0200
X-ME-IP: 93.23.15.202
Subject: Re: [PATCH] net/sonic: Fix some resource leaks in error handling
 paths
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, fthain@telegraphics.com.au,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20200508172557.218132-1-christophe.jaillet@wanadoo.fr>
 <20200508185402.41d9d068@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <50ef36cd-d095-9abe-26ea-d363d11ce521@wanadoo.fr>
 <20200509111321.51419b19@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Message-ID: <9f7ed642-c464-feec-2dfd-13333621492f@wanadoo.fr>
Date:   Sat, 9 May 2020 22:31:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200509111321.51419b19@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/05/2020 à 20:13, Jakub Kicinski a écrit :
> On Sat, 9 May 2020 18:47:08 +0200 Christophe JAILLET wrote:
>> Le 09/05/2020 à 03:54, Jakub Kicinski a écrit :
>>> On Fri,  8 May 2020 19:25:57 +0200 Christophe JAILLET wrote:
>>>> @@ -527,8 +531,9 @@ static int mac_sonic_platform_remove(struct platform_device *pdev)
>>>>    	struct sonic_local* lp = netdev_priv(dev);
>>>>    
>>>>    	unregister_netdev(dev);
>>>> -	dma_free_coherent(lp->device, SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
>>>> -	                  lp->descriptors, lp->descriptors_laddr);
>>>> +	dma_free_coherent(lp->device,
>>>> +			  SIZEOF_SONIC_DESC * SONIC_BUS_SCALE(lp->dma_bitmode),
>>>> +			  lp->descriptors, lp->descriptors_laddr);
>>>>    	free_netdev(dev);
>>>>    
>>>>    	return 0;
>>> This is a white-space only change, right? Since this is a fix we should
>>> avoid making cleanups which are not strictly necessary.
>> Right.
>>
>> The reason of this clean-up is that I wanted to avoid a checkpatch
>> warning with the proposed patch and I felt that having the same layout
>> in the error handling path of the probe function and in the remove
>> function was clearer.
>> So I updated also the remove function.
> I understand the motivation is good.
>
>> Fell free to ignore this hunk if not desired. I will not sent a V2 only
>> for that.
> That's not how it works. Busy maintainers don't have time to hand edit
> patches. I'm not applying this to the networking tree and I'm tossing it
> from patchwork. Please address the basic feedback.
>
> Thank you.
>
Hi,

that's not the way you would like it to work.
It happens that some maintainers make some small adjustments in the 
commit message or the patch itself.

The patch is good enough for me. If you can not accept the additional 
small clean-up, or don't have time to tweak it by yourself, or by anyone 
else, please, just reject it.
The issue I propose to fix is minor and unlikely to happen anyway.

If anyone else cares to update the proposal, please do.


I don't want to discuss your motivation, I understand them.

But please, do also understand mine and do not require too futile things 
from hobbyists.

Spending time only to remove a CR because it does not match your quality 
standard or your expectation of what a patch is, is of no interest for me.
That's why I told I would not send a V2.


It is up to you to accept it as-is, update it or reject it, according to 
the value you think this patch has.

Hoping for your understanding and sorry for wasting your time.

Best regards,
CJ

