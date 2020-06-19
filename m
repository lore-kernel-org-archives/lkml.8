Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F3EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 23:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D31224DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 23:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592611045;
	bh=aReEhsLbHOHgwM2p5jQTSxomK7ZSZh8JsQalBYQPFEg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=GmM2RFTEx5p04dK0C6AwegmdsC5vW6wVdnW+BGQW/BCt9UhoIfbLGcmkdIk7fFeTL
	 bCh13SrR4K20bVQuXdzGupkrxlhR+00z7H39F0xdHypVm9reXj7BWY9mQUFD2JzaQ/
	 MThUyFh86EPw3UlNH/rXx3434dVhcubvfux/sn+o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgFSX5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 19:57:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbgFSX5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 19:57:11 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7824E224B8;
        Fri, 19 Jun 2020 23:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592611031;
        bh=aReEhsLbHOHgwM2p5jQTSxomK7ZSZh8JsQalBYQPFEg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=IJ3uF7HGCnopHleEpq01Yf9QW9fHiySEouJcHkvhYY3Vsm0naQeeJZVW3ncBvNBDp
         DD/bafk0E+34vRDnSQpjBIJkfYxfmEncYJtaHCxF2CsdmvfrRmYT3VT6QdkZhILlNj
         XOdFv0yjNFo8fz9kz9RmXqyhwCUzM6zUgZQ9I22M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bdc91c1b015d2f02bd0ea90ae81a122123c62b38.camel@suse.de>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech> <159255945796.62212.5838238989498858379@swboyd.mtv.corp.google.com> <bdc91c1b015d2f02bd0ea90ae81a122123c62b38.camel@suse.de>
Subject: Re: [PATCH v5 00/27] clk: bcm: rpi: Add support for BCM2711 firmware clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
To:     Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Date:   Fri, 19 Jun 2020 16:57:10 -0700
Message-ID: <159261103077.62212.7410836804489183937@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nicolas Saenz Julienne (2020-06-19 02:44:54)
> On Fri, 2020-06-19 at 02:37 -0700, Stephen Boyd wrote:
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
> >=20
>=20
> FWIW I don't mind taking the device tree changes trough the RPi soc tree.
>=20

Sounds good.
