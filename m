Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0824EC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D704320732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgBXKo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:44:57 -0500
Received: from verein.lst.de ([213.95.11.211]:37269 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgBXKo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:44:57 -0500
Received: by verein.lst.de (Postfix, from userid 2005)
        id 18C1568AFE; Mon, 24 Feb 2020 11:44:53 +0100 (CET)
Date:   Mon, 24 Feb 2020 11:44:52 +0100
From:   Torsten Duwe <duwe@lst.de>
To:     Icenowy Zheng <icenowy@aosc.io>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime@cerno.tech>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: analogix-anx6345: fix set of link bandwidth
Message-ID: <20200224104452.GA31184@lst.de>
References: <20200221165127.813325-1-icenowy@aosc.io> <20200221171328.GC6928@lst.de> <1E7BDB0F-639B-42BB-A4B4-A4C8CF94EBE0@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1E7BDB0F-639B-42BB-A4B4-A4C8CF94EBE0@aosc.io>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 10:43:02AM +0800, Icenowy Zheng wrote:
> 
> 
> 于 2020年2月22日 GMT+08:00 上午1:13:28, Torsten Duwe <duwe@lst.de> 写到:
> >On Sat, Feb 22, 2020 at 12:51:27AM +0800, Icenowy Zheng wrote:
> >> Current code tries to store the link rate (in bps, which is a big
> >> number) in a u8, which surely overflow. Then it's converted back to
> >> bandwidth code (which is thus 0) and written to the chip.
> >> 
> >> The code sometimes works because the chip will automatically fallback
> >to
> >> the lowest possible DP link rate (1.62Gbps) when get the invalid
> >value.
> >> However, on the eDP panel of Olimex TERES-I, which wants 2.7Gbps
> >link,
> >> it failed.
> >> 
> >> As we had already read the link bandwidth as bandwidth code in
> >earlier
> >> code (to check whether it is supported), use it when setting
> >bandwidth,
> >> instead of converting it to link rate and then converting back.
> >> 
> >> Fixes: e1cff82c1097 ("drm/bridge: fix anx6345 compilation for v5.5")
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> >> ---
> >>  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >> 
> >> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> >b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> >> index 56f55c53abfd..2dfa2fd2a23b 100644
> >> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> >> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
> >> @@ -210,8 +210,7 @@ static int anx6345_dp_link_training(struct
> >anx6345 *anx6345)
> >>  	if (err)
> >>  		return err;
> >>  
> >> -	dpcd[0] = drm_dp_max_link_rate(anx6345->dpcd);
> >> -	dpcd[0] = drm_dp_link_rate_to_bw_code(dpcd[0]);
> >> +	dpcd[0] = dp_bw;
> >
> >Why do you make this assignment and not use dp_bw directly in the call?
> 
> Because the dpcd array is then written as a continous array
> back to DPCD.

But the current code never changes this value?
Anyway, as this might change in the future, I support your version;
I want to see this fixed.

Reviewed-by: Torsten Duwe <duwe@suse.de>
Fixes: e1cff82c1097 ("drm/bridge: fix anx6345 compilation for v5.5")
Cc: Maxime Ripard <maxime@cerno.tech>
Cc: Torsten Duwe <duwe@lst.de>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Icenowy Zheng <icenowy@aosc.io>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>

> >
> >>  	err = regmap_write(anx6345->map[I2C_IDX_DPTX],
> >>  			   SP_DP_MAIN_LINK_BW_SET_REG, dpcd[0]);
> >                                                       ^^^^^^
> >>  	if (err)
> >> -- 
> >> 2.24.1
> >
> >BTW, my version is only a bit more verbose:
> >
> >https://patchwork.freedesktop.org/patch/354344/
> >
> >	Torsten
> 
> -- 
> 使用 K-9 Mail 发送自我的Android设备。
