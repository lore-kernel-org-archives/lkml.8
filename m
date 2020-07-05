Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83287C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 23:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A0B206E2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 23:05:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=castello.eng.br header.i=@castello.eng.br header.b="oD9PdhP4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgGEXEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 19:04:09 -0400
Received: from gateway33.websitewelcome.com ([192.185.145.239]:37716 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727894AbgGEXEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 19:04:09 -0400
X-Greylist: delayed 1316 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Jul 2020 19:04:08 EDT
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id C39F96FD94
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 17:42:10 -0500 (CDT)
Received: from br164.hostgator.com.br ([192.185.176.180])
        by cmsmtp with SMTP
        id sDKsj6oGuBb5dsDKsjC8GZ; Sun, 05 Jul 2020 17:42:10 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=castello.eng.br; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WH9xGcE98lBPtINc6g51Vn8ZOXiCuySEHOPSXvbspoE=; b=oD9PdhP4YiLCbHKYjIrZJqLv3N
        yj4GbnjnqcfNtkKwzitFufj22iQ0fISg2nzU2EIcRSn+ZkYaeWk6hgvQdj/GZgyevcfNGL7G89EPJ
        7OHdgXZ42Uji6NPbp3ij5VPZw8FwwPpTk9Z7KfNXvKNpSj2wP8VAgzDALpO4Ga8tBor5qXpVDBpb/
        tdzzjLoT6Hr33JPAVCJ7wnnHIJHGGciPg37EakNM6ZJcd+WkgnvJ4CKEXn9UIGkn6sfGCiIXRo6Du
        a++elEIy+8MmALVaBw6JaEt6C4gINfhwbG52kt1Oe+Dd3YV6YKUFgqM9ttbXyi5YEJiTauXHFgv3o
        lCI/vKhQ==;
Received: from [189.59.31.158] (port=57190 helo=[192.168.15.5])
        by br164.hostgator.com.br with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <matheus@castello.eng.br>)
        id 1jsDKs-000TzD-D1; Sun, 05 Jul 2020 19:42:10 -0300
Subject: Re: [PATCH v1] arm64: dts: actions: Fix smp Bringing up secondary
 CPUs
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Cc:     manivannan.sadhasivam@linaro.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org
References: <20200705191944.404933-1-matheus@castello.eng.br>
 <60c25ef8-761d-9108-a8b1-ea15678c496c@suse.de>
From:   Matheus Castello <matheus@castello.eng.br>
Message-ID: <24c87b5b-d378-bcfa-d557-0dcba5199c1b@castello.eng.br>
Date:   Sun, 5 Jul 2020 19:42:06 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <60c25ef8-761d-9108-a8b1-ea15678c496c@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: pt-BR
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 189.59.31.158
X-Source-L: No
X-Exim-ID: 1jsDKs-000TzD-D1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [189.59.31.158]:57190
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 7
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

Em 7/5/20 7:09 PM, Andreas Färber escreveu:
> Hi Matheus,
> 
> Am 05.07.20 um 21:19 schrieb Matheus Castello:
>> Change the enable-method to fix the failed to boot errors:
>>
>> [    0.040330] smp: Bringing up secondary CPUs ...
>> [    0.040683] psci: failed to boot CPU1 (-22)
>> [    0.040691] CPU1: failed to boot: -22
>> [    0.041062] psci: failed to boot CPU2 (-22)
>> [    0.041071] CPU2: failed to boot: -22
>> [    0.041408] psci: failed to boot CPU3 (-22)
>> [    0.041417] CPU3: failed to boot: -22
>> [    0.041443] smp: Brought up 1 node, 1 CPU
>> [    0.041451] SMP: Total of 1 processors activated.
>>
>> Tested on Caninos Labrador v3 based on Actions Semi S700.
>>
>> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
>> ---
>>   arch/arm64/boot/dts/actions/s700.dtsi | 33 +++++++++++++++++++--------
>>   1 file changed, 23 insertions(+), 10 deletions(-)
> 
> NACK.
> 
> For starters, if this were an actual fix, it should have a Fixes header.
> 
> Don't do random changes in a single patch and call it a "fix". I don't 
> see what changing the cell size has to do with smp, nor adding L2 cache. 
> The latter could be a patch of its own, after fixes are applied (to 
> avoid conflicts when backporting that fix to older branches). A cell 
> size of two used to be perfectly valid, please checking the DT binding.
>  > Finally, you're changing generic S700 code here - you can't just break
> Cubieboard7 just because your Labrador has too old BL31 firmware. Can't 

Sorry for that, got it.

> you just update its TF-A firmware and use the standard PSCI interface 
> for Linux? If not, then you should add your workaround to your 
> module's/board's .dts(i) instead of the SoC's .dtsi.
> 

Yes, the vendor does not seem to support this for now. I think for now 
the best thing to do is to leave the workaround on the module's .dtsi.
Thank you for the tips.

> Thanks,
> Andreas
> 

BR,
Matheus Castello
