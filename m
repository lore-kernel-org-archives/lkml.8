Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA75C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39EC52076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:32:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HCXnERf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgGPXcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:32:43 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8508 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726337AbgGPXcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:32:42 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f10e35f0000>; Thu, 16 Jul 2020 16:31:43 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 16 Jul 2020 16:32:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 16 Jul 2020 16:32:42 -0700
Received: from [10.2.163.115] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Jul
 2020 23:32:41 +0000
Subject: Re: [PATCH v1 2/3] dt-bindings: media: imx274: Add optional xclk and
 supplies
To:     Luca Ceresoli <luca@lucaceresoli.net>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <frankc@nvidia.com>, <hverkuil@xs4all.nl>,
        <leonl@leopardimaging.com>, <robh+dt@kernel.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>
CC:     <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1594787096-26685-1-git-send-email-skomatineni@nvidia.com>
 <1594787096-26685-2-git-send-email-skomatineni@nvidia.com>
 <1df13fad-b5ce-3889-c240-3411e97598d2@lucaceresoli.net>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <ca9b3549-b39f-3110-671a-e856f4a7b2fa@nvidia.com>
Date:   Thu, 16 Jul 2020 16:35:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1df13fad-b5ce-3889-c240-3411e97598d2@lucaceresoli.net>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594942303; bh=8rkN9PIKLB59SMi7kKXMUgG6uZDZbV3+Fs2u5hpdvn4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=HCXnERf9E+rDQYx/GiVGq9zMh381sbqMKWS5iM+cFrNg7zeS1krCw2EhlvoirAQD6
         CVp/w+fJvTxiRNgRJ6biK8hm9orIdYPHNNsDbBOdUZJjmwgYTi85Uk+8FtsAx3R74V
         dSUPQ7S6p0CytUNGztEDXQg/UJb8dOlaOEqdEbjenhs4queB1x088eN3XttWRiSFHE
         pI7wGBhaCXMlN0Z1tV6GtIBko1NkVVtT0TUgS+xdHJXo9oBPsUL2gpqsocPJs6ruwa
         d9MoLoExreEsoK3Qew9A6VemEeYDPbQh1+3hHushCHMm0xcVZ8A7Bsg3GtIMN5m+qf
         k3J23Udywwkjw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/15/20 11:50 PM, Luca Ceresoli wrote:
> Hi Sowjanya,
>
> On 15/07/20 06:24, Sowjanya Komatineni wrote:
>> This patch adds IMX274 optional external clock input and voltage
>> supplies to device tree bindings.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   Documentation/devicetree/bindings/media/i2c/imx274.txt | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/media/i2c/imx274.txt b/Documentation/devicetree/bindings/media/i2c/imx274.txt
>> index 80f2e89..ee427f5 100644
>> --- a/Documentation/devicetree/bindings/media/i2c/imx274.txt
>> +++ b/Documentation/devicetree/bindings/media/i2c/imx274.txt
>> @@ -13,6 +13,11 @@ Required Properties:
>>   
>>   Optional Properties:
>>   - reset-gpios: Sensor reset GPIO
>> +- clocks: Reference to the xclk clock.
>> +- clock-names: Should be "xclk".
> Not sure where the "xclk" name comes from, the datasheet I have calls
> the pin "CKIN". Maybe using the same name as the datasheet is better?
>
> Other than that looks good.

Thanks Luca. Using xclk as its external clock to IMX274.

Datasheet uses it as INCK. Will update in v2 to use "INCK" as referred 
in its datasheet.

