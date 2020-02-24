Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386ADC35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083C520828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="eaWvk5mb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j6r+6Hoy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgBXJSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:18:33 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:46157 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726216AbgBXJSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:18:33 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 62780720A;
        Mon, 24 Feb 2020 04:18:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=WcklOXNjPClAWS2mGAy2bDELI+j
        RDMgRpeGqxJlTeg8=; b=eaWvk5mb6QU+i8e/eaEcqtKocqP3AeUpmGfwwNUW3tc
        mR7TYWALtVHbhxtqGDMEv1ABl26TxD6g5vjeV8QcBeDOoHWUmmr2Fu9hW+K8asPK
        5gOQ7sbowIcRaHS1ThIg6cnKgSmjy1axMbbUCyWRUMNl7zI2zKPuTa2cmzhE1D5n
        FWN1/STx4T61q6X/dPro7YJtnBK25Ah7py17KwR271g6yuxxNECNn1s7UEMIpQER
        QuSedDIe3DlQB2jymVm+xVGiawZskye1TIF4AvhKlpFMvJazwx0+5AE0/Ya7zgNS
        j5RjMh9bxz4704l1csVfdfcIurSFq5kdWlIXLEhSFpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=WcklOX
        NjPClAWS2mGAy2bDELI+jRDMgRpeGqxJlTeg8=; b=j6r+6HoyWpw5af0kl1O8iR
        0OdbS8ReAsYUr4bfIv9GMoVeORg0ooWFc7aTpdZSaijWkjIWLvkAKaxal69d2Q0/
        6GgPo4d4uc3fqRhn3eZtIR63iN3RwsEkqrAyO7vkwpDME6lcfGizPWlX1GIaMbAy
        kQldYdLL725qsWT7gAeSO/xqSEkw1rZKfL8H4XvCwi9h684LiWf8OgoNvWpyNjtp
        2GiR5CSLUrJL+5IvudEh6Vpud/XSqfEDEvcV1T3fa5MN4z4JGQHZ4AIrehvgmHKe
        jzuvjcosS5VKyXLicYM94Wge1iJtyPKGuPyhe4vKoIc5DJF+qnV7wVDyItBp2cJA
        ==
X-ME-Sender: <xms:55RTXlgJSAMnAi4nfC_g3ZHo5yduA_B_loNE2D65PhrDqzsOtmRVmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:55RTXqMAej9EX-4TEbyLaHUvG96ysRAhsOAtLByCCcEzazcoMvBrTg>
    <xmx:55RTXm4Ao7ueAF4H9VB_nlgek5Ag05BHO5h9JXssgKE-ARp94vm5yw>
    <xmx:55RTXo2A-Aku7FfstmsrzCfCb6eXgBCAqsZn_qABY6WuAxUSRrSlVQ>
    <xmx:6JRTXkZRYJvgSjUxVtTCQGIMjpQetw3Gjshc6DpgrFHgisw04ZXiUA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5FC4C3280060;
        Mon, 24 Feb 2020 04:18:31 -0500 (EST)
Date:   Mon, 24 Feb 2020 10:18:30 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-usb@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        mark.rutland@arm.com, devicetree@vger.kernel.org, arnd@arndb.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, paul.kocialkowski@bootlin.com,
        linux-sunxi@googlegroups.com, robh+dt@kernel.org,
        tglx@linutronix.de, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, icenowy@aosc.io
Subject: Re: [PATCH v2 RESEND] phy: allwinner: Fix GENMASK misuse
Message-ID: <20200224091830.xeqhwvufsi4cfivg@gilmour.lan>
References: <20191020134229.1216351-3-megous@megous.com>
 <20191110124355.1569-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6ovbwz4bzccxezb"
Content-Disposition: inline
In-Reply-To: <20191110124355.1569-1-rikard.falkeborn@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6ovbwz4bzccxezb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 23, 2020 at 12:41:25AM +0100, Ondrej Jirman wrote:
> From: Rikard Falkeborn <rikard.falkeborn@gmail.com>
>
> Arguments are supposed to be ordered high then low.
>
> Fixes: a228890f9458 ("phy: allwinner: add phy driver for USB3 PHY on Allwinner H6 SoC")
> Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
> Tested-by: Ondrej Jirman <megous@megous.com>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Maxime

--d6ovbwz4bzccxezb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXlOU5gAKCRDj7w1vZxhR
xcmHAP9WF4Cp+G0e2P+pmkCa0xtayHzdCe3GlicUCpj28PTdQwD+KjqjrzgPEikG
ZnoIi4WBDjj/oBnu7fIyfpFBknOlqwQ=
=8mGu
-----END PGP SIGNATURE-----

--d6ovbwz4bzccxezb--
