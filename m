Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97DAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89CE32084C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 08:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rBI1VPwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgGCI6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 04:58:21 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37472 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgGCI6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 04:58:21 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0638wJWg065658;
        Fri, 3 Jul 2020 03:58:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593766699;
        bh=W7t1sC7N6y7fp2AbFukbs/zUn1q/KxGNhrBoW9dURFo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rBI1VPweRRqGWen3eKyitMNqcQofm5gDxDmwsNo2extK/Qjd1r1NsCMnwQ/rkMwL9
         AI2SkQzIpBliL3Mmh8oE/DsCP5m8yklYxB10z4rI2aHmuIDhoTcvvp4YUWOoFQ2eas
         Q86Qx22hEbsyX9bfRz6ET8jYFhAq+DCCe/2qFtiM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0638wJH0084790
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Jul 2020 03:58:19 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 3 Jul
 2020 03:58:19 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 3 Jul 2020 03:58:19 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0638wHbF057587;
        Fri, 3 Jul 2020 03:58:17 -0500
Subject: Re: [PATCH v3 1/3] dt-binding: phy: convert ti,omap-usb2 to YAML
To:     Rob Herring <robh@kernel.org>
CC:     <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <kishon@ti.com>, <nsekhar@ti.com>,
        <devicetree@vger.kernel.org>
References: <20200630092729.15346-1-rogerq@ti.com>
 <20200630092729.15346-2-rogerq@ti.com> <20200702204758.GA1665250@bogus>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <7899660d-936e-6d88-877a-f75d76f34c40@ti.com>
Date:   Fri, 3 Jul 2020 11:58:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200702204758.GA1665250@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 02/07/2020 23:47, Rob Herring wrote:
> On Tue, 30 Jun 2020 12:27:27 +0300, Roger Quadros wrote:
>> Move ti,omap-usb2 to its own YAML schema.
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   .../devicetree/bindings/phy/ti,omap-usb2.yaml | 69 +++++++++++++++++++
>>   .../devicetree/bindings/phy/ti-phy.txt        | 37 ----------
>>   2 files changed, 69 insertions(+), 37 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/phy/ti,omap-usb2.yaml
>>
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/ti,omap-usb2.example.dt.yaml: example-0: phy@4100000:reg:0: [0, 68157440, 0, 84] is too long
> 

In my local build in the dt example I see

     phy@4100000:
       compatible: ["ti,am654-usb2", "ti,omap-usb2"]
       reg: [[0x0, 0x4100000, 0x0, 0x54]]

And I don't see any errors. I've updated my dt-schema as well.

> 
> See https://patchwork.ozlabs.org/patch/1319665
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure dt-schema is up to date:
> 
> pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> 
> Please check and re-submit.
> 

-- 
cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
