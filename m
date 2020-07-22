Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D124CC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:41:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE0DF20771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 10:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595414493;
	bh=ALDy45uCdZe3Ayi9GNp5dgiErhBW4lkKC52BVf5tDXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pyZcGtWjIx1Nmnsxm+5NnyYb0A4DuIGCmUs/zSjOIRrvyP+VH49oXcsDwpHUqJDfj
	 zEwok4nmTKLwfdHz00EI8rDWoPllMZouhztAWLWap9l4aWC2P0BWu5rdSsoZx7TZXb
	 H9cHTveL3Z2GGDuCgiLI4Bv9/ESOC3pwNzvhPfho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgGVKlc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:41:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:50370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgGVKlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:41:31 -0400
Received: from localhost (p54b33083.dip0.t-ipconnect.de [84.179.48.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37C8B2065E;
        Wed, 22 Jul 2020 10:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595414490;
        bh=ALDy45uCdZe3Ayi9GNp5dgiErhBW4lkKC52BVf5tDXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQ4AmN8uaWfnEgeWwL2absr7V4VQ2TdebuVBocFbptouvLILfg+7HIN1IR6AA9t1B
         yDRUcNmKpM3vP9KQkui6NnL3rhZ0s+FmnQMz/zxHw/Hc1PqDUCs6EtYhNU2hVpVx6L
         qtCWLbkSZ1J4S+N7EhvE8AJQ1XFPZFkMl5SFez9U=
Date:   Wed, 22 Jul 2020 12:41:28 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Dhananjay Phadke <dphadke@linux.microsoft.com>,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] i2c: iproc: fix race between client unreg and isr
Message-ID: <20200722104128.GK1030@ninjato>
References: <1595115599-100054-1-git-send-email-dphadke@linux.microsoft.com>
 <116ac90c-8b49-ca89-90a4-9a28f43a7c50@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LHvWgpbS7VDUdu2f"
Content-Disposition: inline
In-Reply-To: <116ac90c-8b49-ca89-90a4-9a28f43a7c50@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LHvWgpbS7VDUdu2f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > +	synchronize_irq(iproc_i2c->irq);
>=20
> If one takes a look at the I2C slave ISR routine, there are places where
> IRQ can be re-enabled in the ISR itself. What happens after we mask all
> slave interrupt and when 'synchronize_irq' is called, which I suppose is
> meant to wait for inflight interrupt to finish where there's a chance
> the interrupt can be re-enable again? How is one supposed to deal with th=
at?

I encountered the same problem with the i2c-rcar driver before I left
for my holidays.

> > +	iproc_i2c->slave =3D NULL;
> > +
> >  	/* Erase the slave address programmed */
> >  	tmp =3D iproc_i2c_rd_reg(iproc_i2c, S_CFG_SMBUS_ADDR_OFFSET);
> >  	tmp &=3D ~BIT(S_CFG_EN_NIC_SMB_ADDR3_SHIFT);
> >=20

--LHvWgpbS7VDUdu2f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl8YF9cACgkQFA3kzBSg
Kba6cQ//fw45mvFWfHa/AsTWYtBZPnPvi5JJhzzrCqP+3q3bs6ewwzjoCrqGZXyI
KhIJKqbPFhwQOA2mjEbbioPcCJ4Z71mtq0s1IblmUlSL6NzMb0hgMBgdVYKmuEBE
27AwTz6oUzulBfejYPPo9LxVsmY+ZiNA6m6uOhhqkp/SKNbye9Tdy1ZnxwTLmwFV
dXGqEyQoxQK+LBtuzpSCsg/Z1/PYJAM41Ya+F+PZhy616Hkn8f3iW2rYez+oejpc
HjLRER6TLNRewsytxMKGae4AsjA04JQ6PtHfMMrfGdq5WNPY12otZKDx1w6jYC3e
WljQUBdNiD7G3EquvDGyG4KOWub1NhNXMk/RrMsgAqOhH6ErbqwJJYRZpy/7UCao
MYI9cXa93Qfq1LHNGZcrRFaw5pIja8VAD0MKhJG+vtooi5ZTiFdcsUqece2CzoMZ
Dz3WzvDlJOi7CLQEBDng5YmrHO+GrAZNbkcf6SApjss8FGy+qhjx9vasHXkKG6ca
blgY9qHThn5vWYwJ/xe1n6lJywKnSek7EkhkjGqWf8tmww766gQ2fcowSmoGJcdD
gQhq2EZYqhNKeLnL0U2D3t+szaunbbOISNHeyw/E2XI5BtC+knliWe6kaOu3tBKG
xYypzgHmeNzQisBDx3nQV7tnMGkQKrGt0hBAdAGM21lHJmgDtb4=
=5q5r
-----END PGP SIGNATURE-----

--LHvWgpbS7VDUdu2f--
