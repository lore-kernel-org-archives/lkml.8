Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7334C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 00:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C21A02224A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 00:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592611844;
	bh=MF0hLepUxwBvinfeJBBZlK/ffPc/P/vgm80eyJnR3Mc=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=tEQbir4eiNsR7EtufAx/W2iqRqbG2PIaiOFIo5TdF5VwKsBd9WjhFOTsqIsDgu2Jd
	 BKC3KSUu5Bm8AFz6zeVjD6TwNdaet2KclcEDuu/3DfBgXyXbJ5cRK+0oVL/uqfiHFI
	 obLYZMqbk8LTj0cX6mR5QaUSDoRoma/i9yu5g66k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgFTAKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 20:10:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:41136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbgFTAKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 20:10:18 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8A39206D7;
        Sat, 20 Jun 2020 00:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592611817;
        bh=MF0hLepUxwBvinfeJBBZlK/ffPc/P/vgm80eyJnR3Mc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iG7e6an+YvnjNJmyHNIli0/AmGc5US2MgFC90/8ERuXkVKM6WUw4hu2LlbsDbn5YU
         MMvEVykmCPAEMwJ+IB5w+XRMokffYIq8tAzOFJ+LuK0Uj9dscWOzY6vJBtSSfpl7IV
         ScfMtsNpm2ChReedBjA03Bl2NPxHGI7qcpD9KUfM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <706f56a20d318b841792ca19a6fe7135cb6c61e3.camel@pengutronix.de>
References: <cover.4c4625a8e076f3163b800b3d8986b282ee98d908.1591867332.git-series.maxime@cerno.tech> <e22222ca7f41b960e9bb1a31e0dd2de95b8c0cd1.1591867332.git-series.maxime@cerno.tech> <810816166d8ef554e1bb1f4a2b39ea0b8a1a3d5b.camel@suse.de> <20200616121641.jpoz237p43sbndg2@gilmour.lan> <706f56a20d318b841792ca19a6fe7135cb6c61e3.camel@pengutronix.de>
Subject: Re: [PATCH v4 3/3] ARM: dts: bcm2711: Add HDMI DVP
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Mike Turquette <mturquette@baylibre.com>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>, linux-clk@vger.kernel.org
To:     Maxime Ripard <maxime@cerno.tech>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>
Date:   Fri, 19 Jun 2020 17:10:17 -0700
Message-ID: <159261181702.62212.6185371789718045244@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Philipp Zabel (2020-06-16 05:56:55)
> Hi Maxime,
>=20
> On Tue, 2020-06-16 at 14:16 +0200, Maxime Ripard wrote:
> > Hi Nicolas,
> >=20
> > On Mon, Jun 15, 2020 at 06:26:19PM +0200, Nicolas Saenz Julienne wrote:
> > > On Thu, 2020-06-11 at 11:23 +0200, Maxime Ripard wrote:
> > > > Now that we have a driver for the DVP, let's add its DT node.
> > > >=20
> > > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > > > ---
> > >=20
> > > I can take this patch, but I guess the rest should go trough the cloc=
k tree.
> > > Is it OK with you?
> >=20
> > We have a build dependency on the reset framework for that driver, so it
> > should rather go through the reset tree (or Philipp should make an
> > immutable branch that the clk maintainers can merge).
>=20
> I've prepared an immutable branch that these patches could be based on
> and that could be merged into the clk tree:
>=20
> The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c74=
07:
>=20
>   Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)
>=20
> are available in the Git repository at:
>=20
>   git://git.pengutronix.de/git/pza/linux reset/simple
>=20
> for you to fetch changes up to a9701376ed0fb61a5be4bb438daf26bd9cfa24b5:
>=20
>   reset: simple: Add reset callback (2020-06-16 14:19:57 +0200)
>=20

Thanks. I've pulled it into clk-next.
