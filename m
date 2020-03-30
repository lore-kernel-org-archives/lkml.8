Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB434C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8583C2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="WDPNg7gj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NSrzvOuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbgC3Rxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:53:51 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:43447 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726403AbgC3Rxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 13:53:51 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id CEF555C0156;
        Mon, 30 Mar 2020 13:53:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 30 Mar 2020 13:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=CO/QIjk6nVgu5l6xwmRAbGjYJII
        JyujEhdRtGQKC0yE=; b=WDPNg7gjzTvVo7d+rIGUCh5Q+yydtxODX3VC2EbKStl
        l8HDIRZLUTl3O831dUMZEC/1GrKL8CFx0BdqMcKNMgiv+MQLc87HmlX2iX7H4FYq
        15azSmdvBc4FBn3eNMFlSixNbxYyRA1BaVvZVlCRW+SWYSi6qeHnd6yURHIH0Wm1
        dCsTdOghvAo+cFxuWNpq63AX2lZWphfkq4zYE5e5/lhERtwYQPQQakNqZHWbiS/K
        LI/h0UxifIw8thUWg1m1u77S7nNQK2BAW5FoIlBUUqIpMPyiPZGT3E8WmtPT4ySZ
        cl+5S+zDpLBkD0GhuNDz4ASSDrfXj6cfXmvQFQkcWXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=CO/QIj
        k6nVgu5l6xwmRAbGjYJIIJyujEhdRtGQKC0yE=; b=NSrzvOuU7xZY7KjoQZaek9
        QKirBMApR5sbHK6sByJvBcJby3HAsNE+xCGVmWqAIWuhNv79adbpcyehrdEEk8ne
        5dqft9smcmI5ief3RdWQhly9sHK07X/FZtiQBREC99HDQF9hkZ55H0Ely0fM1blu
        ZVPt5k/UlMnmFB7C3cg+jgVucKc7usy9bM5glkMtYXyAyEIFsluL2j6PsGeV4qOg
        QvmvYnRRf0NwNsROHyQVLrJGV8GcAu67ThtDdHXeWkHNAOIFgLCMPalNp/AeBMMo
        0ldgHtNrW0Os9PxSah4jIUpnLvlrgXIw+8OHUQhXkWOJBq1duIe+FA2ggfINO2CQ
        ==
X-ME-Sender: <xms:LTKCXvlC9v0ufYkzn3wmyUvw4StGhSJNYPPGh95j174wXGtFz01XGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrgihi
    mhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkpheple
    dtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:LTKCXu9SAXFkJ4gGPB073ikDj8R8hAVTuqRrRFKmUtHz3kBX-nDRlw>
    <xmx:LTKCXrHoetWILzt06Wtg1Cy1xk_wOmF8D70AT8QaAVq96XawU7D83g>
    <xmx:LTKCXm0GepNm5MEIzYtsyxjLuVl53wvhdJuE7vUfCTYi0CgEJ4Ecjw>
    <xmx:LTKCXk5uQMWH-EwF-EBHfQDTtDuKlvHCtSp6v_2mv5dXl-8F6TH6sA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3B89D306CA01;
        Mon, 30 Mar 2020 13:53:49 -0400 (EDT)
Date:   Mon, 30 Mar 2020 19:53:47 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Petr =?utf-8?Q?=C5=A0tetiar?= <ynezz@true.cz>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: a64: olinuxino: add user red LED
Message-ID: <20200330175347.r4uam7cybvuxlgog@gilmour.lan>
References: <20200325205924.30736-1-ynezz@true.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nwt6gyfwcuq2byho"
Content-Disposition: inline
In-Reply-To: <20200325205924.30736-1-ynezz@true.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nwt6gyfwcuq2byho
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2020 at 09:59:24PM +0100, Petr =C5=A0tetiar wrote:
> There is a red LED marked as `GPIO_LED1` on the silkscreen and connected
> to PE17 by default. So lets add this missing bit in the current hardware
> description.
>
> Signed-off-by: Petr =C5=A0tetiar <ynezz@true.cz>

QUeued for 5.8, thanks!
Maxime

--nwt6gyfwcuq2byho
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXoIyKwAKCRDj7w1vZxhR
xd6FAQDYqWDZm020M4w5o+B3FOfze/BkzqWC4OhCWE+zV1F8MwD8DpZYBKfNcDSq
p4b9HbGJU/Wpobkc5NXQmfPwF+viIww=
=v6rS
-----END PGP SIGNATURE-----

--nwt6gyfwcuq2byho--
