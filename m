Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EAACC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0439F2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595593404;
	bh=SCXFKjxEaCFEqThct34NH7LinKsaOpA7DKxBHAjFIsw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W5lEilvNG4OvUXOT+IUdrTT8LZpT+F7ZlsfQKis3UY2odT9A3tLBx9CMQ3kV4B7k/
	 Pnn5QpwiIGNNgKrYx+xWxtEwElcJtcpaaH2JBBgR+48vp7xfLUL9DPE2BJqgOq3Yv8
	 lCD8Dw1uxwSRsralFq6vYK98ISZw7kOfG0i0S6iM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgGXMXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:23:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:33972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgGXMXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:23:22 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0630820737;
        Fri, 24 Jul 2020 12:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595593402;
        bh=SCXFKjxEaCFEqThct34NH7LinKsaOpA7DKxBHAjFIsw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iHjV6PRMiPtvYQ78i14qyA8AMC0rOelizX1FFlG2owztY0tuTHP2CXjjzPKGE6stH
         nyove5LbJGrydA2rRaNIIpGskvbFZJeTFflHI1EsA+CZSb8YF+eKDyMts8D2XbEPol
         fEgHgsuHT1VV7P84PZFD0ve7K+G61NOc8CFE9fzg=
Date:   Fri, 24 Jul 2020 13:23:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Josef Friedl <josef.friedl@speed.at>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>
Subject: Re: [PATCH 7/8] regulator: mt6359: Add support for MT6359P regulator
Message-ID: <20200724122307.GF5664@sirena.org.uk>
References: <1595509133-5358-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1595509133-5358-8-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jkO+KyKz7TfD21mV"
Content-Disposition: inline
In-Reply-To: <1595509133-5358-8-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Cookie: You will wish you hadn't.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jkO+KyKz7TfD21mV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 23, 2020 at 08:58:52PM +0800, Hsin-Hsiung Wang wrote:
> The MT6359P is a eco version for MT6359 regulator.
> We add support based on MT6359 regulator driver.

Acked-by: Mark Brown <broonie@kernel.org>

--jkO+KyKz7TfD21mV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8a0qoACgkQJNaLcl1U
h9CI9gf9HBScIw40EhXiHa2xEWUpuW7VdZE+GURbcWcwrbYa1DzxTpy8bnVgBHSZ
id1lz9wbu0docIpwklwTolu0/YTvsX/4HbvOdo72+r0g9Q+TEudUGpkbExZEk+VE
7xv+F60dCAdaORA7dCs9Lx0PYgOPzhCvngpNCu0toeAHQjL3xNiFhJVGux5KNMiY
1UuCfEzVa2w/ovCxltxsLJI7Z4Xv5wf1RygqvALUOmp1ziTx1DQiBvMGZHEK+CY9
GdeeA/NGGgDhjTEa0R+yvcBASktquLjlwuWaEB4kXolFZynJhjQSPuFlnLmUljuR
uM5Y076bN5Y/jPaAuQ+gxm0bB+n8ng==
=/gQD
-----END PGP SIGNATURE-----

--jkO+KyKz7TfD21mV--
