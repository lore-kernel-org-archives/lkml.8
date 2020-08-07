Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59902C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 364B0206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V7I86E3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgHGJjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:39:17 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52350 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgHGJjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:39:16 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0779cwpV020790;
        Fri, 7 Aug 2020 04:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1596793138;
        bh=Ci3SQG5GuTu5PfVgX5SPec+hpQmMwKCLgIR+XPhEscc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=V7I86E3He3ICPEnFPJ60kxm8G0x6UY3g4dV1pFfZT51+oR2f1A/swiZ93BNqbwKyN
         wkx2F34f/8JctQbFLF/aANYv6pI+5ECOKkAoxl+djwGg+Poo2BRYurSDgRrxJ1RttI
         gPj0WrXko5rYJXKT6nBt5GeF2mi3XqNd8O5CV3Kc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0779cweJ084121;
        Fri, 7 Aug 2020 04:38:58 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 7 Aug
 2020 04:38:58 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 7 Aug 2020 04:38:58 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0779csxd102220;
        Fri, 7 Aug 2020 04:38:55 -0500
Subject: Re: [PATCH v8 2/3] drm: bridge: Add support for Cadence MHDP DPI/DP
 bridge
To:     Swapnil Jakhade <sjakhade@cadence.com>, <airlied@linux.ie>,
        <daniel@ffwll.ch>, <Laurent.pinchart@ideasonboard.com>,
        <robh+dt@kernel.org>, <a.hajda@samsung.com>,
        <narmstrong@baylibre.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@siol.net>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <mparab@cadence.com>, <yamonkar@cadence.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>, <praneeth@ti.com>
References: <1596713672-8146-1-git-send-email-sjakhade@cadence.com>
 <1596713672-8146-3-git-send-email-sjakhade@cadence.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <0fe8e670-c9eb-729c-f013-28c53bd65abd@ti.com>
Date:   Fri, 7 Aug 2020 12:38:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596713672-8146-3-git-send-email-sjakhade@cadence.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Swapnil,

On 06/08/2020 14:34, Swapnil Jakhade wrote:
> Add a new DRM bridge driver for Cadence MHDP DPTX IP used in TI J721e SoC.
> MHDP DPTX IP is the component that complies with VESA DisplayPort (DP) and
> embedded Display Port (eDP) standards. It integrates uCPU running the
> embedded Firmware (FW) interfaced over APB interface.
> 
> Basically, it takes a DPI stream as input and outputs it encoded in DP
> format. Currently, it supports only SST mode.
> 
> Co-developed-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Co-developed-by: Jyri Sarha <jsarha@ti.com>
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---

<snip>

> +	mhdp_state = to_cdns_mhdp_bridge_state(new_state);
> +
> +	mhdp_state->current_mode = drm_mode_duplicate(bridge->dev, mode);
> +	drm_mode_set_name(mhdp_state->current_mode);
> +

current_mode is never freed, so this leaks memory.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
