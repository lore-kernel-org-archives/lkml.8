Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C2FC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4811E206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="riahHI9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgIAIfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:35:12 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52086 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgIAIfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:35:12 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0818Yo85099108;
        Tue, 1 Sep 2020 03:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598949290;
        bh=aMOn6bXJaXljhRLG2lYRQ+5Vgx5NpdcRrWKng53K0YM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=riahHI9eDEf2QWj1OkUgCE3qSTnjFVT24DCh9Je/Q6LhuqGgnh7fbPutRqX1cum20
         EGL562rZtY1TX21L3vMwghA1fbOCNz5coG1rJG12ZdQBgUtKumGOqEikpXzMQOEQX/
         UiAYFDw2QPDcDfhfLQoqO3KmO+jJtUHQRsaI18j4=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0818Yoj2041937
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Sep 2020 03:34:50 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 1 Sep
 2020 03:34:49 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 1 Sep 2020 03:34:49 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0818Yj7X088076;
        Tue, 1 Sep 2020 03:34:46 -0500
Subject: Re: [PATCH v9 2/3] drm: bridge: Add support for Cadence MHDP8546
 DPI/DP bridge
To:     Swapnil Jakhade <sjakhade@cadence.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <Laurent.pinchart@ideasonboard.com>,
        <robh+dt@kernel.org>, <a.hajda@samsung.com>,
        <narmstrong@baylibre.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <yamonkar@cadence.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>, <praneeth@ti.com>, <nikhil.nd@ti.com>
References: <1598862215-10222-1-git-send-email-sjakhade@cadence.com>
 <1598862215-10222-3-git-send-email-sjakhade@cadence.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <e53e87b0-7e0a-763f-8b8b-0dc278e1f225@ti.com>
Date:   Tue, 1 Sep 2020 11:34:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1598862215-10222-3-git-send-email-sjakhade@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,

On 31/08/2020 11:23, Swapnil Jakhade wrote:

> +	line_thresh1 = ((vs + 1) << 5) * 8 / bpp;
> +	line_thresh2 = (pxlclock << 5) / 1000 / rate * (vs + 1) - (1 << 5);
> +	line_thresh = line_thresh1 - line_thresh2 / mhdp->link.num_lanes;
> +	line_thresh = (line_thresh >> 5) + 2;

These calculations do not seem to go correctly. There's no comment what's the logic here, but e.g.
for 640x480 (pxlclock 31500) with 1.62Gbps link, I get vs=4, and then the second line above comes to:

(31500 << 5) / 1000 / 162 * (4+1) - (1<<5) = -0.8888888888888893

The result is line_thresh of 100663299.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
