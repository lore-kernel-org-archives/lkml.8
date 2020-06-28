Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B610C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 08:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BEE720773
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 08:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SYdIbHiF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgF1IC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 04:02:59 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:42932 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgF1IC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 04:02:58 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3BE854FB;
        Sun, 28 Jun 2020 10:02:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1593331376;
        bh=nESMEEzOIRljPa7RAK8ux5xjY76qkCuwalXmm9dYPSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SYdIbHiF9Bq1TVmfEgpI03wV7vnpqn34KS8O128xqXeK3NzTFCd2WZESfCf1WuJqJ
         T3PTnIEPcI8mp4C/8tfyc827Z0tUoNECApMEfw9ijOV9GLywyXsiHq54f+ABU8MLKL
         JWgeoyPs2lEZlqlYkU1OIUWNqyX69wli98bOzhBU=
Date:   Sun, 28 Jun 2020 11:02:53 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] drm/panel-simple: Add missing BUS descriptions
 for some panels
Message-ID: <20200628080253.GD6954@pendragon.ideasonboard.com>
References: <20200621222742.25695-1-digetx@gmail.com>
 <20200621222742.25695-3-digetx@gmail.com>
 <20200627204338.GL5966@pendragon.ideasonboard.com>
 <dd1c5972-bbac-c2d8-76e8-08997b951e52@gmail.com>
 <20200628070745.GC6954@pendragon.ideasonboard.com>
 <20200628075245.GA128039@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200628075245.GA128039@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Sun, Jun 28, 2020 at 09:52:45AM +0200, Sam Ravnborg wrote:
> On Sun, Jun 28, 2020 at 10:07:45AM +0300, Laurent Pinchart wrote:
> > On Sun, Jun 28, 2020 at 02:44:15AM +0300, Dmitry Osipenko wrote:
> >> 27.06.2020 23:43, Laurent Pinchart пишет:
> >>> On Mon, Jun 22, 2020 at 01:27:42AM +0300, Dmitry Osipenko wrote:
> >>>> This patch adds missing BUS fields to the display panel descriptions of
> >>>> the panels which are found on NVIDIA Tegra devices:
> >>>>
> >>>>   1. AUO B101AW03
> >>>>   2. Chunghwa CLAA070WP03XG
> >>>>   3. Chunghwa CLAA101WA01A
> >>>>   4. Chunghwa CLAA101WB01
> >>>>   5. Innolux N156BGE L21
> >>>>   6. Samsung LTN101NT05
> >>>>
> >>>> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>>> ---
> >>>>  drivers/gpu/drm/panel/panel-simple.c | 12 ++++++++++++
> >>>>  1 file changed, 12 insertions(+)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> >>>> index 87edd2bdf09a..986df9937650 100644
> >>>> --- a/drivers/gpu/drm/panel/panel-simple.c
> >>>> +++ b/drivers/gpu/drm/panel/panel-simple.c
> >>>> @@ -698,6 +698,8 @@ static const struct panel_desc auo_b101aw03 = {
> >>>>  		.width = 223,
> >>>>  		.height = 125,
> >>>>  	},
> >>>> +	.bus_format = MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
> >>>> +	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
> >>> 
> >>> Does DRM_BUS_FLAG_PIXDATA_DRIVE_* make sense for LVDS ?
> >> 
> >> To be honest I don't know whether it make sense or not for LVDS. I saw
> >> that other LVDS panels in panel-simple.c use the PIXDATA flag and then
> >> looked at what timing diagrams in the datasheets show.
> > 
> > I think we should drop DRM_BUS_FLAG_PIXDATA_DRIVE_* for LVDS panels.
> > I'll submit a patch.
> 
> We should also clean up all the DRM_BUS_FLAG_* one day.
> No need for the deprecated values, so a few files needs an update.
> And we could document what flags makes sense for LVDS etc.

Where would you add that documentation ? The hardest part is to find a
place that will be noticed by developers :-)

I've just submitted a patch that adds a WARN_ON to catch similar issues
in the panel-simple driver. It's not ideal as we really shouldn't have
such code in the kernel, this is something that should be caught as part
of the integration process.

> On the TODO list...
>
> >>> The rest looks good, except the Samsung panel for which I haven't been
> >>> able to locate a datasheet.
> >>> 
> >>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
