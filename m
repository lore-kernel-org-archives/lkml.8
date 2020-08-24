Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1912FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD52E206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598267143;
	bh=9APzb+PIK28bYSi6UfNZRcD15AFZZuBMXg3adS+rpc8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q37bvhOV/W/KnlPa7T5pXMF+gVRsOi6NDqlRgT6epNy6ceD3gNdojulkW6BSkQOmf
	 8q/28I2a1L3r1/XWzztW4SKhvOlsd3Y9Lp0g3uhJY/sIrBwXEvAvT+M8nD/4WhBWVF
	 +JEnTdYfdaRbGXqKjwmatueBqYYnZu+egOoesr5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHXLFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:05:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:53700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgHXLFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:05:33 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0443206B5;
        Mon, 24 Aug 2020 11:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598267133;
        bh=9APzb+PIK28bYSi6UfNZRcD15AFZZuBMXg3adS+rpc8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uI7LWHi3gy3FVvYd39Lj7Q3nWy2hq5jsyryJzwcxW8RTZqgwfjWbctyzU/z8DKTwN
         hEGSqZctJAo3maBX3X/U31Vy/iO8Kc6l+uyjeNlDBFRcy9QqzfncV+KgQ//CNQHSX7
         YpwbJwTP39TX8nppWsgCeYU3GGpGn9siQaUw/yoo=
Date:   Mon, 24 Aug 2020 12:04:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, robh+dt@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Gene Chen <gene_chen@richtek.com>
Subject: Re: [PATCH v3 1/2] regulator: mt6360: Add support for MT6360
 regulator
Message-ID: <20200824110458.GB4676@sirena.org.uk>
References: <1597910022-22617-1-git-send-email-gene.chen.richtek@gmail.com>
 <1597910022-22617-2-git-send-email-gene.chen.richtek@gmail.com>
 <20200820114524.GC5854@sirena.org.uk>
 <CAE+NS34WuWnT7zvsHhaciWVLT2y0wpwt0wXAp3UmjEuJ2its6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
Content-Disposition: inline
In-Reply-To: <CAE+NS34WuWnT7zvsHhaciWVLT2y0wpwt0wXAp3UmjEuJ2its6A@mail.gmail.com>
X-Cookie: Weekend, where are you?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2020 at 06:23:19PM +0800, Gene Chen wrote:
> Mark Brown <broonie@kernel.org> =E6=96=BC 2020=E5=B9=B48=E6=9C=8820=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:45=E5=AF=AB=E9=81=93=EF=BC=9A

> > This device only exists in the context of a single parent device, there
> > should be no need for a compatible string here - this is just a detail
> > of how Linux does things.  The MFD should just instntiate the platform
> > device.

> Trying to autoload module without of_id_table will cause run-time error:
> ueventd: LoadWithAliases was unable to load
> of:NregulatorT(null)Cmediatek,mt6360-regulator

You shouldn't have this described in the device tree at all, like I say
the MFD should just instantiate the platform device.

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9DntoACgkQJNaLcl1U
h9AI7Qf/aKJwrqZi6N40mt5MpwiV+hZ9suHb3xMS5nDmfB/Wbs5e2QhLRELVG8Di
V/J+aX+cSq7xN9elG/yRpB6Rv3jEZ+HuzNgWnZT6EEwTO6BFa8JdiDS9Ya9JzOf4
I9mT76nHMMxb0io4hTy0YjxbZIh0BtHU9NK97n3LsG7btQLsQD2eZfdVQHU6RUFy
A55EqlQAvNBZ/fRrl0uJmE7iuuOz9KISKypEcBi96+ztklTRTsoet/9XqoqghOkO
ch9U8SL21g3Y5/GNW1eyHCA+ZVTeTQQ/mxO7ptJoeMU1FF9/gc7gzd0n/O17MbXH
SSApfApl1vKX5VfDD8xKLFEM+9khCw==
=rBbb
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
