Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CCFC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 165F3208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgIKPJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:09:40 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56947 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726257AbgIKPEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:04:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 93E245C0235;
        Fri, 11 Sep 2020 11:03:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 11 Sep 2020 11:03:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=F5vNC///6BzYfwb5gLzF7HsgwYb
        oaMgrWu6nVN+w0PY=; b=lCGQkWh211MB8WDMMg0JMhsnyuD6g1f65uUEt1nGI7p
        q3gKOCbfQ/dd2o1sHpNOUI+wdVXGKguGy2qCeakeG/rkTkMNXhkJfcXy3IN6dw5A
        fL1rKPD/fzyLUUquFVg8Px0cIuC4VZyuegZuOJ6vy5IpxbhdolLc62cA22zgvKU4
        LfGiPCRmGlw62YMfh8fcZsZH0YokyTxD7NmEfX7hu5yGulGrh7QbeWMpagaHqATZ
        eTwLlCnOhCXmovrqoEbkO5qX0zUmuEV5Rkn61Utr826N7jPucWGJFmLb44xGucvV
        SpXp+EAfJnljODz2xAoelhTgid/JuVrG1b1xcJ+DVKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=F5vNC/
        //6BzYfwb5gLzF7HsgwYboaMgrWu6nVN+w0PY=; b=UGzThUAJbuvh+VRDGgCml3
        8DxQWBBdMlL94Xs1afRRPYKWAzy/4dgNeDw4PsKvNXDMrcbvih4CxbTI9ghHWDxL
        rZaMuizp/kGimkOJk9q5d2S1UflN5Qmkf7O5EfXbHeirh6yrCkqI1edyUlkpZx3Z
        UGeI/mbWYiup8p0folAA2xiMZlIVWlaAmsQK4z5CKlKrKEsBh4ozgDzVwehKCGDT
        mZNaSyXH4qL38jJk2tCQikcjBDfxy/EPqeFsSsOMzoeaALlQ8o7SZ0vTpLO2/6dw
        zg6l8jhaJmC4eDxhERmriobDBozr9pzdRVnY62HySQFP13cHz4GYa+NqwfGXbTcA
        ==
X-ME-Sender: <xms:vZFbX-2b1OjfstiLeTfCP7RTvi-7qB_FmslHsQ6qU9pfcNxmLDAPSA>
    <xme:vZFbXxFuD7MdSk5HBIS_B37eOcjAmcF-wi_gTUgUjA4c-fcbpJoPRhSAwRKrk5hrW
    HLONcOTTpIOs9_TC90>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudehledgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomhepofgrgihimhgvucftihhprghrugcuoehmrgigihhmvgestggv
    rhhnohdrthgvtghhqeenucggtffrrghtthgvrhhnpeelkeeghefhuddtleejgfeljeffhe
    ffgfeijefhgfeufefhtdevteegheeiheegudenucfkphepledtrdekledrieekrdejieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigih
    hmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:vZFbX257gUfSxjGHn0uix84dD-QXYW2x590jglxfdM7jhUC1N8C-Eg>
    <xmx:vZFbX_3NUTmwQ5kT9HDqr832SZCou3w7oJYCjJA4SAgJsE0wH0s1Hw>
    <xmx:vZFbXxHHZW7DT9CLa5VhLWXiGgOPkid_Tr1vDrK1I0LZzRBOh3YVOw>
    <xmx:v5FbX2RFAoNPc21RABrsxmpdGS934DifktuXHKF66MouenSfVvmsVw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BC7CE3280060;
        Fri, 11 Sep 2020 11:03:24 -0400 (EDT)
Date:   Fri, 11 Sep 2020 17:03:21 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     wens@csie.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] soc: sunxi: sram: remove unneeded semicolon
Message-ID: <20200911150321.2k62u5fcx2enqjsc@gilmour.lan>
References: <20200910140546.1191280-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5soe5nbp6dp42zaj"
Content-Disposition: inline
In-Reply-To: <20200910140546.1191280-1-yanaijie@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5soe5nbp6dp42zaj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi,

On Thu, Sep 10, 2020 at 10:05:46PM +0800, Jason Yan wrote:
> Eliminate the following coccicheck warning:
>=20
> drivers/soc/sunxi/sunxi_sram.c:197:2-3: Unneeded semicolon
>=20
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied, thanks!
Maxime

--5soe5nbp6dp42zaj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX1uRuQAKCRDj7w1vZxhR
xRCrAP49hBlh6psQjOrVR3j+GTuGgxjtsNj8MqZQ8OLDzg/HiAEA40t9fORe4MGF
EKZCyKApHOaruDwv5lSlKw0WOy3wCwA=
=bUcX
-----END PGP SIGNATURE-----

--5soe5nbp6dp42zaj--
