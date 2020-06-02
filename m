Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA762C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89F672072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 23:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="O+jYNNIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgFBX3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 19:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgFBX26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 19:28:58 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAEEC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 16:28:58 -0700 (PDT)
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B9A4F2A4;
        Wed,  3 Jun 2020 01:28:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1591140535;
        bh=lXkvj1T0Wpo9a3y6ncv9G8LcEGUh4n2+D7BDgxV7xmQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+jYNNIuc7Edhz9qSOLPWtjOOspHJR6sOJ1VTxt8mWv7PTUD4KHv7Bi52BjyGkW/r
         SPcKr1108TkGVpYbGcMD7VIXIU62iM61DoNwRVoD/AdEqW+0hQ9RoWYbslQsQwt1yr
         +GtD4Yiq4fY+j0DmdUIkbriof9U9ZSvbUBZh1Hwg=
Date:   Wed, 3 Jun 2020 02:28:40 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     sandor.yu@nxp.com, Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
        Sandy Huang <hjc@rock-chips.com>, dkos@cadence.com,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        linux-rockchip <linux-rockchip@lists.infradead.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        LAKML <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 1/7] drm/rockchip: prepare common code for cdns and rk
 dpi/dp driver
Message-ID: <20200602232840.GP6547@pendragon.ideasonboard.com>
References: <cover.1590982881.git.Sandor.yu@nxp.com>
 <d3d707cf37e7928a839071242c752779061cc094.1590982881.git.Sandor.yu@nxp.com>
 <CACvgo52NeUSQV5p8+4DkCjpkv12cs8fCkQqy4MFn8pVaorVaHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACvgo52NeUSQV5p8+4DkCjpkv12cs8fCkQqy4MFn8pVaorVaHg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 02:55:52PM +0100, Emil Velikov wrote:
> On Mon, 1 Jun 2020 at 07:29, <sandor.yu@nxp.com> wrote:
> >
> > From: Sandor Yu <Sandor.yu@nxp.com>
> >
> > - Extracted common fields from cdn_dp_device to a new cdns_mhdp_device
> >   structure which will be used by two separate drivers later on.
> > - Moved some datatypes (audio_format, audio_info, vic_pxl_encoding_format,
> >   video_info) from cdn-dp-core.c to cdn-dp-reg.h.
> > - Changed prefixes from cdn_dp to cdns_mhdp
> >     cdn -> cdns to match the other Cadence's drivers
> >     dp -> mhdp to distinguish it from a "just a DP" as the IP underneath
> >       this registers map can be a HDMI (which is internally different,
> >       but the interface for commands, events is pretty much the same).
> > - Modified cdn-dp-core.c to use the new driver structure and new function
> >   names.
> > - writel and readl are replaced by cdns_mhdp_bus_write and
> >   cdns_mhdp_bus_read.
> >
> The high-level idea is great - split, refactor and reuse the existing drivers.
> 
> Although looking at the patches themselves - they seems to be doing
> multiple things at once.
> As indicated by the extensive list in the commit log.
> 
> I would suggest splitting those up a bit, roughly in line of the
> itemisation as per the commit message.
> 
> Here is one hand wavy way to chunk this patch:
>  1) use put_unalligned*
>  2) 'use local variable dev' style of changes (as seem in cdn_dp_clk_enable)
>  3) add writel/readl wrappers
>  4) hookup struct cdns_mhdp_device, keep dp->mhdp detail internal.
> The cdn-dp-reg.h function names/signatures will stay the same.
>  5) finalize the helpers - use mhdp directly, rename

I second this, otherwise review is very hard.

> Examples:
> 4)
>  static int cdn_dp_mailbox_read(struct cdn_dp_device *dp)
>  {
> +"  struct cdns_mhdp_device *mhdp = dp->mhdp;
>    int val, ret;
> 
> -  ret = readx_poll_timeout(readl, dp->regs + MAILBOX_EMPTY_ADDR,
> +  ret = readx_poll_timeout(readl, mhdp->regs_base + MAILBOX_EMPTY_ADDR,
> ...
>    return fancy_readl(dp, MAILBOX0_RD_DATA) & 0xff;
>  }
> 
> 5)
> -static int cdn_dp_mailbox_read(struct cdn_dp_device *dp)
> +static int mhdp_mailbox_read(struct cdns_mhdp_device *mhdp)
>  {
> -  struct cdns_mhdp_device *mhdp = dp->mhdp;
>    int val, ret;
> ...
> -  return fancy_readl(dp, MAILBOX0_RD_DATA) & 0xff;
> +  return cdns_mhdp_bus_read(mhdp, MAILBOX0_RD_DATA) & 0xff;
>  }

-- 
Regards,

Laurent Pinchart
