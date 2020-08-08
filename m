Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D30CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 08:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47EEA221E2
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 08:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgHHIKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 04:10:35 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:40630 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgHHIKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 04:10:35 -0400
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 646CD20028;
        Sat,  8 Aug 2020 10:10:25 +0200 (CEST)
Date:   Sat, 8 Aug 2020 10:10:24 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Joe Perches <joe@perches.com>
Cc:     dri-devel@lists.freedesktop.org, opensource.kernel@vivo.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Stefan Mavrodiev <stefan@olimex.com>,
        David Airlie <airlied@linux.ie>,
        Bernard Zhao <bernard@vivo.com>,
        Jerry Han <hanxu5@huaqin.corp-partner.google.com>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Robert Chiras <robert.chiras@nxp.com>,
        Icenowy Zheng <icenowy@aosc.io>
Subject: Re: [PATCH V2] drm: Remove unnecessary drm_panel_attach and
 drm_panel_detach
Message-ID: <20200808081024.GA1716759@ravnborg.org>
References: <20200801120216.8488-1-bernard@vivo.com>
 <20200802070743.GA822300@ravnborg.org>
 <f1fbc362695af155a30627ef69b375e8a3daaa55.camel@perches.com>
 <20200802084411.GA908790@ravnborg.org>
 <9e13761020750b1ce2f1fabee23ef6e2a2942882.camel@perches.com>
 <20200802173413.GA343746@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200802173413.GA343746@ravnborg.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=f+hm+t6M c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=IkcTkHD0fZMA:10 a=IJv9LcIfAAAA:8 a=klGKM5VlYPBqXGvcqpQA:9
        a=QEXdDO2ut3YA:10 a=cmr4hm9N53k6aw-X_--Q:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe.

On Sun, Aug 02, 2020 at 07:34:13PM +0200, Sam Ravnborg wrote:
> Hi Joe.
> 
> On Sun, Aug 02, 2020 at 09:43:59AM -0700, Joe Perches wrote:
> > These functions are now empty and no longer
> > useful so remove the functions and their uses.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> > 
> > > > It's too tedious to break apart into multiple patches.
> > > > Done with coccinelle and typing.
> > > > 
> > > > Compiled allyesconfig x86-64 only.
> > 
> > V2: Removed 3 additional lines
> > 
> > drivers/gpu/drm/omapdrm/omap_drv.c:390:27: warning: unused variable ‘priv’ [-Wunused-variable]
> > drivers/gpu/drm/exynos/exynos_drm_dpi.c:45:21: warning: unused variable ‘ctx’ [-Wunused-variable]
> > drivers/gpu/drm/sun4i/sun4i_lvds.c:57:21: warning: unused variable ‘lvds’ [-Wunused-variable]
> 
> Thanks, better now.
> 
> I had to fix a few warnings and a build error to get it going on
> drm-misc-next. I will keep it locally just to let anyone speak up.
> I you do not see any mail from me until friday that it is applied please
> ping me.
Thanks, Now applied to drm-misc-next. Will show up in -next sometimes after the
current merge window closes.

	Sam
