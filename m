Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AC5C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D42C2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="eK9D0Nd5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gDXbpy3J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgHYNkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:40:05 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:50467 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726374AbgHYNgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:36:10 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 6E67ACC1;
        Tue, 25 Aug 2020 09:36:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 09:36:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=5Pncf8+79KIbCdN+npAcSw2WlNr
        zFF6U/pUENKFgIl8=; b=eK9D0Nd5H9laRnDihIy6NQHYhAc58O6B7pLdZ+Wkjto
        I3BR9voC15hwWdY7fWUCnDglZ8dmu1B+YxRjI2pgDGYcADUdsqwBiNuuqn1J63Dq
        fd+EyIsZWPJJnOEw2yAd5ddj9iHtfrPlNkNgX8JgeTJypdYJox6BrTTiTwcGvT7A
        6de614Fzv+chIChMBJzJS7EYkhspp/6roKUhsVC4aFfXMxnpvSPJCz7dQtDaAsVl
        TdKPUOH8gP5d/e2Kwy1MM2ZSL33o/7xloXX/QzCxu+IBrtT7ts/qCGAiYXCpBF3C
        iRLWWVQDJatZw64+EaeLmC1ULXvWgmu3sR0YVTNcnjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5Pncf8
        +79KIbCdN+npAcSw2WlNrzFF6U/pUENKFgIl8=; b=gDXbpy3JA8Zsj+BxVWKKXa
        MdBjRkCqtbkiuSXk9T5HiroG4ziuvkxHWM/I5ZKZcT8DCyieDZhkFu5lNrywtkvv
        PasQHBJM+qgirAl+yUqugqJ/oKunHTdxuR67YN4d2G6KG7Cg3+SAaxJ0aHQBSVd9
        FhxC448mQ86nefP/BzId6NJjudAxyFxAXDmRh9St9fHlf2gwVL6oI/DuB5Vy4bae
        CYYBJqSO6kpZEr1SQItq5VqsHgh0wjBF+7OSwcMF4eOFKcAIb3ROm2UX04hAHbUP
        ddLLuk6WvMIXZC5d6wOgBRfu3wdXXPwv0+/EXLct1YRpCbUkSYXkKUQkThcDpASQ
        ==
X-ME-Sender: <xms:yBNFX2wrWHMw_jJGyx0EGlYa7PVwZxy_0grW8xHtcBp5T4ik2IDz2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudegne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:yBNFXyShE0sgyb5W6xhqStBA1xLf7-tKVEkh-nQVugeKE58BNsbhGA>
    <xmx:yBNFX4VMsla9DLvKXYiB0c06G105ttH48i_A80E5uViZJ-FkJuXvnw>
    <xmx:yBNFX8h-KUCLE7rFk0SwkTxcPBmJj-IAzVm5PHwBbFNXUJle9fqj2w>
    <xmx:yRNFX4vhOy0E9uvw6TtLoBviLOE28wFVGLZ7vAMq0Rbu8DRvNfMcsYTBZJY>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 527E03280066;
        Tue, 25 Aug 2020 09:36:08 -0400 (EDT)
Date:   Tue, 25 Aug 2020 10:49:19 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        robh+dt@kernel.org, wens@csie.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tiny.windzz@gmail.com, huangshuosheng@allwinnertech.com,
        liyong@allwinnertech.com, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 11/16] dt-bindings: irq: sun7i-nmi: fix dt-binding for
 a80 nmi
Message-ID: <20200825084919.y5kp5telhrg7v43j@gilmour.lan>
References: <cover.1595572867.git.frank@allwinnertech.com>
 <fb081585c4fedcb9b8b95e5f16879dff482c9717.1595572867.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="byyatgm2s2dabaqh"
Content-Disposition: inline
In-Reply-To: <fb081585c4fedcb9b8b95e5f16879dff482c9717.1595572867.git.frank@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--byyatgm2s2dabaqh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 03:14:48PM +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
>=20
> There is no one use "allwinner,sun9i-a80-sc-nmi". The A80 uses
> "allwinner,sun9i-a80-nmi".
>=20
> Let's fix it.
>=20
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied, thanks!
Maxime

--byyatgm2s2dabaqh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0TQjwAKCRDj7w1vZxhR
xXiVAQDOAeUj4JX86Yrk4ExZjAfyFTXiIerWr7jVkVGTqIM/6gEAviD6il2NwCaR
ly3k6tae3dCGUvQGwV3GgmhsplJ0pgM=
=CwzG
-----END PGP SIGNATURE-----

--byyatgm2s2dabaqh--
