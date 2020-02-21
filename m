Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48018C35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AF9724653
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Wg9/Uy3u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgBUPFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:05:41 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:51738 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbgBUPFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:05:40 -0500
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5114E563;
        Fri, 21 Feb 2020 16:05:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1582297538;
        bh=+PNfg4uEi08dmlNNvtGKnwrRV4kPZIDZ1TGvGbACPug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wg9/Uy3u8ceD8NzGdv6JVmxnbWJTbjKODlEKfeJd3QrKb/r6JGJvHijgSbNp4OIPa
         ruuf7fBXDd0sMFZ9JE+UPPnnpyJZM7WsT7fBin1/MsPR7EfwZesD++03YcbYI7Uq+M
         zApSmBZLNAAqJM+bEmGIfXH3DljXscmENRrapfDI=
Date:   Fri, 21 Feb 2020 17:05:18 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Torsten Duwe <duwe@lst.de>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <treding@nvidia.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [RESEND2][PATCH] drm/bridge: analogix-anx6345: Fix drm_dp_link
 helper removal
Message-ID: <20200221150518.GK4955@pendragon.ideasonboard.com>
References: <20200221140455.8713068BFE@verein.lst.de>
 <b30435c7-95c5-e21e-ea05-cd3ada20d150@suse.de>
 <20200221150117.GA6928@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200221150117.GA6928@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Torsten,

On Fri, Feb 21, 2020 at 04:01:17PM +0100, Torsten Duwe wrote:
> On Fri, Feb 21, 2020 at 03:39:32PM +0100, Thomas Zimmermann wrote:
> > Am 21.02.20 um 15:04 schrieb Torsten Duwe:
> > > drm_dp_link_rate_to_bw_code and ...bw_code_to_link_rate simply divide by
> > > and multiply with 27000, respectively. Avoid an overflow in the u8 dpcd[0]
> > > and the multiply+divide alltogether.
> > > 
> > > fixes: e1cff82c1097bda2478 ("fix anx6345 compilation for v5.5")
> > 
> > You have to create the fixes tag and related cc tags with 'dim fixes',
> > available at [1]. For this patch, the output is
> > 
> > Fixes: e1cff82c1097 ("drm/bridge: fix anx6345 compilation for v5.5")
> > Cc: Torsten Duwe <duwe@suse.de>
> > Cc: Maxime Ripard <maxime@cerno.tech>
> > Cc: Torsten Duwe <duwe@lst.de>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: Icenowy Zheng <icenowy@aosc.io>
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> 
> Ah, neat.
> 
> > > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > 
> > You signed off with your SUSE email address, but sent the mail from
> > lst.de. I don't know if it's strictly not allowed, but that's at least
> > confusing to the tools.
> 
> From my understanding, it is legally correct. The work is owned by Suse,
> so I have to sign off as an employee, but I'm subscribed with the LST
> address, and I'd also like to see all replies there.

That's fine, but then the mail body should start with a From: line that
matches the address used in Signed-off-by. git-send-email should
generate that automatically.

> > [1] https://gitlab.freedesktop.org/drm/maintainer-tools/
> 
> I'll send an appropriate v2 once I get a review for it.

-- 
Regards,

Laurent Pinchart
