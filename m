Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC56C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84703208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UJE/6zWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgIKPva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:51:30 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43242 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgIKPvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:51:12 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08BEiH8S080691;
        Fri, 11 Sep 2020 09:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599835457;
        bh=VeiJJJ5bDbdPOe8X83iD+SDZUH01GPEKBkwwWMTRjgc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=UJE/6zWtsV+dKAnUUe1kgx4juYG0EdbHLsIxlqQHR/qXPSPaff8coqPtO9DENjKvM
         KXBa1Phfd6Bxzs7qBKxWzdfy+oP+0y6GsXXNC9F6nlBk7gsAOEndpke4lriNBhn9v6
         AraTG/qSLZARBudKKUIAalacflPPOiQ7+mqZ5TgM=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08BEiH7P001244
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Sep 2020 09:44:17 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 11
 Sep 2020 09:44:16 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 11 Sep 2020 09:44:16 -0500
Received: from [10.250.66.146] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08BEiEGY111883;
        Fri, 11 Sep 2020 09:44:15 -0500
Subject: Re: [v4,3/4] reset-controller: ti: introduce a new reset handler
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Crystal Guo <crystal.guo@mediatek.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
 <20200817030324.5690-4-crystal.guo@mediatek.com>
 <3a5decee-5f31-e27d-a120-1f835241a87c@ti.com>
 <1599620279.14806.18.camel@mhfsdcap03>
 <096362e9-dee8-4e7a-2518-47328068c2fd@ti.com>
 <1599792140.14806.22.camel@mhfsdcap03>
 <9d72aaef-49fe-ebb6-215d-05ad3ab27af4@ti.com>
 <1599804422.14806.27.camel@mhfsdcap03>
 <dae4ab91ec20e72963f2658efca4874a35dd739e.camel@pengutronix.de>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <407863ba-e336-11fc-297d-f1be1f58adaa@ti.com>
Date:   Fri, 11 Sep 2020 09:44:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <dae4ab91ec20e72963f2658efca4874a35dd739e.camel@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/20 9:26 AM, Philipp Zabel wrote:
> Hi Crystal,
> 
> On Fri, 2020-09-11 at 14:07 +0800, Crystal Guo wrote:
> [...]
>> Should I add the SoC-specific data as follows?
>> This may also modify the ti original code, is it OK?
>>
>> +       data->reset_data = of_device_get_match_data(&pdev->dev);
>> +
>> +       list = of_get_property(np, data->reset_data->reset_bits, &size);
>>
>> +static const struct common_reset_data ti_reset_data = {
>> +       .reset_op_available = false,
>> +       .reset_bits = "ti, reset-bits",
>                             ^
> That space doesn't belong there.
> 
>> +};
>> +
>> +static const struct common_reset_data mediatek_reset_data = {
>> +       .reset_op_available = true,
>> +       .reset_bits = "mediatek, reset-bits",
>> +};
> 
> I understand Robs comments as meaning "ti,reset-bits" should have been
> called "reset-bits" in the first place, and you shouldn't repeat adding
> the vendor prefix, as that is implied by the compatible. So this should
> probably be just "reset-bits".

Hmm, not sure about that. I think Rob wants the reset data itself to be added in
the driver as is being done on some other SoCs (eg: like in reset-qcom-pdc.c).

regards
Suman

> 
> Otherwise this looks like it should work.
> 
> regards
> Philipp
> 

