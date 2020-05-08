Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD0DC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88EF0207DD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 07:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nX3HI5fZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEHHuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 03:50:21 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44106 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726036AbgEHHuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 03:50:21 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0487oD6q011100;
        Fri, 8 May 2020 02:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588924213;
        bh=tplglm/g5jD+nhYnoLzqRzsabkE52+jjVIaqi5MySV0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nX3HI5fZdDuxSsGdGX8/gHo4q/JzaHoYq43tvCuFTvjqgRlBgQqakEEh28fnK1FNi
         HNvSdBAvVeOnyhVIrTo00Qm8CBJDb8w8Hqh0QXOWlqcQKnPFFHQqHDv2IMYPoETT0e
         LzD715a/ztTvr3j36kypm/A29NhPNx97tN9dX0D4=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0487oDVf057360
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 May 2020 02:50:13 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 May
 2020 02:50:12 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 May 2020 02:50:12 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0487oALu043615;
        Fri, 8 May 2020 02:50:11 -0500
Subject: Re: [PATCH v1 2/2] phy: phy-cadence-torrent: Use PHY kernel APIs to
 set PHY attributes
To:     Maxime Ripard <maxime@cerno.tech>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
CC:     Yuti Suresh Amonkar <yamonkar@cadence.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jsarha@ti.com" <jsarha@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        Milind Parab <mparab@cadence.com>
References: <1588057804-29161-1-git-send-email-yamonkar@cadence.com>
 <1588057804-29161-3-git-send-email-yamonkar@cadence.com>
 <20200429122750.hup7vbmz3xnpfwa5@gilmour.lan>
 <BY5PR07MB69827A1E2136455BFDD6090BC5AA0@BY5PR07MB6982.namprd07.prod.outlook.com>
 <20200507171738.atzyfpueo6bjbwpb@gilmour.lan>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <f6e0566a-8e15-5c55-3167-6a1526c37be7@ti.com>
Date:   Fri, 8 May 2020 10:50:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507171738.atzyfpueo6bjbwpb@gilmour.lan>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/05/2020 20:17, Maxime Ripard wrote:

>> Actually, for this particular case, consumer driver will be the Cadence MHDP
>> bridge driver for DisplayPort which is also under review process for
>> upstreaming [1]. So this DRM bridge driver will make use of the PHY APIs
>> phy_get_bus_width() and phy_get_max_link_rate() during execution of probe
>> function to get the number of lanes and maximum link rate supported by Cadence
>> Torrent PHY. This information is required to set the host capabilities in the
>> DRM bridge driver, based on which initial values for DisplayPort link training
>> will be determined.
>>
>> The changes in this PHY patch series are based on suggestions in the review
>> comments in [1] which asks to use kernel PHY APIs to read these properties
>> instead of directly accessing PHY device node. The complete driver and actual
>> use of these APIs can be found in [2]. This is how we are planning to use
>> these APIs.
> 
> I haven't really looked into the displayport spec, but I'd assume that there's a
> lot more parameters that would need to be negociated between the phy and the DP
> block? If so, then it would make more sense to follow the path we did for
> MIPI-DSI where the parameters can be negociated through the phy_configure /
> phy_validate interface.

I don't think this is negotiation, but just exposing the (max) capabilities of PHY, inside which the 
configure can work. Maybe all the capabilities could handled with a struct (struct phy_attrs), 
instead of adding separate functions for each, though.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
