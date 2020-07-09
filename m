Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CD8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3B120775
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="m9I1Ree4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F9FWqgDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgGIHeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:34:03 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:55119 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726163AbgGIHeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:34:03 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 41183580381;
        Thu,  9 Jul 2020 03:34:02 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 09 Jul 2020 03:34:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=k
        VMfsBuCWfBPkcg9196Rz8HEh2r0kWo4fJ6CfQIqUIM=; b=m9I1Ree4S2pglm4Ur
        b6OO0a0jzQi+C9PL2IyFc3YdLO2xZ0Va2GNAPwuTjSnB5MzQkUGJY+Vf/voB+101
        F8J6bognpsuD4t0qdQeIlsA4BHWrqrTQyet/X+9q4WZ59iQ1FglAl6NGpXiLjQsI
        0PcrOEB1nJ0Nnzb6d8yeJV9+hbbTj/YOudpN8Nf807uCoK7rUw/GXxVNsFXV5Hoo
        bBt15eMOyaakFj34JUyjqr06GCKdfiNr0AGWKYJB4wm2BuFGtbC9QacABR7eIv6V
        EHmmgjo5CrvydqbqwXg8Gnj2E1ekjLjKeQPw7kMjrsj12a0TuZcRg0psDKibqo+Q
        8oiVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=kVMfsBuCWfBPkcg9196Rz8HEh2r0kWo4fJ6CfQIqU
        IM=; b=F9FWqgDdlID46ixtQZPcmdSyRXRvBI0Dsyg6Qgj/sKe1fASppZQftudAh
        f4Rce75Q27x0e47sgzYeu0ClQi7U/Woekw3R2r1qm/27YVhLlVwPegQCw9bJjXLF
        1NnJhI5jDKo1Q5Qiurigdt+AjO91MDNn4H6OJPamXboSAXU/uetpMlXC+vQlESwt
        iQYL2q2LvcWTTGHvRGh149Cx2nPE3qa0qrBc8FlP/w80o8sRVdY9q0f/2gyfudmu
        TR9E4fewrYIHhyFOD0oe2cS1XVN2aKtpQStC6e1Q2QKvB5DaxRZlEBug3VvWIhDj
        7CWNbaWSeL+1K8hujx615CSKO5xfQ==
X-ME-Sender: <xms:acgGX34ClCoMiEWSGoZD3gg4mGjjKt0dFktIerep649QcC6EqsdJGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudekgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtugfgjgesthhqredttddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpefgjeettdejgffgffdvteeutdehtdehgeehueetkeefgefhtdetjeekledu
    gedvudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:acgGX85fYPOzxph7jTwTkTec7QqTO23yFIIdZm0PkkdRYU9ATpFyAg>
    <xmx:acgGX-c2ZCMal8csKlNks9UWMGANnJS74V_tWV8KLcnuFKXO6JmHIA>
    <xmx:acgGX4JW1k5DSZY53G56WnWrt0DNisqX8_gH16BVGZfVkdqbZN9ZwA>
    <xmx:asgGX4p5-SevBaV4LnyeiZ2EyS9XUHY3ppHS9gesdJgZRtP1d9qXlA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 36D2C3280060;
        Thu,  9 Jul 2020 03:34:01 -0400 (EDT)
Date:   Thu, 9 Jul 2020 09:33:58 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Eric Anholt <eric@anholt.net>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH] drm/vc4: dsi: Only register our component once a DSI
 device is attached
Message-ID: <20200709073358.zeeczn6253na36l6@gilmour.lan>
References: <20200707101912.571531-1-maxime@cerno.tech>
 <CADaigPVu1PEANANuS03fO=kSxFuhmqsz=Y5WmwiAeXmMOotrHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CADaigPVu1PEANANuS03fO=kSxFuhmqsz=Y5WmwiAeXmMOotrHA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Tue, Jul 07, 2020 at 09:48:45AM -0700, Eric Anholt wrote:
> On Tue, Jul 7, 2020 at 3:26 AM Maxime Ripard <maxime@cerno.tech> wrote:
> >
> > If the DSI driver is the last to probe, component_add will try to run a=
ll
> > the bind callbacks straight away and return the error code.
> >
> > However, since we depend on a power domain, we're pretty much guarantee=
d to
> > be in that case on the BCM2711, and are just lucky on the previous SoCs
> > since the v3d also depends on that power domain and is further in the p=
robe
> > order.
> >
> > In that case, the DSI host will not stick around in the system: the DSI
> > bind callback will be executed, will not find any DSI device attached a=
nd
> > will return EPROBE_DEFER, and we will then remove the DSI host and ask =
to
> > be probed later on.
> >
> > But since that host doesn't stick around, DSI devices like the Raspberr=
yPi
> > touchscreen whose probe is not linked to the DSI host (unlike the usual=
 DSI
> > devices that will be probed through the call to mipi_dsi_host_register)
> > cannot attach to the DSI host, and we thus end up in a situation where =
the
> > DSI host cannot probe because the panel hasn't probed yet, and the panel
> > cannot probe because the DSI host hasn't yet.
> >
> > In order to break this cycle, let's wait until there's a DSI device that
> > attaches to the DSI host to register the component and allow to progress
> > further.
> >
> > Suggested-by: Andrzej Hajda <a.hajda@samsung.com>
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
>=20
> I feel like I've written this patch before, but I've thankfully
> forgotten most of my battle with DSI probing.  As long as this still
> lets vc4 probe in the absence of a DSI panel in the DT as well, then
> this is enthusiastically acked.

I'm not really sure what you mean by that, did you mean vc4 has to probe
when the DSI controller is enabled but there's no panel described, or it
has to probe when the DSI controller is disabled?

Maxime
