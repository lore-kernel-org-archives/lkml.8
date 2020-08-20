Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375B9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1725722B40
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 10:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597920890;
	bh=ZqG3th/b5Uxk50ROdnLR+gts/eCRrmj90/L+6Vb52wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YYGGlV4dz3kzUVNyZY2xRAOqArpswdbBZv7yzXuoZ80tR4HgPWOPqq7liZDx38XQ1
	 gBIANDnAwf2i48YqX+qqc+F+jb45iLhTMbDf0spO9eGFgs+Toj8xbDM8F63YWDgc9i
	 XdwnCu5ChI3AfV/CidnCRgtG/mn1n/NeacCrcXNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbgHTKwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 06:52:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730973AbgHTKwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:52:22 -0400
Received: from localhost (cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net [82.37.168.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F34C206FA;
        Thu, 20 Aug 2020 10:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597920741;
        bh=ZqG3th/b5Uxk50ROdnLR+gts/eCRrmj90/L+6Vb52wc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pKDANHIIeJcjOAaMWCQFzyJXu/r70du2ZKYKRhRDh7VOW0vGBNtjTAJk8z0IVbhAw
         JCszTZds6S/hxCXmwDrfok82iKPXNDKGgNImJdSIvMJ2P9fr6wInj5PcJ3bNLOBRFw
         kCUYhb9pBv6JtwL9RlZ/VriQJ42RkSuLBgvIoGME=
Date:   Thu, 20 Aug 2020 11:51:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Icenowy Zheng <icenowy@aosc.io>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 11/12] regulator: stm32-vrefbuf: Fix W=1 build warning
 when CONFIG_OF=n
Message-ID: <20200820105148.GA5854@sirena.org.uk>
References: <20200820152926.42c48840@xhacker.debian>
 <20200820154626.79d83157@xhacker.debian>
 <20fc45ab-4daf-3855-5817-1898d50c9efc@st.com>
 <20200820163232.54b59e1d@xhacker.debian>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
In-Reply-To: <20200820163232.54b59e1d@xhacker.debian>
X-Cookie: Dead? No excuse for laying off work.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 20, 2020 at 04:32:32PM +0800, Jisheng Zhang wrote:
> On Thu, 20 Aug 2020 10:13:12 +0200 Fabrice Gasnier wrote:

> > You could probably adopt "__maybe_unused" here ? E.g. like:

> __maybe_unused also fixes the warning. I'm not sure the maintainers' preference.

> which solution do you prefer?

__maybe_unused is a bit nicer.

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8+VcAACgkQJNaLcl1U
h9CIQQf8CpLxeYGvZPi26wQNd0LwMWOfzS5DReNlci1HTCE1X6GKANsxjGudPCHZ
dxEIuBuC4eqVCHu4xfXjX+WdYnavp80dGD83kJGzHvMlu6z6gtRUezjspbWClDJF
S92rmkLD1DZo/gMFHKEdyLs7RUNrOVcW/SbesClYSL0S649zBIljRvwibJsFKX9p
npNlMDrRtpx87Rdux0cCAqIXuQEOjFCLs5oFZcHHbIHxvh042022JW7NmyQ5wHx4
sZTeM1eC1wyJqQihJkjziS+VaFwJG3k6vaQZIbkddcRrl1UHC/B7NarX0onCkAso
NGsTd9rE3rfVV9jK51V27xg9pkhIlg==
=fXEC
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--
