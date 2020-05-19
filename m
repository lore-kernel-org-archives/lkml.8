Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF998C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C29320708
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589910296;
	bh=LH/18jKdD4+8dj8U6OaV6ZmON9IfifCHP6whVy4u2dg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AXKfxi+6+Pt6rFh6pL4l9/i+aZ61nOsrbmTIBiS8pKFDK8muZLuFtO6282CsTbR8P
	 kxPMW3SA/RMHuqW1IPzTRDF5R4EgsH5jiEX3Quoq1XbVOYZYE+75gQVO70tljpiUGl
	 ZXCtej9XOGCQtn6Rvk5CQPUqXSv7AVLx4hMHMnMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbgESRo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 13:44:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726059AbgESRoz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 13:44:55 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D95E20708;
        Tue, 19 May 2020 17:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589910295;
        bh=LH/18jKdD4+8dj8U6OaV6ZmON9IfifCHP6whVy4u2dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UfsCw1/B8B8h3JBZYFQESYsQ8akmx/QQ2q3CHrM7/b4e01E5TLYBNt1Dq2e4NL3OI
         cEnKRiv+vCb4M5sfSx4u4Ys08MJvjKEqI/0W/SvST2RRykoWTkhMwifOi87Zlgvpzu
         SegQgDxxHDi1PVNyiyrVwFheVr95oQ+VylbvIGnE=
Date:   Tue, 19 May 2020 18:44:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     shuah <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: vdso: Add a selftest for vDSO getcpu()
Message-ID: <20200519174452.GR4611@sirena.org.uk>
References: <20200505174728.46594-1-broonie@kernel.org>
 <20200505174728.46594-4-broonie@kernel.org>
 <dff4dfbd-f3f1-d683-5dac-4404e9023b2e@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zj18g9eElA7rRQh+"
Content-Disposition: inline
In-Reply-To: <dff4dfbd-f3f1-d683-5dac-4404e9023b2e@kernel.org>
X-Cookie: Do not write below this line.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zj18g9eElA7rRQh+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2020 at 11:11:28AM -0600, shuah wrote:
> On 5/5/20 11:47 AM, Mark Brown wrote:

> > +int main(int argc, char **argv)
> > +{
> > +	unsigned long sysinfo_ehdr =3D getauxval(AT_SYSINFO_EHDR);
>=20
> WARNING: Missing a blank line after declarations
> WARNING: Missing a blank line after declarations
> #135: FILE: tools/testing/selftests/vDSO/vdso_test_getcpu.c:27:
> +	unsigned long sysinfo_ehdr =3D getauxval(AT_SYSINFO_EHDR);
> +	if (!sysinfo_ehdr) {

This is the idiom in use by the existing gettimeofday test:

WARNING: Missing a blank line after declarations
#38: FILE: tools/testing/selftests/vDSO/vdso_test_gettimeofday.c:38:
+	unsigned long sysinfo_ehdr =3D getauxval(AT_SYSINFO_EHDR);
+	if (!sysinfo_ehdr) {

so I don't know how you want the code to look here?

--zj18g9eElA7rRQh+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7EGxMACgkQJNaLcl1U
h9Dtrgf9EvPl6k4mQxLhof/GI9tdCjeQvG/Mnv+3PVimZt6YlWwQj/GFbMTzhRKS
TnWRtySrFArKtJJZT+cmsWR97PIH84sdlc6CJrxnsWUltZhuqxqocTMrDAQB9blU
0qjMzXi6cfIIDeF8NC9LSvQoZOM7PznXZ28meiv0cqqX1hPegI7ihg1woGRlRkPn
FXw6awO+1qKNTjPJsSwTjrqUTX5r4Jsf1r9ccrAVJuh/D+T5+Szjyqy/OLCuHJEp
soHSdEfFRrfh6NE0pl57MiYpB0mXRnQcKnBQNsgnirF4QXr7dMFQEvEiLIdvkTnD
llBPb6z1WnlinXHtHkNE/qBaDNMFOw==
=OVk4
-----END PGP SIGNATURE-----

--zj18g9eElA7rRQh+--
