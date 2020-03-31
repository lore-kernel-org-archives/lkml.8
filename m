Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317AEC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06F34208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 20:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="G+VtWL52"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731416AbgCaUra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 16:47:30 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42673 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731335AbgCaUr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 16:47:28 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48sLx76Mqmz9sSw;
        Wed,  1 Apr 2020 07:47:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1585687645;
        bh=pIS6nb9vgn/2smEo5fZq7jsxhBPw73VjqzvwUwfT2qk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G+VtWL52KBtfXeusCab+K4Z5aStqBgstaXPhckyN2w8qyDoQ8Fu02VCQ/QgmK4mKC
         QwS2GQpnyl6pbKJiP/hKGZFOptHePBvks13vUWlo97t2znXkueboDbn6XaUUfd98G5
         Nv+42WX14NOkrjjL/vEKccQMpLBYhngfcmNBrXoCApB5LfyxKxsZ5Tkck1xKgcbnwy
         suB7sYjB6AKK8MYCoPKqfz0MYJ5o7PoiMYWDfommzHuVB3ZhrANk0RLI1Jy05ys8iH
         LJrgDOZpHBV4TxMVXF4ObM8mueJ4fUqS+xyLvBYcECfs5faq0g7DCIT+C76qL7gn5y
         PFRtTURRJnm7w==
Date:   Wed, 1 Apr 2020 07:47:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        x86 <x86@kernel.org>
Subject: Re: [tip: irq/core] irqchip/xilinx: Enable generic irq multi
 handler
Message-ID: <20200401074722.4783de95@canb.auug.org.au>
In-Reply-To: <2ee07d59d34be09be7653cbb553f26dc@kernel.org>
References: <20200317125600.15913-4-mubin.usman.sayyed@xilinx.com>
        <158551357076.28353.1716269552245308352.tip-bot2@tip-bot2>
        <083ad708-ea4d-ed53-598e-84d911ca4177@xilinx.com>
        <085188fea81d5ddc88b488124596a4a3@kernel.org>
        <895eba40-2e77-db1b-ea82-035c05f0b77e@xilinx.com>
        <ca0f62da-1e89-4fe8-5cb4-b7a86f97c5a3@xilinx.com>
        <21f1157d885071dcfdb1de0847c19e24@kernel.org>
        <44b64be7-9240-fd52-af90-e0245220f38b@xilinx.com>
        <2ee07d59d34be09be7653cbb553f26dc@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1H5MB2Drzxc4D_J.vgssIZM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1H5MB2Drzxc4D_J.vgssIZM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Marc,

On Mon, 30 Mar 2020 11:04:14 +0100 Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-03-30 10:27, Michal Simek wrote:
> > On 30. 03. 20 11:19, Marc Zyngier wrote: =20
> >> On 2020-03-30 10:12, Michal Simek wrote: =20
> >>> On 30. 03. 20 11:03, Michal Simek wrote: =20
>=20
> [...]
>=20
> >>> One more thing. We could also get this function back and it will be=20
> >>> fine
> >>> too. But up2you. =20
> >>=20
> >> If you leave it up to me, I'll revert the whole series right now.
> >>=20
> >> What I'd expect from you is to tell me exactly what is the minimal
> >> change that keeps it working on both ARM, microblaze and PPC.
> >> If it is a revert, tell me which patches to revert. if it is a patch
> >> on top, send me the fix so that I can queue it now. =20
> >=20
> > It won't be that simple. Please revert patches
> >=20
> > 9c2d4f525c00 ("irqchip/xilinx: Do not call irq_set_default_host()")
> > a0789993bf82 ("irqchip/xilinx: Enable generic irq multi handler")
> >=20
> > And we should be fine. =20
>=20
> Now reverted and pushed out. I'll send a pull request to Thomas=20
> tomorrow.

Unfortunately, those commits made it to Linus' tree without the reverts :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/1H5MB2Drzxc4D_J.vgssIZM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6DrFoACgkQAVBC80lX
0GydPwf/f16SxExtN814pfAzjVmhz19KKKFkJj4VWO9HtT3EwDsRz1OeVhWPBeDo
0Cv6gywKWJBF8ZEtYPs6/CV3xU8+hed7ykk301klpy0SRAFxJOuTorITeuQ0RWOj
A84hvaXjjcqNOj28hK7xqVlcGRDoCRxpi3h+Ki7z/x7xCvcmkYzQavHTwGzbw+5T
aojV5z6BYPJN0Hp89tkPxJ1OGhMHo/jtC3UTAl0tB/EvRgGCt4z7ekdAoaOEDPhz
Hj72cJgSClNM4vTxWsv2dMwH9MVDQrS1nJOT1lr1uvfLmsAXd+zTYZAUJ4ud34aa
DdL44zrpp+a5KUG5a2fOZjhLvQ6UpA==
=9HvH
-----END PGP SIGNATURE-----

--Sig_/1H5MB2Drzxc4D_J.vgssIZM--
