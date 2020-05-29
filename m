Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFADC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67635208A7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590750560;
	bh=bNs4Fp0Ooi+xfHhQ8BXp4A2WXIzoLKgHBPiDTBQ4BUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Y1n+SyoLLp4x+EegpG7ayRyvdh2uzXeWqm1btcRuDdJDnHhaahpnjYKuLhQ8qyeKQ
	 410Ro3fWtXJPwvVC18+TnFIRd5sCrMxsCHkMMVxy7ysPLRg2coAKwi6/9aeIgJNG/0
	 PTidg/MO30XAOPAfoq4uGab1CXG559H09Eh+2izo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgE2LJT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:09:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgE2LJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:09:19 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A1292074B;
        Fri, 29 May 2020 11:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590750558;
        bh=bNs4Fp0Ooi+xfHhQ8BXp4A2WXIzoLKgHBPiDTBQ4BUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C1cE12Lrdc/YrKo0DmHo/ufRLkXADE8la0AOb7Bwp8gFC4QmPr35agLnvnpbLxngn
         cTgy0Hk+Na707yQKdL05M3NWniNbQZOdU6DVlCPLift57F56RgRd71rL3slc3W1VaP
         Jv+9vAUe1fBnks/TB62lYrEQwu/oIzoP4t42r24c=
Date:   Fri, 29 May 2020 12:09:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, matthias.bgg@gmail.com,
        hariprasad.kelam@gmail.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        howie.huang@mediatek.com, tzungbi@google.com
Subject: Re: [PATCH] ASoC: mediatek: mt6358: support DMIC one-wire mode
Message-ID: <20200529110915.GH4610@sirena.org.uk>
References: <1590750293-12769-1-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QDd5rp1wjxlDmy9q"
Content-Disposition: inline
In-Reply-To: <1590750293-12769-1-git-send-email-jiaxin.yu@mediatek.com>
X-Cookie: The Killer Ducks are coming!!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QDd5rp1wjxlDmy9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2020 at 07:04:53PM +0800, Jiaxin Yu wrote:
> Supports DMIC one-wire mode. Adds a mixer control to enable and disable.

What is DMIC one wire mode?  This doesn't sound like something I'd
expect to vary at runtime.

--QDd5rp1wjxlDmy9q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7Q7VoACgkQJNaLcl1U
h9DwIQf/QoUXcR5znRfl1nQpP4QTwnoPi7CPIFAYYQv475mekxLBWIopRSwlj19A
kwQRFL85PeTib/Pngyr5KhcHjyDqURrVmuCRgO+8dtEXcq8RVYVo0J/tSSMcYtKw
bNpDZKkp98v+uMHgY5ldvoscyTMC/hFjsN9c31bMIjhSSyvFsAkjTTGTTsg9o8iy
bmMzVAEUwkuYfYFXypmN0PYIgMo74x0CxmAjbvp1WoZpQv1vI0Hxe+Fc3s0LgjLC
CUka+MsG6+52tpHF/fazhv8oBFbUOh70roWkZ4ZlhxV7CpR2iWFjw/0Om/T+2U1L
27KuaQ/3mh5q4RPeSDyAMeFwOjQJbg==
=Texz
-----END PGP SIGNATURE-----

--QDd5rp1wjxlDmy9q--
