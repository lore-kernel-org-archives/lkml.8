Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A98C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B93620848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 12:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+SjzJaG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbgH1Mfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 08:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgH1Mfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 08:35:31 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F76C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 05:35:30 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id l23so1005775edv.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 05:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S/FP18GdeEsQIBGpdNuuhDRuibofRXoQRIPNbtt9sRY=;
        b=a+SjzJaGpDMjLFI4m4bUgdWkdHu18yc5GfL5js7fSMQWXUvk4ovchSKQSVfpyvzLD6
         0SDxmQiEQ9kVtcsheYiiZKY6taD2YxkRjcEwE0AphlIZMLmLMa/dk64bO48yD3Pc/zLS
         Ss1WsveDreGhDW30tSFaUkOqsbU4VuzFLHdwX42U3ocu1otvjbqeOMBlwoZaSPR6+hai
         38Thk1IWapK/hXEe6Q9jxSy2N64dY/APbPpDVmxqLutGChiOE8FH4nBulsyrjEQLVfn1
         RoOhwfAg8eYJFfl3uVBo9LAlxZA7aBpDF259nwmGTpbKG51bo0NOUusd5EemqUPMXqtl
         nvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S/FP18GdeEsQIBGpdNuuhDRuibofRXoQRIPNbtt9sRY=;
        b=Ashvmqocz4X2witOJKiCXnRTaoLX5v3RktA0t5+bdxwBlW9f7TxxShQgxaEJHgIn6L
         u+cRIyAQ9V1Eq9chz8YYsGhGgCa9uXa7wxeMLapimZcfeqNUb5IMDMApUgeYXCfTzuHL
         904wo4aNEV4bHRw6J3opyxPCooJ9cGByuuhLvg9NFsGJwvLuTjZMh7Tmqbp2suGX0vBB
         2VALyY/oLoZKhL8DFVVxA0RJc9PAe1seSOIChnWeay18X7I0S6mliMc9xKJA8oV8XI9P
         WmZkk0xsc425+sKkLR4Z0waHELxL2mBrvDOMe3q9U71qqQvkcNqIcXhFknQSlfNaSGL6
         +GBw==
X-Gm-Message-State: AOAM531y7kRqutTCzo76OFzRZSSV7txK22aTmXS0hn2IQh9sHhfsnjlv
        LKdSsDMYxx8tIM/Y7gKOj08=
X-Google-Smtp-Source: ABdhPJy6QQInAfaYYn6sA/5SFfqm16o4ELO1cDSV915jWO7sE29ZtFz1Iutso4lgZ0ROGcfIMaDSpQ==
X-Received: by 2002:a05:6402:2285:: with SMTP id cw5mr1614748edb.242.1598618128648;
        Fri, 28 Aug 2020 05:35:28 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net. [89.212.178.211])
        by smtp.gmail.com with ESMTPSA id l23sm760431eje.46.2020.08.28.05.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 05:35:27 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-sunxi@googlegroups.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, megous@megous.com
Subject: Re: [linux-sunxi] [PATCH] drm/sun4i: Fix dsi dcs long write function
Date:   Fri, 28 Aug 2020 14:35:26 +0200
Message-ID: <1872601.C7yQfbK89F@jernej-laptop>
In-Reply-To: <20200828112444.916455-1-megous@megous.com>
References: <20200828112444.916455-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 28. avgust 2020 ob 13:24:44 CEST je Ondrej Jirman napisal(a):
> It's writing too much data. regmap_bulk_write expects number of
> register sized chunks to write, not a byte sized length of the
> bounce buffer. Bounce buffer needs to be padded too, so that
> regmap_bulk_write will not read past the end of the buffer.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Fixes: 133add5b5ad4 ("drm/sun4i: Add Allwinner A31 MIPI-DSI controller 
support")

should be added. Fix will be then automatically picked into stable releases.

Small nit below.

> ---
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c index 7f13f4d715bf..840fad1b68dd
> 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -889,7 +889,7 @@ static int sun6i_dsi_dcs_write_long(struct sun6i_dsi
> *dsi, regmap_write(dsi->regs, SUN6I_DSI_CMD_TX_REG(0),
>  		     sun6i_dsi_dcs_build_pkt_hdr(dsi, msg));
> 
> -	bounce = kzalloc(msg->tx_len + sizeof(crc), GFP_KERNEL);
> +	bounce = kzalloc(msg->tx_len + sizeof(crc) + 3, GFP_KERNEL);

It would be nicer to use ALIGN() macro, but I'm fine either way.

Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Best regards,
Jernej

>  	if (!bounce)
>  		return -ENOMEM;
> 
> @@ -900,7 +900,7 @@ static int sun6i_dsi_dcs_write_long(struct sun6i_dsi
> *dsi, memcpy((u8 *)bounce + msg->tx_len, &crc, sizeof(crc));
>  	len += sizeof(crc);
> 
> -	regmap_bulk_write(dsi->regs, SUN6I_DSI_CMD_TX_REG(1), bounce, 
len);
> +	regmap_bulk_write(dsi->regs, SUN6I_DSI_CMD_TX_REG(1), bounce,
> DIV_ROUND_UP(len, 4)); regmap_write(dsi->regs, SUN6I_DSI_CMD_CTL_REG, len +
> 4 - 1);
>  	kfree(bounce);




