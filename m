Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1521C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8768420672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 08:16:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="YrgcxlpE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Va1mcUBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgDFIQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 04:16:49 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:40165 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726535AbgDFIQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 04:16:49 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E2A195C0135;
        Mon,  6 Apr 2020 04:16:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 06 Apr 2020 04:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=CF2JGTX2lmYm+0Luc5WMUbWddfh
        IiV6ykRb8Y5fDHqM=; b=YrgcxlpEV+FnnI5895p6Lwb9khHPqURxLlAO7YElv3j
        gZkCFfOzNqzQ1iFn7hMkzeWh4j05kYn4uwF6NpsLMU0tolXDG48A48l80mb6LTyo
        al8RDFrCul/dHpqZkQEW4fBmpLP59xpW4KYJYcRWMIS+BBEJLrQqGLA7vYulaJlg
        9E+SNBOlXLr96ngSsD/AdORiLsx9nxrPL+/9IMOuIOYonKHd5AuAzigFPv2u2+dx
        RtT55/n8ONl2k9PiPuZhVXxVwihUC0f2ew4ppfotBwbeBjNIS/W+jbSuzlzFbQV8
        UL/3F6NoTLW3ZyA3TF8mTrFcov6tF5BTCMwHFSBnK1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=CF2JGT
        X2lmYm+0Luc5WMUbWddfhIiV6ykRb8Y5fDHqM=; b=Va1mcUBGzXRRkRTHUPmoKN
        nmPshwoihcqx6sFvYm0G5vh1JoEw+vxShJ7Ob9T8SXla0+5dvFAxOEJ6rjquqNHQ
        FhTxJM5wDMpu18cOCiEe62RnjkjnEtxpFZR0J5mYH8xjuVzCj/JQIPu8nMklRfUU
        vBQYiS9TMdgPz3Ly5iz0djp7nYuJ6wRD/i6SjXkhQtZhNw/hTh9IncjjeUfZ8jDX
        OSTmUTHDMUYuE5t5kImLLtBn3Fy6k+JE0shwQ+F+YYb9nwtqdvzjyxNE75Y6RsiW
        N9/iUK3NieCEh+xmckgdyTjXQAD81TXNLiHgxslNmxkJaTKSjos0JQXKQnSlL+3w
        ==
X-ME-Sender: <xms:b-WKXkOQ3NPMe67cT8I1n7HOKrYgwt99J-uEztzpNXZT05TlGWFH9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:b-WKXnRoyyMh9zzFKwWagheeuHcMN_LeHC_v8P7ickj-UfoQS1Axvg>
    <xmx:b-WKXs5TWZo9U2buvYAIKLYpiC-G_gH5iOaCb1aj0bxketnUxShoFA>
    <xmx:b-WKXp2BgChCwiv8M42X7H-Sio_qUYA3z5rAXLcixdydOFA3fNUeyA>
    <xmx:b-WKXsxndKMi8PyqnHrT_unl-ZjzMV9478ouGnnOphKYRDNk63HMbA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8486C306D37B;
        Mon,  6 Apr 2020 04:16:47 -0400 (EDT)
Date:   Mon, 6 Apr 2020 10:16:46 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v2 5/7] arm64: configs: Enable sun50i cpufreq nvmem
Message-ID: <20200406081646.yduso2velulbedku@gilmour.lan>
References: <20200405173601.24331-1-peron.clem@gmail.com>
 <20200405173601.24331-6-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d3h3r5s2altjvdpi"
Content-Disposition: inline
In-Reply-To: <20200405173601.24331-6-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d3h3r5s2altjvdpi
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 05, 2020 at 07:35:59PM +0200, Cl=E9ment P=E9ron wrote:
> Allwinner H6 needs this driver to be able to get
> the correct speed_bin required for DVFS.
>
> Enable this option in arm64 defconfig.
>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

In general, it's better to put anything in arm64 defconfig as a
module, this defconfig is used by everyone.

Maxime

--d3h3r5s2altjvdpi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXorlbgAKCRDj7w1vZxhR
xXYHAQCYFche+fruhs7HL9PcB8Ws7GcpaL1wGd0FzELeszvbbQEA4PpN1F2lYa81
QGyoZJ0c34qJBd5u34lOzcl+NB1frgU=
=t4/j
-----END PGP SIGNATURE-----

--d3h3r5s2altjvdpi--
