Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE39C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EFAE207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390762AbgFYIjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 04:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389830AbgFYIjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 04:39:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA07C061573;
        Thu, 25 Jun 2020 01:39:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 3846A2A087F
Subject: Re: [PATCH 4/7] arm64: dts: mt8183: Fix unit name warnings
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, erwanaliasr1@gmail.com,
        drinkcat@chromium.org, hsinyi@chromium.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200619102757.1358675-1-enric.balletbo@collabora.com>
 <20200619102757.1358675-5-enric.balletbo@collabora.com>
 <ec4fb6c1-37a3-08b2-ae57-3e35868383ef@gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <c519de37-1377-9860-d831-0781c259cc0c@collabora.com>
Date:   Thu, 25 Jun 2020 10:39:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <ec4fb6c1-37a3-08b2-ae57-3e35868383ef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Thank you for you review.

On 22/6/20 12:14, Matthias Brugger wrote:
> 
> 
> On 19/06/2020 12:27, Enric Balletbo i Serra wrote:
>> Remove the unit address from the DT nodes that doesn't have a reg
>> property. This fixes the following unit name warnings:
>>
>>   Warning (unit_address_vs_reg): /cpus/idle-states/cluster-sleep@0: node has a unit name, but no reg or ranges property
>>   Warning (unit_address_vs_reg): /cpus/idle-states/cluster-sleep@1: node has a unit name, but no reg or ranges property
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> index 00137ec61164d..e356076749148 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
>> @@ -168,7 +168,7 @@ CPU_SLEEP: cpu-sleep {
>>  				min-residency-us = <800>;
>>  			};
>>  
>> -			CLUSTER_SLEEP0: cluster-sleep@0 {
>> +			CLUSTER_SLEEP0: cluster-sleep0 {
> 
> Should be:
> cluster-sleep-0
> 

Ack, I'll change in next version

>>  				compatible = "arm,idle-state";
>>  				local-timer-stop;
>>  				arm,psci-suspend-param = <0x01010001>;
>> @@ -176,7 +176,7 @@ CLUSTER_SLEEP0: cluster-sleep@0 {
>>  				exit-latency-us = <400>;
>>  				min-residency-us = <1000>;
>>  			};
>> -			CLUSTER_SLEEP1: cluster-sleep@1 {
>> +			CLUSTER_SLEEP1: cluster-sleep1 {
> 
> Same here.
> 

Ack.

> Regards,
> Matthias1
> 
>>  				compatible = "arm,idle-state";
>>  				local-timer-stop;
>>  				arm,psci-suspend-param = <0x01010001>;
>>
