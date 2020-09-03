Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597F0C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 05:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3480120716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 05:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nCwvJHb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgICFZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 01:25:23 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38180 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgICFZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 01:25:21 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0835PGpK106044;
        Thu, 3 Sep 2020 00:25:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599110716;
        bh=gBdMuSqpoJW5+xK4b3xBor8GR+5z9HkxD1LroMmwd0o=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nCwvJHb4cTIgz0czU5mwtGvPzqf1BZmnb1+bCRwz7FDsyvkjnwBvq9ktjxwy0g0jA
         ftWz4SrnKDvDDodTw8/luxIb45MNHjMTfmigipDi0H7LElAFpxyR46Ay1I5Ocy7QNI
         54sTyMrVhG7QeSmhlH0JR8V6yH3DjxT1uqo0GO0s=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0835PGM4080260;
        Thu, 3 Sep 2020 00:25:16 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 3 Sep
 2020 00:25:14 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 3 Sep 2020 00:25:15 -0500
Received: from [10.250.235.166] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0835PBC9061764;
        Thu, 3 Sep 2020 00:25:12 -0500
Subject: Re: [PATCH 6/7] arm64: dts: ti: k3-*: Use generic adc for node names
To:     Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <lokeshvutla@ti.com>,
        <grygorii.strashko@ti.com>, <nsekhar@ti.com>
References: <20200901223059.14801-1-nm@ti.com>
 <20200901223059.14801-7-nm@ti.com>
 <60e6b790-360a-6eaf-03a3-5bb256adf215@ti.com>
 <20200902181820.nlvl3pfzeh4agzzi@akan>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <9fb2f8f4-5eeb-6190-9cbf-b28084c58a8f@ti.com>
Date:   Thu, 3 Sep 2020 10:55:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902181820.nlvl3pfzeh4agzzi@akan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 9/2/20 11:48 PM, Nishanth Menon wrote:
> On 11:51-20200902, Suman Anna wrote:
>> On 9/1/20 5:30 PM, Nishanth Menon wrote:
>>> Use adc@ naming for nodes following standard conventions of device
>>> tree (section 2.2.2 Generic Names recommendation in [1]).
>>>
>>> [1] https://github.com/devicetree-org/devicetree-specification/tree/v0.3
>>>
>>> Suggested-by: Suman Anna <s-anna@ti.com>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> ---
>>>  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi         | 4 ++--
>>>  arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi | 4 ++--
>>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
>>> index 51ca4b4d4c21..6dfec68ac865 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
>>> @@ -80,7 +80,7 @@
>>>  		#size-cells = <0>;
>>>  	};
>>>  
>>> -	tscadc0: tscadc@40200000 {
>>> +	tscadc0: adc@40200000 {
>>
>> OK with these changes, since these seem to be only have the adc child nodes.
>> This node is essentially a parent node for touchscreen and adc child nodes. The
>> driver is currently looking for "tsc" on touchscreen child nodes, but none of
>> the K3 SoCs have them atm.
>>
> 
> 
> Vignesh: are you ok with this, care to comment?
> 

On K3 SoCs, ADC IP is reuse from AM335x but just lacks resistive
touchscreen interfaces. So, existing AM335x ADC driver is being reused
for K3 devices as well. Unfortunately, ADC driver cannot be used as
standalone and is dependent on MFD parent to be present...
Above node represents the MFD parent and ADC itself is the child node
(see arch/arm64/boot/dts/ti/k3-am654-base-board.dts). So, I recommend
that we keep this node's name as tscadc in order to avoid having same
name for parent and child node which will be quite confusing.

Regards
Vignesh
