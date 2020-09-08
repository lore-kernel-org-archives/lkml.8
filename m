Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91781C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3F8020C09
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:08:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbgIHTIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:08:42 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:49939 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730734AbgIHQGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:06:48 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4E264580441;
        Tue,  8 Sep 2020 08:00:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 08 Sep 2020 08:00:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=A
        t0ECiv86wOydFiONx1rKX74GnbiUZGiVwaMOztKjuk=; b=A28HdI8alVUfO+NGz
        jhOSfc5vwRPeVN7GA2rcjgFsQTj4DmJjpoyrEQkyjXPCh3ig+997suzCFj225jSs
        LIeEQWtGZev9qkXT288I3DiK25ASbo1vLbs+21RikvLtgfYvZJcLqnuWwVkkKZjV
        kBIuYuOqUKkofKQ7/5qvIgUXphgJKKsh1GC2K8wV7VANnkV90ZCfKsQJ+WyggWSj
        bEk/rdkOr5PrzRiAHdmPd7EAd6kV/ATbM9lgGss/QODATDhCzzsGwxQHTGHinFeB
        p6GuTicJXU0TkVP+vI13kbKL8Tpa2zf47B+QJMZmUCXLsHqrJ7qSvWf4dgsSX40w
        h1GYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=At0ECiv86wOydFiONx1rKX74GnbiUZGiVwaMOztKj
        uk=; b=dhghoUJmS7jVoxYnaqVEzRC1l/H3fLlqWDpRqZ+MysnqvW7+KIG3BEF2L
        79nCo2PnEFKJCFGixMT6iyQYtYfujiYACHcKSVRWmyKRSVtSSOD9spYoMkQCxAjI
        fuu32uUrij8KOA92gAPsDg4uMz+iTnJR3Qx/sOUG3/9dWaYbO4nnkRhYd8Sd/ebv
        mehj32n2xTqDORYsIBS3q58wEnFCg2ScmAVMLzoILwbZ8wlhpTrg1VnRTInQT7ms
        AcI8M8/qs+KBhM2uRhcIqMmfzlhP1uGMY7aozWmPavKmnHP/zIYDxP5LD5dNMHJ2
        GX7R7lhLgdUgZdYHI7gKYEl+H+G3Q==
X-ME-Sender: <xms:VnJXX9Snuh4Cse39j9YfRGTXSrPqxCxPAeYkDMDL2TQWOY0JWoHOQw>
    <xme:VnJXX2wJqJ89WKHQlrOSPRKliK6E18tW7Ny8iUSWdNx0Nhkl1-rliKRfrvys2OLmR
    6EDFwifw5WC5x7lNok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehfedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefgjeettdejgffgffdvteeutdehtdehgeehueetkeefgefhtdetjeekledu
    gedvudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:VnJXXy1j80EPqHy8o0z4n9Uud9Z1vczcgHt2eYwuUIsMgOlvFJZGXA>
    <xmx:VnJXX1AUG3iZSUaVW69wOb0p4qmgeWVSwqTlOqtDSaVdwzDYZ9-f-w>
    <xmx:VnJXX2hKy80dBWfVA0hBxnuXwHSqNVFVeMUADbN8CKENBj6PIFT4YA>
    <xmx:V3JXX3bXx01SDa8CprDSFTPaGFIoJl2eQ0TFaUDkdyDdzLnkqJS8lw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BE0F33280060;
        Tue,  8 Sep 2020 08:00:21 -0400 (EDT)
Date:   Tue, 8 Sep 2020 14:00:19 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Hoegeun Kwon <hoegeun.kwon@samsung.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, devicetree@vger.kernel.org,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 00/80] drm/vc4: Support BCM2711 Display Pipeline
Message-ID: <20200908120019.3rmhzoijoijrbb7d@gilmour.lan>
References: <CGME20200904071259epcas1p3de4209531c0bc5ed6ea9ef19827b6ed5@epcas1p3.samsung.com>
 <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
 <cca5234f-e1e8-b642-048b-b710f402409d@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cca5234f-e1e8-b642-048b-b710f402409d@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hoegeun,

On Mon, Sep 07, 2020 at 08:49:12PM +0900, Hoegeun Kwon wrote:
> On 9/3/20 5:00 PM, Maxime Ripard wrote:
> > Hi everyone,
> >
> > Here's a (pretty long) series to introduce support in the VC4 DRM driver
> > for the display pipeline found in the BCM2711 (and thus the RaspberryPi=
 4).
> >
> > The main differences are that there's two HDMI controllers and that the=
re's
> > more pixelvalve now. Those pixelvalve come with a mux in the HVS that s=
till
> > have only 3 FIFOs. Both of those differences are breaking a bunch of
> > expectations in the driver, so we first need a good bunch of cleanup and
> > reworks to introduce support for the new controllers.
> >
> > Similarly, the HDMI controller has all its registers shuffled and split=
 in
> > multiple controllers now, so we need a bunch of changes to support this=
 as
> > well.
> >
> > Only the HDMI support is enabled for now (even though the DPI and DSI
> > outputs have been tested too).
> >
> > Let me know if you have any comments
> > Maxime
> >
> > Cc: bcm-kernel-feedback-list@broadcom.com
> > Cc: devicetree@vger.kernel.org
> > Cc: Kamal Dasu <kdasu.kdev@gmail.com>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> >
> > Changes from v4:
> >    - Rebased on top of next-20200828
> >    - Collected the various tags
> >    - Fixed some issues with 4k support and dual output (thanks Hoegeun!)
>=20
> Thanks for your v5 patchset.
>=20
> I tested all patches based on the next-20200812.

Thanks again for testing all the patches

> Everything else is fine, but the dual hdmi modetest doesn't work well in =
my
> environment...
>=20
> In my environment, dsi is not connected, I have seen your answer[1].

Can you share a bit more your setup? What monitors are being connected
to each HDMI port? Do you hotplug any?

Maxime
