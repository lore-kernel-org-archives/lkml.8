Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32AD0C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 055002087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 18:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579287240;
	bh=Ggs4OoJBCkjO8db/zcQts4isiDP4L4RjiRCqQPSG+Do=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sYmCMkgG2xrQbCQXOQOzzEWUXYnBG1o2XsKJv8xUL+AQWtn66J4Oyd7iMCy9xNFfT
	 19yLBxYkaXUILPtwxnqTqiUNlIbyIu4mpbAQ+lZIs1Cya9y1HadzWuzk5svygCfuWP
	 Z9P5cYj4bnsq673wyMsG0lb8tO+vuDcGgkWwGf2A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgAQSx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 13:53:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:47520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgAQSx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 13:53:59 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A857D20748;
        Fri, 17 Jan 2020 18:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579287238;
        bh=Ggs4OoJBCkjO8db/zcQts4isiDP4L4RjiRCqQPSG+Do=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ckG2ELRNQQm99wQbw8vq+wWoAinNuDS1uWRMdwoY5ePHou+8BHw2vcCMGKAUN8cnt
         ikesXAuWEmHyUoev/Hc57X+zKChsZEh63Awa/wgJpxIhjGk0jINT32oVj2AD4iR5S0
         DS12dDaoxUdkAKnoTs+vFOzj/HyePGibWABa1HNY=
Date:   Fri, 17 Jan 2020 19:53:55 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 0/5] Add support for Pine64 PineTab
Message-ID: <20200117185355.wmu3so53whvtbnhx@gilmour.lan>
References: <20200116033636.512461-1-icenowy@aosc.io>
 <20200117185012.GC14298@ravnborg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p4f53y6km3ucx2zs"
Content-Disposition: inline
In-Reply-To: <20200117185012.GC14298@ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p4f53y6km3ucx2zs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 17, 2020 at 07:50:12PM +0100, Sam Ravnborg wrote:
> Hi Icenowy
>
> On Thu, Jan 16, 2020 at 11:36:31AM +0800, Icenowy Zheng wrote:
> > This patchset tries to add support for the PineTab tablet from Pine64.
> >
> > As it uses a specific MIPI-DSI panel, the support of the panel should be
> > introduced first, with its DT binding.
> >
> > Then a device tree is added. Compared to v1 of the patchset, the
> > accelerometer support is temporarily removed because a DT binding is
> > lacked (although a proper driver exists).
> >
> > Icenowy Zheng (5):
> >   dt-bindings: vendor-prefix: add Shenzhen Feixin Photoelectics Co., Ltd
> >   dt-bindings: panel: add Feixin K101 IM2BA02 MIPI-DSI panel
> >   drm/panel: Add Feixin K101 IM2BA02 panel
> >   dt-bindings: arm: sunxi: add binding for PineTab tablet
> >   arm64: dts: allwinner: a64: add support for PineTab
>
> Thanks for the updates.
> I have applied the first three patches to drm-misc-next.
> The remaining two patches shall most likely go in via another tree.

queued the last two for 5.7, thanks!
Maxime

--p4f53y6km3ucx2zs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXiICwwAKCRDj7w1vZxhR
xZQcAQCabPKDVEHD7EEKVMSsoVVvXNcUSRxlLRN7UZEzxKP8/QD/TvXs63UOJH6/
6zRTD2fYEmgvB1Cr3YJC7JpuiB5qbgE=
=a6tO
-----END PGP SIGNATURE-----

--p4f53y6km3ucx2zs--
