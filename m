Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B495CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E16320780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593513651;
	bh=5qvJz6IPxW4GxH4mEunu4MaN4GfIhfcEM+grEQlyTOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fKQzdyZjzFzLyOo4QFckYkB3RAiqe2QrE7P6ywQyN/FXZJ/RS9gAJTFlPdbZHv1/Z
	 HfjorOPAlk8Xi4RnVK591CSMMWXcscg3A8RNqaH4LNS9AdXfcB7Z5DQSESU6rNTHuC
	 SoTeCuGcZXYx+Qz7PWln5OeizGDd/vsKZ3abvck0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732555AbgF3Kku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:40:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732417AbgF3Kkt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:40:49 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7EA82065F;
        Tue, 30 Jun 2020 10:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593513649;
        bh=5qvJz6IPxW4GxH4mEunu4MaN4GfIhfcEM+grEQlyTOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2Uz5FpxOZMzl1sRgzzhtHb6mSSdB+Pa8aK8nLsqq7guqzojcCLyep/rpV8vPC0f8
         GInCDAwuI4Q3Um2eBSbZbdDVn8yzsRP2GM6roG2FasbLMiXKUaHB73QHczNQNwDpGd
         M9tT+5mcW9a/Q56/qBGo1XMddjjNrz9vFUlGz5ic=
Date:   Tue, 30 Jun 2020 11:40:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>
Subject: Re: [PATCH] ASoC: rockchip: add format and rate constraints on rk3399
Message-ID: <20200630104047.GD5272@sirena.org.uk>
References: <20200630091615.4020059-1-yuhsuan@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline
In-Reply-To: <20200630091615.4020059-1-yuhsuan@chromium.org>
X-Cookie: Walk softly and carry a megawatt laser.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2020 at 05:16:15PM +0800, Yu-Hsuan Hsu wrote:
> S8 and S24 formats does not work on this machine driver so force to use
> S16_LE instead.

> In addition, add constraint to limit the max value of rate because the
> rate higher than 96000(172000, 192000) is not stable either.

What is the source of these restrictions - are they due to the component
devices?  If they are then the component devices ought to be setting
suitable constraints themselves.

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl77Fq4ACgkQJNaLcl1U
h9BqcQf/bBQI6UlLdBzbns/XWHMzns0NgqJqIDhyUaAV2cK/NnbvoadF7Q/Ierez
Kksy56oOcNJtiTpSuhy/Z2ubQNKNkcMYkwVSp3M3FllU/QxR59Ia7N8P4xkvbOsx
a5niu9cUSP94dygzita0jqcVvYkXXAaC9IHK/v11WwKsoM8KTgP3CWgksBGWJqVm
uTY3zisJtV1m7GIHObSu0Vr9c6XJrCi5G9qDZSxPyq+Fhcpz6nFtA3sN7Ctu5j8J
G8HdFjK69Suj6ESd13Xkd2/ELgNGzpA/W0SVpVkJzmS4Mbj6iyUegxXIk5LjVx4C
XfuoMxggN8y3ux+S5/MlmEw9AqU/TA==
=1Ldw
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--
