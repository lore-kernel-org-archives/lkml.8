Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2475C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0D0120707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728013AbgHZJTC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:19:02 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:44529 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727793AbgHZJS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:18:58 -0400
X-Originating-IP: 90.89.180.255
Received: from lhopital-XPS-13-9360 (lfbn-tou-1-1372-bdcst.w90-89.abo.wanadoo.fr [90.89.180.255])
        (Authenticated sender: kevin.lhopital@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 02DA62001E;
        Wed, 26 Aug 2020 09:18:50 +0000 (UTC)
Date:   Wed, 26 Aug 2020 11:18:50 +0200
From:   =?UTF-8?B?S8OpdmluIEwnaMO0cGl0YWw=?= <kevin.lhopital@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Yong Deng <yong.deng@magewell.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/7] media: sun6i-csi: Fix the bpp for 10-bit bayer
 formats
Message-ID: <20200826111850.06cbe400@lhopital-XPS-13-9360>
In-Reply-To: <CAGb2v65enzLHdK09-8Nm7=YU9-bRP=0Q+BXjXah6MZR2-y=zrA@mail.gmail.com>
References: <20200821145935.20346-1-kevin.lhopital@bootlin.com>
        <20200821145935.20346-2-kevin.lhopital@bootlin.com>
        <CAGb2v65enzLHdK09-8Nm7=YU9-bRP=0Q+BXjXah6MZR2-y=zrA@mail.gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Le Tue, 25 Aug 2020 23:50:30 +0800,
Chen-Yu Tsai <wens@csie.org> a écrit :

> On Fri, Aug 21, 2020 at 11:00 PM Kévin L'hôpital
> <kevin.lhopital@bootlin.com> wrote:
> >
> > 10-bit bayer formats are aligned to 16 bits in memory, so this is
> > what needs to be used as bpp for calculating the size of the
> > buffers to allocate.
> >
> > Signed-off-by: Kévin L'hôpital <kevin.lhopital@bootlin.com>  
> 
> Please add:
> 
> Fixes: 5cc7522d8965 ("media: sun6i: Add support for Allwinner CSI
> V3s")
> 
> 
I will add this, thank you very much for the review.
Kévin
> 
> > ---
> >  drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h
> > b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h index
> > c626821aaedb..8b83d15de0d0 100644 ---
> > a/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h +++
> > b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.h @@ -100,7
> > +100,7 @@ static inline int sun6i_csi_get_bpp(unsigned int
> > pixformat) case V4L2_PIX_FMT_SGBRG10: case V4L2_PIX_FMT_SGRBG10:
> >         case V4L2_PIX_FMT_SRGGB10:
> > -               return 10;
> > +               return 16;
> >         case V4L2_PIX_FMT_SBGGR12:
> >         case V4L2_PIX_FMT_SGBRG12:
> >         case V4L2_PIX_FMT_SGRBG12:
> > --
> > 2.17.1
> >  



-- 
Kevin L'Hopital, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
