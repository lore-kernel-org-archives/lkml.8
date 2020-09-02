Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A1CC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE0F207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="AJKZvdUd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nYV+dqD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgIBTE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:04:59 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:37033 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727894AbgIBTE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 15:04:57 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 4E724FCA;
        Wed,  2 Sep 2020 15:04:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 02 Sep 2020 15:04:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=UIxnX4c3cvkVCih8WXAhZh++fhZ
        H2lstxce/AgcyQoQ=; b=AJKZvdUd2hz7jzsHrNCLB8F9hPKLifeW8Ovg5/yFd2t
        XpN21E5ZqYufX6n8KZ0kv5KMMyz4hSmAGFtAglJUp7rK9mG18PAnhTpJniG9Q+w7
        yS+fMtG09pybMflubjIvk0ttfxOZ25TMtdhQGuD9NKA47eutv9AV/2d1F8VTTQer
        VFmjOF5OlugqlHyElkJrA4LYXZiEI10zQp0mh8HVPeQurKwv/avQaYCuC1ohMR3z
        9LE0+W3KJFALG3IcOPkJSyZR0vf9cx7nbipyIqyVGvvFssXsEguRlsDl7/1XN91H
        RN0P1wtMijIjMaDhPefcFUAEU1A0ikQlkbPFXmYqThw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=UIxnX4
        c3cvkVCih8WXAhZh++fhZH2lstxce/AgcyQoQ=; b=nYV+dqD/xqacR59c0aEIVX
        w21OygFMPvsHZ+wSSwyjfBirfUiycS2DkJ3spPXp5nYrtBXJqdPwiE7TEjHcCQil
        EbImxL8Zv4F5VsTRuzveasbzzp+AxTMeVyGTjb/d2waBjUJXvKXaSRoo2iI8YvG0
        sR+4cuAgLW8oJ96cd40QcDWPpF6M5iHKKheE0R9kjKJszZDkSeAK9hhlOsuV0sXw
        tLa3lHvY/sJzXYwXQhxRPgE+dxc2x65xMzkucVMhKC8TTw8HAugm06UIFxGrfu4s
        BfCSTVi5Ud96BxPKZdko4QS1gM5r80I3g/lQWmd0WOICHUMmOXf1HXNfijDdXxTQ
        ==
X-ME-Sender: <xms:0-xPX81_2pmSYCwjPMBPQbp6-bpPubcFntWpzHUK2Eu0vyb0HIVSdw>
    <xme:0-xPX3G0zK_pHMTCBs19YydbT96GjrjRkoW3bCtimhgfVLkBQsROJRAzqGaRB4f1Z
    O1K8OVA1d1Mmj6v3Io>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefledgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrg
    htthgvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheei
    heegudenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:0-xPX06y0hG23LP7_LMq8pEjF4P4SARltqMy1mQ52XqicUfHZXK96A>
    <xmx:0-xPX11rsyv1zoMPKj5RWPjcA0KoCItSlmWAGmyF1FPUsHr2bap5CA>
    <xmx:0-xPX_EI2qk5p6WephGhjAyuB5gZF5IaTDhUKpP9Upks5H_HnqhuTw>
    <xmx:1exPX5EZ_sCdMNtmrFMDAa6dpLeRkCn7YBKIE3Xn5FYbHnue5VLc7POaFVA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 329EF328005E;
        Wed,  2 Sep 2020 15:04:51 -0400 (EDT)
Date:   Wed, 2 Sep 2020 21:04:49 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     sboyd@kernel.org, mturquette@baylibre.com
Cc:     Hoegeun Kwon <hoegeun.kwon@samsung.com>, nsaenzjulienne@suse.de,
        eric@anholt.net, stefan.wahren@i2se.com,
        dave.stevenson@raspberrypi.com, devicetree@vger.kernel.org,
        tim.gover@raspberrypi.com, kdasu.kdev@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] clk: bcm: rpi: Add register to control pixel bvb
 clk
Message-ID: <20200902190449.qoao72lc4hdgv6m2@gilmour.lan>
References: <20200901040759.29992-1-hoegeun.kwon@samsung.com>
 <CGME20200901040851epcas1p28f443c0e819bea756ebf9296491b32da@epcas1p2.samsung.com>
 <20200901040759.29992-2-hoegeun.kwon@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r53kpuqz3egnnm7b"
Content-Disposition: inline
In-Reply-To: <20200901040759.29992-2-hoegeun.kwon@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--r53kpuqz3egnnm7b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen, Mike,

On Tue, Sep 01, 2020 at 01:07:56PM +0900, Hoegeun Kwon wrote:
> To use QHD or higher, we need to modify the pixel_bvb_clk value. So
> add register to control this clock.
>=20
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Can you merge this patch through the clk tree?

The rest will go through drm

Thanks!
Maxime

--r53kpuqz3egnnm7b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0/s0QAKCRDj7w1vZxhR
xSj5AQCqraZ624rX3+422hwzvHAjXebcXXo/k5QtfouULAH9uAEA2hUPPx3QnSzt
d+sIaCmCMaBIBO9JCuo1qwf1JJ6mAQA=
=K0vZ
-----END PGP SIGNATURE-----

--r53kpuqz3egnnm7b--
