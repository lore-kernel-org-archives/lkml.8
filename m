Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21CAC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C25A020644
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="kNhzk0My";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="2YEk2iM0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDFJVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:21:38 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:59253 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726621AbgDFJVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:21:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2E3F25C018F;
        Mon,  6 Apr 2020 05:21:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 06 Apr 2020 05:21:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=oMeIIJ1mDIWN3kALdLXCgbaXtnO
        iigOn5+MO3vnZOUI=; b=kNhzk0My+PGFQesmQtfITGCTkAeUIuaxp6gv1SR4m5/
        H1dk3sWdxRwvl7KHVmHoXvAgg0Ut7ayn2alYB1MG9NLASeBGuOqcpvHj+273H+jz
        o/ve/EiunT8XbLNS/wb0JtQDO+i5WaRm/d1hCf+572uib0klzX7gphcXAMcHT1Bm
        +jTCC3C7lsCvJnZ4Nf8SF0xuOWZ/Ewv4MX8z4GlamBAZK4bk4igE536nHw41nLRR
        pFmP24HGe7TTLr7/tQrWq5Hrg5yVREHVOVku+JTT+t9DGRUyrKmFalCqkjC3hXpp
        RH5IkGnQFgMNoDUX02hGc1XOsf8QTve37DmCF7t2YBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=oMeIIJ
        1mDIWN3kALdLXCgbaXtnOiigOn5+MO3vnZOUI=; b=2YEk2iM0BCpDj6J2DwGxRb
        CNvPyqIgYSnkOeedlqJfT4R51xuWw3305b5b4Eoxcv6h8/Jnek6q8VDatcDuS5cO
        /YaqEcroXtKy1UGkIJX718/tp5O/8U0etMLrrqGzNkKqcWF5IRD0AODQ0PW5JLkz
        CTa4l+wc2DWHtiXbHff1a6hLOsOxk4De7aMbJP9/9Nv9y6g64RHUkYmZ1jhxCddT
        Z/QQW8DTAnIe8dOGX2aWLiGUOdW8zbe++oYSrLhZaiFZsvwXk05KJp42uW02uLu+
        QxSc2H/EYtX7+/qnoLfn48SEELr2plGm+xbFwuv72lO0GIQnLwgRYTBUsNyz9jvw
        ==
X-ME-Sender: <xms:n_SKXov82wD0S1qvcrji2PDWNwVHREeDi65UkUo8dtE63J3pQngYpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:n_SKXjD-OFB8wBhpApb-_WEl3SFb8u7j9noWylh2j2Vj1KSnSnPvfg>
    <xmx:n_SKXsxSRR5VgKXcX_bMSuxNF_spethl7D9dYS7QdLUUNjlvtmE0sg>
    <xmx:n_SKXmFlGuzOkszQTm6wqMLvNpfr4JoNBx2tu1HuQmgJneHiK6wPrg>
    <xmx:ofSKXt4XozOGp_tz2A4geXQex8OTLlg0pelVgZrOipjfRmrbaSP6GA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 43150328005D;
        Mon,  6 Apr 2020 05:21:35 -0400 (EDT)
Date:   Mon, 6 Apr 2020 11:21:34 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linux@armlinux.org.uk, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH] ARM: configs: sunxi: Add sun8i analog codec
Message-ID: <20200406092134.ugxuj46qp6tmjf75@gilmour.lan>
References: <1585820061-24172-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y4kqwfcf6dwztl2s"
Content-Disposition: inline
In-Reply-To: <1585820061-24172-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y4kqwfcf6dwztl2s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 02, 2020 at 09:34:21AM +0000, Corentin Labbe wrote:
> On my orange pi PC, I got lot of "sun4i-codec 1c22c00.codec: Failed to register our card".
> This was due to a missing compoment: the sun8i analog codec.
>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied, thanks

Maxime

--y4kqwfcf6dwztl2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXor0ngAKCRDj7w1vZxhR
xX1NAQDtmDUG0N56YtytHARXBanE8n3MN0rgFqs5YzsPTH7BKgEAlr+sj0EyZc5+
dGB6hLBjFhR/iA7JQIbMnPSJPRYKIgE=
=Umyl
-----END PGP SIGNATURE-----

--y4kqwfcf6dwztl2s--
