Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3740BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165222082F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbgFROVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:21:09 -0400
Received: from foss.arm.com ([217.140.110.172]:51018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727078AbgFROVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:21:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D4B2101E;
        Thu, 18 Jun 2020 07:21:08 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E1CDE3F6CF;
        Thu, 18 Jun 2020 07:21:07 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id AB6D7682B9C; Thu, 18 Jun 2020 15:21:06 +0100 (BST)
Date:   Thu, 18 Jun 2020 15:21:06 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     David Airlie <airlied@linux.ie>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/arm: fix unintentional integer overflow on left shift
Message-ID: <20200618142106.GK159988@e110455-lin.cambridge.arm.com>
References: <20200618100400.11464-1-colin.king@canonical.com>
 <20200618121405.GJ159988@e110455-lin.cambridge.arm.com>
 <5d08fbec-75d8-d9a9-af61-e6ab98e77c80@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d08fbec-75d8-d9a9-af61-e6ab98e77c80@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 01:50:34PM +0100, Colin Ian King wrote:
> On 18/06/2020 13:14, Liviu Dudau wrote:
> > On Thu, Jun 18, 2020 at 11:04:00AM +0100, Colin King wrote:
> >> From: Colin Ian King <colin.king@canonical.com>
> > 
> > Hi Colin,
> > 
> >>
> >> Shifting the integer value 1 is evaluated using 32-bit arithmetic
> >> and then used in an expression that expects a long value leads to
> >> a potential integer overflow.
> > 
> > I'm afraid this explanation makes no sense to me. Do you care to explain better what
> > you think the issue is? If the shift is done as 32-bit arithmetic and then promoted
> > to long how does the overflow happen?
> 
> The shift is performed using 32 bit signed math and then assigned to an
> unsigned 64 bit long. This if the shift is 31 bits then the signed int
> conversion of 0x80000000 to unsigned long becomes 0xffffffff80000000.
> If the shift is more than 32 bits then result overflows and becomes 0x0.

You are right, I've missed the fact that it is signed math. Not very likely that
we are going to ever have 30 or more CRTCs in the driver, but Coverity has no
way of knowing that.

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

I will pull this into drm-misc-next today.

Best regards,
Liviu

> 
> Colin
> 
> > 
> > Best regards,
> > Liviu
> > 
> >> Fix this by using the BIT macro to
> >> perform the shift to avoid the overflow.
> >>
> >> Addresses-Coverity: ("Unintentional integer overflow")
> >> Fixes: ad49f8602fe8 ("drm/arm: Add support for Mali Display Processors")
> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >> ---
> >>  drivers/gpu/drm/arm/malidp_planes.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
> >> index 37715cc6064e..ab45ac445045 100644
> >> --- a/drivers/gpu/drm/arm/malidp_planes.c
> >> +++ b/drivers/gpu/drm/arm/malidp_planes.c
> >> @@ -928,7 +928,7 @@ int malidp_de_planes_init(struct drm_device *drm)
> >>  	const struct malidp_hw_regmap *map = &malidp->dev->hw->map;
> >>  	struct malidp_plane *plane = NULL;
> >>  	enum drm_plane_type plane_type;
> >> -	unsigned long crtcs = 1 << drm->mode_config.num_crtc;
> >> +	unsigned long crtcs = BIT(drm->mode_config.num_crtc);
> >>  	unsigned long flags = DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_180 |
> >>  			      DRM_MODE_ROTATE_270 | DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y;
> >>  	unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
> >> -- 
> >> 2.27.0.rc0
> >>
> > 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
