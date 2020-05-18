Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35040C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0199620643
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WNl6T3Js"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgERMLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:11:14 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:55586 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbgERMLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:11:13 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04ICB5cP121874;
        Mon, 18 May 2020 07:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589803865;
        bh=fMGTY5PIsiqvGaRm42OKgWyyYTbjkb2Wswgalvi1feg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=WNl6T3JsFT9SLHE/DW4wnWph7f+dUaElb9ELROzbo+IjZAd5zfkAm7I1+f5GdlzXk
         seOicsbKY91/DOCNqJAF8cAM/sUg9ydLZdlPyBsETpadRpnQCw1mHtQo2hRCrmgiuo
         wR0Q5bZz29kpZzjs2itKJr7Jy++nD/x3/hemZ8Dg=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04ICB5kI111612
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 May 2020 07:11:05 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 18
 May 2020 07:11:04 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 18 May 2020 07:11:04 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04ICB04S085031;
        Mon, 18 May 2020 07:11:01 -0500
Subject: Re: [PATCH v1 2/2] phy: phy-cadence-torrent: Use PHY kernel APIs to
 set PHY attributes
To:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Maxime Ripard <maxime@cerno.tech>
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
 <c96c3fa8-a66f-7eca-8d23-8dd2a8f044aa@ti.com>
 <BY5PR07MB6982568DE9F5A4BF00433CA6C5B80@BY5PR07MB6982.namprd07.prod.outlook.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <39d5238c-0344-14ef-9e35-8ce4348ce9e4@ti.com>
Date:   Mon, 18 May 2020 17:41:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <BY5PR07MB6982568DE9F5A4BF00433CA6C5B80@BY5PR07MB6982.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/18/2020 12:24 PM, Swapnil Kashinath Jakhade wrote:
> Hi Kishon,
> 
>> -----Original Message-----
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>> Sent: Wednesday, May 13, 2020 8:08 AM
>> To: Tomi Valkeinen <tomi.valkeinen@ti.com>; Maxime Ripard
>> <maxime@cerno.tech>; Swapnil Kashinath Jakhade
>> <sjakhade@cadence.com>
>> Cc: Yuti Suresh Amonkar <yamonkar@cadence.com>; linux-
>> kernel@vger.kernel.org; mark.rutland@arm.com; jsarha@ti.com;
>> praneeth@ti.com; Milind Parab <mparab@cadence.com>; Vinod Koul
>> <vkoul@kernel.org>
>> Subject: Re: [PATCH v1 2/2] phy: phy-cadence-torrent: Use PHY kernel APIs to
>> set PHY attributes
>>
>> EXTERNAL MAIL
>>
>>
>> Hi,
>>
>> On 5/8/2020 1:20 PM, Tomi Valkeinen wrote:
>>> On 07/05/2020 20:17, Maxime Ripard wrote:
>>>
>>>>> Actually, for this particular case, consumer driver will be the
>>>>> Cadence MHDP bridge driver for DisplayPort which is also under
>>>>> review process for upstreaming [1]. So this DRM bridge driver will
>>>>> make use of the PHY APIs
>>>>> phy_get_bus_width() and phy_get_max_link_rate() during execution of
>>>>> probe function to get the number of lanes and maximum link rate
>>>>> supported by Cadence Torrent PHY. This information is required to
>>>>> set the host capabilities in the DRM bridge driver, based on which
>>>>> initial values for DisplayPort link training will be determined.
>>>>>
>>>>> The changes in this PHY patch series are based on suggestions in the
>>>>> review comments in [1] which asks to use kernel PHY APIs to read
>>>>> these properties instead of directly accessing PHY device node. The
>>>>> complete driver and actual use of these APIs can be found in [2].
>>>>> This is how we are planning to use these APIs.
>>>>
>>>> I haven't really looked into the displayport spec, but I'd assume
>>>> that there's a lot more parameters that would need to be negociated
>>>> between the phy and the DP block? If so, then it would make more
>>>> sense to follow the path we did for MIPI-DSI where the parameters can
>>>> be negociated through the phy_configure / phy_validate interface.
>>>
>>> I don't think this is negotiation, but just exposing the (max)
>>> capabilities of PHY, inside which the configure can work. Maybe all
>>> the capabilities could handled with a struct (struct phy_attrs),
>>> instead of adding separate functions for each, though.
>>
>> yeah, that makes sense. Just that users should take care not to over-write all
>> the phy attributes with partial information.
> 
> It would be really helpful if you could clarify a bit regarding how to handle this
> exactly. What I could understand from Tomi' suggestion is that all PHY attributes
> in struct phy_attrs should have single pair of functions to get and set all the PHY
> attributes (e.g. phy_get_attrs / phy_set_attrs), instead of separate get/set pair of
> functions for individual attribute (bus_width, mode, max_link_rate etc). Is this
> understanding correct? If so, how should the existing functions for bus_width and
> mode be used?

Yes, your understanding is correct. There are already existing users of
bus_width, mode, so let's not disturb that. That could maybe deprecated later.

Thanks
Kishon
