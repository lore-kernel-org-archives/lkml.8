Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D8BBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0148E20781
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FLCDAVbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgHLKsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 06:48:21 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38822 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgHLKsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 06:48:21 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07CAllRr030912;
        Wed, 12 Aug 2020 05:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597229267;
        bh=evki6dI5ts5KOmGlF8qCX59wMWhwGQMc/ZNVJhMADKg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=FLCDAVbve+oTVJhXUk7KB9Nf1N8Y5hv2YdvDJfrw1FlDnAjzXHCfuyeJByBhGI5VC
         IRk6YOcrYOzn50dLMDMAAUNtsDpxbJe1ntKJBfo4mxBorMFfFWdsFwycdn86j+IJ8L
         ZGVk/Vu1l5zcx7oB8QZkFkIBnkfHCFzIrC1ZStKw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07CAll8W063305
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Aug 2020 05:47:47 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 12
 Aug 2020 05:47:47 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 12 Aug 2020 05:47:47 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07CAlhX8025723;
        Wed, 12 Aug 2020 05:47:43 -0500
Subject: Re: [PATCH v8 0/3] drm: Add support for Cadence MHDP DPI/DP bridge
 and J721E wrapper.
To:     =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Swapnil Jakhade <sjakhade@cadence.com>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>,
        <Laurent.pinchart@ideasonboard.com>, <robh+dt@kernel.org>,
        <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mparab@cadence.com>,
        <yamonkar@cadence.com>, <praneeth@ti.com>, <nsekhar@ti.com>,
        <jsarha@ti.com>, <sandor.yu@nxp.com>
References: <1596713672-8146-1-git-send-email-sjakhade@cadence.com>
 <20200812083937.GA8816@bogon.m.sigxcpu.org>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <3bcbbb0b-ee04-0f1e-6c54-97b01c552d82@ti.com>
Date:   Wed, 12 Aug 2020 13:47:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812083937.GA8816@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guido,

On 12/08/2020 11:39, Guido Günther wrote:
> Hi,
> On Thu, Aug 06, 2020 at 01:34:29PM +0200, Swapnil Jakhade wrote:
>> This patch series adds new DRM bridge driver for Cadence MHDP DPI/DP
>> bridge. The Cadence Display Port IP is also referred as MHDP (Mobile High
>> Definition Link, High-Definition Multimedia Interface, Display Port).
>> Cadence Display Port complies with VESA DisplayPort (DP) and embedded
>> Display Port (eDP) standards.
> 
> Is there any relation to the cadence mhdp ip core used inthe imx8mq:
> 
>     https://lore.kernel.org/dri-devel/cover.1590982881.git.Sandor.yu@nxp.com/
> 
> It looks very similar in several places so should that use the same driver?
> Cheers,
>  -- Guido

Interesting.

So the original Cadence DP patches for TI SoCs did create a common driver with Rockchip's older mhdp
driver. And looks like the IMX series points to an early version of that patch ("drm/rockchip:
prepare common code for cdns and rk dpi/dp driver").

We gave up on that as the IPs did have differences and the firmwares used were apparently quite
different. The end result was very difficult to maintain, especially as (afaik) none of the people
involved had relevant Rockchip HW.

The idea was to get a stable DP driver for TI SoCs ready and upstream, and then carefully try to
create common parts with Rockchip's driver in small pieces.

If the Rockchip and IMX mhdp have the same IP and same firmware, then they obviously should share
code as done in the series you point to.

Perhaps Cadence can clarify the differences between IMX, TI and Rockchip IPs and FWs?

I'm worried that if there are IP differences, even if not great ones, and if the FWs are different
and developed separately, it'll be a constant "fix X for SoC A, and accidentally break Y for SoC B
and C", especially if too much code is shared.

In the long run I'm all for a single driver (or large shared parts), but I'm not sure if we should
start with that approach.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
