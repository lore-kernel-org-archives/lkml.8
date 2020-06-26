Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C831AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D5B520679
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="joXIMXVt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uLBxaHyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgFZNcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:32:39 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:58173 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725864AbgFZNci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:32:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0B1835800E9;
        Fri, 26 Jun 2020 09:32:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 26 Jun 2020 09:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=3ULkGw0K1uowMBdVFivSKs3z/Pd
        HGimtIeBF3iZ45OE=; b=joXIMXVtJ0FedsvAUBs29rqdOqRoKE6+f0RvjoPetJk
        vVQ5ZU4+Uif0v2/m/l1QgFKlRU+/S0tFdE4eZgbf3GIOxAdjkv6+I57Qegp/HV8V
        kx8ikbhgEa10QHm/ijgIp4Wnbk2oiHtvu0uC6hjXDGE5ZApy88f0O4dXttfgWGiH
        wY6ZdT1EW6lPM7JIqgIGDdaiSiRr9zVfgGyGdTfk/b1vHHRm/ce88et+KiklK62I
        GJBcRkAT5A3an6J74rdDDZJtFki9pScWCKa1AOhmK7xURUjGKOFFBbWziQBB4v8o
        z0W/s+/8b3XMr70vhUuUnY+ZaGD/anIqQGizxzBr28w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3ULkGw
        0K1uowMBdVFivSKs3z/PdHGimtIeBF3iZ45OE=; b=uLBxaHyPolUuINEWc1G8cq
        +ZqwJsI3LaoIIY0XQ6JpQ6UFpgaKHwutk1uI0Rnalu+p1Quev56XwRYo9eoUC2Ox
        qcoVya4iWbT3HjxL/pW9dUdzNOPYRQGcpLfpPBxPydkWfPoDSISO7vxzmhqMrf+0
        Nerl8WwJDhW0JDG4gguXcXvDiMplnlRBlDFEpfO+D40RQYrOomrTEV/RH4WWihYJ
        y+32vYweKfDm69MkPoxG3mIBr2DG8oIhlBXqH4VdZj0c1soGf/rKwlksypKwcB14
        m5Cw7Ul+x7oO1y5Vyld+53MEe+Mb0tNHNlYW6gOT3A0Tt5GtcuviiK+KzAidrWXg
        ==
X-ME-Sender: <xms:8Pj1Xt0Z_6BU09s8thb6f0XU7sSR2BkYU1IVkQOSvaY2mMefFTv0iQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeluddgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnheptdfggfelgeehieeuieegfefgueduudefheffhfejleekheefjeevveegueel
    ueefnecuffhomhgrihhnpehlihhnuhigqdhsuhhngihirdhorhhgnecukfhppeeltddrke
    elrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:8Pj1XkGtjIO9a-ehEbiBU2LHmdk14NmwyBoWLDKqgX8CQ4FH9CZmvw>
    <xmx:8Pj1Xt6C2nN0kmYtWJzHAcZ6Cqqg8zDSgRlqOKh9k8kvmMUp9MiCZg>
    <xmx:8Pj1Xq2YKBOH0D40YMMS7KGYfEot6Ay9Su1yuQaozYSgps7duJIj2Q>
    <xmx:9Pj1XrA--VmX1wt-SP_XjKrkaWuaT7waMCYAsj9YNBLDX2Mr4NZw-Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 313333280059;
        Fri, 26 Jun 2020 09:32:32 -0400 (EDT)
Date:   Fri, 26 Jun 2020 15:32:30 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 1/9] irqchip/sun6i-r: Use a stacked irqchip driver
Message-ID: <20200626133230.yawpmhrhgd2pxzqn@gilmour.lan>
References: <20200525041302.51213-1-samuel@sholland.org>
 <20200525041302.51213-2-samuel@sholland.org>
 <20200608084853.wr6eca5nt772p5h7@gilmour.lan>
 <fcfe6d02-2500-37de-e795-664bf2c7b5ee@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w2cxdmvddkia6p7z"
