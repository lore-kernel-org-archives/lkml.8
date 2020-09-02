Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A087C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A64C20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 16:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgIBQqu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 12:46:50 -0400
Received: from mailoutvs19.siol.net ([185.57.226.210]:44758 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727776AbgIBQqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 12:46:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 5D25E52676B;
        Wed,  2 Sep 2020 18:46:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ORtNQRatnqJ9; Wed,  2 Sep 2020 18:46:43 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id E90D752676F;
        Wed,  2 Sep 2020 18:46:42 +0200 (CEST)
Received: from kista.localnet (cpe1-5-97.cable.triera.net [213.161.5.97])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id DB01552676B;
        Wed,  2 Sep 2020 18:46:40 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Roman Stratiienko <r.stratiienko@gmail.com>
Cc:     mripard@kernel.org, wens@csie.org, irlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: Fix DE2 YVU handling
Date:   Wed, 02 Sep 2020 18:51:15 +0200
Message-ID: <10671571.W45mMbEh4O@kista>
In-Reply-To: <CAGphcdnT4U8AztL_B_B2HYskQSAYKRgCQcnO3Q8Qj+UFO082hQ@mail.gmail.com>
References: <20200901220305.6809-1-jernej.skrabec@siol.net> <CAGphcdnT4U8AztL_B_B2HYskQSAYKRgCQcnO3Q8Qj+UFO082hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 02. september 2020 ob 09:01:17 CEST je Roman Stratiienko 
napisal(a):
> ср, 2 сент. 2020 г. в 00:58, Jernej Skrabec <jernej.skrabec@siol.net>:
> > Function sun8i_vi_layer_get_csc_mode() is supposed to return CSC mode
> > but due to inproper return type (bool instead of u32) it returns just 0
> > or 1. Colors are wrong for YVU formats because of that.
> > 
> > Fixes: daab3d0e8e2b ("drm/sun4i: de2: csc_mode in de2 format struct is
> > mostly redundant") Reported-by: Roman Stratiienko
> > <r.stratiienko@gmail.com>
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/sun4i/sun8i_vi_layer.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c index 22c8c5375d0d..c0147af6a840
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > +++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
> > @@ -211,7 +211,7 @@ static int sun8i_vi_layer_update_coord(struct
> > sun8i_mixer *mixer, int channel,> 
> >         return 0;
> >  
> >  }
> > 
> > -static bool sun8i_vi_layer_get_csc_mode(const struct drm_format_info
> > *format) +static u32 sun8i_vi_layer_get_csc_mode(const struct
> > drm_format_info *format)> 
> >  {
> >  
> >         if (!format->is_yuv)
> >         
> >                 return SUN8I_CSC_MODE_OFF;
> > 
> > --
> > 2.28.0
> 
> Hi Jernej,
> 
> Thank you for the fix.
> I can confirm this patch fixes the issue with wrong colors.

Thanks! Can I assume that this means your Tested-by tag can be added?

> 
> Let me share my thoughts:
> I've looked into csc code, and it seems to me reordering U, V offsets
> should be a much simpler solution than applying
> color transformation matrices.It should also simplify adding more
> color encodings in the future.

Switching offsets assumes that you have separate planes for U and V which may 
not be true in the future. I agree that CSC matrices are needlessly duplicated 
for handling U/V switch. I have a patch which reorganize matrix on the fly when 
coefficients are written in registers but since it's a part of a bigger, 
unfinished series, I didn't sent it out yet. Only difference in YUV and YVU CSC 
matrices are switched 2nd and 3rd column.

Best regards,
Jernej

> 
> Regards,
> Roman




