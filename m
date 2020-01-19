Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E337C33CB7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 01:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A629206B7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 01:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fnarfbargle.com header.i=@fnarfbargle.com header.b="yXXRc9zh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgASB7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 20:59:21 -0500
Received: from ns3.fnarfbargle.com ([103.4.19.87]:35646 "EHLO
        ns3.fnarfbargle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgASB7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 20:59:21 -0500
Received: from [10.8.0.1] (helo=srv.home ident=heh27698)
        by ns3.fnarfbargle.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <lists2009@fnarfbargle.com>)
        id 1iszri-0001Dx-Ni; Sun, 19 Jan 2020 09:59:02 +0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fnarfbargle.com; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=IcoeF8ZKL8q7zcbyW8LQy/2+4jjbmV9Gw23mNx+sFLc=;
        b=yXXRc9zhAd80mR37sYLqbLcYyHF+k0MwgvB+aYykw+1rFlrJML8J2rq35QCInTFxofgRoCc/cLtqUPlLfMabLrX7f6X0I+WHDa0p5ke9vpI2mAs3lDxmjczs63nWDvtbL2+x96+u7eTDKDLZw0EutkIOl7MFGnskLOECvU/iGoU=;
Subject: Re: [RFT PATCH 0/4] hwmon: k10temp driver improvements
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Cc:     Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
References: <20200116141800.9828-1-linux@roeck-us.net>
 <492345ed-f82e-e4d9-20ac-924b4a00df90@fnarfbargle.com>
 <6bb6770d-cfb0-1209-6c8f-f89c5dc4fa7f@roeck-us.net>
From:   Brad Campbell <lists2009@fnarfbargle.com>
Message-ID: <3a6068a1-3504-26e0-d1e6-947eae287a29@fnarfbargle.com>
Date:   Sun, 19 Jan 2020 09:59:01 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6bb6770d-cfb0-1209-6c8f-f89c5dc4fa7f@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/1/20 1:14 am, Guenter Roeck wrote:
> On 1/18/20 12:52 AM, Brad Campbell wrote:
>> On 16/1/20 10:17 pm, Guenter Roeck wrote:
>>> This patch series implements various improvements for the k10temp 
>>> driver.
>>>
>>
>> Looks good here. Identical motherboards (ASUS x370 Prime-Pro), 
>> different CPUs.
>>
>> 3950x
>>
> Interesting. I thought the 3950X needs a newer motherboard. 

This board has the 3950x listed on the compatibility matrix, so I took 
the punt. I am running a beta BIOS with the 1.0.0.4 AGESA but it's 
running in a stock production environment and has been stable. I don't 
overclock or game, it's predominantly a VM host.

> Is that CPU as amazing as everyone says it is ? 

It is fairly impressive and a significant update over the 1800x it 
replaced. Kernel compiles are pretty quick :)

> And does it really need liquid cooling ?

No. I'm using a stock AMD Wraith Prism cooler in a 4U rack case.

It might reach higher boost clocks with better cooling, but under an 
all-core load I still see > 4.1GHz across all cores.

Regards,
Brad
