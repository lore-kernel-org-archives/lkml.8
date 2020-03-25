Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614EDC54FD3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 02:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395232074D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 02:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585102836;
	bh=+57wLOzdrvfVY9oRgwlinhOdDYxWS98Ii68KfvWZAeE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=nvlSH9fSuzoq0UktxghDgAIzcPTQXTJ19vCsj17meH2pYAqaCp/kpM6bgUF8TCNbV
	 NHwhvf4X4BvExpxAObhIwNuW9scFG3oOi2652CmnumE/G85RgNq9Np4WQcJdJS4aPw
	 DV99YMhTQw3szS/RBNgjC84ejCiQqLjb0a4cNL6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCYCUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 22:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbgCYCUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 22:20:34 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 040492072E;
        Wed, 25 Mar 2020 02:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585102834;
        bh=+57wLOzdrvfVY9oRgwlinhOdDYxWS98Ii68KfvWZAeE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=HRLni0JDRk8bdJjwHaSbs4cTHqNClt8LAi7FFXx302v+o3W/j6lDNZbtadQwzVKhe
         +1Nx7xlZ5T6dMRFDuTY5OXv5qoC3XAIvnKBrV61LtGEX4YrRuFvAnwnO4VPjSK9cAw
         6p4BBy3OkERRlTAanuh1/I0EtpqXul9kXHfexaNg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200323105616.kiwcyxxcb7eqqfsc@gilmour.lan>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech> <6dd6bd48e894c1e8ee85c29a30ba1b18041d83c4.1582533919.git-series.maxime@cerno.tech> <158406125965.149997.13919203635322854760@swboyd.mtv.corp.google.com> <20200323105616.kiwcyxxcb7eqqfsc@gilmour.lan>
Subject: Re: [PATCH 27/89] clk: bcm: Add BCM2711 DVP driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Eric Anholt <eric@anholt.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Maxime Ripard <maxime@cerno.tech>
Date:   Tue, 24 Mar 2020 19:20:33 -0700
Message-ID: <158510283320.125146.11874786046657431725@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-03-23 03:56:16)
> Hi Stephen,
>=20
> On Thu, Mar 12, 2020 at 06:00:59PM -0700, Stephen Boyd wrote:
> > > +       dvp->clks[1] =3D clk_register_gate(&pdev->dev, "hdmi1-108MHz",
> > > +                                        parent, CLK_IS_CRITICAL,
> > > +                                        base + DVP_HT_RPI_MISC_CONFI=
G, 4,
> > > +                                        CLK_GATE_SET_TO_DISABLE, &dv=
p->reset.lock);
> >
> > Can we use clk_hw APIs, document why CLK_IS_CRITICAL, and use something
> > like clk_hw_register_gate_parent_data() so that we don't have to use
> > of_clk_get_parent_name() above?
>=20
> That function is new to me, and I'm not sure how I'm supposed to use it?
>=20
> It looks like clk_hw_register_gate, clk_hw_register_gate_parent_hw and
> clk_hw_register_gate_parent_data all call __clk_hw_register_gate with
> the same arguments, each expecting the parent_name, so they look
> equivalent?
>=20
> It looks like the original intent was to have the parent name, clk_hw
> or clk_parent_data as argument, but the macro itself was copy pasted
> without changing the arguments it's calling __clk_hw_register_gate
> with?
>=20

Yeah! It looks like nobody has tried to use it yet so you've come across
that problem where nobody reviews things and I just merge it anyway.
I'll send a fix shortly.
