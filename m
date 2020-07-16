Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C765AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57A2206F5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="BsCJ6kU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgGPAZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 20:25:20 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33927 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgGPAZT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 20:25:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B6Zld2MlRz9sDX;
        Thu, 16 Jul 2020 10:25:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1594859117;
        bh=FgzQ/5FpACI+HBCtnA5PxzdCoZK0LnHa59Fs+lvFQQE=;
        h=Date:From:To:Cc:Subject:From;
        b=BsCJ6kU3yaUR0AOxSBwEzoNekFOJD9RwnLKLc6TaaTdc4sM+OjkCIWWba72yef1Ob
         5s75kplxdxvMhBYlhIbE++nFiG9yHcr2ymyYum0VGKssQfTfaru290A7fP3Am1hqLv
         Q4wV8lPlH9ZDcqsrW7g480dbluxf8Px/V3Za6drx4ymwveMclFJjLDQg+PFkx8UkNq
         X1hOYJCaAV+mGrpW3eG4NOcReWGyB4DbTjNFlHMpxnZSaz8A6ML78SGEAjtt1RntAs
         zFQHnqaHNJSxX36wYcAs9cPJ5d2+4nhSttCQC9CTr61ya5VzJSr5n67nU9mi3jAbPY
         FGK4deIHehzPA==
Date:   Thu, 16 Jul 2020 10:25:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <seanpaul@chromium.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the drm-msm tree
Message-ID: <20200716102516.71eac9ce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/08z2xdNVYSJ0kscP98ixYs.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/08z2xdNVYSJ0kscP98ixYs.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  9e3d8cc1cfbc ("drm/msm/adreno: fix gpu probe if no interconnect-names")

Fixes tag

  Fixes: 8e29fb37b301 ("drm/msm: handle for EPROBE_DEFER for of_icc_get")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 937c55f6b726 ("drm/msm: handle for EPROBE_DEFER for of_icc_get")

--=20
Cheers,
Stephen Rothwell

--Sig_/08z2xdNVYSJ0kscP98ixYs.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl8PnmwACgkQAVBC80lX
0GxjlAgAmOMsoIeaUEqizo61Rh+cuejA3+GS4tBVh0I3qKUnnCsejP0FQejAyk0D
1Ll24hwO1QlM20TVP+osLp9UAjFtQEAaGztaz6GEp7gYMoeh8xHh7pMO2c4+9App
4rPMD4/6EtflWKYo/PP/qaMyXCVRtZ++kVpkPXhfzG3uaxG0gAFElbBOVVxQHvCk
DecjqZVKLXUedxJTV3WuycEbHg7ONYuX5Ismyfcm/El5i9gu/M5d9N1gzNpabqCm
q2qKbE9WLHge8MIL+RcdV09Mbb8Qi5kXaVkbt31o5yol40jhOKeqGYYKQPlXitYo
n8FfVOi3ZExP7Ds36lyh/jl5s8PIUA==
=gTqb
-----END PGP SIGNATURE-----

--Sig_/08z2xdNVYSJ0kscP98ixYs.--
