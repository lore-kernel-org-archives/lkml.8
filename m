Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5181C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD75B206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580990023;
	bh=1xvY/LZ5+BcQR7weHhsZteZ6jqaIUuGsop854FUfj5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jjH57OE2Fmt0qjHffPKVrM+3yW2WC8IyFVAPPFnq6tLrJi1+PXnunD0qpI2J0Szui
	 AUBVJBdib2vPZuJKSqVfN5siVhcSbskp1gjHhtCHWEQ7FruEICDS2uwQflYD/am/EM
	 7hVa8hABM9rGpDXkeccfP7EbzW4j0de6PRS3wfcc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgBFLxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:53:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:38012 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgBFLxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:53:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1xvY/LZ5+BcQR7weHhsZteZ6jqaIUuGsop854FUfj5c=; b=pUITjQ3pQFD1iGesatTI0LM13
        pCcXLRX9bb5tSwiqiTWuNpk5m+4SiA0S57VmhPAdwTSBtgv0KOVM47iFSL72Yz6J641+LdTpBylLs
        USXeRP3xOr2yG6Ggs6B9Nb8mLaNdfC2esiFrcoEjxaxqDBEUg/uVfMwYaCNpzXoCbM/gw=;
Received: from fw-tnat-cam3.arm.com ([217.140.106.51] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1izfiw-0001df-WF; Thu, 06 Feb 2020 11:53:35 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 5D3EFD01D7F; Thu,  6 Feb 2020 11:53:34 +0000 (GMT)
Date:   Thu, 6 Feb 2020 11:53:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benson Leung <bleung@chromium.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>
Subject: Re: [PATCH v2 11/17] ASoC: cros_ec_codec: Use cros_ec_cmd()
Message-ID: <20200206115334.GO3897@sirena.org.uk>
References: <20200205190028.183069-1-pmalani@chromium.org>
 <20200205190028.183069-12-pmalani@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wmfuW8osuO2pi9jF"
Content-Disposition: inline
In-Reply-To: <20200205190028.183069-12-pmalani@chromium.org>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wmfuW8osuO2pi9jF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 05, 2020 at 11:00:16AM -0800, Prashant Malani wrote:
> Replace send_ec_host_command() with cros_ec_cmd() which does the same
> thing, but is defined in a common location in platform/chrome and
> exposed for other modules to use. This allows us to remove
> send_ec_host_command() entirely.

Acked-by: Mark Brown <broonie@kernel.org>

--wmfuW8osuO2pi9jF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl47/j0ACgkQJNaLcl1U
h9Cy5wf/Zyo5kGxMlBNTGiB1Kyc98OfbEGfmx/48+5hLnPqdcYy9Gef8m3gVlQPs
6No9zS9XjFOYA4kfxQGhcTc7EeOtwZ6DFVUi37wPQqrrnFXeP32LjyakdbF1gfjV
M4b1veTxJ+JJt9nSkgZpISzeQkP0wAjy+gy/cQH41BPv52X3jVP1CxpaqX67bQSj
cnqbJQK2BXFhr7/EoxxXZTEiV1e9zP2Se5xSpZGnaXjzIGpu+McGxRowQ6LL/29u
xCFWXss8tY+PDRomjc9OnYFIAKkXDtCDvC3nObn1j2GzoyNsxlxJiSeYkm5abfxZ
YaEuSMCW4PRRF1XG6ixWpt2jbgYLRQ==
=4B9v
-----END PGP SIGNATURE-----

--wmfuW8osuO2pi9jF--
