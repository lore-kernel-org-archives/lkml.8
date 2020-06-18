Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D537DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A989720885
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 11:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592478065;
	bh=QvA8no1TpMEdmiZ/sm5KuNeLuojuw47r6rENr5Cw9+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IJXo21bybgAfVkOz7p37OPKGy3xvYvhHZC2bbF1Bizpm50tktWCBt9CSEPtYJy1hd
	 6NpTFuH+d1TW9amF+vcOgmHdsQVp7YQq51rgv4vAW1QikM/CUlYnVxn7fo2Wg0MC60
	 0MXMPzhPforeWB4Vkod6cF5K6F/LTuldZlwaitCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgFRLA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 07:00:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:46080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728958AbgFRLA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 07:00:26 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFBEB204EA;
        Thu, 18 Jun 2020 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592478025;
        bh=QvA8no1TpMEdmiZ/sm5KuNeLuojuw47r6rENr5Cw9+8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pcuC0TFlvq8aKx88UCMeFc3rKXzUVLLNyBEvCpsWnqZeoA1M8YmOjb/tXZIE0izgP
         nXXIl4qYKqeyLcjaCCuRVrpejc1Hm/59ui99dtK2/Fy9lk6DD7UfE7UsFFf/h2oKmb
         TwksHOd8UsbZNWik6LpYRpAobmBjx6J5USfHZ4tw=
Date:   Thu, 18 Jun 2020 12:00:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.7 004/388] ASoC: tegra: tegra_wm8903: Support
 nvidia, headset property
Message-ID: <20200618110023.GB5789@sirena.org.uk>
References: <20200618010805.600873-1-sashal@kernel.org>
 <20200618010805.600873-4-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
In-Reply-To: <20200618010805.600873-4-sashal@kernel.org>
X-Cookie: Androphobia:
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2020 at 09:01:41PM -0400, Sasha Levin wrote:
> From: Dmitry Osipenko <digetx@gmail.com>
>=20
> [ Upstream commit 3ef9d5073b552d56bd6daf2af1e89b7e8d4df183 ]
>=20
> The microphone-jack state needs to be masked in a case of a 4-pin jack
> when microphone and ground pins are shorted. Presence of nvidia,headset
> tells that WM8903 CODEC driver should mask microphone's status if short
> circuit is detected, i.e headphones are inserted.

This is a new feature not a bugfix.

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7rSUYACgkQJNaLcl1U
h9A3vQf/WXhR7I7AHZ2vrSHUiTEBwIC375nL3wtLMM3A9X0B0jomIhmyFDZxYaNS
dw633sHw9HlgWyTTyx07S1iNlk2hHjOGMi/HzrTbSyK9zivf9QN6K8CIfNFzQn52
ynhCFORe0eQEP5gGqZF3bghKDzGSLwzYDq12GzJJPgibuoUk/nEq3hQblqQZj5ZZ
abqeBpm2aI5QAesPDCqYIFfqxo2pdhc39lSgHAw23df1mtuaKGn5MDPU6B/VDCiG
oHrUfwTkTc4HM06aKEUYnkkoY/y/2fxbI/wRmpHauweXn0PiWmUYeDtr8DrNJINh
uTQy4zb22IVORBEEJd7xHQg7TsL+Ug==
=2QST
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
