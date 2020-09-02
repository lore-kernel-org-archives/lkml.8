Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0277AC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07AC20758
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 23:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yGg2rh9P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgIBX0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 19:26:20 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:37782 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgIBX0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 19:26:16 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 082NQ0C5022347;
        Wed, 2 Sep 2020 18:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599089160;
        bh=HlAs1wgxV8DXY4mBeHgZx/mwNEWUVkjB7NzPw810ZHI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=yGg2rh9Pr23KfE3TOCb4MWQLWIBp6pJrxqWekCjjbl1sjaH6TbLojmkRDEzaJke4e
         gxtcr5dsqEIWpvE8TnJDMdGgbdrSpFJPtY+KkvMuPT00ioz0BfBMBAZnVl5TEeyNDi
         AS4VlsadUXUYBbFC1lXZLpDy1cuw5Yxv1ImoR/rM=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 082NQ0Pm062378
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Sep 2020 18:26:00 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 2 Sep
 2020 18:25:59 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 2 Sep 2020 18:25:59 -0500
Received: from [10.250.34.112] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 082NPwxZ121283;
        Wed, 2 Sep 2020 18:25:59 -0500
Subject: Re: [v4,2/4] dt-binding: reset-controller: ti: add
 'mediatek,infra-reset' to compatible
To:     Crystal Guo <crystal.guo@mediatek.com>,
        Rob Herring <robh@kernel.org>
CC:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?= 
        <seiya.wang@mediatek.com>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?UTF-8?B?WWluZ2pvZSBDaGVuICjpmbPoi7HmtLIp?= 
        <Yingjoe.Chen@mediatek.com>,
        =?UTF-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>,
        =?UTF-8?B?WW9uZyBMaWFuZyAo5qKB5YuHKQ==?= <Yong.Liang@mediatek.com>
References: <20200817030324.5690-1-crystal.guo@mediatek.com>
 <20200817030324.5690-3-crystal.guo@mediatek.com>
 <20200825190219.GA1125997@bogus> <1598440183.30048.14.camel@mhfsdcap03>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <6c292056-1cb1-bc6c-0422-46e047dcf08f@ti.com>
Date:   Wed, 2 Sep 2020 18:25:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1598440183.30048.14.camel@mhfsdcap03>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 8/26/20 6:09 AM, Crystal Guo wrote:
> On Wed, 2020-08-26 at 03:02 +0800, Rob Herring wrote:
>> On Mon, Aug 17, 2020 at 11:03:22AM +0800, Crystal Guo wrote:
>>> The TI syscon reset controller provides a common reset management,
>>> and is suitable for MTK SoCs. Add compatible 'mediatek,infra-reset',
>>> which denotes to use ti reset-controller driver directly.
>>>
>>> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
>>> ---
>>>  Documentation/devicetree/bindings/reset/ti-syscon-reset.txt | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt b/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
>>> index ab041032339b..5a0e9365b51b 100644
>>> --- a/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
>>> +++ b/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
>>> @@ -25,6 +25,7 @@ Required properties:
>>>  			    "ti,k2l-pscrst"
>>>  			    "ti,k2hk-pscrst"
>>>  			    "ti,syscon-reset"
>>> +			    "mediatek,infra-reset", "ti,syscon-reset"
>>
>> You need your own binding doc. If you can use the same driver then fine, 
>> but that's a separate issue. There's also reset-simple driver if you 
>> have just array of 32-bit registers with a bit per reset.
>>
>> Don't repeat 'ti,reset-bits' either.
> 
> Do you mean I should add a Mediatek reset binding doc, although Mediatek
> reuse the TI reset controller directly?

Hmm, how do you envision not repeating the same bits in a separate binding?
Does it help if I convert this to YAML first without a ti, prefix in the file name?

The usage philosophy definitely was to use a <soc-compatible> followed by the
<generic-compatible>. This is how all of our reset nodes were added as well.

Looks like Andrew may have misinterpreted your comment [1] during the original
binding and changed "syscon-reset" to "ti,syscon-reset" in the final version [2].

regards
Suman

[1] https://lore.kernel.org/patchwork/comment/876688/
[2] https://lore.kernel.org/patchwork/patch/693172/

> 
> Best Regards
> Crystal
>>
>>>   - #reset-cells		: Should be 1. Please see the reset consumer node below
>>>  			  for usage details
>>>   - ti,reset-bits	: Contains the reset control register information
>>> -- 
>>> 2.18.0
> 

