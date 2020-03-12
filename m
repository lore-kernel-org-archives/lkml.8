Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2036FC1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 07:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECC0206B1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 07:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="nL4Hv1FK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388000AbgCLHB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 03:01:56 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35368 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387831AbgCLHBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 03:01:55 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02C71TsD089814;
        Thu, 12 Mar 2020 02:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583996489;
        bh=2DcFuiREd1lLevtuAMxfcFQw8QwTShJd4BPuKAz9Lh0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=nL4Hv1FKZs/YfiOt8XmC7MZAc+wkXNl8hk7ZXvwXvsGxmXagJd6RhnIu//VFvqN4M
         zftKyV63MeMCsh91IERuLv4S2K+/wPJlsq6ZXITZIB0qzzSHFSnsuIRHtgEs7NYw3n
         vvdkDBs130WKzqh06H8UE7NWKw1RWwvdWqsHprw4=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02C71TPB017366;
        Thu, 12 Mar 2020 02:01:29 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 12
 Mar 2020 02:01:28 -0500
Received: from localhost.localdomain (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 12 Mar 2020 02:01:28 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 02C71O9n084767;
        Thu, 12 Mar 2020 02:01:24 -0500
Subject: Re: [PATCH v6 3/3] drm: bridge: cdns-mhdp: add j721e wrapper
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Yuti Amonkar <yamonkar@cadence.com>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <maxime@cerno.tech>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <mark.rutland@arm.com>, <a.hajda@samsung.com>,
        <narmstrong@baylibre.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <praneeth@ti.com>, <jsarha@ti.com>,
        <mparab@cadence.com>, <sjakhade@cadence.com>
References: <1582712579-28504-1-git-send-email-yamonkar@cadence.com>
 <1582712579-28504-4-git-send-email-yamonkar@cadence.com>
 <20200311205217.GD4863@pendragon.ideasonboard.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <0e9b73b7-a960-e2a1-d8a1-f12309755176@ti.com>
Date:   Thu, 12 Mar 2020 09:01:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200311205217.GD4863@pendragon.ideasonboard.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On 11/03/2020 22:52, Laurent Pinchart wrote:

>> +void cdns_mhdp_j721e_enable(struct cdns_mhdp_device *mhdp)
>> +{
>> +	/*
>> +	 * Eneble VIF_0 and select DPI2 as its input. DSS0 DPI0 is connected
>> +	 * to eDP DPI2. This is the only supported SST configuration on
>> +	 * J721E.
> 
> Without hardware documentation I can't really comment on this, but I'd
> like to make sure it doesn't imply that the MHDP has more than one input
> and one output.

You can download the TRM for j721e here:

http://www.ti.com/lit/pdf/spruil1

MHDP has one DP output, but 4 inputs to support MST and split/dual panel modes. None of those are 
supported by the drivers, but perhaps some thought should be paid to figure out if adding these 
features affect the DT bindings.

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
