Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62FDC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF532065F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="P7+W7+nj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgIAIDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:03:49 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49046 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIAIDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:03:47 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08183U9n038807;
        Tue, 1 Sep 2020 03:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598947410;
        bh=rTdSKw6jc2hIcyQD34V8CbUn0PeOh3Lnz/RojDEQl28=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=P7+W7+njHjsDoAJNb7Bq8ex3fOF316aSw/LTChMzasA/ZxG+qD3lIeGf5tb/erTxs
         y0HuN8y5mM+QxMUiZBrQk/aNwOEIUkbM7Yhqsi6CCn+jCp0ARuSm413t1pHbD1hoWG
         7TuyuY3QnlujSButsKyhNmrTAh0tU0cpTuKte/4Y=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08183UL6058781
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Sep 2020 03:03:30 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 1 Sep
 2020 03:03:29 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 1 Sep 2020 03:03:29 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08183Pql056860;
        Tue, 1 Sep 2020 03:03:26 -0500
Subject: Re: [PATCH v9 2/3] drm: bridge: Add support for Cadence MHDP8546
 DPI/DP bridge
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
To:     Swapnil Jakhade <sjakhade@cadence.com>,
        <Laurent.pinchart@ideasonboard.com>,
        <dri-devel@lists.freedesktop.org>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <a.hajda@samsung.com>, <narmstrong@baylibre.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <yamonkar@cadence.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>, <praneeth@ti.com>, <nikhil.nd@ti.com>
References: <1598862215-10222-1-git-send-email-sjakhade@cadence.com>
 <1598862215-10222-3-git-send-email-sjakhade@cadence.com>
 <71452de7-80e7-0144-4802-e3370c00854b@ti.com>
Message-ID: <44d5f9de-61e6-9345-d65b-b56f804e6550@ti.com>
Date:   Tue, 1 Sep 2020 11:03:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <71452de7-80e7-0144-4802-e3370c00854b@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2020 10:46, Tomi Valkeinen wrote:

> I think the above suggests that the driver is not properly updating all the registers based on the
> new mode and link. I tried adding cdns_mhdp_validate_mode_params() call to
> cdns_mhdp_atomic_enable(), so that tu-size etc will be calculated, but that did not fix the problem.

Oh, it actually did fix the problem. It was just that my first hack updated the old state, but after
changing the code to call cdns_mhdp_atomic_enable() with new_state I see it helps with the issue.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
