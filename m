Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4579CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 212D2206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:49:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="b9HIaOxX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kaZSv4s5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgFHItV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:49:21 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46757 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729085AbgFHItU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:49:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9C0AF5801BC;
        Mon,  8 Jun 2020 04:49:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 08 Jun 2020 04:49:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=pHrqLUxD8NCGQWXj/OLcTY5z8hm
        NTSXoKcbo0L/lZZ8=; b=b9HIaOxXI+jBphibKXG4hTwMIHjudTorOID3DwqNsEs
        MNpF8NhGL/cMHmyWkNHYThWeBf1K8euOjvVIerzos7s09Mo+9jEdc6TAtn56KT3B
        dulmycfS3ogInT/OgczDvcfxYTvtyWOB8d2b/fC0fH+3961a8lc5kOm2lbStjpye
        dGxmCdbMsn+NEgI5aG+on0JL5oeD2y9Fn1z7r1fJglNUwXE2ME0VS2H1RMGuTCJe
        qoXYJmimcvLHCZklK8whe+RtK0r5l0oN57kr+9UqxU0EXTJSpzL5VuulVLiS1lzx
        +QGHGMhFWuGTkhHI25dhpARSbenRc4UqaOqftmidxFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=pHrqLU
        xD8NCGQWXj/OLcTY5z8hmNTSXoKcbo0L/lZZ8=; b=kaZSv4s5TiDbYke9NqbaPt
        3yqz2bOyGp5TYpr6X6lO+ykvjlZR9q5/hcrbo2E2kcCRsYbPGt1OtNGmBgiHUtfm
        RD9vsZbYuOue0fJKlJki9FCBB3izUnC1lZHmbh9eYvTIhxeu4SswDmHnizuZzb7k
        EqsA69AyENdB1mPtImruugcUAnH3lFw2Wla+FSKYYPe9vjjNer7PbrVRrI1EUWJX
        pyQe71qk/jPvjX/umkv38j7fo6stDuZd9wcGLOhc1nui0Ckx3hb5d08xwWo7zmi+
        8hJsAhwJlB3gc4zZOXmzJCgJkVdjKbVyThJQiLxwteMFihevfCZ2InXA+UtPfR+Q
        ==
X-ME-Sender: <xms:j_vdXiNTY3652zRm6BaBIFC7mdysxQLUje3fbr8A0YsHM53QOjv6qA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudehuddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:j_vdXg_0NVP9T0VBeNu29bRkUE1elIdnGWZAymFaGmVBn9IIPtgrVA>
    <xmx:j_vdXpS8ct4glPYJHw8WWpdUPHRgr7-PoNdwGpcjhU-r-WzmYGZ-uw>
    <xmx:j_vdXiuvmkGe9WpL2kmbWrS7qwrserkow5bVqstyVHRNhDkm9W0y0A>
    <xmx:j_vdXq7wNXooeisN-oPZYnrj_jxQAWd6SCVhYgy53PVDGu85danaww>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 39F2F30618B7;
        Mon,  8 Jun 2020 04:49:19 -0400 (EDT)
Date:   Mon, 8 Jun 2020 10:49:17 +0200
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
Subject: Re: [PATCH v2 2/9] irqchip/sun6i-r: Add wakeup support
Message-ID: <20200608084917.qufcgedya2kr4arv@gilmour.lan>
References: <20200525041302.51213-1-samuel@sholland.org>
 <20200525041302.51213-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hhnnuvojjvpvrory"
Content-Disposition: inline
In-Reply-To: <20200525041302.51213-3-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hhnnuvojjvpvrory
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 24, 2020 at 11:12:55PM -0500, Samuel Holland wrote:
> Maintain a mask of wake-enabled IRQs, and enable them in hardware
> during the syscore phase of suspend. The restore the original mask
> of enabled IRQs (just the NMI) during resume.
>=20
> This serves two purposes. First, it lets power management firmware
> running on the ARISC coprocessor know which wakeup sources Linux wants
> to have enabled. That way, it can avoid turning them off when it shuts
> down the remainder of the clock tree. Second, it preconfigures the
> coprocessor's interrupt controller, so the firmware's wakeup logic
> is as simple as waiting for an interrupt to arrive.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--hhnnuvojjvpvrory
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXt37jQAKCRDj7w1vZxhR
xX1OAQC5mX5yhmjwOKp3HJXrXFGEXTeo1cjUm439PInsQbX4+AD/ZHAcr+zLEmOn
8IjIXz6vKJL/ItkgD1SrjpSKMvdH9wg=
=VPNa
-----END PGP SIGNATURE-----

--hhnnuvojjvpvrory--
