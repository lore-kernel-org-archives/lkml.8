Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6835C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A87E21569
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578930825;
	bh=gSSUGb6E72HohSMVqvfUArksaBKB+PGK4wGO9njgLZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QUcT37Kh2ws1uwANDAKiudEcdCCxaPcBC5lB17xo/BynanOHmWewxzOwf3hrD0/Mz
	 gUkvxycAHfG1FzRi4UKQVDqVYYgVaIBUYyOWrIBmavanJNhYkE790I0Z4D7GwUnzmb
	 UpYwIMIn/MbI8COqKd+OHmp3dFKnRuXKPSsVX4RE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728864AbgAMPxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:53:44 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47148 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbgAMPxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:53:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aEQXcauEtwtBTMlxbZX7udfUWpI37znKKr88yDEAqxQ=; b=YHz+pZ1lLirdpU1tTN1eAEZ2r
        IKMucJkzS5KpRS42TeZub17Go3/m4+Xkn5fk9nhWtKp4qqjQyjd1r3LaIiKeX6KJXflCOXbC1xFzR
        tmuyU8lo7BM7sfjZHKTJFEx0qmxLii1sMLT3GN3YFn9kxPMQCfVmki8F+sTgc5FHcSKYk=;
Received: from fw-tnat-cam7.arm.com ([217.140.106.55] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1ir221-0003bw-8n; Mon, 13 Jan 2020 15:53:33 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id A2941D01965; Mon, 13 Jan 2020 15:53:32 +0000 (GMT)
Date:   Mon, 13 Jan 2020 15:53:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jeff Chang <richtek.jeff.chang@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeff_chang@richtek.com
Subject: Re: [PATCH v5] ASoC: Add MediaTek MT6660 Speaker Amp Driver
Message-ID: <20200113155332.GO3897@sirena.org.uk>
References: <1578644496-16575-1-git-send-email-richtek.jeff.chang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/TUrtqMIkCP4YtJm"
Content-Disposition: inline
In-Reply-To: <1578644496-16575-1-git-send-email-richtek.jeff.chang@gmail.com>
X-Cookie: Programming is an unnatural act.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/TUrtqMIkCP4YtJm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 10, 2020 at 04:21:36PM +0800, Jeff Chang wrote:

> +	- rt,init_setting_num : The initial register setting element number.
> +
> +	- rt,init_setting_addr : the addreses array for INIT Setting table.
> +
> +	- rt,init_setting_mask : the mask array for INIT Setting table.
> +
> +	- rt,init_setting_val : the value array for INIT Setting table.

I'm not 100% clear what this is indended to be used for but given
that it's just raw register writes it's hard to see how it can be
used well in a general driver - it basically means we have no
idea how the chip might be configured in any given system which
*might* be fine but it could break some assumption the driver
makes about the state of the system on some particular OS or
version.  If there are some system specific tuning parameters
that need to be set as raw values it would be safer to do that by
just including the data in DT (eg, "X bytes of data to be written
starting at register Y to tune component Z" type stuff) or by
exposing individual parameters for things that are documentable.
Allowing a completely unconstrained sequence of register writes
doesn't seem like a good idea.

If possible it might be best to send a version of the driver that
doesn't let this stuff be configured at all then a patch on top
of that which configures all this stuff, the rest of the driver
looks good now.

--/TUrtqMIkCP4YtJm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4cknsACgkQJNaLcl1U
h9BTeAf8C55cmcfxY+HHqvC1iVVcYfUzf1wTdh3zed7cpd624wm6yrjvr2UzzcR4
t/LEvnTIeZTPFvorQNMaZLDM5KWU8YWrll6SM6deiXo2dv5uAFzs2XGY+eRvTnN3
HjcX+dnQlvd7ZCekd/b7M03IhNGIx5VY3QDDhbDTDrHA26wpil5GT3seJhV0yXsM
w1+ITl4WshJ1kDwE8+jIBG5j7FfR/4ig3ZDb2iP2frIKn7r12AJDlQXfM/pf3vpm
IXFs+JX8tyuHEU35AyG1vMOoReF0/UDGvgKI0m0hiV7E9W37FHfB+bJS64sSmnTv
4EUo2bTKPCiJv7BxPJVngMSK1D+qeA==
=xYed
-----END PGP SIGNATURE-----

--/TUrtqMIkCP4YtJm--
