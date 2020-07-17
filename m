Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE77C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1360F20734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594987879;
	bh=SM9pIqkwHsZoqbdzaqeC6yp+KV1bCcBYMudp0X0KOLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aaEiUoJzO72uypDQv4BEkzZekH6grt14YtyFjWfM7ZiOgvcPV1FNEfD73RgxPaSy7
	 C9zBPaePUFkX8SjKWQpu/mFHjir910Kssng7V+GM2dhFi1RiKFvyqlOuxlDCbHqvfi
	 Oo6b0wMTiMoVkEnIhgv2a/7/4ZJ6aCntoaDqM3BI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgGQMLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 08:11:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgGQMLR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:11:17 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78ACD20684;
        Fri, 17 Jul 2020 12:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594987877;
        bh=SM9pIqkwHsZoqbdzaqeC6yp+KV1bCcBYMudp0X0KOLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uhTW3gqJ5bZvoMfEWzYsddz60gssaUrfoVqBbYH59a9/VtPkqVj/lmn3g+Ym9r6T4
         ZSlCIDuN2hyUB5UbeZoHYzeEmmAW7VLGEa6mq9cDIxQmVYBGtrdaPkPrCamhqyQ6Qj
         e9PRRqIrBIDiZTXkklffx4y3U0K39lbgsJcndV4o=
Date:   Fri, 17 Jul 2020 13:11:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        trix@redhat.com, matthew.gerlach@linux.intel.com,
        russell.h.weight@intel.com, lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v2 2/3] regmap: spi-avmm: start with the last SOP on phy
 rx buffer parsing
Message-ID: <20200717121105.GE4316@sirena.org.uk>
References: <1594896174-18826-1-git-send-email-yilun.xu@intel.com>
 <1594896174-18826-3-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T6xhMxlHU34Bk0ad"
Content-Disposition: inline
In-Reply-To: <1594896174-18826-3-git-send-email-yilun.xu@intel.com>
X-Cookie: No other warranty expressed or implied.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T6xhMxlHU34Bk0ad
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2020 at 06:42:53PM +0800, Xu Yilun wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
>=20
> This patch works around a bug in the SPI Slave to Avalon Master bridge.
> The SPI slave will send an unexpected extra SOP in the following case.

This is fixing a bug introduced in patch 1 - just send a version of
patch 1 that works, don't incrementally fix it.

--T6xhMxlHU34Bk0ad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8RlVkACgkQJNaLcl1U
h9D4HAf/fupAOOvRf5rJW5/OHDc8uSimJBvXiLjpkyrkSNoJD7+QVXxBqpMmCRrI
5a9GByP6pZysHOju1TWkpNDnceLavQJ8ZsCStQlkzm15/PSEJZ+wrGtUtAjY1qGg
NPhaGLtS0kpS8NswSyDLBfJOOVvsHZEu0dIN3XMW9ZkTXFoM169IrN7irspP2GXV
WVAMI+onD3jO3DknJpDz5c6FS5cNhRzP8JmgC5VgP71A/VKm4jhJPBzfzB4iFO5r
LjBp06qwEBRsfAKTwlUMbb05AvI0igFuUsUcSmyhpcUmDw07FJPQdJw+kJvi/OOJ
bfJPCb9aiJrg2nvIbETllZixdU1X2w==
=fRvS
-----END PGP SIGNATURE-----

--T6xhMxlHU34Bk0ad--
