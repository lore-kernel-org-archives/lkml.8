Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE54C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47AC724692
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="nLEb1dEC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VLX6OF3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgB0Mzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:55:49 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46403 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729036AbgB0Mzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:55:49 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 60636220C7;
        Thu, 27 Feb 2020 07:55:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 27 Feb 2020 07:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=EsLh1ElVWcPMN6QEUKEjRZC4EEK
        YwHmgnVppcHj4F4c=; b=nLEb1dECBO6hZMBDokjWOh2E3TgBmY1oxWqwFTdNXq+
        d/NWy/0BXqO/W/rfadUWUBVpmdAr4K4Z0PN0z31KtrMAvs1HVa9sacge1dh11o4y
        dLLIDNCDGNXaNzsGl1Cxnkykk1aXsEfuXQY+2p2gnA0BNbalrQTxfviLREQddWRF
        +oBJCmKYVIhGp1/rPvd6uxdZ6NdfFvHwTnbXYz6/cnh73Xs4WD17u2UHU4EsxVAj
        N5kSymrK0qDd8yDPOPBHnDuJDxXA1rBzX/gFLAjRYKDcvD1GaTnosqPQ2OWDhYbo
        n1B/r5RiZQXJtpaDqnjWf9EHl94NMKk28kLPiorOsjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=EsLh1E
        lVWcPMN6QEUKEjRZC4EEKYwHmgnVppcHj4F4c=; b=VLX6OF3r+dVjSenAdqsozN
        efj26IFFopT/I/Uv+dPH1+trEebkWT44ed32Lz35dh8P1DEr5P8YOpp5c/Q4u27X
        08jZ+FVtXBCvPcyeukNO6CHA4DHoGEjZ+gxGtuvdmYHEBkL3ZEqWimnUZmJMyeRT
        7kXC0uawYbYEzGiWItsMLaok2/H+UA1xM6B3xuuNKrSbloFsjyXdotwuCxwDopUx
        zXYMr9unYTdFx2cEZHU1VMyuEXPMeQhyT8VVh3Kcm+5d7tEA2DhQtkJ9C0CPsCab
        HNtnA6QWFq/JPhtc53DynzW3MRXOLxXtLpqyeg4ny3H461dYHNUc4rwo/FWoRIyg
        ==
X-ME-Sender: <xms:UrxXXvS-QYkKD4c-XkJKc8O-fBZ5wbBV2-2kiV2HV-XD87sQ97dWQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleeigdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:UrxXXqV9S4DI_kFbZFkDKHzoZU9sTkM1-rjWpSmJPWznUSypm1p1AQ>
    <xmx:UrxXXgSgrzqsbgRMjYjjhJqIPLy0PaL9BRaTahhDiIriBMNOlfR6Kw>
    <xmx:UrxXXtv6m8GJrPrBqxFBQMz5kJ-eAkLqjORwfFCXl44kriaspXHbLQ>
    <xmx:VLxXXvmzBMa2NVri2yVvR2_19kBX13niJkMQCzPeS5JFUmoY4mC3JQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id AB4EF3060FD3;
        Thu, 27 Feb 2020 07:55:46 -0500 (EST)
Date:   Thu, 27 Feb 2020 13:55:45 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Mans Rullgard <mans@mansr.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: sunxi: h3/h5: add r_pwm node
Message-ID: <20200227125545.ynzmwcbs6gqqm4ys@gilmour.lan>
References: <20200227115526.28075-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7rb5t2q5bd2tfoz6"
Content-Disposition: inline
In-Reply-To: <20200227115526.28075-1-mans@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7rb5t2q5bd2tfoz6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2020 at 11:55:26AM +0000, Mans Rullgard wrote:
> There is a second PWM unit available in the PL I/O block.
> Add a node and pinmux definition for it.
>
> Signed-off-by: Mans Rullgard <mans@mansr.com>

Applied, thanks!
Maxime

--7rb5t2q5bd2tfoz6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXle8UAAKCRDj7w1vZxhR
xcTXAQDy5uVx/AsVCJdyv0LVkS82AGvP61hYpI7z6iB/82Ar4gD+PmcwHsBHmKWW
INLYhHsvJkK7fO13YhEWs9ZcqYlRdg8=
=01S8
-----END PGP SIGNATURE-----

--7rb5t2q5bd2tfoz6--
