Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA38BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FA5207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594986369;
	bh=KX5mPfLHuUjnGJeMBjtqTQ1Ck4CB31BE9OJacRIWQDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qF12dtUOYc0r4tUcxaigD6pTskuFFlTOSc62JxVlWv9Ygab6Ui/yGZm8KAUl4Ue0b
	 +W0cxdMgdOulQwCv6QOrN063ZSSDXcPVp3TDrqNB/7GAU6quaDYA8VqczPxOIKd4BV
	 Tr27fTFMfWDnwmMKPZVdTzpRk0Cm6PaBT07yhZhc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgGQLqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:46:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:49088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726079AbgGQLqH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:46:07 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C25B20768;
        Fri, 17 Jul 2020 11:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594986367;
        bh=KX5mPfLHuUjnGJeMBjtqTQ1Ck4CB31BE9OJacRIWQDE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DHCB9uLiov4F0fSB35Lqnoa6srk5KAw9Kka9E9gBd1LAkSsiU0JIXYaz4BR4ium8/
         KVtjkPOMF+Y0iOe6zWU8O563rEp/D3ou24ojmd9e5+p1tNf9oph/oq6tBfpy8Oz+BE
         RJTIrZgqZWeDyNRk5gByfHb1fQsze9zDrIPsr0EU=
Date:   Fri, 17 Jul 2020 12:45:56 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Arnaud Ferraris <arnaud.ferraris@collabora.com>
Cc:     alsa-devel@alsa-project.org, Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v3 0/1] ASoC: fsl_asrc: always select different clocks
Message-ID: <20200717114556.GC4316@sirena.org.uk>
References: <20200716232000.GA27246@Asurada-Nvidia>
 <20200717103857.31877-1-arnaud.ferraris@collabora.com>
 <20200717112156.GA4316@sirena.org.uk>
 <5bdf1102-e964-3d44-e673-beb23b0dc970@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <5bdf1102-e964-3d44-e673-beb23b0dc970@collabora.com>
X-Cookie: No other warranty expressed or implied.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 17, 2020 at 01:34:34PM +0200, Arnaud Ferraris wrote:

> Understood, sorry about that. Should I do a "clean" re-send for this one?

It's fine, please just remember this for future submissions.

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8Rj3MACgkQJNaLcl1U
h9DDqgf/eQ2QLdcqzuvznpoDrEQ0LM6SxnFnr3vplVVaQsHOluS09uLqLR+HkP2p
hfONZTrrp2pEVi2rOBUwm8Q9Iw8llcsgfDSY4QIdM3OMW2RBx0eZbZzJuF4GEZG2
q8oKUo2Ytc7Dw00dssXYUqEoYzAuKhcDjO0ik0J/omCjFvqX2h5CODQQRbSTSxQY
HHQlH57XuzZvN48iU5PFISv8azIzQHe/BRJNRa/UC83eoaicJ38sahPkXkIE1vjq
EM2viwQEbYK567qsSO6eKdt+SgrbV87awChbYGrL7f5+b40/NzUjXg5+E3BE+j4G
17XXR4WyhCrLNtECvaAY4KCOPrmq+w==
=maun
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--
