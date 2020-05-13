Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE3BC2D0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57519206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 02:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ivT0SzG3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgEMChn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 22:37:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57574 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgEMChn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 22:37:43 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04D2badb092448;
        Tue, 12 May 2020 21:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589337456;
        bh=/W0losaKE+OtadQbq8BpFkOvawfv3WrRa9LJr4eZlKs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ivT0SzG3dwpvMLQHOz5Jyvx7SF7cqz8jRsZhTVvuOsscD0f9tWMILSJ6joy76NVDy
         5ojK7usvdwcSyZy2S8isAFuBXAzomTYxkTW1Ga9zX9BxOzIcSs9395688T7xIfVuCY
         n4MTWPuFsdxygXSjMgAVIWpmzuLm0nD0iMIjnob4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04D2ba7K026237
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 21:37:36 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 12
 May 2020 21:37:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 12 May 2020 21:37:35 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04D2bWDX060736;
        Tue, 12 May 2020 21:37:33 -0500
Subject: Re: [PATCH v1 2/2] phy: phy-cadence-torrent: Use PHY kernel APIs to
 set PHY attributes
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>
CC:     Yuti Suresh Amonkar <yamonkar@cadence.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "jsarha@ti.com" <jsarha@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        Milind Parab <mparab@cadence.com>,
        Vinod Koul <vkoul@kernel.org>
References: <1588057804-29161-1-git-send-email-yamonkar@cadence.com>
 <1588057804-29161-3-git-send-email-yamonkar@cadence.com>
 <20200429122750.hup7vbmz3xnpfwa5@gilmour.lan>
 <BY5PR07MB69827A1E2136455BFDD6090BC5AA0@BY5PR07MB6982.namprd07.prod.outlook.com>
 <20200507171738.atzyfpueo6bjbwpb@gilmour.lan>
 <f6e0566a-8e15-5c55-3167-6a1526c37be7@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c96c3fa8-a66f-7eca-8d23-8dd2a8f044aa@ti.com>
Date:   Wed, 13 May 2020 08:07:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f6e0566a-8e15-5c55-3167-6a1526c37be7@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/8/2020 1:20 PM, Tomi Valkeinen wrote:
> On 07/05/2020 20:17, Maxime Ripard wrote:
> 
>>> Actually, for this particular case, consumer driver will be the Cadence MHDP
>>> bridge driver for DisplayPort which is also under review process for
>>> upstreaming [1]. So this DRM bridge driver will make use of the PHY APIs
>>> phy_get_bus_width() and phy_get_max_link_rate() during execution of probe
>>> function to get the number of lanes and maximum link rate supported by Cadence
>>> Torrent PHY. This information is required to set the host capabilities in the
>>> DRM bridge driver, based on which initial values for DisplayPort link training
>>> will be determined.
>>>
>>> The changes in this PHY patch series are based on suggestions in the review
>>> comments in [1] which asks to use kernel PHY APIs to read these properties
>>> instead of directly accessing PHY device node. The complete driver and actual
>>> use of these APIs can be found in [2]. This is how we are planning to use
>>> these APIs.
>>
>> I haven't really looked into the displayport spec, but I'd assume that there's a
>> lot more parameters that would need to be negociated between the phy and the DP
>> block? If so, then it would make more sense to follow the path we did for
>> MIPI-DSI where the parameters can be negociated through the phy_configure /
>> phy_validate interface.
> 
> I don't think this is negotiation, but just exposing the (max) capabilities of
> PHY, inside which the configure can work. Maybe all the capabilities could
> handled with a struct (struct phy_attrs), instead of adding separate functions
> for each, though.

yeah, that makes sense. Just that users should take care not to over-write all
the phy attributes with partial information.

Thanks
Kishon
