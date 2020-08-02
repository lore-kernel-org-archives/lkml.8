Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83AFC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 17:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CB62072A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 17:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596388104;
	bh=Ueg/E/nPfiWqU92s3F8StP7QZAqD5EKpNriEqglQy6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zzXT7qBXIhPn1AtQV2fueSzuwvXBvCaOWvWSGnnsTt42DBnx2D2zfjXfvdsGzMe2I
	 yr8qeAUGsicC4wDvReTYYfhFLyIeL87K5yLkfufbVukcuVnl0Y2+GjX1tv/fyninvV
	 YGJNil+oAJtGAp4MB0ShTFooYuw6X66KqEx7DTmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgHBRIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 13:08:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgHBRIX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 13:08:23 -0400
Received: from localhost (router.4pisysteme.de [80.79.225.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37992206E7;
        Sun,  2 Aug 2020 17:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596388102;
        bh=Ueg/E/nPfiWqU92s3F8StP7QZAqD5EKpNriEqglQy6s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BcQu0fr14IdODrK0TSyznfrrcB1GtI3t4oB7WXb7dfNkXvCMLxpJ8zNFbwjvf1ggj
         AhkainBW2YSxFEafQQc7YdFVpswtj0JkCHbeRLN47LkG+AvSl988WGdM9NpI6cK1qn
         GzajU2vnYRcZMSK/NfwpRYjmsha82QzN6HJT66sM=
Date:   Sun, 2 Aug 2020 19:08:20 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, ludovic.desroches@microchip.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        linux@armlinux.org.uk, kamel.bouhara@bootlin.com
Subject: Re: [RFC PATCH 4/4] i2c: at91: Move to generic GPIO bus recovery
Message-ID: <20200802170820.GC10193@kunai>
References: <20200619141904.910889-1-codrin.ciubotariu@microchip.com>
 <20200619141904.910889-5-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline
In-Reply-To: <20200619141904.910889-5-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2020 at 05:19:04PM +0300, Codrin Ciubotariu wrote:
> Make the Microchip at91 driver the first to use the generic GPIO bus
> recovery support from the I2C core and discard the driver implementation.
>=20
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
>  drivers/i2c/busses/i2c-at91-master.c | 69 ++--------------------------
>  drivers/i2c/busses/i2c-at91.h        |  3 --

Nice diffstat! I will try using this new functionality with another
controller next week.


--DIOMP1UsTsWJauNi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl8m8wQACgkQFA3kzBSg
KbaBmw//QdK4p7QCdFMhEXMOhurIjSRsRgKD9/Lzj4Sz25CH8dfzr+r8irJ2xDO3
5GGH4kWTNKO/+6BFDRroooDsvwqC/seiu2kF0f+pWh7m8fIzTWM/NetRTJuAJ+Cq
tczzLPFFILaUDrw1IoeglkA8dUqLOGatc+gdKIHHI04uakoE+rrcq8AJbkoBHKif
/NAePpfsVXYdhKIBPY/NCZtNrSBhOfSvUZ3jmA8X/1IyWXoBRb79TwsMHsvmiAJ9
W/mnxWPvUKyATnxa6/jHpfaQyuCzJSZDtHoHRwMxPLpFMZrkiAIjY55DhCaoF+AK
7fDzS/dHPf9Isu7UBldxtH4myA5YZJ3OaQ5mWEOafHcGBK3k0r4N0oZBDobowHGQ
h1GLAtwoC8scqIx1KSYH4WsYphA/zVMR0vgPUw4k35fgptz0cGVOPaBVZVUM8AWa
Q3FZujEHtTfuDOksNqjOouFFkmvOUd7Aa+OCeL3W2ybHOMJ/O39DcmqdvL3CiJRL
Bf7aL1LE3yBhYhJ7dRMrKpUVoSbMKMHm9PV65zwfB+4R8sRDGwmeShPUTOXRklqG
+bTkrSYIRwGhdeYJJ2WzTziFzizMw3lomU00rWyLXlarUwr053flbv65XxNgfAhq
NDKvO6H2IOqhZzZglqXB5hWQ3vA6OJlomTuG46wY7FojKuCLr+w=
=ae5q
-----END PGP SIGNATURE-----

--DIOMP1UsTsWJauNi--
