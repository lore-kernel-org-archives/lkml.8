Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87359C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67587206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594806592;
	bh=9xx+gNtt6oLKxftC59xyOBTx9fu4Ex6Msj/y14JyeWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sny2NQl1++1BNsgPtlMxXWpOvJA2D65bzIRuqAS5f/BFD8I9II6Qr9miUZAGzA0sq
	 EIy6/JnmBRqoUHsh9wrPT+8e0YW3LflebBsqm7ouYCkqAbXN3B4xrrfXiLYQZdWTlq
	 X9GdHt0heSRaPH7rIxBshch/gD4E0PAgcXIj95LM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbgGOJtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730854AbgGOJtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:49:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0174206E9;
        Wed, 15 Jul 2020 09:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594806590;
        bh=9xx+gNtt6oLKxftC59xyOBTx9fu4Ex6Msj/y14JyeWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ymdu1pusQGg3JKkkxYsuWEvNXbUAmj6yZmX3c5nnbA3rs6vQFtoG3QW9cPQ0+LEtn
         Jo+k18VjelP0t6a4o348atJSeCgZBIECuTTxeGuzPwn3lLCUcpT1w1wrMmr/0ppM01
         CaSdBcQqbLFNsAwj/ZOKebcI+o2WFy64YNsNUzbg=
Date:   Wed, 15 Jul 2020 10:49:40 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] spi: coldfire-qspi: Use clk_prepare_enable and
 clk_disable_unprepare
Message-ID: <20200715094940.GB5431@sirena.org.uk>
References: <1594790807-32319-1-git-send-email-zhangqing@loongson.cn>
 <1594790807-32319-2-git-send-email-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <1594790807-32319-2-git-send-email-zhangqing@loongson.cn>
X-Cookie: 40 isn't old.  If you're a tree.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 15, 2020 at 01:26:47PM +0800, Qing Zhang wrote:
> Convert clk_enable() to clk_prepare_enable() and clk_disable() to
> clk_disable_unprepare() respectively in the spi-coldfire-qspi.c.

Like I said on the previous version are you sure that ColdFire uses the
common clock framework and has the prepare calls?

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8O0TQACgkQJNaLcl1U
h9A/dgf/aLQzZJxJjJtHkv0PkrYiFHMKt2j85g9+O2DYaRsaX7NqkYxlg7mdzgaC
m/+BgYLwuUMzGHtkk10454Sdixed6OMIARbGbX6SfzUOIgkeqMOmStuTlVh1ShcL
TLB6EBDXUaVXvozf5NTIfQg2HYoB/4eUILY8jI56JJwhn034883Eu429EGbOQWCs
TO9ndf1B6klLdBJ+u7Arl20jUHmiCYPLIuhPHdaKSzsV8FMMP4TdmeMhi1SX0fVO
uiTbBXXsucV3+d7KUxLzCUR+h4plV0R5ckyucfTZE3luKrg3PYHL5VXUE3S9UVlz
rHHfbNqENQMR5G8iyTkI8IjSiqnF8w==
=How3
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
