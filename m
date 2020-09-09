Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD50C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 000472166E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u/+ts5j5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730991AbgIIQoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:44:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:50632 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730993AbgIIQnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:43:51 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 089FAAnU061479;
        Wed, 9 Sep 2020 10:10:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599664210;
        bh=y4ypjBJCmmVVWSAzOMpL0Yzjxk7jCoHxtQOFSri+Anw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=u/+ts5j5SpV+waYzgQySKVrYaTAvl6uBOp84sSfEcJAW//jpLjWcjzkvnMwA3Frda
         DcgUnu9/SR6ASEHDG8soaQr/EkhVrE5ai+thntuHL3iTqY/7r++fqS6qUx7nOGhlcq
         SPIlVSjWsVfaLxzELrbxRnvkTv2hHoKgNfcaYKp8=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 089FAAeT090290;
        Wed, 9 Sep 2020 10:10:10 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 9 Sep
 2020 10:10:09 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 9 Sep 2020 10:10:09 -0500
Received: from [10.250.34.59] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 089FA99W115484;
        Wed, 9 Sep 2020 10:10:09 -0500
Subject: Re: [v4,2/4] dt-binding: reset-controller: ti: add
 'mediatek,infra-reset' to compatible
To:     Rob Herring <robh@kernel.org>
CC:     Crystal Guo <crystal.guo@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
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
 <6c292056-1cb1-bc6c-0422-46e047dcf08f@ti.com>
 <CAL_JsqKuL7XM2CL3z0OQdRua5YJO2ZRdsoE3fdAH948mKGfWnA@mail.gmail.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <b91c4ddf-8f12-2154-0a41-bf9563b5aefd@ti.com>
Date:   Wed, 9 Sep 2020 10:10:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKuL7XM2CL3z0OQdRua5YJO2ZRdsoE3fdAH948mKGfWnA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 1:49 PM, Rob Herring wrote:
> On Wed, Sep 2, 2020 at 5:26 PM Suman Anna <s-anna@ti.com> wrote:
>>
>> Hi Rob,
>>
>> On 8/26/20 6:09 AM, Crystal Guo wrote:
>>> On Wed, 2020-08-26 at 03:02 +0800, Rob Herring wrote:
>>>> On Mon, Aug 17, 2020 at 11:03:22AM +0800, Crystal Guo wrote:
>>>>> The TI syscon reset controller provides a common reset management,
>>>>> and is suitable for MTK SoCs. Add compatible 'mediatek,infra-reset',
>>>>> which denotes to use ti reset-controller driver directly.
>>>>>
>>>>> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
>>>>> ---
>>>>>  Documentation/devicetree/bindings/reset/ti-syscon-reset.txt | 1 +
>>>>>  1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt b/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
>>>>> index ab041032339b..5a0e9365b51b 100644
>>>>> --- a/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
>>>>> +++ b/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
>>>>> @@ -25,6 +25,7 @@ Required properties:
>>>>>                         "ti,k2l-pscrst"
>>>>>                         "ti,k2hk-pscrst"
>>>>>                         "ti,syscon-reset"
>>>>> +                       "mediatek,infra-reset", "ti,syscon-reset"
>>>>
>>>> You need your own binding doc. If you can use the same driver then fine,
>>>> but that's a separate issue. There's also reset-simple driver if you
>>>> have just array of 32-bit registers with a bit per reset.
>>>>
>>>> Don't repeat 'ti,reset-bits' either.
>>>
>>> Do you mean I should add a Mediatek reset binding doc, although Mediatek
>>> reuse the TI reset controller directly?
>>
>> Hmm, how do you envision not repeating the same bits in a separate binding?
> 
> I mean 'ti,reset-bits' isn't really something that should have been in
> DT in the first place, but rather implied by the compatible string.

Ok, should I be deprecating this and move this data to driver then?

I am assuming that is how you are envisioning the new Mediatek binding to be
atleast.

regards
Suman

> 
>> Does it help if I convert this to YAML first without a ti, prefix in the file name?
> 
> No, I don't think this should be a shared binding. The driver may be
> able to be shared, but that's independent from the binding.
> 
> Rob
> 

