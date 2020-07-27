Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D986EC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53142073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 17:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Omxugap+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgG0RCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 13:02:52 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55702 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbgG0RCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 13:02:52 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06RH2kdB111893;
        Mon, 27 Jul 2020 12:02:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595869366;
        bh=ra8ZdNG64gqiGE/obEmUEMweGgGl04HZSwgKLKJS2bM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Omxugap+fhz6qMQJrnSPQuLZLHJZapWy5P7mjkrZpOhVjeGre/CZ7xuijEZPQAAlh
         igPeo0QMUL2QmnsfHbcVOjuQZ9YxouVyx8/Aj/BxCys0MuAQ4eZGf+Ey8igOHXKDqT
         YHyyql90N+YuD1b2c5N6t4fmO/t70RzKSVEn7H6I=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06RH2kAv074195
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jul 2020 12:02:46 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Jul 2020 12:02:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Jul 2020 12:02:45 -0500
Received: from [10.24.69.198] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06RH2gbO112745;
        Mon, 27 Jul 2020 12:02:43 -0500
Subject: Re: [PATCH v4 0/2] Add new PHY APIs to framework to get/set PHY
 attributes
To:     Vinod Koul <vkoul@kernel.org>
CC:     Swapnil Jakhade <sjakhade@cadence.com>, <kishon@ti.com>,
        <linux-kernel@vger.kernel.org>, <maxime@cerno.tech>,
        <mparab@cadence.com>, <yamonkar@cadence.com>,
        <tomi.valkeinen@ti.com>, <jsarha@ti.com>, <praneeth@ti.com>
References: <1594968633-12535-1-git-send-email-sjakhade@cadence.com>
 <f1f2cdca-99a1-2bcc-6fe2-9ce95553a7cd@ti.com>
 <20200727095515.GX12965@vkoul-mobl>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <b6c1984d-e774-3b24-cb10-ee47cb5fd835@ti.com>
Date:   Mon, 27 Jul 2020 22:32:41 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200727095515.GX12965@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/20 3:25 PM, Vinod Koul wrote:
> Hi Sekhar,
> 
> On 26-07-20, 01:24, Sekhar Nori wrote:
>> Hi Vinod,
>>
>> On 7/17/20 12:20 PM, Swapnil Jakhade wrote:
>>> This patch series adds a new pair of PHY APIs that can be used to get/set
>>> all the PHY attributes. It also adds a new PHY attribute max_link_rate.
>>>
>>> It includes following patches:
>>>
>>> 1. v4-0001-phy-Add-new-PHY-attribute-max_link_rate-and-APIs-.patch
>>> This patch adds max_link_rate as a new PHY attribute along with a pair of
>>> APIs that allow using the generic PHY subsystem to get/set PHY attributes
>>> supported by the PHY.
>>>
>>> 2. v4-0002-phy-cadence-torrent-Use-kernel-PHY-API-to-set-PHY.patch
>>> This patch uses PHY API phy_set_attrs() to set corresponding PHY properties
>>> in Cadence Torrent PHY driver. This will enable drivers using this PHY to
>>> read these properties using PHY framework.
>>>
>>> The phy_get_attrs() API will be used in the DRM bridge driver [1] which is
>>> in the process of upstreaming.
>>
>> Is it possible to queue these for v5.9 also? I did notice that phy
>> updates for v5.9-rc1 are posted already. But these APIs are needed for
>> the DisplayPort driver thats getting ready for merge too. Having these
>> queued now will make managing dependencies much easier.
> 
> I would prefer if we defer core change to post rc1. For your display, we
> can provide a signed tag for you/drm folks to fetch.
> 
> Would that be okay?

Okay, that would work too.

Thanks,
Sekhar
