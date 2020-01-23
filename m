Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D25C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7E821D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 19:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgAWTuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:50:05 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:54180 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgAWTuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 14:50:04 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 763698046E;
        Thu, 23 Jan 2020 20:50:00 +0100 (CET)
Date:   Thu, 23 Jan 2020 20:49:59 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: linux-next: Tree for Jan 23 (gpu/drm/panel/)
Message-ID: <20200123194959.GA25073@ravnborg.org>
References: <20200123172101.2f31947c@canb.auug.org.au>
 <098616df-a696-9544-5ca2-c84ce9980999@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <098616df-a696-9544-5ca2-c84ce9980999@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=92UefTgV_KLRBibrx7QA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy.

Thanks - I think (kidding, this has bugged of for a long time).

On Thu, Jan 23, 2020 at 12:44:25AM -0800, Randy Dunlap wrote:
> On 1/22/20 10:21 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20200122:
> > 
> 
> 
> on i386:
> 
> ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-sharp-lq101r1sx01.ko] undefined!
> ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-rocktech-jh057n00900.ko] undefined!
> ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-raydium-rm68200.ko] undefined!
> ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.ko] undefined!
> ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.ko] undefined!
> ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-olimex-lcd-olinuxino.ko] undefined!
> ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-leadtek-ltk500hd1829.ko] undefined!
> ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.ko] undefined!
> ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-innolux-p079zca.ko] undefined!
> ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-ilitek-ili9881c.ko] undefined!
> ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-lvds.ko] undefined!
> ERROR: "drm_panel_of_backlight" [drivers/gpu/drm/panel/panel-boe-himax8279d.ko]
> 
> 
> Full randconfig file is attached.

I tried reproducing with latest drm-misc-next - no luck.

Can you check if you have:

8d6cb2f7fb90018d9e3efdc9bc95e6da213a352f
    drm/drm_panel: fix export of drm_panel_of_backlight, try #3


As we expect this to fix it for good.
Maybe the patch has not hit the right tree
and is thus not in -next.

	Sam
