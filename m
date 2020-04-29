Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA78C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2876420787
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XDfkkNuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgD2H4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:56:42 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54284 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgD2H4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:56:41 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03T7uN8w007867;
        Wed, 29 Apr 2020 02:56:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588146983;
        bh=n4pmfRipX17yviyXCDK8at/AM0pg14P8PWeY9w6wQmA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=XDfkkNuUPYbFAV2lKtYm2z5y+m4/7Qo7STPFfnkln0JgNbc19/pUDC16TTyYK5sXU
         nucf2/Vc057I3eFohiLDCxffAjvn4V7jzRRwHQMobraXzKpC5x7rTcq6jFO4loa1TL
         0HeWsLMASeQNvQ4qgAkJK0RYBVKc6/W/G/SaptDo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03T7uNgE116017
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Apr 2020 02:56:23 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 29
 Apr 2020 02:56:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 29 Apr 2020 02:56:22 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03T7uJJV074144;
        Wed, 29 Apr 2020 02:56:20 -0500
Subject: Re: [PATCH] drm/bridge: fix stack usage warning on old gcc
To:     Arnd Bergmann <arnd@arndb.de>, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20200428215408.4111675-1-arnd@arndb.de>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <22ee464b-f59a-69a3-b669-f821d567fbf5@ti.com>
Date:   Wed, 29 Apr 2020 10:56:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428215408.4111675-1-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2020 00:53, Arnd Bergmann wrote:
> Some older versions of gcc badly optimize code that passes
> an inline function argument into another function by reference,
> causing huge stack usage:
> 
> drivers/gpu/drm/bridge/tc358768.c: In function 'tc358768_bridge_pre_enable':
> drivers/gpu/drm/bridge/tc358768.c:840:1: error: the frame size of 2256 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]
> 
> Use a temporary variable as a workaround and add a comment pointing
> to the gcc bug.
> 
> Fixes: ff1ca6397b1d ("drm/bridge: Add tc358768 driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/gpu/drm/bridge/tc358768.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
> index 1b39e8d37834..6650fe4cfc20 100644
> --- a/drivers/gpu/drm/bridge/tc358768.c
> +++ b/drivers/gpu/drm/bridge/tc358768.c
> @@ -178,6 +178,8 @@ static int tc358768_clear_error(struct tc358768_priv *priv)
>   
>   static void tc358768_write(struct tc358768_priv *priv, u32 reg, u32 val)
>   {
> +	/* work around https://gcc.gnu.org/bugzilla/show_bug.cgi?id=81715 */
> +	int tmpval = val;
>   	size_t count = 2;
>   
>   	if (priv->error)
> @@ -187,7 +189,7 @@ static void tc358768_write(struct tc358768_priv *priv, u32 reg, u32 val)
>   	if (reg < 0x100 || reg >= 0x600)
>   		count = 1;
>   
> -	priv->error = regmap_bulk_write(priv->regmap, reg, &val, count);
> +	priv->error = regmap_bulk_write(priv->regmap, reg, &tmpval, count);
>   }
>   
>   static void tc358768_read(struct tc358768_priv *priv, u32 reg, u32 *val)
> 

tc358768_write is not inline. What is the inline function here? Or is tc358768_write optimized to 
inline by the compiler?

  Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
