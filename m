Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D1AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF1BA2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 12:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595593336;
	bh=8PXCx60bJOB2VVd2llmJy4lMgQ91giqE48nQabhYHIs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hu+8kuUUQyvxys2aaLySZU0Jhmw4xczmrW6mpZ+JBuJE+8moJYcuWzfIGYs8sEf5x
	 lxsl87X9APFhocRi6Nk6fIJESUIJvaiyRRg1fMgELVthWcsQPwvwwBuZ0U87HF8PxL
	 k54r3vJA/ZrR3GdsdSRFEnxXMoG4aPS4m8ssXXnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgGXMWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 08:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726258AbgGXMWP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 08:22:15 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A59CC2074B;
        Fri, 24 Jul 2020 12:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595593335;
        bh=8PXCx60bJOB2VVd2llmJy4lMgQ91giqE48nQabhYHIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y/wjC9A/oDApgq731MtfIyCOZrYiKVWbu6UV9mKKddRCYmUwAp4KPKzXQ87WkGdi0
         dFemXfYLVI7DxFBNUtnopYEV8e4mkNKhWBWL9y0Na4rmj/iFTqcs68ztCcnidGhS5J
         E/hMuWYUqksr3ogD2pICcfNMTQOwnaJzO74vsbnk=
Date:   Fri, 24 Jul 2020 13:22:00 +0100
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
Subject: Re: [PATCH 6/8] regulator: mt6359: Set the enable time for LDOs
Message-ID: <20200724122200.GE5664@sirena.org.uk>
References: <1595509133-5358-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1595509133-5358-7-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gMR3gsNFwZpnI/Ts"
Content-Disposition: inline
In-Reply-To: <1595509133-5358-7-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Cookie: You will wish you hadn't.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gMR3gsNFwZpnI/Ts
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 23, 2020 at 08:58:51PM +0800, Hsin-Hsiung Wang wrote:
> Add the enable time for LDOs.
> This patch is preparing for adding mt6359p regulator support.

Acked-by: Mark Brown <broonie@kernel.org>

--gMR3gsNFwZpnI/Ts
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8a0mcACgkQJNaLcl1U
h9ClHgf+Iv+wHsCGXF3YvUuwEgURaO7JIQ3MmUBIbBA9ydPNLInosIv5pzsEfzKU
ksXKf6YrYRWtvGKZ/RI+yQy50doSXIsjpVdGtaSthXlkCtU3O85UmnYH2/XbgQWU
39glGYpINamDCNkrNc7DqdtxXEwoymcfRktME+Hb/jhiunoGNi/nXXhi1lsgA2KE
kLufn7w7rvstpsbmxgRjlbwN9bPQNLe4N/hMMLaI1vClZiYdlKPEsvL5eUZiMSUi
9yQqKDVFzYFMsDsrdAwnqEP04OKIqgJ3WHoy5S8lZB23r6slnMddqXSSsPRNy9K8
Q00IJm9y5cHVZ6Z5sWNDrNfJy9D4MA==
=ZtYc
-----END PGP SIGNATURE-----

--gMR3gsNFwZpnI/Ts--
