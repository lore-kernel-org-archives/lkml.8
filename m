Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6B8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 470192070B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="SSOBpvk4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oUMwvVek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbgFJSkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:40:19 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:47001 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726105AbgFJSkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:40:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id DBB4858015B;
        Wed, 10 Jun 2020 14:40:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 10 Jun 2020 14:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=udqN551CwjSTVUDc0D3kSahB8HY
        8CeSIkA8lNOgclJo=; b=SSOBpvk4b4Pw9e8QupB5MChycdXrWcxNGUbo5+QqOB2
        EG/b6zh9og0gepAraw33BO9gskuaIRH/d0B35Z8IRps3FyOX9d09lsd8adi6iZud
        e4LF60hPZkpPmAu/O1VqMmODBhtuiuTNUgkN6kPFd0EfVB6pqxZ0SQ+sbm/y/nRO
        MNTEjq/SsNEpo9sa0FRTaXDvCrZLPJFIAn6DudP3qcIE9GxA/fgU8wjLHtzPcYpE
        Nu3K+4rdJ1I2YSTF4zBggLJD53HHuXGiDBIgUIg7GAQMLxDLwTE9cIgBj8SQsIGB
        DQ4z62PiBkuUX6hQy+lS0Tf3xRZ7FSAlI0tNzJyEtTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=udqN55
        1CwjSTVUDc0D3kSahB8HY8CeSIkA8lNOgclJo=; b=oUMwvVekXmmDKq3tMHHOiq
        Oe9XPwUXSkst2D1ORd9yRYO9u/dghU0y7YQOhRV5KtF2yslH5qzusgPFowpBlrpU
        +TGcxs6rkP28NyrODwFw+02LPte9frNWwwH6y/bNeay6zQ2ABLMb3yU7hkmLiWbK
        TcDdko3D0PsAE3dbjz079ZwugHREMVR+ecCwNXR9JnDW+BjmFHCKW+/rOCZYsI/N
        ZZvYdbkGu6Td/qD0nK/UgT1g/fsNMLm+PBk8ocOchxmIDUcZ/kuSo8mrQkVZO4Ck
        snK/aDJys04wqBT2O6DV+tzzKj3CMNH827Hc5u6Pl2u7J461+KLnuKbUKy/HPfYw
        ==
X-ME-Sender: <xms:DCnhXtRpnDDHB7tIAsgobtDpskmMLtcq5mgmBd4ZveX-ADkzXrvmjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehiedgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:DCnhXmyjE-mu_wBJfFrUMjijn_JHiqCkLoIfce_gMkkOdJy5pzYR-Q>
    <xmx:DCnhXi31HyndptgqdHeNm8rYG2sDdpk_rg8DI31Fibd1LTqMSLPWag>
    <xmx:DCnhXlA-QYkYRubCILB4TOA-06l9HsdBHv39yzdJvOD_yWDnTM09AA>
    <xmx:ECnhXqjgnNS8FrTCg8Qxbtz9huV6yGQNddfcwbSdHWAb8o8mOm9kaA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 962643280064;
        Wed, 10 Jun 2020 14:40:12 -0400 (EDT)
Date:   Wed, 10 Jun 2020 20:40:10 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        LAKML <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 066/105] drm/vc4: txp: Turn the TXP into a CRTC of its
 own
Message-ID: <20200610184010.slnn46azvxvtxp7t@gilmour.lan>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <e9bc87e240b62c80617ea7825144121a470a2d44.1590594512.git-series.maxime@cerno.tech>
 <CACvgo50j1t5VtMgE7-pquuYRaC_ku5pZ2aBVoD-MCCktfPm-VQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="heqnr6uenmn6etam"
Content-Disposition: inline
In-Reply-To: <CACvgo50j1t5VtMgE7-pquuYRaC_ku5pZ2aBVoD-MCCktfPm-VQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--heqnr6uenmn6etam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Emil,

On Thu, May 28, 2020 at 04:51:31PM +0100, Emil Velikov wrote:
> Have you considered splitting the series into several parts and
> focusing on merging one at a time?
> IIRC this the longest series _ever_ submitted to dri-devel, plus it
> seems to be growing with each revision.
>=20
> Due to the sheer volume, it's likely to miss various points - large or
> small (like below).

Yeah, I know, I wasn't really happy about it either :/ I already removed
some parts of it to reduce it, but I'll try to be more aggressive.

> On Thu, 28 May 2020 at 08:47, Maxime Ripard <maxime@cerno.tech> wrote:
>=20
> > +static int vc4_txp_enable_vblank(struct drm_crtc *crtc)
> > +{
> > +       return 0;
> > +}
> > +
> > +static void vc4_txp_disable_vblank(struct drm_crtc *crtc) {}
> > +
> Core should handle if these are NULL, so the stubs should not be needed.

I'm really not sure actually. In the general case, you'll want to have
vblank functions, since it doesn't really make sense to have a driver
without it.

We could argue that with writeback, it might be optional like being done
here, but you don't really know if you're going to use a writeback
connector in the CRTC at initialisation time, and all the other
writeback encoders actually seem to use a real CRTC that can output to a
real encoder, and therefore has some proper vblank handling too.

So yeah, it really looks like the check is valid, and that driver is
just the odd case.

Maxime

--heqnr6uenmn6etam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXuEpCgAKCRDj7w1vZxhR
xfKbAP4guXZpKOBW0DBgderX3rva9jNmN1dH66Kel2jC5+ha2AD/f4mM9LuoVOUU
FtD2pyxEBAUtj6eIpZBwTD4vxJiVgg0=
=v1fz
-----END PGP SIGNATURE-----

--heqnr6uenmn6etam--
