Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4461EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15BB720663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594830134;
	bh=eT6BTd/Zx8Q5ccT8rkBpk/1FMwIdvf+1GrdYf74olgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W4umFlEOJbRyLjBsdQhbAqVXk7QWiy9WwSb65euVh0nVMos62myw3xiEf7H7WYfy7
	 t8DwVJLwQq/B7ncEf2PmCtopzGyI7+Y9imyEB93w0ayYl3otuD/blpGf0Ds8/6c8dl
	 WMMalxAaFJtwhUC+KcqnQGrjWbANyl5yC7MgiePM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgGOQWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:22:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:35506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725770AbgGOQWM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:22:12 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 607842065E;
        Wed, 15 Jul 2020 16:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594830131;
        bh=eT6BTd/Zx8Q5ccT8rkBpk/1FMwIdvf+1GrdYf74olgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xtBMl1Lkp2tHTt9F0hewQXObOrrserzLr+rKu4S4aktKmcNKltsAmxyGYDskLoMTt
         dS2nIL8K+eHBckSCxbCGTXI6Fd3LDmfG8htgV9VTM58BKQOSCTt6zz9+n+kNxjkREB
         I6JgfGJRBr9lKocj0owTpglgIJ5owpryEeTDW/hY=
Date:   Wed, 15 Jul 2020 17:22:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>, alsa-devel@alsa-project.org,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, kernel@collabora.com,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH 0/4] ASoC: fsl_asrc: allow selecting arbitrary clocks
Message-ID: <20200715162202.GJ5431@sirena.org.uk>
References: <20200702142235.235869-1-arnaud.ferraris@collabora.com>
 <20200702184226.GA23935@Asurada-Nvidia>
 <3f39a0bb-a766-f646-28b3-a51cf9983c6b@collabora.com>
 <3fea8912-63df-ff27-0c29-6284a85107ab@collabora.com>
 <20200714201544.GA10501@Asurada-Nvidia>
 <20200714202753.GM4900@sirena.org.uk>
 <20200714205050.GB10501@Asurada-Nvidia>
 <20200715140519.GH5431@sirena.org.uk>
 <0a56326b-27a9-d9f4-3923-8773963d7548@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+9faIjRurCDpBc7U"
Content-Disposition: inline
In-Reply-To: <0a56326b-27a9-d9f4-3923-8773963d7548@collabora.com>
X-Cookie: 40 isn't old.  If you're a tree.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+9faIjRurCDpBc7U
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 06:18:38PM +0200, Arnaud Ferraris wrote:
> Le 15/07/2020 =E0 16:05, Mark Brown a =E9crit=A0:

> > Honestly for anything that fun it tends to be a custom machine driver.
> > A property would seem reasonable though.

> I think so, does my initial implementation of the properties look
> sensible to you? ("fsl,asrc-input-clock" & "fsl,asrc-output-clock")

Those look reasonable enough off the top of my head, not that I've
really looked at the hardware.

--+9faIjRurCDpBc7U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8PLSkACgkQJNaLcl1U
h9BkmAf/Z0V1Eb+A2EGmiFuW+ziL7yJnYp0req34SxMFVo/WgQPUOSpA8ioVX/a+
xt5KVDHCN9FmjHphFHf6t+t7XJjEtnlfrKyoAhJlmu30K4Hyw6YeFnACEr2gQzcL
qJYhS22uU76Jrgk0l11rvDlX3pAsGrjEwBo+INsYdix6x339mi3cVc8dNQp76lPO
OiGE+vnHKqbtw71caWc+No4JXPVm0W8FD/ovs52fvWEg1mjHKXENDMaxAWvXEMo/
fvx9P5LgACTfmclCzh+Iub3Qz+ETuUreytKgi8I647DAO2pMxul9HuxlZ8ZmcvTP
Ibm55Iff0fv/6vg5p7ze/mxldgAN9A==
=un2V
-----END PGP SIGNATURE-----

--+9faIjRurCDpBc7U--
