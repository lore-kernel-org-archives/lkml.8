Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90A7C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF578206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 17:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgCXR7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 13:59:01 -0400
Received: from mailoutvs40.siol.net ([185.57.226.231]:50145 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727333AbgCXR7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 13:59:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 9520952458E;
        Tue, 24 Mar 2020 18:58:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id scDAk1DWhDMx; Tue, 24 Mar 2020 18:58:57 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 39BA152458F;
        Tue, 24 Mar 2020 18:58:57 +0100 (CET)
Received: from jernej-laptop.localnet (cpe-194-152-20-232.static.triera.net [194.152.20.232])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 928FE52458E;
        Tue, 24 Mar 2020 18:58:56 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     mripard@kernel.org, wens@csie.org,
        Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     airlied@linux.ie, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        Roman Stratiienko <r.stratiienko@gmail.com>
Subject: Re: [PATCH v4 4/4] RFC: drm/sun4i: Process alpha channel of most bottom layer
Date:   Tue, 24 Mar 2020 18:58:56 +0100
Message-ID: <2979815.5fSG56mABF@jernej-laptop>
In-Reply-To: <20200302103138.17916-5-r.stratiienko@gmail.com>
References: <20200302103138.17916-5-r.stratiienko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Dne ponedeljek, 02. marec 2020 ob 11:31:38 CET je Roman Stratiienko 
napisal(a):
> Allwinner display engine blender consists of 3 pipelined blending units.
> 
> PIPE0->\
>         BLD0-\
> PIPE1->/      BLD1-\
> PIPE2->------/      BLD2->OUT
> PIPE3->------------/
> 
> This pipeline produces incorrect composition if PIPE0 buffer has alpha.

I always thought that if bottom layer has alpha, it's blended with background 
color, which is set to opaque black. If that is not the case, can you solve 
this by changing blending formula located in BLD control registers (offsets 
0x90, 0x94, 0x98 and 0x9c)?

Best regards,
Jernej

> Correct solution is to add one more blending step and mix PIPE0 with
> background, but it is not supported by the hardware.
> 
> Use premultiplied alpha buffer of PIPE0 overlay channel as is.
> In this case we got same effect as mixing PIPE0 with black background.
> 
> Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
> 
> ---
> 
> v4:
> - Initial version, depends on other unmerged patches in the patchset.
> ---
>  drivers/gpu/drm/sun4i/sun8i_ui_layer.c | 2 +-
>  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c index dd6145f80c36..d94f4d8b9128
> 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
> @@ -106,7 +106,7 @@ static void sun8i_ui_layer_update_alpha(struct
> sun8i_mixer *mixer, int channel, regmap_update_bits(mixer->engine.regs,
>  			   SUN8I_MIXER_BLEND_PREMULTIPLY(bld_base),
>  			   SUN8I_MIXER_BLEND_PREMULTIPLY_EN(zpos),
> -			   SUN8I_MIXER_BLEND_PREMULTIPLY_EN(zpos));
> +			   zpos ? 
SUN8I_MIXER_BLEND_PREMULTIPLY_EN(zpos) : 0);
>  }
> 
>  static int sun8i_ui_layer_update_coord(struct sun8i_mixer *mixer, int
> channel, diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c index e6d8a539614f..68a6843db4ab
> 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> @@ -108,7 +108,7 @@ static void sun8i_vi_layer_update_alpha(struct
> sun8i_mixer *mixer, int channel, regmap_update_bits(mixer->engine.regs,
>  			   SUN8I_MIXER_BLEND_PREMULTIPLY(bld_base),
>  			   SUN8I_MIXER_BLEND_PREMULTIPLY_EN(zpos),
> -			   (mixer->cfg->is_de3) ?
> +			   (zpos != 0 && mixer->cfg->is_de3) ?
>  				
SUN8I_MIXER_BLEND_PREMULTIPLY_EN(zpos) : 0);
> 
>  }




