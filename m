Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C1FC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0D92075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 11:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586864220;
	bh=rBfPN/ao44IgV8u6nut9I0cnbZOEwRrUEaznfJbJcEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1J67O+GKQGZT1XEq9Ft9otFFzCTJd9lRhiOAe/ArhiY1wPzpxbPfXFbLXpQo8r/67
	 Ys4GIGLdTabiUoAhnNx2/pLoS6pKOsbrtC3LQra1ZqcQ4fN50aAvXd6lASDdbJcz8W
	 dKUm/x8GGE2M922fKw2R+Sho+TPUXN3trIIMX7nM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439384AbgDNLg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 07:36:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439354AbgDNLgi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:36:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13A042072D;
        Tue, 14 Apr 2020 11:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586864197;
        bh=rBfPN/ao44IgV8u6nut9I0cnbZOEwRrUEaznfJbJcEs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dx7zmByFwnWZhiXSn0JMjnlzaVgVG94arpZwp8n3bJcUozE2n5gxsVc7/P7aK8zf+
         XsIILNNT3HUMpZlY3ZE/+OOV9Kp0lV3/4YkwS4y/OTTBm+xrDpD+OGlTT6AeEjWu1z
         AWMhZ6sbqEvWEYTpVIIH0G9/ifA+dnWi1zI3aRrc=
Date:   Tue, 14 Apr 2020 12:36:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Philipp Puschmann <p.puschmann@pironex.de>
Cc:     cernekee@chromium.org, lgirdwood@gmail.com, tglx@linutronix.de,
        nhuck@google.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tas571x: disable regulators on failed probe
Message-ID: <20200414113635.GD5412@sirena.org.uk>
References: <20200414112754.3365406-1-p.puschmann@pironex.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RYJh/3oyKhIjGcML"
Content-Disposition: inline
In-Reply-To: <20200414112754.3365406-1-p.puschmann@pironex.de>
X-Cookie: I've only got 12 cards.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RYJh/3oyKhIjGcML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2020 at 01:27:54PM +0200, Philipp Puschmann wrote:
> If probe fails after enabling the regulators regulator_put is called for
> each supply without having them disabled before. This produces some
> warnings like
>=20
> WARNING: CPU: 0 PID: 90 at drivers/regulator/core.c:2044 _regulator_put.p=
art.0+0x154/0x15c
> [<c010f7a8>] (unwind_backtrace) from [<c010c544>] (show_stack+0x10/0x14)
> [<c010c544>] (show_stack) from [<c012b640>] (__warn+0xd0/0xf4)
> [<c012b640>] (__warn) from [<c012b9b4>] (warn_slowpath_fmt+0x64/0xc4)
> [<c012b9b4>] (warn_slowpath_fmt) from [<c04c4064>] (_regulator_put.part.0=
+0x154/0x15c)

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--RYJh/3oyKhIjGcML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6VoEIACgkQJNaLcl1U
h9Bo0Af+IXKF1Q32vmdETtU29TWHcGhIhdcsD7Z71zelETh1yMnDCbxnSv+CocWU
qZBG45EmfRWXLQAmNIKdHXKoCy5MwpQ/5pr2MszFdOB5Z2NwsDCn02ohUqguX8z/
EjJWqkpINlYhE4wAr+6oBrl2Vqjre/lFhZ+vhh2SHzQue4kQeNqajDUDzMnlUSJV
XMIL+u15zTB3c7TmvxmTp5cm8scjEDyVXCNZE6WFTB3irUtIkklfcNQwM3ykAXo0
tmkGH4cImu+dHNW7fw3HUhcGJMS+go2RmSuVeOdU0bkvmfvfw4MRnZoIr+Do3Dv3
cZNfkS8B8z6UwsNQNqES/11xfjt/fA==
=WKEJ
-----END PGP SIGNATURE-----

--RYJh/3oyKhIjGcML--
