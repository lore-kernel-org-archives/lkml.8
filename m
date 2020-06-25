Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55915C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DC662080C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593107068;
	bh=7naWqeQw6q7LYgBdxVyp89BuWmzeBELZAgXO4fbDFBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Iz0fuJAzIvI60vSbREuQ7ElZ75ByVsvc1w4kAFxNGacaPX/bRNzUme94CihO9IVAh
	 DTV7S+LfZDiE0n18l24QcAXqBR17UH9GP4lCZySjh6WnAG8CALB2LQHaFofSKrAYGk
	 Jxw/9s5x4js4rDqSnlWS9t1G4/hCqtsOO5HDBVVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406901AbgFYRo0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:44:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406879AbgFYRo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:44:26 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5560F20781;
        Thu, 25 Jun 2020 17:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593107065;
        bh=7naWqeQw6q7LYgBdxVyp89BuWmzeBELZAgXO4fbDFBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=swCmIaWnAL/EyJdCD0hfMqiMNSdKoj+38Uwh+mDHC/LM5CG4UmENQnV4h87XENMyd
         Qxmf4Lv0VgxGJvHRO5qOsJGMaGBGWZdZQVBOZgADk8tnR8nAnSbcIMWGbDcXO+xXPr
         peE0uitQeenEZNW1NvViurVo2o43j1BqSM3YrvTw=
Date:   Thu, 25 Jun 2020 18:44:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] regulator: da9063-regulator: Fix .suspend
 'initialized field overwritten' warnings
Message-ID: <20200625174423.GF5686@sirena.org.uk>
References: <20200625163614.4001403-1-lee.jones@linaro.org>
 <20200625163614.4001403-10-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="K/NRh952CO+2tg14"
Content-Disposition: inline
In-Reply-To: <20200625163614.4001403-10-lee.jones@linaro.org>
X-Cookie: One organism, one vote.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--K/NRh952CO+2tg14
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 25, 2020 at 05:36:13PM +0100, Lee Jones wrote:
> Looks as though 9f75ce666199 ("regulator: da9063: fix suspend") failed

$ git show 9f75ce666199
fatal: ambiguous argument '9f75ce666199': unknown revision or path not in the working tree.

You should probably CC this to the authors of that commit - a similar
thing applies to several of the other patches here.  You probably don't
want to CC everyone on everything but OTOH there isn't really any need
for things to be bundled up in a series anyway.

--K/NRh952CO+2tg14
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl704nYACgkQJNaLcl1U
h9B8Vgf/W3i4vBx4UEY3dyhXea3ctidu/6B/GCWTMnDyU0eo+/g9NGmfmkX3jCg5
rbG5q9R1S41RFthhhSK9CAc4PfHk9pZVij5SlCTZkIP36FlLO+IWetdtCJsmm4Jy
UQEXFPDrPlZ6d0J3hMGd/PR2fP4E7ZAZB3eboJchoWCJNfca1H/ZRLLGR3CEDtab
2zHgFub3vRFfF+NA7+X5GlLTUUpyJ2Rut33QkyEFVnyqVv/sfTnmDDWs3SMJYL3U
Xvgrrp+rUI7IQHUjB7Xg4lNGREziiY1fzfKem3NqmiH6uBP8jSczMPII6ZAabrxr
+atxq/G02ZbYY6Sa7NNbpfDgmlemmA==
=e1P/
-----END PGP SIGNATURE-----

--K/NRh952CO+2tg14--
