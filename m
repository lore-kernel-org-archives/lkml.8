Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412FCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A6E820774
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594215172;
	bh=pWRPHGibjjPPWKpbJyMPd4KeiPF/cZsn0uBAep4dEts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MYO/TIfGo6fbiWuDgYZDlzpTwmVnQOuS9nxb/JdAHd42iF/OlGiMo5EjjgSS+CNXU
	 bl0CmDiTMSjONlvYOk67x3bPfu7VPfdirbRePsrEQySKnek+3J4HPeU/uJocD+PWOq
	 p2YfxjCPhzaEaMIMOOFXriTBsnBYaq6euHshG7c4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729584AbgGHNcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:32:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729323AbgGHNcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:32:50 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EFEE20720;
        Wed,  8 Jul 2020 13:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594215169;
        bh=pWRPHGibjjPPWKpbJyMPd4KeiPF/cZsn0uBAep4dEts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Scq6byouIRCANUCFAPOYPb22KSZxoBqJ+tf5/JkEVp1ex3HMbOmWCGCcTOAp4JEyM
         bS3aaHUNuKowQdQEaW6FT6Tc3+GHrLSYBzOsfq3tqy8hENXhvZpkHSH0WRA52EkmV8
         FQ1nqTlCxk6MqS3biSx0DMaLruXltRliCPAT1YDs=
Date:   Wed, 8 Jul 2020 14:32:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com
Subject: Re: [PATCH 00/11] ASoC: qdsp6: add gapless compressed audio support
Message-ID: <20200708133244.GP4655@sirena.org.uk>
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+mr2ctTDD1GjnQwB"
Content-Disposition: inline
In-Reply-To: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
X-Cookie: Oh Dad!  We're ALL Devo!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+mr2ctTDD1GjnQwB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 07, 2020 at 05:36:30PM +0100, Srinivas Kandagatla wrote:

> Along with this there are few trivial changes which I thought are necessary!

It's better to split stuff like this out of the series, or put it near
the start after any fixes if other things depend on it.  That way it can
progress without getting caught up with the rest of the series and the
series gets smaller and more focused.

--+mr2ctTDD1GjnQwB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8FyvsACgkQJNaLcl1U
h9AWqQf+O9QgCNEJa54N14qIB5Rc4Mw/3fizJUF48b0PH+rmGoca3G1ZG5wMWi0Y
dACGNRHobAITHwclS6Sf2vJ9mYarNB+IWHBI7H9TR0bwXhg39gXqma6AmD6qCohW
P+4PpynoFmPkZ5vJ+ZXymzWbTQ3jbEfamhVV6HOoHZQWIo6DogQV8bRvxGs4u31O
/+RBvxigPKakC3IJWfGgri5pTo9IE2WIB4Lxg+oValuJ4zyAtdbhNP4D8/5AkozK
e98sDMLocMQ6WFRChSS6VnAB3ySmzOf250vL98fgn4bEJ/harJ5aCmmBXphStOKE
8thsg/8jOVCrWSnHTloxWQIfMHjAzg==
=apo/
-----END PGP SIGNATURE-----

--+mr2ctTDD1GjnQwB--
