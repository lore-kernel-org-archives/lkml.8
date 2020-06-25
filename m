Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD720C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA68D2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 00:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593045655;
	bh=VT4fYgAE8cSrz3NM2ZpTOt2jz848PPE60lBQ+xXWg5w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Zar7vCBmkmZrLlBjrqWYAz/bjKmGLSLKpmy5K+NDuapymxPfyFFK0wICJPy6PgXGS
	 lZrkVANerTu6xqb/2v41NHq3jFZ+j8hH4968XyKr2MBZg33X929OXbLLHDOU6Q1KK2
	 tInnYpJa+p2YfZgGZv7IvlGAbaKIP25IhQLSmZsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388789AbgFYAky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 20:40:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:55998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388467AbgFYAkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 20:40:53 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 909F720781;
        Thu, 25 Jun 2020 00:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593045652;
        bh=VT4fYgAE8cSrz3NM2ZpTOt2jz848PPE60lBQ+xXWg5w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rmMTivuD0aTc1HQpvXP3fevFCP0FVrh7hk+y/hfHEJSRu4xrcQrT7u++bN1TRv0d+
         5AVf7VqGkzYeEsITcGarxtACbdYYgklqJUww1x7vvMLANKr7zodVRU8qrjsFVq2xDe
         7OllJugvKVmQcHlW5i63s5L3BJ47n5jlbGn4y9gc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <159261242477.62212.2251732478648139482@swboyd.mtv.corp.google.com>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <159255945796.62212.5838238989498858379@swboyd.mtv.corp.google.com> <bdc91c1b015d2f02bd0ea90ae81a122123c62b38.camel@suse.de> <159261103077.62212.7410836804489183937@swboyd.mtv.corp.google.com> <159261242477.62212.2251732478648139482@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH v5 00/27] clk: bcm: rpi: Add support for BCM2711 firmware clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, Tim Gover <tim.gover@raspberrypi.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To:     Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date:   Wed, 24 Jun 2020 17:40:51 -0700
Message-ID: <159304565187.62212.8773518296142750910@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-06-19 17:20:24)
> Quoting Stephen Boyd (2020-06-19 16:57:10)
> > Quoting Nicolas Saenz Julienne (2020-06-19 02:44:54)
> > > On Fri, 2020-06-19 at 02:37 -0700, Stephen Boyd wrote:
> > > > Quoting Maxime Ripard (2020-06-15 01:40:40)
> > > > > Hi,
> > > > >=20
> > > > > Since the whole DRM/HDMI support began to grow fairly big, I've c=
hosen
> > > > > to split away the two discussions between the firmware clocks and=
 the
> > > > > HDMI support.
> > > > >=20
> > > > > Let me know what you think,
> > > > > Maxime
> > > >=20
> > > > Do you want this to go through clk tree? Or looking for acks/review
> > > > tags?
> > > >=20
> > >=20
> > > FWIW I don't mind taking the device tree changes trough the RPi soc t=
ree.
> > >=20
> >=20
> > Sounds good.
> >=20
>=20
> Just to clarify, that is just the dts patch? Or the binding patches too?

Ok. I'll push everything out now and you can tell me to undo that if
it's wrong.
