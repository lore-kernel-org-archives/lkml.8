Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5845C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966732072D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584637591;
	bh=aP9ejx7SnCaC82qYc3Vt82pK0yL3U36c8HGf9fweu5k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qKsLVA7fyYDk2xf1s4EkrZ0M+paxvPO5ab3ffAKhIaX3NHlRkf6ivepoSrliz1BRs
	 8p3dVK7LJwBRCvW9hmmFiUXI9kyc0tcQX6+mdGUSh2/mTW9NoVcW0pXZRHdc442Tl6
	 rYUucj2rjx/4B6lCW93yKqXZvbsMSCRC4gs6J9Kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgCSRGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:06:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:49762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727252AbgCSRGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:06:30 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A473207FC;
        Thu, 19 Mar 2020 17:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584637589;
        bh=aP9ejx7SnCaC82qYc3Vt82pK0yL3U36c8HGf9fweu5k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XM2Syf+m0FPM5y451GLPJloUXJW+SHrVz3gtS+F2kYAKF+JPMq3t3kxXd4T9UhQdu
         /DH4w1/T/X5JYOS05FN7SiXn2ToTRs263m3yh9l2+FLCPiM2rAy/w8VoC0pGi89aVS
         MA5ixdCa2OTXbTW7xAYxhbsETQydP+Xw8No5Ku/I=
Received: by mail-qt1-f172.google.com with SMTP id t13so2422200qtn.13;
        Thu, 19 Mar 2020 10:06:29 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2rF099seJU1ow3pV63h8W07xUaoYtWv8b1tllhmYdPwuLqWtC9
        XtklYob0ZKTwB+fWNiMz267qk6UqeP15fucQpg==
X-Google-Smtp-Source: ADFU+vt+yFqWedpHLHifVRY04DtI47w8tUOPVx49UqRoZIuaFPvx2qIUuM2+JMkhxWeFf5AgL90mTKdywpKvgvFxzBQ=
X-Received: by 2002:ac8:59:: with SMTP id i25mr4039750qtg.110.1584637586896;
 Thu, 19 Mar 2020 10:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAGWqDJ7AccvoxjKfQJ3GytJ-+u56Bk3rEn0sSYv-zCuBe1brAg@mail.gmail.com>
 <CAL_JsqLz-0myc-PSSaCQWDFXQx+=X9nBSXWsJaGCVqTFn0d5kw@mail.gmail.com> <CAGWqDJ4yA4ikz5MwQQwW8CAvE_dt16iuvN6cKRL2DdAuw8QWww@mail.gmail.com>
In-Reply-To: <CAGWqDJ4yA4ikz5MwQQwW8CAvE_dt16iuvN6cKRL2DdAuw8QWww@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 19 Mar 2020 11:06:15 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLU4kEmRnXhQ5+gP-ZisS2Za+s6mNFg4RnMdpDtDRQB3g@mail.gmail.com>
Message-ID: <CAL_JsqLU4kEmRnXhQ5+gP-ZisS2Za+s6mNFg4RnMdpDtDRQB3g@mail.gmail.com>
Subject: Re: graph connection to node is not bidirectional kernel-5.6.0-rc6
To:     Vinay Simha B N <simhavcs@gmail.com>
Cc:     "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 9:56 AM Vinay Simha B N <simhavcs@gmail.com> wrote:
>
> On Thu, Mar 19, 2020 at 9:16 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, Mar 19, 2020 at 1:31 AM Vinay Simha B N <simhavcs@gmail.com> wrote:
> > >
> > > hi,
> > >
> > > I am getting the endpoint' is not bidirectional(d2l_in, dsi0_out)
> > > warning in compilation, built boot image works on qcom apq8016-ifc6309
> > > board with the dsi->bridge->lvds panel.
> > > Because of this warning i cannot create a .yaml documentation examples.
> > > Please suggest.
> > >
> > > tc_bridge: bridge@f {
> >
> >              ^^^^^^^^
> >
> > > arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi:253.28-255.9: Warning
> > > (graph_endpoint): /soc/i2c@78b8000/bridge@39/ports/port@0/endpoint:
> >
> >                                      ^^^^^^^^^
> >
> > Looks like you have 2 different bridges.
> >
> i had two bridges, if we disable one bridge also we get the warning
>
> arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi:333.53-335.35: Warning
> (graph_endpoint): /soc/auo,b101xtn01/port/endpoint: graph connection
> to node '/soc/i2c@78b8000/bridge@f/ports/port@1/endpoint' is not
> bidirectional

You can't just disable nodes. To switch which bridge is enabled, you
already have to modify remote-endpoint at the other end. So the
requirement is you have to modify both 'remote-endpoint' properties
(or really all 3).

The other options is if you want both connections described, then you
need 2 'endpoint' nodes to connect both bridges.
