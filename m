Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4275DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 05:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AB0B2074B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 05:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgFDFTs convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 01:19:48 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:39551 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgFDFTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 01:19:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id a9so2079314ljn.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 22:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CDYCwrGwgyePOxlS0CraEvHzE1DftCgl+yxJsEBFx8c=;
        b=JhzRdx8BJGN8tiYa6AAxpCqVsAuOyNAIrPoL9FYfAmrcS/00J9CTMFLVjzZcUuft30
         KrZZqarp/xDGm0vYKsKqyA7nVoQRGoLCI/euQ4Kq+Zh0FqueZjaUmq/y4a9SzKfhUDfH
         dB0U6lIJDQLz6IXl8qT40vjvWtgTcNtfrh0xwEScuQ6KdNA9V//I7ibwvh7f+9BtGEty
         4covMqDnT2VMT8kEuK6fc1hxjWovZM+i49IDOpCnREN42qOF/0YXpID/DosuYR9XKfJl
         kpPwBupZUdSTQn70ba1jvx7aaIydtnhbVf33jXiJXua3Wx5KfLWSbmPTSwpPXWbuHd9l
         Tpgw==
X-Gm-Message-State: AOAM530A9/iFGzVhO3NzLgWwJlVCZjxWEnv51fY/IIKYKc9xUzveCqKH
        LegJmtRNFTo22nfRUmsVIpF00xoDbMI=
X-Google-Smtp-Source: ABdhPJyXW8H/eCk2SNRvD/B6QSUvLqnignl92jZLVMtmhXVbcTUHeEXZQetzbdeB8b1vOUp5GtCjnQ==
X-Received: by 2002:a2e:8290:: with SMTP id y16mr1281144ljg.340.1591247983665;
        Wed, 03 Jun 2020 22:19:43 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id t12sm951927ljj.139.2020.06.03.22.19.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 22:19:43 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id c11so5664340ljn.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 22:19:43 -0700 (PDT)
X-Received: by 2002:a2e:9246:: with SMTP id v6mr1269112ljg.47.1591247982979;
 Wed, 03 Jun 2020 22:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200413095457.1176754-1-jernej.skrabec@siol.net>
 <1742537.tdWV9SEqCh@jernej-laptop> <20200415104214.ndkkxfnufkxgu53r@gilmour.lan>
 <1785843.taCxCBeP46@jernej-laptop> <20200422092300.444wcaurdwyrorow@gilmour.lan>
In-Reply-To: <20200422092300.444wcaurdwyrorow@gilmour.lan>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 4 Jun 2020 13:19:32 +0800
X-Gmail-Original-Message-ID: <CAGb2v64++4rxcwdQXgz30vNbRRR5+tXehP-CFu9T7Lx7K_QOOw@mail.gmail.com>
Message-ID: <CAGb2v64++4rxcwdQXgz30vNbRRR5+tXehP-CFu9T7Lx7K_QOOw@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: hdmi ddc clk: Fix size of m divider
To:     Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 5:23 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Wed, Apr 15, 2020 at 07:52:28PM +0200, Jernej Škrabec wrote:
> > Dne sreda, 15. april 2020 ob 12:42:14 CEST je Maxime Ripard napisal(a):
> > > On Mon, Apr 13, 2020 at 06:09:08PM +0200, Jernej Škrabec wrote:
> > > > Dne ponedeljek, 13. april 2020 ob 16:12:39 CEST je Chen-Yu Tsai
> > napisal(a):
> > > > > On Mon, Apr 13, 2020 at 6:11 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > > > > > On Mon, Apr 13, 2020 at 5:55 PM Jernej Skrabec
> > > > > > <jernej.skrabec@siol.net>
> > > >
> > > > wrote:
> > > > > > > m divider in DDC clock register is 4 bits wide. Fix that.
> > > > > > >
> > > > > > > Fixes: 9c5681011a0c ("drm/sun4i: Add HDMI support")
> > > > > > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > > > >
> > > > > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > > > >
> > > > > Cc stable?
> > > >
> > > > I don't think it's necessary:
> > > > 1. It doesn't change much (anything?) for me when reading EDID. I don't
> > > > think it's super important to have precise DDC clock in order to properly
> > > > read EDID. 2. No matter if it has "Cc stable" tag or not, it will be
> > > > eventually picked for stable due to fixes tag.
> > > >
> > > > This was only small observation when I was researching EDID readout issue
> > > > on A20 board, but sadly, I wasn't able to figure out why reading it
> > > > sometimes fails. I noticed similar issue on SoCs with DE2 (most
> > > > prominently on OrangePi PC2 - H5), but there was easy workaround - I just
> > > > disabled video driver in U- Boot. However, if A20 display driver gets
> > > > disabled in U-Boot, it totally breaks video output on my TV when Linux
> > > > boots (no output). I guess there is more fundamental problem with clocks
> > > > than just field size. I think we should add more constraints in clock
> > > > driver, like preset some clock parents and not allow to change parents
> > > > when setting rate, but carefully, so simplefb doesn't break. Such
> > > > constraints should also solve problems with dual head setups.
> > > I disagree here. Doing all sorts of special case just doesn't scale,
> > > and we'll never have the special cases sorted out on all the boards
> > > (and it's a nightmare to maintain).
> > >
> > > Especially since it's basically putting a blanket over the actual
> > > issue and looking the other way. If there's something wrong with how
> > > we deal with (re)parenting, we should fix that. It impacts more than
> > > just DRM, and all the SoCs.
> >
> > I agree with you that automatic solution would be best, but I just don't see
> > it how it would be done.
>
> > Dual head display pipeline is pretty complex for clock driver to get it right
> > on it's own. There are different possible setups and some of them are hot
> > pluggable, like HDMI.
>
> Do you have an actual scenario that is broken right now?
>
> > And there are also SoC specific quirks, like A64, where for some reason, MIPI
> > DPHY and HDMI PHY share same clock parent - PLL_VIDEO0. Technically, MIPI DPHY
> > can be clocked from PLL_PERIPH0 (fixed to 600 MHz), but that's not really
> > helpful. I'm not even sure if there is any good solution to this - certainly
> > HDMI and MIPI can't claim exclusivity and somehow best common rate must be
> > found for PLL_VIDEO0, if that's even possible.
>
> IIRC the DSI DPHY needs a clock running at 297MHz, which is pretty much what the
> HDMI PHY should need too (or 148.5, but that's pretty easy to generate from
> 297). So which problem do we have there?
>
> > I was sure that HDMI PHY on A64 can be clocked from PLL_VIDEO1, which would
> > solve main issue, but to date, I didn't find any way to do that.
> >
> > That's pretty off topic, so I hope original patch can be merged as-is.
>
> It does, sorry
>
> Acked-by: Maxime Ripard <maxime@cerno.tech>

Looks like this hasn't landed yet.

ChenYu
