Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45673C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 23:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C47224D4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 23:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592611050;
	bh=81hRUtcVR11BsydhG8B51A5da+wdAlZkBPJ+MP1X4qw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=ufn8FR/sWGdVu+sM/Ix1rjErX2fQZU1t1A4niwm6S8UuvrP0UthKAxbR37GA1YMB1
	 G8A9w3Llnih3F2VYzByhN6LV2NozyW8G6/80TYtqxLytKzCaoaizzjGnNjfJHVpZiw
	 zcfVr8MxMl07+FiB1w2k4FWvU4faGijDShFlGPJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgFSX53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 19:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:33512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728687AbgFSX5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 19:57:24 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 419A7224D1;
        Fri, 19 Jun 2020 23:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592611044;
        bh=81hRUtcVR11BsydhG8B51A5da+wdAlZkBPJ+MP1X4qw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RbYwyZVHiVJE4eO4PI9w4EcMOQsiwRP130Altk9bzPm+lzLVhwAxItZq1/KKihsqo
         NYbaKOFUVJIMr1K7/FH6bAAVteNK4m6qZO0uTR362x9JTrSTHSlWvYXXaEQBYvO3fb
         WtDfVAick3Z19m9i4HNnnRXJF3qhkNZfOjfjwbBA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200619115255.6pk5xb42b5ol7bk4@gilmour.lan>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <159255945796.62212.5838238989498858379@swboyd.mtv.corp.google.com> <20200619115255.6pk5xb42b5ol7bk4@gilmour.lan>
Subject: Re: [PATCH v5 00/27] clk: bcm: rpi: Add support for BCM2711 firmware clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
To:     Maxime Ripard <maxime@cerno.tech>
Date:   Fri, 19 Jun 2020 16:57:23 -0700
Message-ID: <159261104359.62212.13637457840164649678@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2020-06-19 04:52:55)
> Hi Stephen,
>=20
> On Fri, Jun 19, 2020 at 02:37:37AM -0700, Stephen Boyd wrote:
> > Quoting Maxime Ripard (2020-06-15 01:40:40)
> > > Hi,
> > >=20
> > > Since the whole DRM/HDMI support began to grow fairly big, I've chosen
> > > to split away the two discussions between the firmware clocks and the
> > > HDMI support.
> > >=20
> > > Let me know what you think,
> > > Maxime
> >=20
> > Do you want this to go through clk tree? Or looking for acks/review
> > tags?
>=20
> As far as I understood, you usually apply the bcm patches to the clk
> tree directly, so if you could apply them it would be awesome :)
>=20

Ok. Thanks for letting me know.
