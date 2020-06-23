Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF31C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 992702078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="f7sfvr3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbgFWWpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387815AbgFWWpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 18:45:07 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D748C0619C1;
        Tue, 23 Jun 2020 15:45:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49s1Z81khxz9sRR;
        Wed, 24 Jun 2020 08:45:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1592952305;
        bh=tChZ5ngJ34qizWuYEBwfwH6ZaiLJwxDvT/lkEo4q9x0=;
        h=Date:From:To:Cc:Subject:From;
        b=f7sfvr3LzTag9fmHGMc5JFPtOXxlJ8MOgiSBTmEOdXqUVNgWxVqnpszgWVGBk9g74
         vsXEqfS+4VrzeLyuLSQrdUEXMD/pDnTNwHHSLzTRSnNIff7zaJ7Ze9u9kHiH36/BwV
         n2HWwTyPeZhYE3p4e/ItoVIghaPbsVm6ZwyW80lb95EUW4znMO0Xr10Is0uV0Q1ksL
         /vDfG+UZ0dqi0TGSlrFDdab0tDkR/p8E9mCsm4bSSGe2GtaQVmlGMDUhKZQURR59NL
         Q8ZryN885BG0k2V+YVKWzt1kUiNciW4i1+iW8HCWE/Rm2foLOT/59m2RQKla4sMjzg
         +mjecWu6h3Fbg==
Date:   Wed, 24 Jun 2020 08:45:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chen Tao <chentao107@huawei.com>
Subject: linux-next: Fixes tag needs some work in the amdgpu tree
Message-ID: <20200624084503.42c9d5b8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/X9YwbIPP/p9BLWtR10GVZ6S";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/X9YwbIPP/p9BLWtR10GVZ6S
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  82d6b9745744 ("drm/amdgpu/debugfs: fix memory leak when amdgpu_virt_enabl=
e_access_debugfs failed")

Fixes tag

  Fixes: 95a2f917387a2 ("drm/amdgpu: restrict debugfs register accessunder =
SR-IOV")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/X9YwbIPP/p9BLWtR10GVZ6S
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7yhe8ACgkQAVBC80lX
0Gwt/AgAi7T9upqEqmwTL5Jo1e40mKR4uHvaSn/MPR/zjFHapH86Q4B+9ipQ6Xtm
yMDA2MqLFRVHYCfpb0pEnsZOdty4ik9BYzm8g4//z+TKoiADsoKznEKZMQmWgqM2
5ti5R0hqVtA+PC4vGs9z3ffr7QKnKLxG1K9HnjNoBp+jCcyihaL81IaMolkInKkd
Oh4UMj4H6nhQWnrCrXRWbyr0JSq2IUPfFfYi/QL0LGH65gsWvkIBI1oweJpUx23t
zYdaqTZyLRuOWzsstRKKcXIzmbcnIOn/yZ0i+bjI53j1vQ/2vw0BMo4kwZLHF+iI
XUcaXMIVs1Gd6/N1WnbpA6AWXT6KnQ==
=v9ii
-----END PGP SIGNATURE-----

--Sig_/X9YwbIPP/p9BLWtR10GVZ6S--
