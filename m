Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8399C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A71620780
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 10:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593513918;
	bh=HCwlK42xB042oqF7MAHHSUKyEu4RNuEIcvJII2cfj1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WNWSxfrPUbbGBL+pNEFo6YSZtQKJ0DI0cVh4lAvpQzRljVBN1QA5VCHXfR0H9aTut
	 5qJ5+ibyjuU3hwjS9RmFFqnwkfEp9ClJ/OvlLFdcc4Yk6uzMUwekZhj1VTSRm5yfA9
	 f72LjKvltTKd+IKSpo+RPUfBWqb/d+/oIgblcqDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732585AbgF3KpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 06:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:56010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732510AbgF3KpQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:45:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B29792065F;
        Tue, 30 Jun 2020 10:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593513916;
        bh=HCwlK42xB042oqF7MAHHSUKyEu4RNuEIcvJII2cfj1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RgTVEDZX01EVqYqLfOdTNEQOSbgsNYs8npVeIBBFE+rp1yLIUrdMrWppFoa77aR04
         IVKfrY9h5tntGo4pKMAInZn9L48ADjfSmMxec67wMCW28Fer4NQ/ParNsoEawFwx1p
         75enOI0s/p4r3CYIk1x1fFAU+4N6ejj9hE9zU+Ck=
Date:   Tue, 30 Jun 2020 11:45:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     perex@perex.cz, tiwai@suse.com, kuninori.morimoto.gx@renesas.com,
        robh+dt@kernel.org, lgirdwood@gmail.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, digetx@gmail.com,
        alsa-devel@alsa-project.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, sharadg@nvidia.com,
        mkumard@nvidia.com, viswanathl@nvidia.com, rlokhande@nvidia.com,
        dramesh@nvidia.com, atalambedu@nvidia.com, nwartikar@nvidia.com,
        swarren@nvidia.com, nicoleotsuka@gmail.com
Subject: Re: [PATCH v4 08/23] ASoC: soc-core: Fix component name_prefix
 parsing
Message-ID: <20200630104514.GE5272@sirena.org.uk>
References: <1593233625-14961-1-git-send-email-spujar@nvidia.com>
 <1593233625-14961-9-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3XA6nns4nE4KvaS/"
Content-Disposition: inline
In-Reply-To: <1593233625-14961-9-git-send-email-spujar@nvidia.com>
X-Cookie: Walk softly and carry a megawatt laser.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3XA6nns4nE4KvaS/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 27, 2020 at 10:23:30AM +0530, Sameer Pujar wrote:
> The "prefix" can be defined in DAI link node or it can be specified as
> part of the component node itself. Currently "sound-name-prefix" defined
> in a component is not taking effect. Actually the property is not getting
> parsed. It can be fixed by parsing "sound-name-prefix" property whenever
> "prefix" is missing in DAI link Codec node.

Any fixes should go at the start of a series so they can be applied as
such without needing to pull in the rest of the series.

--3XA6nns4nE4KvaS/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl77F7kACgkQJNaLcl1U
h9Ddygf7BrD+E2FcOp8W6S0EYnd7iYl0lFpKgh7ecrnG7StoGY3SPitqEAa0P2L3
2yl+I7bikIQtVPb0E0k55Fr8bnIo/b+7Gn5LGI+BnXRg6E8wU/nRIrmiu1Yg5Abo
QE5BLjDS98Bg3HmoR2qA3shJ6GM2bNOphemjtLP4gtd1ceCKoS143lR+XkkoSWoD
Vnw0bkyg86RJoLykmF1IwIjPdx0HtDygI9PhX/e0rOU9iDDCMmNGtAoFe0berc5d
/xUlYzSeVbpBbeCCT0g1Q/uZmAGUo0kydWp0pdPTqgjkzhTUNam6yY9L/25JBHsY
qf/OnFDPGSaSKEtgp8kltfZMcT1d4g==
=t15Z
-----END PGP SIGNATURE-----

--3XA6nns4nE4KvaS/--
