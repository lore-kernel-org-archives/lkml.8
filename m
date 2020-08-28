Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC25C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D74D2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="WaxiOLCG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F6T3vOg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgH1Jos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:44:48 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:38787 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728016AbgH1Joq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:44:46 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id EF2DA8D9;
        Fri, 28 Aug 2020 05:44:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 28 Aug 2020 05:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=P
        tXB5hSLgVKMT2j7Z0Zf6VjUGFj2dGFbBan+VqncaY8=; b=WaxiOLCG1wd63Ab8p
        nEomIFSHutNxqnOOT0uiTJQjuFRgyeHL3s0CYiCO6ElyoBYIrRDyGfqGxVSLOcam
        +qaVN9OAPUwle2vIXuw+bJSrda7XxaRHE+S9ljasCf2J8Xe5eh0+DYURyq3cxOOd
        MPBS7lYgpd0CEXhHyY50tOtZKK0tbRZwlqT4zFBhVCCb8Jd+cX7OI+HZZyJL6AN2
        5phncL0hhAgZC5RjTtEv1iH4YvaddVO0er2I/RXtOjRKardVzoXmesG9TaQKF525
        jwfWKfRWGiyG6FfkEAv7rrmceN+DqtVmN2+fZ12nWRNnCnMoxel/xxwHejD2PUQ6
        ux5iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=PtXB5hSLgVKMT2j7Z0Zf6VjUGFj2dGFbBan+Vqnca
        Y8=; b=F6T3vOg5RkD/XnZfWJ6BPo+sYfYwPZQ6XdWeZ1JTC8PGr1+s4y//RPov7
        OF/EtlUzJ4xzZgNg5pb1QKTAjH2O3E1PgwLlgj5nOFuzuoQ2jjyDC3SP7TIK4h8r
        PpyELbuiO1ceQj+YWrNRPU1tX/CJFVKHtY0HAPwf7HprU7bVH7DjO86MmCw8N78p
        ChaqVE53fIE6dMYLP9dxcMPHrSboZP639jgFqC8DPdP2UQu17aG/LhhCvnawVQiK
        n79C01mXl0wcEPhbUqS51NXSKwFjbtSAK4X1svaP3ZQG4HMrYU7Ykj1AgDTW3Yr+
        A4JquaiK6cN0B4EFaBUD2Cg9U7ezQ==
X-ME-Sender: <xms:C9JIX7W03dadeG8PEMoGoVQfbh_sjVanI-guPv-3VbPVr-Oi5EBHlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvjedgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefgjeettdejgffgffdvteeutdehtdehgeehueetkeefgefhtdetjeekledu
    gedvudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:C9JIXzmrkoEGwVijS9wdGLeWSJS48ripl0cKVPDQWgVYh2iEL7bEvg>
    <xmx:C9JIX3Z1NC_o9diyU9cdZgnc4uiDqV49Hs_EHT4shiolZMYtIB42MQ>
    <xmx:C9JIX2VziRx8voA1cfGPjtE0YegQ1TiWRfZRBVq-WPf1uXwtS--Sjw>
    <xmx:DNJIX3n7To6TC90qWslSds0yFEFG8Ls9wjHb99y34G1AY1Aqqje_4DLiu6E>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 602503280063;
        Fri, 28 Aug 2020 05:44:43 -0400 (EDT)
Date:   Fri, 28 Aug 2020 11:44:41 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Hoegeun Kwon <hoegeun.kwon@samsung.com>
Cc:     nsaenzjulienne@suse.de, eric@anholt.net,
        devicetree@vger.kernel.org, tim.gover@raspberrypi.com,
        dave.stevenson@raspberrypi.com, sboyd@kernel.org,
        mturquette@baylibre.com, kdasu.kdev@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] drm/vc4: Support HDMI QHD or higher output
Message-ID: <20200828094441.6h6siehqbebayffn@gilmour.lan>
References: <CGME20200821071121epcas1p12225cf2891c2bbe22b90ac65e826dcaa@epcas1p1.samsung.com>
 <20200821071045.24501-1-hoegeun.kwon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200821071045.24501-1-hoegeun.kwon@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Fri, Aug 21, 2020 at 04:10:42PM +0900, Hoegeun Kwon wrote:
> Hi everyone,
>=20
> There is a problem that the output does not work at a resolution
> exceeding FHD. To solve this, we need to adjust the bvb clock at a
> resolution exceeding FHD.
>=20
> Rebased on top of next-20200708 and [1].
>=20
> [1] : [PATCH v4 00/78] drm/vc4: Support BCM2711 Display Pipeline (Maxime'=
s patchset)

Thanks a lot for figuring it out

I have to send a new (and hopefully final) version next week to address som=
e changes suggested by
Dave, so I'll squash your patches into the series

Thanks again!
Maxime
