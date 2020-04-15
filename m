Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F17C2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5267620771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="DugdLxZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407934AbgDOPkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404324AbgDOPkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:40:17 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3F9C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:40:14 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0BCE62D1;
        Wed, 15 Apr 2020 17:40:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1586965212;
        bh=BMc0UjmXRz760BpBGzK5lNlt1pjOrdG2fEpiQi+Os7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DugdLxZ0613/Mqc867UaJNpk6wWeA0CQsZ724aCSEee3RBW/KTvwQQvEoceJfh3kD
         Pf03mlM5P2F9pm4qSnEe0O6UNoWwtxReFDUrB3OLxL3J0CFM//NOwhdHa/OZ+lLzzC
         eHPU91lFZH+Q+Ui1TUTfkHFi8lZxOyS+YrHwBvuk=
Date:   Wed, 15 Apr 2020 18:39:59 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     tomi.valkeinen@ti.com, airlied@linux.ie, daniel@ffwll.ch,
        sebastian.reichel@collabora.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm/omap: venc: remove unused variable
 'venc_config_pal_bdghi'
Message-ID: <20200415153959.GI4758@pendragon.ideasonboard.com>
References: <20200415132105.43636-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200415132105.43636-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yue,

Thank you for the patch.

On Wed, Apr 15, 2020 at 09:21:05PM +0800, YueHaibing wrote:
> drivers/gpu/drm/omapdrm/dss/venc.c:211:33:
>  warning: 'venc_config_pal_bdghi' defined but not used [-Wunused-const-variable=]
>  static const struct venc_config venc_config_pal_bdghi = {
>                                  ^~~~~~~~~~~~~~~~~~~~~
> 
> It is never used, remove it.

Tomi, is this the right fix, or should we work on making use of this
structure ?

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/omapdrm/dss/venc.c | 43 ------------------------------
>  1 file changed, 43 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/venc.c b/drivers/gpu/drm/omapdrm/dss/venc.c
> index 766553bb2f87..9701843ccf09 100644
> --- a/drivers/gpu/drm/omapdrm/dss/venc.c
> +++ b/drivers/gpu/drm/omapdrm/dss/venc.c
> @@ -208,49 +208,6 @@ static const struct venc_config venc_config_ntsc_trm = {
>  	.gen_ctrl				= 0x00F90000,
>  };
>  
> -static const struct venc_config venc_config_pal_bdghi = {
> -	.f_control				= 0,
> -	.vidout_ctrl				= 0,
> -	.sync_ctrl				= 0,
> -	.hfltr_ctrl				= 0,
> -	.x_color				= 0,
> -	.line21					= 0,
> -	.ln_sel					= 21,
> -	.htrigger_vtrigger			= 0,
> -	.tvdetgp_int_start_stop_x		= 0x00140001,
> -	.tvdetgp_int_start_stop_y		= 0x00010001,
> -	.gen_ctrl				= 0x00FB0000,
> -
> -	.llen					= 864-1,
> -	.flens					= 625-1,
> -	.cc_carr_wss_carr			= 0x2F7625ED,
> -	.c_phase				= 0xDF,
> -	.gain_u					= 0x111,
> -	.gain_v					= 0x181,
> -	.gain_y					= 0x140,
> -	.black_level				= 0x3e,
> -	.blank_level				= 0x3e,
> -	.m_control				= 0<<2 | 1<<1,
> -	.bstamp_wss_data			= 0x42,
> -	.s_carr					= 0x2a098acb,
> -	.l21__wc_ctl				= 0<<13 | 0x16<<8 | 0<<0,
> -	.savid__eavid				= 0x06A70108,
> -	.flen__fal				= 23<<16 | 624<<0,
> -	.lal__phase_reset			= 2<<17 | 310<<0,
> -	.hs_int_start_stop_x			= 0x00920358,
> -	.hs_ext_start_stop_x			= 0x000F035F,
> -	.vs_int_start_x				= 0x1a7<<16,
> -	.vs_int_stop_x__vs_int_start_y		= 0x000601A7,
> -	.vs_int_stop_y__vs_ext_start_x		= 0x01AF0036,
> -	.vs_ext_stop_x__vs_ext_start_y		= 0x27101af,
> -	.vs_ext_stop_y				= 0x05,
> -	.avid_start_stop_x			= 0x03530082,
> -	.avid_start_stop_y			= 0x0270002E,
> -	.fid_int_start_x__fid_int_start_y	= 0x0005008A,
> -	.fid_int_offset_y__fid_ext_start_x	= 0x002E0138,
> -	.fid_ext_start_y__fid_ext_offset_y	= 0x01380005,
> -};
> -
>  enum venc_videomode {
>  	VENC_MODE_UNKNOWN,
>  	VENC_MODE_PAL,

-- 
Regards,

Laurent Pinchart