Content-Disposition: inline
In-Reply-To: <fcfe6d02-2500-37de-e795-664bf2c7b5ee@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w2cxdmvddkia6p7z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Mon, Jun 15, 2020 at 12:29:50AM -0500, Samuel Holland wrote:
> On 6/8/20 3:48 AM, Maxime Ripard wrote:
> > On Sun, May 24, 2020 at 11:12:54PM -0500, Samuel Holland wrote:
> >> The R_INTC in the A31 and newer sun8i/sun50i SoCs is more similar to t=
he
> >> original sun4i interrupt controller than the sun7i/sun9i NMI controlle=
r.
> >> It is used for two distinct purposes:
> >>  1) To control the trigger, latch, and mask for the NMI input pin
> >>  2) To provide the interrupt input for the ARISC coprocessor
> >>
> >> As this interrupt controller is not documented, information about it
> >> comes from vendor-provided ARISC firmware and from experimentation.
> >>
> >> Like the original sun4i interrupt controller, it has:
> >>  - A VECTOR_REG at 0x00 (configurable via the BASE_ADDR_REG at 0x04)
> >>  - A NMI_CTRL_REG, PENDING_REG, and ENABLE_REG as used by both the
> >>    sun4i and sunxi-nmi drivers
> >>  - A MASK_REG at 0x50
> >>  - A RESP_REG at 0x60
> >>
> >> Differences from the sun4i interrupt controller appear to be:
> >>  - It is only known to have one register of each kind (max 32 inputs)
> >>  - There is no FIQ-related logic
> >>  - There is no interrupt priority logic
> >>
> >> In order to fulfill its two purposes, this hardware block combines two
> >> types of IRQs. First, the NMI pin is routed to the "IRQ 0" input on th=
is
> >> chip, with a trigger type controlled by the NMI_CTRL_REG. The "IRQ 0
> >> pending" output from this chip, if enabled, is then routed to a SPI IRQ
> >> input on the GIC, as IRQ_TYPE_LEVEL_HIGH. In other words, bit 0 of
> >> ENABLE_REG *does* affect the NMI IRQ seen at the GIC.
> >>
> >> The NMI is then followed by a contiguous block of (at least) 15 IRQ
> >> inputs that are connected in parallel to both R_INTC and the GIC. Or
> >> in other words, the other bits of ENABLE_REG *do not* affect the IRQs
> >> seen at the GIC.
> >>
> >> Finally, the global "IRQ pending" output from R_INTC, after being mask=
ed
> >> by MASK_REG and RESP_REG, is connected to the "external interrupt" inp=
ut
> >> of the ARISC CPU (an OR1200). This path is not relevant to Linux.
> >>
> >> Because of the 1:1 correspondence between R_INTC and GIC inputs, this =
is
> >> a perfect scenario for using a stacked irqchip driver. We want to hook
> >> into enabling/disabling IRQs to add more features to the GIC
> >> (specifically to allow masking the NMI and setting its trigger type),
> >> but we don't need to actually handle the IRQ in this driver.
> >>
> >> And since R_INTC is in the always-on power domain, and its output is
> >> connected directly in to the power management coprocessor, a stacked
> >> irqchip driver provides a simple way to add wakeup support to this set
> >> of IRQs. That is a future patch; for now, just the NMI is moved over.
> >>
> >> This driver keeps the same DT binding as the existing driver. The
> >> "interrupt" property of the R_INTC node is used to determine 1) the
> >> offset between GIC and R_INTC hwirq numbers and 2) the type of trigger
> >> between the R_INTC "IRQ 0 pending" output and the GIC NMI input.
> >>
> >> This commit mostly reverts commit 173bda53b340 ("irqchip/sunxi-nmi:
> >> Support sun6i-a31-r-intc compatible").
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >=20
> > As usual, thanks for that commit log (and the experiments you did to
> > write it in the first place).
> >=20
> > Acked-by: Maxime Ripard <mripard@kernel.org>
> >=20
> > Maxime
>=20
> I've done more experimenting, and I've learned what comes after the first=
 16
> IRQs: all of the other SPI IRQs, multiplexed in clusters of 8, with per-I=
RQ
> masks for the inputs to each cluster.
>=20
> In fact, the H6 has so many IRQs that it begins to use the the second reg=
ister
> in each group (0x14, 0x44, 0x54). This means that more than one register =
in each
> group are in fact implemented.
>=20
> See https://linux-sunxi.org/INTC#IRQ_Mapping for more details.
>=20
> The ability to send other IRQs to the AR100 makes it possible to implement
> functionality like USB Remote Wakeup or Wake on LAN without adding comple=
xity to
> the AR100 firmware.
>=20
> I will need to update the driver to take advantage of this ability, and it
> raises some questions about the binding. Since the NMI is not the
> lowest-numbered IRQ that can be mapped,

I'm not quite sure I get that part. From the link you mentionned above,
the NMI is the interrupt 0 for all the SoCs, so we shouldn't have any
number lower?

> the numbering scheme would need to change.

As far as I know, upstream we only ever use the 0 interrupt for the AXP,
so it should be fairly easy to come up with a numbering scheme that is
backward compatible with that.

> Maybe the IRQ number should be the same as the GIC SPI IRQ number? But
> this would mean a new compatible.
>=20
> The other question is which devices should be routed through this irqchip
> driver? Anything that provides a wakeup source needs to go through it, so=
 it can
> intercept irq_set_wake. Probably other devices should not, as 1) not quit=
e all
> IRQs can even be sent to the AR100 for wakeup (e.g. the A64 appears to st=
op in
> the middle of the GPU IRQs), and 2) stacking on another irqchip driver ad=
ds a
> (tiny) overhead to masking/unmasking during IRQ handling.

It's probably a bit of a non-answer, but I guess all the devices for
which it makes sense? The ethernet / USB controllers that you already
mentionned would make sense, the GPIO banks too, possibly the UARTs?

I guess we could just enable most of the one that makes sense at first,
and then discuss cases we didn't consider as we discover them?

Maxime

--w2cxdmvddkia6p7z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXvX47gAKCRDj7w1vZxhR
xRxyAPwL7ZoWHt8da2j7EhneJLKVCFwtc3+Gq4LllYPi+tCvFAEA1oY+SejBB//l
AXnc3/m1MK4LWLArMpWj2bymYHiZlgY=
=f1Iv
-----END PGP SIGNATURE-----

--w2cxdmvddkia6p7z--
