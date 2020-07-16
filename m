Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5C5C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9692F207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594910102;
	bh=nxkcrc5P7Qd7poz1LmdDvcMFnguH4wq4okmKRFsmWhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hYqs/6v8Z15GIe9y5mD7SLfIdu6RNG5ib+EMl4xxAZ1OlXv5B+ispXkTzuTK4we9l
	 5LMdtrN5oDriR0j54DH5/zQuLz5fWbdiSMQhKixf1FS5WKp9T0Vj/gp0bR5avGKGZy
	 /vwOtuhfYb42CkA+uih03TmpA/EviQzeM/+SR53w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbgGPOfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:35:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:54486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726963AbgGPOfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:35:00 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4C7F206F4;
        Thu, 16 Jul 2020 14:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594910100;
        bh=nxkcrc5P7Qd7poz1LmdDvcMFnguH4wq4okmKRFsmWhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5zWQW7KcwQQwGsZLtlihkD9diBPlVE3DBlaRFuftlKxZJ9FVattsI4I5Lc5ENbS6
         68oniVnmgwkk+HemvqlyT3+a+Hh1TY0Gnd7IxVfpyVYoSt8jOuG0WBzyiv3oJVZgbP
         AkJnG3L9x3uLfQ8tI5QQ0QFX+YzK4k1rEXAGhr6k=
Date:   Thu, 16 Jul 2020 15:34:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Jing Xiangfeng <jingxiangfeng@huawei.com>, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, khilman@baylibre.com,
        kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: meson: add the missed kfree() for
 axg_card_add_tdm_loopback
Message-ID: <20200716143450.GB5105@sirena.org.uk>
References: <20200716132558.33932-1-jingxiangfeng@huawei.com>
 <1jzh7zegfw.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline
In-Reply-To: <1jzh7zegfw.fsf@starbuckisacylon.baylibre.com>
X-Cookie: This login session: $13.99
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 16, 2020 at 03:29:39PM +0200, Jerome Brunet wrote:
> On Thu 16 Jul 2020 at 15:25, Jing Xiangfeng <jingxiangfeng@huawei.com> wrote:

> > axg_card_add_tdm_loopback() misses to call kfree() in an error path. Add
> > the missed function call to fix it.
> >
> > Fixes: c84836d7f650 ("ASoC: meson: axg-card: use modern dai_link style")
> > Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>

> Thanks for fixing this.
> Maybe it would be better to use the devm_ variant for the name instead ?

Yes, that should be more robust.

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8QZYkACgkQJNaLcl1U
h9B59Qf/cQ/Ssu6kfNi9QbWnYWdZOWPmbzLXNPPSbdpuW2McJvjhrFAscgfM5b/m
+ShTyHn5oEztIfyoIXlaCPsfmNJRBjLotRdmo8xlZ3FyzgxAE810aNDKwR4uaOnv
lSByiQZOnNa3EhV5P1naQaRf/MLw35gsHixOxQBO3kLkkokx5GpL1F1quQC33N9l
cNu6tviX29PziUhmYNdjr6nhhSsHB4qC7+l6YwQmR3DzEPeVTiW8b1lWsmWL1YQq
fhLlNWrqQSBTs01/EUEmvCHnHZZTZUhJRpIozH8eGjvhvg9YeY1nRj0ggxClpGHh
Dzc0HtU/KTKfLk8zhuQLhLrKBKGvzg==
=gap3
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--
