Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57121C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2215B20734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 11:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594984940;
	bh=4Ytl/sJApXV4/rt16Tz5YqZRmbwVqcvOPJ+WrmLBSIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zoFVnx6znhOqnmaySglmTfzeuQ3tbxUyLdmcO1x+QidZx3o4oo4dxXKait9MWiALS
	 64BRWRGiOjOeWDryY4toznab5bcGNIUor1SKHsiVS4SDHi9xLjahl+QzMHdl//6cW5
	 REVXKrbAEu7gTRvpE9sOdr+BMIyphhcjAjIicdOI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgGQLWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:22:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726238AbgGQLWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 07:22:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B94320734;
        Fri, 17 Jul 2020 11:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594984927;
        bh=4Ytl/sJApXV4/rt16Tz5YqZRmbwVqcvOPJ+WrmLBSIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AfEOvqoSmBqSuZ3IGZrCNgaEKKyAJrLH9mU99LQvawWDxFCaTs78HCYeflnfPK61R
         tJqGICRWpojrt4iXZhd8qKRhlYtLUGmPmXBEK+GAU3j/Kvof1igZFdi0/lE21Q0eL2
         lZT/XLVFvff+JAIz+bdonDDX9JyTGaCqUDa72oro=
Date:   Fri, 17 Jul 2020 12:21:56 +0100
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
Message-ID: <20200717112156.GA4316@sirena.org.uk>
References: <20200716232000.GA27246@Asurada-Nvidia>
 <20200717103857.31877-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
In-Reply-To: <20200717103857.31877-1-arnaud.ferraris@collabora.com>
X-Cookie: No other warranty expressed or implied.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 12:38:56PM +0200, Arnaud Ferraris wrote:
> This patch fixes the automatic clock selection so it always selects
> distinct input and output clocks.

Please don't send new patches in reply to old ones, it buries things and
makes it hard to keep track of what the current version of a series
looks like.  Just send new versions as a completely new thread.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--3MwIy2ne0vdjdPXF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8RidAACgkQJNaLcl1U
h9BABgf+McXrUIeMmHD9s/UnkWkyNJ4PKl5NQIIRBqxooaMsMM8EleOfLVIvm21q
gpXLvv741e7NL5slM0lyEmbPOGkrOlQtAXqQRfjXrE058oe69xfZc81UBJyY/qGs
6FHaHrv/I7t8Qi/P4omXIkWV7o8dYepW8bqoGmGaj+sWokZRH/2t+RtUhIqWGL/T
h2GOGFLnNU62s0KhCin26ASw2lf+Yn7aiVPylMz985lOH+eRL6hCaCnWFEeeoeyC
Ik2ICPmAdoqofYG6Nh1Su1w4hZC6gAhh8VheBeHjWoK5+6rJcRZ+uB1cWwSl458n
kGpe9Jse9m2ZILav2E4WlGb5ncO4JA==
=UqXD
-----END PGP SIGNATURE-----

--3MwIy2ne0vdjdPXF--
