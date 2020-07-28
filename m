Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243CFC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E655C2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 22:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VomaKcFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgG1Wfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 18:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbgG1Wfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 18:35:54 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEF9C061794;
        Tue, 28 Jul 2020 15:35:54 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ACCD7563;
        Wed, 29 Jul 2020 00:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1595975752;
        bh=vliL54QKa1F6SxBCTfJKHAv2UhgWOg86DJA+2YvF06g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VomaKcFOR7zTGlu9YGdE96U6xDVq22P9SipsjOJ6FR3ZL5qtlPJWIPtnZ/Ad2Py46
         ixyoKDvr+4GHfrxKcW4o7qBC+0iH++lD62nV3QMu77ekXPhUBtyVv8q71j8JduFam+
         6pJ1q0I9Ire+wL4RJRtzqnIuVuUwlTg4I7QQVvqA=
Date:   Wed, 29 Jul 2020 01:35:43 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     daniel@ffwll.ch
Cc:     Hyun Kwon <hyun.kwon@xilinx.com>, David Airlie <airlied@linux.ie>,
        Michal Simek <michal.simek@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] drm: xlnx: Fix typo in parameter description
Message-ID: <20200728223543.GU13753@pendragon.ideasonboard.com>
References: <20200725063429.172139-1-weiyongjun1@huawei.com>
 <20200728220205.GJ6419@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728220205.GJ6419@phenom.ffwll.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 12:02:05AM +0200, daniel@ffwll.ch wrote:
> Hi Hyun Kwon,
> 
> Are you all sorted with drm-misc commit rights so you can push the 3
> (maybe there's more) xlnx fixup patches to drm-misc-next-fixes?

Thanks Daniel for bringing this up.

Hyun, would that work for you ?

> On Sat, Jul 25, 2020 at 06:34:29AM +0000, Wei Yongjun wrote:
> > Fix typo in parameter description.
> > 
> > Fixes: d76271d22694 ("drm: xlnx: DRM/KMS driver for Xilinx ZynqMP DisplayPort Subsystem")
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > ---
> >  drivers/gpu/drm/xlnx/zynqmp_dp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > index 821f7a71e182..3d53638ab15e 100644
> > --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> > @@ -44,7 +44,7 @@ MODULE_PARM_DESC(aux_timeout_ms, "DP aux timeout value in msec (default: 50)");
> >   */
> >  static uint zynqmp_dp_power_on_delay_ms = 4;
> >  module_param_named(power_on_delay_ms, zynqmp_dp_power_on_delay_ms, uint, 0444);
> > -MODULE_PARM_DESC(aux_timeout_ms, "DP power on delay in msec (default: 4)");
> > +MODULE_PARM_DESC(power_on_delay_ms, "DP power on delay in msec (default: 4)");
> >  
> >  /* Link configuration registers */
> >  #define ZYNQMP_DP_LINK_BW_SET				0x0

-- 
Regards,

Laurent Pinchart
