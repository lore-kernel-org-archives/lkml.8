Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4287EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17CFC2078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591710659;
	bh=QLyGqEIUvJCZktBQO3E8b5CNoUk6xAoFrKqLtbqNglk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rsXMbWznqEDw1nZAIugC8WDJZlm8Qr36N2V3oXi4vcIkWmjg9k4+0Xf8Fj2Ute8Hv
	 uFgQ1DIIH+Q4W7/EnITwTdgktuIiEDWTnV//kDfWTKxIQTyeaHLxcHVGJRosmlKoCS
	 +BzNSKQM+vrMiSMDCrccKDqj18kDrp8PaIyMQrGU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbgFINu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbgFINu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:50:57 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B61520737;
        Tue,  9 Jun 2020 13:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591710656;
        bh=QLyGqEIUvJCZktBQO3E8b5CNoUk6xAoFrKqLtbqNglk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SgBCgfOg8D/M+dvQX5QNjeGmhKzkxrdjcDxhSSrj0Rjwea5+jRa4nCpF/cyiqPoFp
         SAG3+xF9PTbYhGHopwujbytcte2t2dYZlU11C8YOxHGzo8SoD8XYgQpP8f6MithbKO
         jUoT+p6ERnegqu65UE27VuvmLeA6tjTpMvi78y2s=
Date:   Tue, 9 Jun 2020 14:50:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     lars@metafoo.de, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, timur@kernel.org, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] ASoC: fsl_asrc_dma: Fix warning "Cannot create DMA
 dma:tx symlink"
Message-ID: <20200609135054.GJ4583@sirena.org.uk>
References: <83e1682e88baf127d25e3470011bd034cfc32032.1591598561.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ELVYuRnMxQ5nnKRy"
Content-Disposition: inline
In-Reply-To: <83e1682e88baf127d25e3470011bd034cfc32032.1591598561.git.shengjiu.wang@nxp.com>
X-Cookie: Be careful!  Is it classified?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ELVYuRnMxQ5nnKRy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2020 at 03:07:00PM +0800, Shengjiu Wang wrote:
> The issue log is:
>=20
> [   48.021506] CPU: 0 PID: 664 Comm: aplay Not tainted 5.7.0-rc1-13120-g1=
2b434cbbea0 #343
> [   48.031063] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   48.037638] [<c0110dd8>] (unwind_backtrace) from [<c010b8ec>] (show_st=
ack+0x10/0x14)
> [   48.045413] [<c010b8ec>] (show_stack) from [<c0557fc0>] (dump_stack+0x=
e4/0x118)

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

> ---
>  include/sound/dmaengine_pcm.h         | 11 ++++++
>  include/sound/soc.h                   |  2 ++
>  sound/soc/fsl/fsl_asrc_common.h       |  2 ++
>  sound/soc/fsl/fsl_asrc_dma.c          | 49 +++++++++++++++++++++------
>  sound/soc/soc-core.c                  |  3 +-
>  sound/soc/soc-generic-dmaengine-pcm.c | 12 -------
>  6 files changed, 55 insertions(+), 24 deletions(-)

Please split the core changes you are adding from the driver changes
that use them.

The change does look reasonable for the issue, it's not ideal but I'm
not sure it's avoidable with DPCM.

--ELVYuRnMxQ5nnKRy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7fk70ACgkQJNaLcl1U
h9BOngf/aLSe603sBhY25UjUBm5u7bXy02u1WBCRODt4C2xhzRdn/ONB0kSnJZWH
sMhms0bZYQD3+F08frWKdLRZzzfTqjTCJYIUnI53dNTGflHB3eVyLSOwhL4VgRwd
kwjHJACGkDrwncomu6q5hoFNIBnnnz0Ng8hs17CnUmelNFbGyz7oUzLRNYboJy/8
6S5lJ8xXcCVzQshXwALtw1ap0i42G+lagJpgnslaguun5p2/f700o422CQiteofT
Wn6GMhF125HPe/MpKSheTO234UQ3xuPlrE/ZHEiu0cDH5UFWnFeIBeRmkqfSpKsz
jdUXsC+t9AipuS2loQv/KSDyrZG4MQ==
=rIq/
-----END PGP SIGNATURE-----

--ELVYuRnMxQ5nnKRy--
