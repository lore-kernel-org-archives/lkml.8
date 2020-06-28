Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D87C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AFBE20773
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgF1Hww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 03:52:52 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:43150 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgF1Hwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 03:52:51 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 0AEF22002B;
        Sun, 28 Jun 2020 09:52:46 +0200 (CEST)
Date:   Sun, 28 Jun 2020 09:52:45 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] drm/panel-simple: Add missing BUS descriptions
 for some panels
Message-ID: <20200628075245.GA128039@ravnborg.org>
References: <20200621222742.25695-1-digetx@gmail.com>
 <20200621222742.25695-3-digetx@gmail.com>
 <20200627204338.GL5966@pendragon.ideasonboard.com>
 <dd1c5972-bbac-c2d8-76e8-08997b951e52@gmail.com>
 <20200628070745.GC6954@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200628070745.GC6954@pendragon.ideasonboard.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=IkcTkHD0fZMA:10 a=P1BnusSwAAAA:8 a=pGLkceISAAAA:8
        a=gXmQgUmAU1xYsUhDFicA:9 a=QEXdDO2ut3YA:10 a=D0XLA9XvdZm18NrgonBM:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent.

On Sun, Jun 28, 2020 at 10:07:45AM +0300, Laurent Pinchart wrote:
> Hi Dmitry,
> 
> On Sun, Jun 28, 2020 at 02:44:15AM +0300, Dmitry Osipenko wrote:
> > 27.06.2020 23:43, Laurent Pinchart пишет:
> > > On Mon, Jun 22, 2020 at 01:27:42AM +0300, Dmitry Osipenko wrote:
> > >> This patch adds missing BUS fields to the display panel descriptions of
> > >> the panels which are found on NVIDIA Tegra devices:
> > >>
> > >>   1. AUO B101AW03
> > >>   2. Chunghwa CLAA070WP03XG
> > >>   3. Chunghwa CLAA101WA01A
> > >>   4. Chunghwa CLAA101WB01
> > >>   5. Innolux N156BGE L21
> > >>   6. Samsung LTN101NT05
> > >>
> > >> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > >> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> > >> ---
> > >>  drivers/gpu/drm/panel/panel-simple.c | 12 ++++++++++++
> > >>  1 file changed, 12 insertions(+)
> > >>
> > >> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > >> index 87edd2bdf09a..986df9937650 100644
> > >> --- a/drivers/gpu/drm/panel/panel-simple.c
> > >> +++ b/drivers/gpu/drm/panel/panel-simple.c
> > >> @@ -698,6 +698,8 @@ static const struct panel_desc auo_b101aw03 = {
> > >>  		.width = 223,
> > >>  		.height = 125,
> > >>  	},
> > >> +	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
> > >> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
> > > 
> > > Does DRM_BUS_FLAG_PIXDATA_DRIVE_* make sense for LVDS ?
> > 
> > To be honest I don't know whether it make sense or not for LVDS. I saw
> > that other LVDS panels in panel-simple.c use the PIXDATA flag and then
> > looked at what timing diagrams in the datasheets show.
> 
> I think we should drop DRM_BUS_FLAG_PIXDATA_DRIVE_* for LVDS panels.
> I'll submit a patch.

We should also clean up all the DRM_BUS_FLAG_* one day.
No need for the deprecated values, so a few files needs an update.
And we could document what flags makes sense for LVDS etc.

On the TODO list...

	Sam
> 
> > > The rest looks good, except the Samsung panel for which I haven't been
> > > able to locate a datasheet.
> > > 
> > > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Thanks to you and Sam!
> 
> -- 
> Regards,
> 
> Laurent Pinchart
