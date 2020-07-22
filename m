Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938C1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 04:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6878F20771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 04:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="k5jj9EB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgGVEe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 00:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgGVEe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 00:34:26 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FC0C061794;
        Tue, 21 Jul 2020 21:34:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BBN0C43Ggz9sPB;
        Wed, 22 Jul 2020 14:34:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1595392463;
        bh=i51/MVwIwEu8gxnbsRmgekTqX8n4jpeFMBM4wQ17X00=;
        h=Date:From:To:Cc:Subject:From;
        b=k5jj9EB/XmHzBMdZw5QFCToCxG4wGzvv4ChcoW0lAJfTf3J2wEexfQLGoWR46mhHn
         TF94bPoNd9F2tn7BD2NfmG63NjVDV6p8PZIQsACJNwo/Sq7j3OIbFUTsfM10IWHdyu
         p7PA3GcykoaxW6jUlSGvPrLcr2k/hxFqdU6miGKptsbpM8bj6CFDBLzdtJ1MFoZezZ
         EeqPqCQk2CnO+pRT0CzRccc4m8f++itPuJNHbztpSoVFGfIT1kT74uH4Mn51q8Fr4B
         IBas/9KtGAo3B4Hf84VEBZIYtvtVhahQ0Jvb2G6H00K2vTLFi08kxGeS4bB0/k5U/4
         FZHFrtirnkrAw==
Date:   Wed, 22 Jul 2020 14:34:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: manual merge of the amdgpu tree with Linus' tree
Message-ID: <20200722143417.42b52c73@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.GeUuTE65gktOvt/6ol=jTK";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.GeUuTE65gktOvt/6ol=jTK
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

[I can't find a previous email about this, sorry ...]

There is a semantic conflict between Linus' tree and the amdgpu tree
between commit

  d7a6634a4cfb ("drm/amdgpu/atomfirmware: fix vram_info fetching for renoir=
")

from Linus' tree and commts

  fe098a5d6443 ("drm/amdgpu/atomfirmware: fix vram_info fetching for renoir=
")
  836dab851903 ("drm/amdgpu/atomfirmware: update vram info handling for ren=
oir")

The automted git merge leaves two "case 12" labels.  I have been
reverting commit d7a6634a4cfb since July 3 ... This will need to be
fixed up when the amdgpu tree is next merged into the drm tree, or a back
merge of d7a6634a4cfb could be done into the amdgpu tree and the older
"case 12" label removed in that merge.

--=20
Cheers,
Stephen Rothwell

--Sig_/.GeUuTE65gktOvt/6ol=jTK
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8XwckACgkQAVBC80lX
0GyQ7Af/ScEs0gB7A7xYNmEyiGaYbcDzKPylhe57EP8JNVAa/28+NrNsLh/rh7OO
rN9ATGH5UBEpI7tSxrycLho6Crg5KAhZjU9awhcY12ixd8XtdGicgwkbKUdYLaOe
HlQkGTFnRfymOtVuOaAFB4DYEqPMM87YydfXd3yA7Sh+PGaNW/SglGvNDqv60uUG
G1xINDcAC9w+xza++OnOQ4BIWseDEZm7AtmE/YPQH9TqHFCeLS5B8TBtTK/V3f9k
ji0o2xG/SRfJNgtHthYDZbp73r8w1Jhpr4/oXJnp71oDdRpmd6qxUEbf9lQdB9DM
gv+44T0QxpGsmk5nKIBU5PybhjqGCQ==
=ISPa
-----END PGP SIGNATURE-----

--Sig_/.GeUuTE65gktOvt/6ol=jTK--
