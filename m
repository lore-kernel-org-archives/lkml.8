Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E303C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 10:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44E892051A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 10:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580896930;
	bh=oBYuPXXv/66fzN1ASv2aU1O7QlQkXjCIjDUBNtWwQko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=imiWBJMdsHLXVpuHtM6sdMn5p1FiY4AaGpQyvxJpi5biV1jZBcA4/3IBXwdRt8BIP
	 NfLfSvdOzZEBUoIM4ZOSF0YwS19LFMG/cERRZx6On83a3gBXlzpqc2QlOmDtg6S0Bk
	 /K+cteNURGS989/w+EyFqbi881w6ni4HS7MWwKkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbgBEKCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 05:02:09 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57012 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727068AbgBEKCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 05:02:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=oBYuPXXv/66fzN1ASv2aU1O7QlQkXjCIjDUBNtWwQko=; b=t3te0ZeVUoGID8glNCTYlLc2Y
        m/BVOnTtbeJ5Oeut5ykyuzhQghXxwnF2PB7S5Pm5QyWiAMDroyLvQsxTpNZIByL7PP1Pbx2J878ks
        gIcWFHWmOWNGjPpGHOXLRnlegLh+h4j322VjzrLdKzFhcl75nwbxwdEbni9QI2iEqTh/o=;
Received: from fw-tnat-cam3.arm.com ([217.140.106.51] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1izHVP-0003oo-Ps; Wed, 05 Feb 2020 10:01:59 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 73FE5D00D65; Wed,  5 Feb 2020 10:01:59 +0000 (GMT)
Date:   Wed, 5 Feb 2020 10:01:59 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: wcd934x: Add missing COMMON_CLK dependency to
 SND_SOC_ALL_CODECS
Message-ID: <20200205100159.GF3897@sirena.org.uk>
References: <20200204131857.7634-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k4g3xMTzTwvmb7wy"
Content-Disposition: inline
In-Reply-To: <20200204131857.7634-1-geert@linux-m68k.org>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k4g3xMTzTwvmb7wy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 04, 2020 at 02:18:57PM +0100, Geert Uytterhoeven wrote:
> Just adding a dependency on COMMON_CLK to SND_SOC_WCD934X is not
> sufficient, as enabling SND_SOC_ALL_CODECS will still select it,
> breaking the build later:

Srini already fixed this.

--k4g3xMTzTwvmb7wy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl46kpYACgkQJNaLcl1U
h9CdWQf/aFT0LLxtrjpK2ZraWkMAXbc/uzMv9oyxBMRJkViEi5/GaE8J9XwyGR0L
xNV/jE0eMc6y4xMMkwcjv7Mla/fudCZoYaG5bjPI/xLMYG8MYwsPlLUXtt+1Rpcz
9xEeatoF0rOleTANkzmNYTxDZPOCN2BL7ALgzQJKS1rWsIJumG0KrRni9P88/NlG
y+hBF+N+QBvb7TEpkMHdeLvAZ/tZaV+2HJ0hG+zt3IlTPXmV4pvQ4RWMgTiuxW4e
8kxxC8kq4oEt7Dvn2YxEItUt07ttcEgHWDVm10GzT103a1/+qaISvCEDsFPYuSnW
FzReuyLciaCuSyqzmUUH9fufzkLpIQ==
=Ycyk
-----END PGP SIGNATURE-----

--k4g3xMTzTwvmb7wy--
