Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86321C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 601C120791
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597420912;
	bh=bwt4I1Ivw+5s6OaoKYWYSNGKjE4/A6uymfb27r28z6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HYkafPJ6FB0aUfz60qhEjuYTa0ydyJvltn49O/miCVlN+1OXYKu8Yr85FF5y1mAPb
	 CD7FOU+q3FHY+rlVhGULD0xXnUQkLUnTdRkP5ZgQ/wVutl7q6w68OdHQjPzJRMEKJy
	 Dgk1roee/+8vGc3zEZ6Nr/NPq+9UZTdL7OagdMrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgHNQBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:01:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726593AbgHNQBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 12:01:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 341332078D;
        Fri, 14 Aug 2020 16:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597420903;
        bh=bwt4I1Ivw+5s6OaoKYWYSNGKjE4/A6uymfb27r28z6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fgHf/GGPT4X5Rh3a7QelbgRyOu9jbsHEgWPkF14MskZ4qfuSVe5YhbU4bvrSsNNjQ
         JggiVYC73FnhPU2fZZ+iHhZXVtTw/Jb+a8JNUUCzUfE6Qucl5W+YW+7B04lXQfjyBu
         BoBIz68fhhXmp9nCPVgQAaYoFxAdWulVUbR6KsGs=
Date:   Fri, 14 Aug 2020 17:01:15 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, howie.huang@mediatek.com,
        tzungbi@google.com, eason.yen@mediatek.com,
        shane.chien@mediatek.com, bicycle.tasi@mediatek.com
Subject: Re: [PATCH v3 1/2] WIP: ASoC: mediatek: mt6359: add codec driver
Message-ID: <20200814160115.GC4783@sirena.org.uk>
References: <1597401954-28388-1-git-send-email-jiaxin.yu@mediatek.com>
 <1597401954-28388-2-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Sr1nOIr3CvdE5hEN"
Content-Disposition: inline
In-Reply-To: <1597401954-28388-2-git-send-email-jiaxin.yu@mediatek.com>
X-Cookie: Non-sequiturs make me eat lampshades.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Sr1nOIr3CvdE5hEN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 14, 2020 at 06:45:53PM +0800, Jiaxin Yu wrote:

This looks mostly good, a couple of very small things:

> +	ret = regulator_enable(priv->avdd_reg);
> +	if (ret) {
> +		dev_err(&pdev->dev, "%s(), failed to enable regulator!\n",
> +			__func__);
> +		return ret;
> +	}

You need a remove() function to undo this enable.

> +	dev_info(&pdev->dev, "%s(), dev name %s\n",
> +		 __func__, dev_name(&pdev->dev));

This isn't really adding anything, just remove it - it's not reading
info from the hardware or anything.

--Sr1nOIr3CvdE5hEN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl82tUoACgkQJNaLcl1U
h9Azugf+KQT2qjv6S1GYzqybbbwsXf9EyoEnEt+nTpEnAUPp4fJMT8SboJ0j++fD
4je+pUPhMO3oMDD+s7/1npVhSowHCaO1943wiq5X31lTnio2zcYYFiaI577/8E9Q
jcrESOC0PUcLZjuUPGc4I8Ae2yh9uen2vMoJqmSDZaRYKW38a3V3vAjV5Ky51l2/
vTw65kfnt87EVF7X18TiheJmgK3ZYWkgV4ugljUQ8FqWxnnUHtaQUUzF7Th5+khJ
aAQM1NW022CE9MFXd8idK+RvGbWuQZBjv+MIOpy2eE5RpdQvbSUgrC+up6bDntjF
FCirVs8xfLOqqP4ld/eJlZxW2vF3qg==
=eI4S
-----END PGP SIGNATURE-----

--Sr1nOIr3CvdE5hEN--
